using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.Security.Permissions;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// 메뉴정보 : 입시 > 지원자관리 > 신입생 학번부여
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.12.04 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class StudNoAdd : WebFormBase
    {
        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindDdlOrgID.Click += BtnReBindDdl_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();

                this.Retrieve();
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            //일괄처리, 일괄취소 버튼 표시유무 제어
            if (Batch_Chk("") == 0)
            {
                this.ExToolBar4.Visible = true;
                this.ExToolBar5.Visible = false;
            }
            else
            {
                this.ExToolBar4.Visible = false;
                this.ExToolBar5.Visible = true;
            }

            //연도
            //COMMMethod.SetApplicationYearSeason(txt연도조회, ddl지원시기조회);
            DataSet ds = new COMMBiz().GetApplicationConfig();
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataColumn dc = ds.Tables[0].Columns["ApplYear"];

                foreach(DataRow row in ds.Tables[0].Rows)
                {
                    txt연도.Text = row[dc].ToString();
                }
            }

            //계열 (위탁제외) 바인딩
            SetDDLNotConsignCode(this.ddl계열구분, this.txt연도.Text.Trim());
            //위탁 바인딩
            SetDDLConsignCode(this.ddl위탁, this.txt연도.Text.Trim());

            //학과
            COMMMethod.SetDDLMajorCode(this.ddl학과, this.txt연도.Text.Trim());
        }

        public static void SetDDLNotConsignCode(ExDropDownList DDL, string Year)
        {
            DataSet ds = null;
            DataTable dt = null;
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_계열조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", Year);
                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                        {
                            dt = tbl;
                        }
                        ds = dt.DataSet;
                    }
                }
                DDL.DataSource = ds;
                DDL.DataTextField = "DataText";
                DDL.DataValueField = "DataValue";
                DDL.DataBind();

                DDL.Items.Insert(0, new ListItem("선택", ""));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void SetDDLConsignCode(ExDropDownList DDL, string Year)
        {
            DataSet ds = null;
            DataTable dt = null;
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_위탁조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", Year);
                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                        {
                            dt = tbl;
                        }
                        ds = dt.DataSet;
                    }
                }
                DDL.DataSource = ds;
                DDL.DataTextField = "DataText";
                DDL.DataValueField = "DataValue";
                DDL.DataBind();

                DDL.Items.Insert(0, new ListItem("선택", ""));
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar4.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
        }

        #endregion 초기화

        #region 이벤트

        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            //계열 (위탁제외) 바인딩
            SetDDLNotConsignCode(this.ddl계열구분, this.txt연도.Text.Trim());
            //위탁 바인딩
            SetDDLConsignCode(this.ddl위탁, this.txt연도.Text.Trim());
        }

        /// <summary>
        /// (정규) 일괄처리 버튼 클릭시 학번 부여
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            this.Batch(this.txt연도.Text.Trim(), this.ddl계열구분.SelectedValue);
        }

        /// <summary>
        /// (위탁) 일괄처리 버튼 클릭시 학번 부여
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc2Cmd(object sender, CommandEventArgs e)
        {
            this.Batch(this.txt연도.Text.Trim(), this.ddl위탁.SelectedValue);
        }

        /// <summary>
        /// 개별처리 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc3Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_개별처리_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                if (PYD_Chk(this.txt수험번호.Text.Trim()) > 0)
                {
                    CommonMessage.AlertMessage(this, "학번 부여 후 신입생 자료가 이미 이관되었습니다. 학번부여를 취소합니다.");
                    return;
                }

                parameters.Add("@Year", this.txt연도.Text.Trim());
                parameters.Add("@StudentNo", this.txt학번.Text.Trim());
                parameters.Add("@recpNo", this.txt수험번호.Text.Trim());

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();

                    this.ExToolBar4.Visible = false;
                    this.ExToolBar5.Visible = true;
                    this.txt수험번호.Text = string.Empty;
                    this.txt학번.Text = string.Empty;

                    CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                }
                else if (shell.ErrorCode == 2627)
                {
                    CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 자료이관 일괄처리 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc4Cmd(object sender, CommandEventArgs e)
        {
            this.Move(this.txt연도.Text.Trim(), string.Empty, this.edp입학일정규.SelectedDate.Trim(), this.edp입학일위탁.SelectedDate.Trim());
        }

        /// <summary>
        /// 자료이관 일괄취소 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc5Cmd(object sender, CommandEventArgs e)
        {
            this.MoveBack(this.txt연도.Text.Trim(), string.Empty);
        }

        /// <summary>
        /// 인쇄 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("Year", txt연도.Text);

                Report1.ShowReportByStoredProcedure("0001438001", "dbo.APL_Print_MajorChoice", dataParams);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 학과 드롭다운 변경 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddl학과_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.Retrieve();
        }

        /// <summary>
        /// 그리드 행 데이타 바인딩
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DataRowView drv = e.Row.DataItem as DataRowView;

                    string pass = drv["PYD"].ToString();

                    LinkButton lnk개별이관 = (LinkButton)e.Row.FindControl("lnk개별이관");

                    lnk개별이관.Text = pass.Equals("N") ? "이관" : "이관취소";
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 그리드 Row 선택 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;

                //strDocNo = gvr.Cells[0].Text;
                //strDocTitle = ((LinkButton)gvr.Cells[1].Controls[1]).Text;

                if (e.CommandName == "SELECT")
                {
                    LinkButton lnk개별이관 = (LinkButton)gvr.FindControl("lnk개별이관");
                    string recpNo = gvr.Cells[0].Text;

                    if (lnk개별이관.Text.Equals("이관"))
                    {
                        this.Move(this.txt연도.Text.Trim(), recpNo, this.edp입학일정규.SelectedDate.Trim(), this.edp입학일위탁.SelectedDate.Trim());
                    }
                    else //이관취소
                    {
                        this.MoveBack(this.txt연도.Text.Trim(), recpNo);
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 일괄처리 가능유무 체크
        /// </summary>
        /// <param name="lesson"></param>
        /// <returns></returns>
        private int Batch_Chk(string lesson)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_이관유무조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            int returnValue = -1;

            try
            {
                parameters.Add("@Year", this.txt연도.Text.Trim());
                parameters.Add("@lesson", lesson);
                parameters.Add("@ReturnValue", DBNull.Value, System.Data.ParameterDirection.Output);

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    returnValue = Convert.ToInt32(dataCommands[0].ListOfParameters[0]["@@ReturnValue"].Value);
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }

            return returnValue;
        }

        /// <summary>
        /// 개별처리 가능유무 체크
        /// </summary>
        /// <param name="recpNo">수험번호</param>
        /// <returns></returns>
        private int PYD_Chk(string recpNo)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_개별처리가능유무조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            int returnValue = -1;

            try
            {
                parameters.Add("@RecpNo", recpNo);
                parameters.Add("@ReturnValue", DBNull.Value, System.Data.ParameterDirection.Output);

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    returnValue = Convert.ToInt32(dataCommands[0].ListOfParameters[0]["@@ReturnValue"].Value);
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }

            return returnValue;
        }

        /// <summary>
        /// 그리드 데이터 조회
        /// </summary>
        private void Retrieve()
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", this.txt연도.Text.Trim());
                parameters.Add("@majorCode", this.ddl학과.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        ds = dataCommands[0].DataSet;
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            // Do something
                            DataView dv = ds.Tables[0].DefaultView;

                            dv.Sort = (String)ViewState["SortExpression"];
                            if ((String)ViewState["SortAscending"] == "no")
                                dv.Sort += " DESC";

                            this.grdList.DataBindGrid(dv, this.ExDataCounter1);
                            ExDataCounter1.DataCount = ds.Tables[0].Rows.Count;
                        }
                        else
                        {
                            this.grdList.ClearDataSource();
                            ExDataCounter1.DataCount = 0;
                        }
                    }
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }

                this.ClearDetail();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        ///  일괄처리 버튼 클릭 시
        /// </summary>
        /// <param name="Year">연도</param>
        /// <param name="ddlSelectedValue">계열구분 또는 위탁구분 드롭다운 선택 값</param>
        private void Batch(string Year, string ddlSelectedValue)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_일괄처리_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                if (Batch_Chk(ddlSelectedValue) > 0)
                {
                    CommonMessage.AlertMessage(this, "학번 부여 후 신입생 자료가 이미 이관되었습니다.  일괄처리를 취소합니다.");
                    return;
                }

                parameters.Add("@Year", Year);
                parameters.Add("@chk", ddlSelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                }
                else
                {
                    switch (shell.ErrorCode)
                    {
                        case 1:
                            CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                            break;

                        case 2627:
                            CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                            break;

                        default:
                            CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                            break;
                    }

                    //CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }

                this.Retrieve();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 자료이관
        /// </summary>
        /// <param name="Year">연도</param>
        /// <param name="recpNo">수험번호</param>
        /// <param name="EnterDate1">정규 입학일</param>
        /// <param name="EnterDate2">위탁 입학일</param>
        private void Move(string Year, string recpNo, string EnterDate1, string EnterDate2)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_자료이관_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", Year);
                parameters.Add("@recpNo", recpNo);
                parameters.Add("@EnterDate1", EnterDate1);
                parameters.Add("@EnterDate2", EnterDate2);
                parameters.Add("@ProcessID", UserId);
                parameters.Add("@ProcessIP", UserIp);

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();

                    this.ExToolBar4.Visible = false;
                    this.ExToolBar5.Visible = true;

                    CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                }
                else if (shell.ErrorCode == 2627)
                {
                    CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 자료이관취소
        /// </summary>
        /// <param name="Year">연도</param>
        /// <param name="recpNo">수험번호</param>
        private void MoveBack(string Year, string recpNo)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_신입생학번부여_자료이관취소_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", Year);
                parameters.Add("@recpNo", recpNo);

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();

                    this.ExToolBar4.Visible = false;
                    this.ExToolBar5.Visible = true;

                    CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                }
                else if (shell.ErrorCode == 2627)
                {
                    CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 항목 초기화
        /// </summary>
        private void ClearDetail()
        {
            if (!this.ddl계열구분.SelectedValue.Equals("00"))
            {
                this.txt학과구분코드정규.ParamaterValue = this.ddl계열구분.SelectedValue;
            }
            if (!this.ddl위탁.SelectedValue.Equals("00"))
            {
                this.txt학과구분코드위탁.ParamaterValue = this.ddl위탁.SelectedValue;
            }
        }

        #endregion 메소드
    }
}