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
    public partial class highSchoolScoreMngr : WebFormBase
    {
        #region 초기화

        protected int ROW_NUM = 10;
        protected int page_num;

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

                if (!string.IsNullOrEmpty(Request["Year"]))
                    txtSearchApplYear.Text = HttpUtility.UrlDecode(Request["Year"] as string);
                if (!string.IsNullOrEmpty(Request["Season"]))
                    ddlSearchApplSeason.SelectedValue = HttpUtility.UrlDecode(Request["Season"] as string);

                if (!string.IsNullOrEmpty(Request["StudNo"]))
                    StudSearch.학번 = HttpUtility.UrlDecode(Request["StudNo"] as string);

                if (!string.IsNullOrEmpty(Request["StudNM"]))
                    StudSearch.성명 = HttpUtility.UrlDecode(Request["StudNM"] as string);

                if (!string.IsNullOrEmpty(Request["PageNo"]))
                    this.page_num = Convert.ToInt32(Request["PageNo"] as string);
                else
                    this.page_num = 1;

                this.Retrieve(true);
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            this.initPage();
            // 지원연도, 지원시기 셋팅
            COMMMethod.SetApplicationYearSeason(txtSearchApplYear, ddlSearchApplSeason);

            ((StudSearchControl)StudSearch).Year = txtSearchApplYear.Text;
            ((StudSearchControl)StudSearch).Season = string.Empty;
        }

        private void SetScriptForClientEvent()
        {
            ((Button)ExToolBar2.FindControl("Save")).Attributes["onClick"] = "StudentFileUpload(); return false;";
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
            this.Retrieve(false);
        }

        /// <summary>
        /// 그리드 리스트 Row 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;

                lblrecpNo1.Text = ((LinkButton)gvr.Cells[1].Controls[1]).Text.Trim();
                lblStudentName1.Text = gvr.Cells[2].Text;
                lblrecpNo2.Text = ((LinkButton)gvr.Cells[1].Controls[1]).Text.Trim();
                lblStudentName2.Text = gvr.Cells[2].Text;

                string ApplYear = gvr.Cells[8].Text;
                string ApplSeason = gvr.Cells[9].Text;
                string SocialNumber = gvr.Cells[10].Text;

                this.RetrieveDetail(ApplYear, ApplSeason, SocialNumber);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        #endregion 이벤트

        #region 메소드

        private void initPage()
        {
            try
            {
                txtSearchApplYear.Text = string.Empty;
                ddlSearchApplSeason.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ClearDetail()
        {
            try
            {
                lblrecpNo1.Text = string.Empty;
                lblStudentName1.Text = string.Empty;
                lblrecpNo2.Text = string.Empty;
                lblStudentName2.Text = string.Empty;

                this.grdList2.ClearDataSource(ExDataCounter2);
                this.grdList3.ClearDataSource(ExDataCounter3);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Retrieve(bool PAGE_YN)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부등록_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", txtSearchApplYear.Text);
                parameters.Add("@ApplSeason", ddlSearchApplSeason.SelectedValue);
                parameters.Add("@StudentNo", StudSearch.학번);
                parameters.Add("@Page", PAGE_YN ? this.page_num : 1);
                parameters.Add("@TotalRecord", ROW_NUM);

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
                            string strTotalCount = ds.Tables[0].Rows[0]["TOTAL_COUNT"].ToString();
                            this.grdList1.DataBindGrid(ds, this.ExDataCounter1);
                            ExDataCounter1.DataCount = strTotalCount.ToInt32();
                            SetPage(PAGE_YN ? this.page_num : 1, Convert.ToInt32(strTotalCount));
                        }
                        else
                        {
                            this.grdList1.ClearDataSource(ExDataCounter1);
                            SetPage(1, 0);
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
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath + "?Year=" + HttpUtility.UrlEncode(txtSearchApplYear.Text)
                                                          + "&Season=" + HttpUtility.UrlEncode(ddlSearchApplSeason.SelectedValue)
                                                          + "&StudNo=" + HttpUtility.UrlEncode(StudSearch.학번)
                                                          + "&StudNM=" + HttpUtility.UrlEncode(StudSearch.성명);

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        private void RetrieveDetail(string applyear, string applseason, string socialnumber)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부등록_상세조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", applyear);
                parameters.Add("@ApplSeason", applseason);
                parameters.Add("@SocialNumber", socialnumber);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                DataSet ds = null;
                DataTable table = null;
                if (shell.ErrorCode == 0)
                {
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

                    this.grdList2.DataBindGrid(ds.Tables[0], this.ExDataCounter2);
                    this.grdList3.DataBindGrid(ds.Tables[1], this.ExDataCounter3);
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

        #endregion 메소드
    }
}