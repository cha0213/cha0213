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
/// 메뉴정보 : 입시 > 지원자관리 > 면접/합격 대장
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.12.04 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amPassList : WebFormBase
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
            //연도, 시기
            COMMMethod.SetApplicationYearSeason(this.txt연도, this.ddl시기);
        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar4.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
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
                this.Retrieve();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
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
                string pass = rdo구분.SelectedValue;
                string printNum = string.Empty;
                string spName = string.Empty;

                if (pass == "30")    // 면접대상자
                {
                    printNum = "0001436006";
                    spName = "dbo.APL_Select_PassList";
                }
                else if (pass == "09")   // 합격자
                {
                    printNum = "0001436006";
                    spName = "dbo.APL_Select_PassList_S";
                }
                else if (pass == "06") //후보자
                {
                    printNum = "0001436006";
                    spName = "dbo.APL_Select_PassList_HH";
                }
                else if (pass == "04")    // 불합격자
                {
                    printNum = "0001439001";
                    spName = "dbo.APL_Select_PassList_HH";
                }

                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("year", txt연도.Text);
                dataParams.Add("season", ddl시기.SelectedValue);
                dataParams.Add("pass", pass);

				ReportInvoker1.ShowReportByStoredProcedure(printNum, spName, dataParams);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 그리드 데이터 조회
        /// </summary>
        private void Retrieve()
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_지원자관리_면접합격대장_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", this.txt연도.Text.Trim());
                parameters.Add("@season", this.ddl시기.SelectedValue);
                parameters.Add("@pass", this.rdo구분.SelectedValue);

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
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 메소드
    }
}