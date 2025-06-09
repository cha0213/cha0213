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
	///  메뉴정보 : 고교별 지원/합격/등록인원 현황
	///  수정이력
	///  1. 작성일자 / 작성자 / 최초작성
	///	  -  2018.08.10 / 송준혁 / 최초작성
	///	  2. 수정일자 / 수정자 / 수정내용
	/// </summary>
	/// 

	[PrincipalPermission(SecurityAction.Demand)]
    public partial class highClassGradeList22 : WebFormBase
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
            //ddlSearchApplyArea.SelectedIndex = 0;
        }

        private void SetScriptForClientEvent()
        {
        }
        #endregion 초기화

        #region 메서드

        private void ShowReportInvoker()
        {
            Dictionary<string, object> dataParams = new Dictionary<string, object>();
            //dataParams.Add("StayType", ddlStayType.SelectedValue);
            //dataParams.Add("OrgID", ddlLesson.SelectedValue);
            //dataParams.Add("Grade", ddlGrade.SelectedValue);
            //dataParams.Add("StudentNO", studNoSearch2.학번);
            dataParams.Add("year", txtSearchApplyYear.Text);
            dataParams.Add("season", ddlSearchApplySeason.SelectedValue == "%" ? "" : ddlSearchApplySeason.SelectedValue);

            ReportInvoker.ShowReportByStoredProcedure("0001507001", "dbo.USP_학사행정_입시_통계_고교별지원합격등록인원현황_조회_업그레이드", dataParams);   // rptHighClassGradeList22
        }

        #endregion 메서드

        #region 이벤트
        public override void Etc1Cmd(object sender, CommandEventArgs e)
		{
			try
			{
                ShowReportInvoker();

                //Dictionary<string, object> dataParams = new Dictionary<string, object>();

                //dataParams.Add("@year", txtSearchApplyYear.Text);
                //dataParams.Add("@season", ddlSearchApplySeason.SelectedValue == "%" ? "" : ddlSearchApplySeason.SelectedValue);

                //rv1.ShowReportByStoredProcedure("0001507001", "dbo.USP_학사행정_입시_통계_고교별지원합격등록인원현황_조회_업그레이드", dataParams);   // rptHighClassGradeList22
            }
            catch (Exception ex)
			{
				CommonMessage.AlertMessage(this, ex.ToString());
			}
		}
		#endregion 이벤트
	}
}