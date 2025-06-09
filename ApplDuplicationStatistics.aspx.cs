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
    /// <summary>
    /// 메뉴정보 : 중복지원자 현황
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 2018.08.10/ 김예은 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    ///

    [PrincipalPermission(SecurityAction.Demand)]
    public partial class ApplDuplicationStatistics : WebFormBase
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
            COMMMethod.SetApplicationYearSeason(txtSearchApplyYear, ddlSearchApplySeason);

            ddlSearchApplySeason.Items.Add(new ListItem("수시(전체)", "10"));
            ddlSearchApplySeason.Items.Add(new ListItem("정시(전체)", "11"));
            ddlSearchApplySeason.Items.Add(new ListItem("정규과정(전체)", "13"));

            ddlSearchApplySeason.SelectedIndex = 0;
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트

        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            try
            {
                //SP 명 : USP_학사행정_입시_통계_중복지원자현황_조회_업그레이드

                Dictionary<string, object> dataParams = new Dictionary<string, object>();

                dataParams.Add("@year", txtSearchApplyYear.Text);

                if (rblPrintGubun.SelectedValue == "1") // 현황
                {
                    dataParams.Add("@season", ddlSearchApplySeason.SelectedValue == "%" ? "" : ddlSearchApplySeason.SelectedValue);
                    rv1.ShowReportByStoredProcedure("0001504001", "dbo.USP_학사행정_입시_통계_중복지원자현황_조회_업그레이드", dataParams);   // rptApplDuplicationStatistics
                }
                else    // 학생 정보
                {
                    dataParams.Add("@season", ddlSearchApplySeason.SelectedValue);
                    rv1.ShowReportByStoredProcedure("0001504002", "dbo.USP_학사행정_입시_통계_중복지원자현황_엑셀_업그레이드", dataParams);   // rptDuplicationStudent
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 엑셀 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc2Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_통계_중복지원자현황_엑셀_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", txtSearchApplyYear.Text);
                parameters.Add("@season", ddlSearchApplySeason.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        Util.ExcelDownLoad(this, ds, "중복지원자 리스트");
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

        #endregion 이벤트
    }
}