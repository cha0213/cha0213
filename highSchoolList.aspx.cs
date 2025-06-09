using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL.COFF;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KJC.IMS.ENTR.StaffMngr
{
    /// <summary>
    /// 메뉴정보 : 입시 > 지원자관리 > 고교별지원자명단
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 2018.10.16 / 송준혁 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolList : WebFormBase
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

            ddlSearchApplySeason.SelectedIndex = 0;
            //ddlSearchApplyArea.SelectedIndex = 0;

            this.ddlGbn.Items.Add(new ListItem("최종등록자(최초+충원)", "31"));
        }

        private void SetScriptForClientEvent()
        {

        }
        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 인쇄클릭
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            try
            {
                ShowReportInvoker();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트

        #region 메서드

        /// <summary>
        /// 리포트
        /// </summary>
        private void ShowReportInvoker()
        {
            Dictionary<string, object> dataParams = new Dictionary<string, object>();

            dataParams.Add("year", txtSearchApplyYear.Text);
            dataParams.Add("season", ddlSearchApplySeason.SelectedValue);
            dataParams.Add("pass", ddlGbn.SelectedValue);
            dataParams.Add("schoolName", txtNeisName.neisName);
            dataParams.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

            if (ddlGbn.SelectedValue == "%")
            {
                ReportInvoker.ShowReportByStoredProcedure("0001538003", "dbo.USP_학사행정_입시_지원자관리_고교별지원자명단(전체)_조회_업그레이드", dataParams);   // rptHighClassGradeList22
            }
            else
            {
                ReportInvoker.ShowReportByStoredProcedure("0001538001", "dbo.USP_학사행정_입시_지원자관리_고교별지원자명단_조회_업그레이드", dataParams);   // rptHighClassGradeList22
            }        
        }

        #endregion 메서드        
    }
}