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

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreCalculateMngr : WebFormBase
    {
        protected int ROW_NUM = 15;
        protected int page_num;

        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindDdl.Click += BtnReBindDdl_Click;
            btnReSearch.Click += BtnReSearch_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
                this.SetControlValueByParam();
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txtSearchApplYear, ddlSearchApplSeason);    // 지원연도, 지원시기

            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplYear.Text);  //전형구분(조회조건) 바인딩
            COMMMethod.SetDDLMajorCode(ddlSearchApplOrgID, txtSearchApplYear.Text);       //지원학과(조회조건) 바인딩

            ((StudSearchControl)StudSearch).Year = this.txtSearchApplYear.Text;
            ((StudSearchControl)StudSearch).Season = string.Empty;
        }

        private void SetScriptForClientEvent()
        {
        }

        private void SetControlValueByParam()
        {
            if (!string.IsNullOrEmpty(Request["year"]))
                txtSearchApplYear.Text = HttpUtility.UrlDecode(Request["year"].ToString());

            if (!string.IsNullOrEmpty(Request["season"]))
                ddlSearchApplSeason.SelectedValue = HttpUtility.UrlDecode(Request["season"].ToString());

            if (!string.IsNullOrEmpty(Request["sppoClsCode"]))
                ddlSearchGubun.SelectedValue = HttpUtility.UrlDecode(Request["sppoClsCode"].ToString());

            if (!string.IsNullOrEmpty(Request["orgID"]))
                ddlSearchApplOrgID.SelectedValue = HttpUtility.UrlDecode(Request["orgID"].ToString());

            if (!string.IsNullOrEmpty(Request["StudNo"]))
                StudSearch.학번 = HttpUtility.UrlDecode(Request["StudNo"].ToString());

            if (!string.IsNullOrEmpty(Request["StudNM"]))
                StudSearch.성명 = HttpUtility.UrlDecode(Request["StudNM"].ToString());

            if (!string.IsNullOrEmpty(Request["PageNo"]))
                this.page_num = Convert.ToInt32(Request["PageNo"] as string);
            else
                this.page_num = 1;

            this.Retrieve(true);
            RetrieveVerification();
        }

        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath + "?year=" + HttpUtility.UrlEncode(txtSearchApplYear.Text)
                                                          + "&season=" + HttpUtility.UrlEncode(ddlSearchApplSeason.SelectedValue)
                                                          + "&sppoClsCode=" + HttpUtility.UrlEncode(ddlSearchGubun.SelectedValue)
                                                          + "&orgID=" + HttpUtility.UrlEncode(ddlSearchApplOrgID.SelectedValue)
                                                          + "&StudNo=" + HttpUtility.UrlEncode(StudSearch.학번)
                                                          + "&StudNM=" + HttpUtility.UrlEncode(StudSearch.성명);

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
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
            try
            {
                this.Retrieve(false);
                this.RetrieveVerification();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출_내신성적산출_업그레이드";
            //string spName = "dbo.USP_학사행정_입시_성적사정_성적산출_내신성적산출_";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                parameters.Add("@Year", txtSearchApplYear.Text);
                parameters.Add("@Season", ddlSearchApplSeason.SelectedValue);
                parameters.Add("@pass", "30");

                spName += txtSearchApplYear.Text + ddlSearchApplSeason.SelectedItem.Text;

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, "성적산출이 정상적으로 수행 되었습니다");
                    this.Retrieve(true);
                    this.RetrieveVerification();
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

        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplYear.Text);  //전형구분(조회조건) 바인딩
            COMMMethod.SetDDLMajorCode(ddlSearchApplOrgID, txtSearchApplYear.Text);       //지원학과(조회조건) 바인딩

            ((StudSearchControl)StudSearch).Year = this.txtSearchApplYear.Text.Trim();
            ((StudSearchControl)StudSearch).Season = string.Empty;
        }

        /// <summary>
        /// 1,2,3학생 성적 미존재 학생 리스트 에서
        /// 체크박스(대학(전문대)졸업자 전형 제외 또는 3학년 2학기 성적 제외) 변경시
        /// 리스트 재조회
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReSearch_Click(object sender, EventArgs e)
        {
            this.RetrieveVerification();
        }

        #endregion 이벤트

        #region 메소드

        private void Retrieve(bool isPage)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplYear.Text);
                parameters.Add("@Season", ddlSearchApplSeason.SelectedValue);
                parameters.Add("@MajorCode", ddlSearchApplOrgID.SelectedValue);
                parameters.Add("@SppoClsCode", ddlSearchGubun.SelectedValue);
                parameters.Add("@RecpNo", StudSearch.학번);
                parameters.Add("@페이지넘버", isPage ? this.page_num : 1);
                parameters.Add("@보여줄출력물갯수", ROW_NUM);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                DataSet ds = null;
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
                            string strTotalCount = ds.Tables[0].Rows[0]["TOTAL_COUNT"].ToString();
                            this.grdList.DataBindGrid(ds, this.ExDataCounter1);
                            ExDataCounter1.DataCount = strTotalCount.ToInt32();
                            SetPage(isPage ? this.page_num : 1, Convert.ToInt32(strTotalCount));
                        }
                        else
                        {
                            this.grdList.ClearDataSource();
                            ExDataCounter1.DataCount = 0;
                            SetPage(1, 0);
                        }
                    }
                    //	SetPage(isPage ? hdnPageNo.Value.ToInt32() : 1, totalRecord.ToInt32());

                    //	foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                    //                   {
                    //                       table = tbl;
                    //                   }

                    //                   ds = table.DataSet;
                    //               }
                    //else
                    //{
                    //	SetPage(1, 0);
                    //}
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

        private void RetrieveVerification()
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적산출_검증리스트_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplYear.Text);
                parameters.Add("@Season", ddlSearchApplSeason.SelectedValue);
                parameters.Add("@MajorCode", ddlSearchApplOrgID.SelectedValue);
                parameters.Add("@SppoClsCode", ddlSearchGubun.SelectedValue);
                parameters.Add("@RecpNo", StudSearch.학번);
                parameters.Add("@ScoreExceptYN", chkScoreExceptYN.Checked == true ? "Y" : "N");
                parameters.Add("@CollegeExceptYN", chkCollegeExceptYN.Checked == true ? "Y" : "N");

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                DataSet ds = null;
                DataTable table = null;
                if (shell.ErrorCode == 0)
                {
                    ds = dataCommands[0].DataSet;

                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                        {
                            table = tbl;
                        }
                        ds = table.DataSet;
                    }
                    this.grdList_verifi1.DataBindGrid(ds.Tables[0], this.ExDataCounter2);
                    this.grdList_verifi2.DataBindGrid(ds.Tables[1], this.ExDataCounter3);
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

        #endregion 메소드
    }
}