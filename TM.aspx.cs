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
/// 메뉴정보 : 입시 > 지원자관리 > 통화기록 대장
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.12.04 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class TM : WebFormBase
    {
        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindDdl.Click += BtnReBindDdl_Click;   //연도 변경시 전형구분, 학과계열 바인딩
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
            //전형구분
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분, this.txt연도.Text.Trim());
            //학과계열
            COMMMethod.SetDDLMajorCode(this.ddl학과계열, this.txt연도.Text.Trim());
			//합격구분
			this.ddl합격구분.Items.Insert(0, new ListItem("합격자(등록자포함)", "ZZ"));

			this.ddl합격구분.SelectedValue = "ZZ"; //합격자(등록자포함)
        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar4.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 인쇄 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("ApplYear", txt연도.Text);
                dataParams.Add("ApplSeason", ddl시기.SelectedValue);
                dataParams.Add("SppoClsCode", ddl전형구분.SelectedValue);
                dataParams.Add("MajorCode", ddl학과계열.SelectedValue);
                dataParams.Add("Pass", ddl합격구분.SelectedValue);

                rv2.ShowReportByStoredProcedure("0001440001", "dbo.USP_학사행정_입시_지원자관리_통화기록대장_조회_업그레이드", dataParams);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 연도 변경시 전형구분, 학과계열 바인딩
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분, this.txt연도.Text.Trim()); // 연도 변경시 전형구분 바인딩
            COMMMethod.SetDDLMajorCode(this.ddl학과계열, this.txt연도.Text.Trim());           // 연도 변경시 학과계열 바인딩
        }

        #endregion 이벤트
    }
}