using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class ApplMajorGuideMsgMngr : WebFormBase
    {
        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            grdList.RowCommand += GrdList_RowCommand;
            grdList.RowDataBound += GrdList_RowDataBound;
            btnReBindSearchYear.Click += BtnReBindSearchYear_Click;
            btnReBindYear.Click += BtnReBindYear_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txtSearchApplyYear, ddlSearchApplySeason);  //지원연도, 지원시기(조회) 바인딩(현재 진행)
            COMMMethod.SetApplicationYearSeason(txtApplyYear, ddlApplySeason);              //지원연도, 지원시기(입력) 바인딩(현재 진행)
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //지원학과(조회) 바인딩
            COMMMethod.SetDDLMajorCode(ddlApplyOrgID, txtApplyYear.Text);                   //지원학과(입력) 바인딩
            COMMMethod.SetDDLPassCode(ddlSearchPassCode);                                   //합격코드(조회) 바인딩
            COMMMethod.SetDDLPassCode(ddlPassCode);                                         //합격코드(입력) 바인딩
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 조회 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            this.ClearDetail();
            this.Retrieve();
        }

        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                if (txtApplyYear.ReadOnly)
                    parameters.Add("@State", "U");
                else
                    parameters.Add("@State", "C");
                parameters.Add("@Year", txtApplyYear.Text);
                parameters.Add("@Season", ddlApplySeason.SelectedValue);
                parameters.Add("@MajorCd", ddlApplyOrgID.SelectedValue);
                parameters.Add("@PassCd", ddlPassCode.SelectedValue);
                parameters.Add("@Msg", txtInfoMessage.Text);
                parameters.Add("@ID", UserId);
                parameters.Add("@IP", UserIp);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, 202);
                    this.Retrieve();

                    spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_조회_업그레이드";
                    parameters = new DataParameterCollection();
                    shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    parameters.Add("@Year", txtApplyYear.Text);
                    parameters.Add("@Season", ddlApplySeason.SelectedValue);
                    parameters.Add("@MajorCd", ddlApplyOrgID.SelectedValue);
                    parameters.Add("@PassCd", ddlPassCode.SelectedValue);

                    shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        DataSet ds = dataCommands[0].DataSet;
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            DataRow dr = ds.Tables[0].Rows[0];
                            txtInfoMessage.Text = dr["GuideMsg"].ToString();
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "EditorSetValue", "setEditorValue();", true);
                        }
                    }

                    txtApplyYear.ReadOnly = true;
                    ddlApplySeason.Enabled = false;
                    ddlApplyOrgID.Enabled = false;
                    ddlPassCode.Enabled = false;
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
        /// 신규 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void NewCmd(object sender, CommandEventArgs e)
        {
            this.ClearDetail();
        }

        /// <summary>
        /// 삭제 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                foreach (GridViewRow item in grdList.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[6].Controls[1]).Checked)
                        {
                            parameters.Add("@State", "D");
                            parameters.Add("@Year", item.Cells[7].Text);
                            parameters.Add("@Season", item.Cells[8].Text);
                            parameters.Add("@MajorCd", ((LinkButton)item.Cells[1].Controls[1]).Text);
                            parameters.Add("@PassCd", item.Cells[9].Text);

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, 203);
                    this.Retrieve();
                    this.ClearDetail();
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
        /// 이전연도복사 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_복사_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@BeforeYear", Convert.ToString(int.Parse(txtSearchApplyYear.Text) - 1));
                parameters.Add("@ID", UserId);
                parameters.Add("@IP", UserIp);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, "이전연도복사가 완료되었습니다.");
                    this.Retrieve();
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
        /// 그리드 row 선택시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void GrdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;

                if (e.CommandName == "SELECT")
                    this.SelectItem(gvr);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 지원연도(입력) 변경시 지원학과(입력) 재조회
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindYear_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(ddlApplyOrgID, txtApplyYear.Text);
        }

        /// <summary>
        /// 지원연도(조회) 변경시 지원학과(조회) 재조회
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindSearchYear_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);
        }

        /// <summary>
        /// 그리드 바인딩시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void GrdList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    DataRowView dv = (DataRowView)e.Row.DataItem;

                    Button btnInfoMessage = e.Row.FindControl("btnInfoMessage") as Button;

                    string year = dv["ApplYear"].ToString();
                    string season = dv["Season"].ToString();
                    string majorCd = dv["MajorCode"].ToString();
                    string passCd = dv["Pass"].ToString();

                    btnInfoMessage.Attributes.Add("onClick", "return infoMessagePop('" + year + "', '" + season + "', '" + majorCd + "', '" + passCd + "');");
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트

        #region 메소드

        private void Retrieve()
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@MajorCd", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@PassCd", ddlSearchPassCode.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = null;
                    DataTable table = null;

                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        // Do something
                        foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                        {
                            table = tbl;
                        }

                        ds = table.DataSet;
                    }
                    grdList.DataBindGrid(ds, ExDataCounter1);
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

        private void ClearDetail()
        {
            try
            {
                COMMMethod.SetApplicationYearSeason(txtApplyYear, ddlApplySeason);
                ddlApplyOrgID.SelectedIndex = 0;
                ddlPassCode.SelectedIndex = 0;
                txtInfoMessage.Text = string.Empty;

                txtApplyYear.ReadOnly = false;
                ddlApplySeason.Enabled = true;
                ddlApplyOrgID.Enabled = true;
                ddlPassCode.Enabled = true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SelectItem(GridViewRow gvr)
        {
            try
            {
                txtApplyYear.Text = Util.GetGridViewString(gvr.Cells[7].Text);
                ddlApplySeason.SelectedValue = Util.GetGridViewString(gvr.Cells[8].Text);
                ddlApplyOrgID.SelectedValue = ((LinkButton)gvr.Cells[1].Controls[1]).Text;
                ddlPassCode.SelectedValue = Util.GetGridViewString(gvr.Cells[9].Text);
                //txtInfoMessage.Text = gvr.Cells[10].Text;
                //if (!string.IsNullOrEmpty(txtInfoMessage.Text))
                //{
                //    this.Page.ClientScript.RegisterStartupScript(this.GetType(), "EditorSetValue", "setEditorValue();", true);
                //}
                txtApplyYear.ReadOnly = true;
                ddlApplySeason.Enabled = false;
                ddlApplyOrgID.Enabled = false;
                ddlPassCode.Enabled = false;

                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_조회_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@Year", gvr.Cells[7].Text);
                parameters.Add("@Season", gvr.Cells[8].Text);
                parameters.Add("@MajorCd", ((LinkButton)gvr.Cells[1].Controls[1]).Text);
                parameters.Add("@PassCd", gvr.Cells[9].Text);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];
                        txtInfoMessage.Text = dr["GuideMsg"].ToString();
                        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "EditorSetValue", "setEditorValue();", true);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드
    }
}