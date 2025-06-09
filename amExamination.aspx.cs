using IFW.Data;
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
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amExamination : WebFormBase
    {
        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBind.Click += BtnReBind_Click; // 지원연도 변경시 지원학과 재바인딩(UpdatePanel)
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
            // 지원연도
            COMMMethod.SetApplicationYear(this.txtYear);
            // 지원학과
            COMMMethod.SetDDLMajorCode(this.ddlOrgID, this.txtYear.Text.Trim());
        }

        private void SetScriptForClientEvent()
        {
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

                dataParams.Add("@Year", txtYear.Text);
                dataParams.Add("@Season", ddlSeason.SelectedValue);
                dataParams.Add("@major", ddlOrgID.SelectedValue);
                dataParams.Add("@Neis", "%%");

                if (ddlSeason.SelectedValue == "7")  // 전공심화
                {
                    //rv1.ShowReportByStoredProcedure("0001487001", "dbo.APL_Select_applicationMasterInterViewList", dataParams);   // 개발 DB
                    rv1.ShowReportByStoredProcedure("0001489001", "dbo.APL_Select_applicationMasterInterViewList", dataParams);   // 실 DB
                }
                else if (ddlSeason.SelectedValue == "8") // 편입
                {
                    rv1.ShowReportByStoredProcedure("0001489003", "dbo.APL_Select_applicationMasterInterViewList", dataParams); // 실 DB
                }
                else if (ddlSeason.SelectedValue == "9") // 위탁
                {
                    //rv1.ShowReportByStoredProcedure("0001487002", "dbo.APL_Select_applicationMasterInterViewList", dataParams); // 개발 DB
                    rv1.ShowReportByStoredProcedure("0001489002", "dbo.APL_Select_applicationMasterInterViewList", dataParams); // 실 DB
                }
                else if (ddlSeason.SelectedValue == "A") // 특별편입학
                {
                    //rv1.ShowReportByStoredProcedure("0001487002", "dbo.APL_Select_applicationMasterInterViewList", dataParams); // 개발 DB
                    rv1.ShowReportByStoredProcedure("0001489004", "dbo.APL_Select_applicationMasterInterViewList", dataParams); // 실 DB
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 지원연도 변경시 지원학과 재바인딩(UpdatePanel)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBind_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(this.ddlOrgID, this.txtYear.Text.Trim());
        }

        #endregion 이벤트
    }
}