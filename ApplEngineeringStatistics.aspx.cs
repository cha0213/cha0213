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
    /// 메뉴정보 : 학생부 / 수능등급 현황
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 20108.08.17 / 송준혁 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    ///

    [PrincipalPermission(SecurityAction.Demand)]
    public partial class ApplEngineeringStatistics : WebFormBase
    {
        #region 초기화

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
            }
            this.SetScriptForClientEvent();
        }

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYear(txtSearchApplyYear);

            ddlSearchApplySeason.Items.Add(new ListItem("수시(전체)", "10"));
            ddlSearchApplySeason.Items.Add(new ListItem("정시(전체)", "11"));
            ddlSearchApplySeason.Items.Add(new ListItem("정규과정(전체)", "13"));
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
                Dictionary<string, object> dataParams = new Dictionary<string, object>();

                dataParams.Add("year", txtSearchApplyYear.Text);
                dataParams.Add("season", ddlSearchApplySeason.SelectedValue);
                dataParams.Add("passgubun", rdlPassGbn.SelectedValue);

                rv1.ShowReportByStoredProcedure("0001516001", "dbo.USP_학사행정_입시_통계_공학계열신입생현황_조회_업그레이드", dataParams);
                //rv1.ShowReportByStoredProcedure("0001517001", "dbo.USP_학사행정_입시_통계_공학계열신입생현황_조회_업그레이드", dataParams);   // 로컬
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트
    }
}