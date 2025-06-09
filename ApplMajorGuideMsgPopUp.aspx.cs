using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
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
    public partial class ApplMajorGuideMsgPopUp : WebFormBase
    {
        protected string year = string.Empty, season = string.Empty, majorCd = string.Empty, passCd = string.Empty;

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
                if (!string.IsNullOrEmpty(Request["Year"]))
                    year = Request.QueryString["Year"];
                if (!string.IsNullOrEmpty(Request["Season"]))
                    season = Request.QueryString["Season"];
                if (!string.IsNullOrEmpty(Request["MajorCd"]))
                    majorCd = Request.QueryString["MajorCd"];
                if (!string.IsNullOrEmpty(Request["PassCd"]))
                    passCd = Request.QueryString["PassCd"];

                this.InitPageSetting();
                this.Retreive();
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 메소드

        private void Retreive()
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자안내관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", year);
                parameters.Add("@Season", season);
                parameters.Add("@MajorCd", majorCd);
                parameters.Add("@PassCd", passCd);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];

                        lblInfoMessage.Text = dr["Preview"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        #endregion 메소드
    }
}