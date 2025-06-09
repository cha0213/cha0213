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
    public partial class FreshmanFeeEnrollStatistics2 : WebFormBase
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
            ddlSearchApplySeason.Items.Add(new ListItem("교장추천자", "12"));

            //2019-12-17 김동균 임시적으로 '전체'를 삭제 (편입,심화 모두 표에 바인딩 됨. '정규과정(전체)'를 이용해서 보도록 유도)
            ddlSearchApplySeason.Items.RemoveAt(0);

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
                // SP 명 : USP_학사행정_입시_통계_지원경쟁률_조회_업그레이드

                Dictionary<string, object> dataParams = new Dictionary<string, object>();

                dataParams.Add("@Year", txtSearchApplyYear.Text);
                dataParams.Add("@pSelect", ddlSearchApplySeason.SelectedValue);
                dataParams.Add("@pGubun", rdGbn.SelectedValue);

                rv1.ShowReportByStoredProcedure("0001495001", "dbo.USP_학사행정_입시_통계_지원경쟁등록률_조회_업그레이드", dataParams);   // 실서버
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 이벤트
    }
}