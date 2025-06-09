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
    public partial class QualificationScoreMngr : WebFormBase
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
            this.initPage();
            // 지원연도, 지원시기 셋팅
            COMMMethod.SetApplicationYearSeason(txtSearchApplYear, ddlSearchApplSeason);
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
            this.Retrieve();
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
                
                string ApplYear = gvr.Cells[9].Text;
                string ApplSeason = gvr.Cells[10].Text;
                string SocialNumber = gvr.Cells[11].Text;

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
                
                this.grdList2.ClearDataSource(ExDataCounter2);                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void Retrieve()
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_검정고시등록_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@ApplYear", txtSearchApplYear.Text);
                parameters.Add("@ApplSeason", ddlSearchApplSeason.SelectedValue);               

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

                    this.grdList1.DataBindGrid(ds, this.ExDataCounter1);
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

        private void RetrieveDetail(string applyear, string applseason, string socialnumber)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_검정고시등록_상세조회_업그레이드";
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