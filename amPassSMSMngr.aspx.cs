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
    public partial class amPassSMSMngr : WebFormBase
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
                this.Retrieve();                
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            // 합격코드에 추가
            ddl합격코드조회.Items.Add(new ListItem("예비후보", "ZZ"));
            ddl합격코드입력.Items.Add(new ListItem("예비후보", "ZZ"));

            this.ClearInput();
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트

        public override void NewCmd(object sender, CommandEventArgs e)
        {
            try
            {
                this.ClearInput();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            try
            {
                this.ClearInput();
                this.Retrieve();

            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        public override void SaveCmd(object sender, CommandEventArgs e)
        {
			try
            {               
                string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리_SMS문장관리_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@rowstate", "C");
                parameters.Add("@pass", ddl합격코드입력.SelectedValue);
                parameters.Add("@SmsContent", txtSMS문장.Text);
                parameters.Add("@AutoSend", rbl자동발송.SelectedValue);

                parameters.Add("@ProcessID", UserId);
                parameters.Add("@ProcessIP", UserIp);


                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    ddl합격코드입력.Enabled = false;
                    this.Retrieve();
                    CommonMessage.AlertMessage(this, 202);
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
               
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리_SMS문장관리_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                foreach (GridViewRow item in grdList.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[3].Controls[1]).Checked)
                        {
                            parameters.Add("@rowstate", "D");
                            parameters.Add("@pass", Util.GetGridViewString(item.Cells[4].Text));

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve();
                    this.ClearInput();
                    CommonMessage.AlertMessage(this, 203);
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        /// <summary>
        /// 그리드 리스트 Row 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow gvr = ((Control)e.CommandSource).NamingContainer as GridViewRow;
                this.SelectItem(gvr);

                this.grdList.SelectIndex(e, "SELECT");
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }



        #endregion 이벤트

        #region 메소드

        private void ClearInput()
        {
            try
            {
                ddl합격코드입력.SelectedIndex = 0;
                ddl합격코드입력.Enabled = true;
                rbl자동발송.SelectedIndex = 0;
                txtSMS문장.Text = string.Empty;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        private void Retrieve()
        {
            try
            {
                string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리_SMS문장관리_조회_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@pass", ddl합격코드조회.SelectedValue.Trim());

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    grdList.DataBindGrid(ds, ExDataCounter);
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

        private void DeleteItem()
        {
            //try
            //{
            //    string spName = "dbo.USP_학사행정_장학_장학관리_장학입력_파일업로드_등록_업그레이드";
            //    var parameters = new DataParameterCollection();
            //    var shell = new DataCommandShell();
            //    var dataCommands = new List<DataCommand>();

            //    parameters.Add("@STATE", "D");
            //    parameters.Add("@Type", rblGubun.SelectedValue == "01" ? "2" : "1");

            //    shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);

            //    dataCommands = shell.Execute();

            //    if (shell.ErrorCode == 0)
            //    {
            //        //CommonMessage.AlertMessage(this, 203);
            //    }
            //    else
            //    {
            //        CommonMessage.AlertMessage(this, shell.ErrorMessage);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    CommonMessage.AlertMessage(this, ex.ToString());
            //}
        }

        private void SelectItem(GridViewRow gvr)
        {
            try
            {
                ddl합격코드입력.SelectedValue = Util.GetGridViewString(gvr.Cells[4].Text);
                rbl자동발송.SelectedValue = Util.GetGridViewString(gvr.Cells[5].Text);
                //txtSMS문장.Text = Util.GetGridViewString(((LinkButton)gvr.Cells[1].Controls[1]).Text);
                txtSMS문장.Text = Util.GetGridViewString(gvr.Cells[6].Text);

                ddl합격코드입력.Enabled = false;
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드
    }
}