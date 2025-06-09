using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
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
    /// 메뉴정보 : 학생부 등급 현황
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 20108.08.10 / 김예은 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    ///

    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreStatistics : WebFormBase
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
            COMMMethod.SetApplicationYear(txtSearchApplyYear);
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트

        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();

                dataParams.Add("year", txtSearchApplyYear.Text);
                dataParams.Add("gubun", rdApplySeasonGbn.SelectedValue);

                rv1.ShowReportByStoredProcedure("0001512001", "dbo.USP_학사행정_입시_통계_합격자학생부등급_조회_업그레이드", dataParams);   // rptHighSchoolScoreStatistics1
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트
    }
}