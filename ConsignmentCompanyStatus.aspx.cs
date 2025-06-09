using System;
using System.Collections.Generic;
using System.Linq;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL.COFF;
using IFW.Data;
using IFW.WebUI;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Security.Permissions;

namespace KJC.IMS.ENTR.StaffMngr
{
    /// <summary>
    /// 메뉴정보 : 산업체위탁교육 모집결과 (산업체 현황)
    /// </summary>
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class ConsignmentCompanyStatus : WebFormBase
    {

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindDdl.Click += BtnReBindDdl_Click;  // 연도 변경시 학과 바인딩
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.InitPageSetting();
            }
        }
        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYear(txtSearchYear);
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchYear.Text);
            ddlSearchApplyOrgID.SelectedIndex = 0;
        }

        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchYear.Text);
        }
    }
}