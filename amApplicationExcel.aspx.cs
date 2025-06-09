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
    public partial class amApplicationExcel : WebFormBase
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
            COMMMethod.SetApplicationYear(txtSearchYear);
            ddlSearchGubun.SelectedIndex = 0;
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.APL_Select_ApplicationExcel";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            string fileName = string.Empty;

            try
            {
                parameters.Add("@Year", txtSearchYear.Text);
                parameters.Add("@Type", ddlSearchGubun.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {

                        if (ddlSearchGubun.SelectedValue == "4")
                            fileName = "4. 정보공시 자료";

                        else if (ddlSearchGubun.SelectedValue == "5")
                            fileName = "5. 대졸자 전형 상세정보";

                        else
                            fileName = ddlSearchGubun.SelectedItem.Text;

                        
                        Util.ExcelDownLoad(this, ds, fileName + "("+ txtSearchYear.Text + ")");
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