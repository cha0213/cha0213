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
	///  메뉴정보 : 졸업연도별 지원/합격/등록인원 현황
	///  수정이력
	///  1. 작성일자 / 작성자 / 최초작성
	///	  -  2018.08.10 / 송준혁 / 최초작성
	///	  2. 수정일자 / 수정자 / 수정내용
	/// </summary>
	/// 

	[PrincipalPermission(SecurityAction.Demand)]
	public partial class highClassGradeList8 : WebFormBase
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
                string sp_Name = string.Empty;

                Dictionary<string, object> dataParams = new Dictionary<string, object>();

                dataParams.Add("@year", txtSearchApplyYear.Text);
                dataParams.Add("@season", ddlSearchApplySeason.SelectedValue == "%" ? "" : ddlSearchApplySeason.SelectedValue);

                if (rdGbn.SelectedValue == "01")                    // 지원자
                {
                    sp_Name = "dbo.USP_학사행정_입시_통계_졸업연도별지원자인원현황_조회_업그레이드";
                }
                else if (rdGbn.SelectedValue == "02")               // 합격자 
                {
                    sp_Name = "dbo.USP_학사행정_입시_통계_졸업연도별합격자인원현황_조회_업그레이드";
                }
                else                                                // 등록자
                {
                    sp_Name = "dbo.USP_학사행정_입시_통계_졸업연도별등록자인원현황_조회_업그레이드";
                }

                rv1.ShowReportByStoredProcedure("0001510001", sp_Name, dataParams);   // rptHighClassGradeList8
            }
			catch (Exception ex)
			{
				CommonMessage.AlertMessage(this, ex.ToString());
			}
		}
		#endregion 이벤트
	}
}