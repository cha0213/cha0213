using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KJC.IMS.ENTR.StaffMngr
{
    public partial class amPassPreviewSMS : WebFormBase
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
                // 부모창에서 넘어 온 저장 될 합격코드 스트링
                string ArrayPassCode = Request["PassCodeString"].ToString();
                
                this.InitPageSetting();
                this.Retrieve(ArrayPassCode);
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

        #region 이벤트
        


        /// <summary>
        /// 그리드 리스트 Row 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //try
            //{
            //    GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;
            //    this.SelectItem(gvr);

            //    this.grdList.SelectIndex(e, "SELECT");
            //}
            //catch (Exception ex)
            //{
            //    CommonMessage.AlertMessage(this, ex.Message);
            //}
        }
        

        #endregion 이벤트

        #region 메소드

        private void Retrieve(string ArrPassCode)
        {
            try
            {
                string queryPass = string.Empty;
                if(ArrPassCode.Length > 0)
                {
                    string[] arr = ArrPassCode.Split('|');

                    for(int i = 0; i < arr.Length; i++)
                    {
                        queryPass += ",'" + arr[i] + "'";
                    }

                    queryPass = queryPass.Substring(1);
                }
                


                string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리_SMS문장관리_조회_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();
                parameters.Add("@pass", "%");

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataTable dt = dataCommands[0].DataSet.Tables[0];

                    DataRow[] drList = dt.Select("pass IN (" + queryPass + ")");

                    DataTable dtTemp = dt.Clone();
                    foreach (DataRow row in drList)
                    {
                        dtTemp.ImportRow(row);
                    }

                    grdList.DataBindGrid(dtTemp, ExDataCounter);
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
        #endregion 메소드
    }
}