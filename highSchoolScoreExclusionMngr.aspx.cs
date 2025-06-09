using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL.COFF;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

/// <summary>
/// 메뉴정보 : 입시 > 성적사정 > 성적산출 교과목 관리
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.27 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreExclusionMngr : WebFormBase
    {
        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
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
            COMMMethod.SetApplicationYearSeason(this.txt지원연도조회, this.ddl지원시기조회);// 지원연도, 지원시기
        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar2.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 조회 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            this.Retrieve();
            this.ClearDetail();
        }

        /// <summary>
        /// 좌측 리스트 제외등록 버튼 클릭 시 모든 과목을 제외등록
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출교과목관리_제외등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            string returnCode = string.Empty;
            string returnMessage = string.Empty;

            try
            {
                foreach (GridViewRow item in grdList.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[6].Controls[1]).Checked)
                        {
                            parameters.Add("@ApplYear", Util.GetGridViewString(item.Cells[7].Text));
                            parameters.Add("@ApplSeason", Util.GetGridViewString(item.Cells[8].Text));
                            parameters.Add("@OrganizationCode", Util.GetGridViewString(((LinkButton)item.Cells[1].Controls[1]).Text));
                            parameters.Add("@CourceCode", Util.GetGridViewString(item.Cells[3].Text));
                            parameters.Add("@SubjectCode", string.Empty);
                            parameters.Add("@UserID", UserId);
                            parameters.Add("@UserIP", UserIp);

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();
                    this.ClearDetail();
                    CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        /// <summary>
        /// 우측 리스트 제외등록 버튼 클릭 시 해당 과목만 제외등록
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc2Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출교과목관리_제외등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            string returnCode = string.Empty;
            string returnMessage = string.Empty;

            try
            {
                foreach (GridViewRow item in grdList2.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[4].Controls[1]).Checked)
                        {
                            parameters.Add("@ApplYear", Util.GetGridViewString(item.Cells[5].Text));
                            parameters.Add("@ApplSeason", Util.GetGridViewString(item.Cells[6].Text));
                            parameters.Add("@OrganizationCode", Util.GetGridViewString(item.Cells[7].Text));
                            parameters.Add("@CourceCode", Util.GetGridViewString(item.Cells[8].Text));
                            parameters.Add("@SubjectCode", Util.GetGridViewString(item.Cells[1].Text));
                            parameters.Add("@UserID", UserId);
                            parameters.Add("@UserIP", UserIp);

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();
                    this.ClearDetail();
                    CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        public override void Etc3Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출교과목관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", this.txt지원연도조회.Text.Trim());
                parameters.Add("@ApplSeason", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@Exclusion", this.ddl제외여부조회.SelectedValue);
                parameters.Add("@OriginalScore", this.chk점수미존재조회.Checked == true ? "N" : "Y");
                parameters.Add("@AvgScore", this.chk평균0인과목만조회.Checked ? "Y" : "N");

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];

                        dt.Columns.Remove("ApplYear");
                        dt.Columns.Remove("ApplSeason");
                        dt.Columns.Remove("TotalSubjectCnt");
                        dt.Columns.Remove("ExclusionSubjectCnt");
                        dt.Columns.Remove("ExclusionCode");
                        dt.Columns["OrganizationCode"].ColumnName = "편제코드";
                        dt.Columns["OrganizationName"].ColumnName = "편제명";
                        dt.Columns["CourceCode"].ColumnName = "교과코드";
                        dt.Columns["CourceName"].ColumnName = "교과명";
                        dt.Columns["ExclusionName"].ColumnName = "제외여부";

                        Util.ExcelDownLoad(this, dt, "성적산출 교과목 관리 리스트");
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, "데이터가 존재하지 않습니다.");
                    }
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
        /// 좌측 그리드 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;
                this.SelectItem(gvr);
                this.Retrieve_grdList2(gvr);
                this.grdList.SelectIndex(e, "SELECT");
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve()
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출교과목관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", this.txt지원연도조회.Text.Trim());
                parameters.Add("@ApplSeason", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@Exclusion", this.ddl제외여부조회.SelectedValue);
                parameters.Add("@OriginalScore", this.chk점수미존재조회.Checked == true ? "N" : "Y");
                parameters.Add("@AvgScore", this.chk평균0인과목만조회.Checked ? "Y" : "N");

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
                            this.grdList.DataBindGrid(ds, this.ExDataCounter1);
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
            }
            catch (Exception ex)

            {
                throw ex;
            }
        }

        /// <summary>
        /// 좌측 리스트 클릭 시 우측 리스트 데이터 조회
        /// </summary>
        private void Retrieve_grdList2(GridViewRow gvr)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출교과목관리_과목조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", Util.GetGridViewString(gvr.Cells[7].Text));
                parameters.Add("@ApplSeason", Util.GetGridViewString(gvr.Cells[8].Text));
                parameters.Add("@OrganizationCode", Util.GetGridViewString(((LinkButton)gvr.Cells[1].Controls[1]).Text));
                parameters.Add("@CourceCode", Util.GetGridViewString(gvr.Cells[3].Text));
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
                            this.grdList2.DataBindGrid(ds, this.ExDataCounter2);
                            ExDataCounter2.DataCount = ds.Tables[0].Rows.Count;
                        }
                        else
                        {
                            this.grdList2.ClearDataSource();
                            ExDataCounter2.DataCount = 0;
                        }
                    }
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)

            {
                throw ex;
            }
        }

        /// <summary>
        /// 입력항목 초기화
        /// </summary>
        private void ClearDetail()
        {
            try
            {
                this.txt편제코드.Text = string.Empty;
                this.txt교과코드.Text = string.Empty;
                //우측 리스트 초기화
                this.grdList2.ClearDataSource();
                ExDataCounter2.DataCount = 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 좌측 그리드 선택 시
        /// </summary>
        private void SelectItem(GridViewRow gvr)
        {
            try
            {
                this.txt편제코드.Text = Util.GetGridViewString(((LinkButton)gvr.Cells[1].Controls[1]).Text) + ' ' + Util.GetGridViewString(gvr.Cells[2].Text);
                this.txt교과코드.Text = Util.GetGridViewString(gvr.Cells[3].Text) + ' ' + Util.GetGridViewString(gvr.Cells[4].Text);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드
    }
}