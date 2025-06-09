using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL.COFF;
using System;
using System.Collections.Generic;
using System.Data;
using System.Security.Permissions;
using System.Web.UI.WebControls;
/// <summary>
/// 메뉴정보 : 입시 > SMS문자서비스 > SMS문자서비스(계열)
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.12.11 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class SendSMSMajor : WebFormBase
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
            COMMMethod.SetApplicationYearSeason(this.txt연도, this.ddl시기);       
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형, this.txt연도.Text.Trim());
            COMMMethod.SetDDLMajorCode(this.ddl계열, this.txt연도.Text.Trim());

            ExGridView grdSMS = ((ExGridView)this.ucSMS.FindControl("grdList"));
            grdSMS.Columns[1].HeaderText = "수험번호";

            StudSearch.Year = this.txt연도.Text.Trim();

            //var chkColumn = grdSMS.Columns[4];
            //grdSMS.Columns.RemoveAt(4);

            //BoundField boundField = new BoundField();
            //boundField.HeaderText = "전공";
            //boundField.DataField = "MajorName";
            //boundField.HeaderStyle.CssClass = "text-center";
            //boundField.HeaderStyle.Width = Unit.Percentage(15);
            //boundField.ItemStyle.CssClass = "text-center";
            //grdSMS.Columns.Insert(4, boundField);
            ////grdSMS.Columns.Add(boundField);

            //boundField = new BoundField();
            //boundField.HeaderText = "가상계좌";
            //boundField.DataField = "BankNO";
            //boundField.HeaderStyle.CssClass = "text-center";
            //boundField.HeaderStyle.Width = Unit.Percentage(15);
            //boundField.ItemStyle.CssClass = "text-center";
            //grdSMS.Columns.Insert(5, boundField);
            ////grdSMS.Columns.Add(boundField);

        }

        private void SetScriptForClientEvent()
        {
            
        }

        #endregion 초기화


        #region 이벤트

        /// <summary>
        /// 조회 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            try
            {
                Retrieve();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        protected void txt연도_TextChanged(object sender, EventArgs e)
        {
            try
            {
                StudSearch.Year = this.txt연도.Text.Trim();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        #endregion 이벤트


        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        public void Retrieve()
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_SMS문자서비스_SMS문자서비스계열_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", this.txt연도.Text.Trim());
                parameters.Add("@Season", this.ddl시기.SelectedValue);
                parameters.Add("@Pass", this.ddl구분.SelectedValue);
                parameters.Add("@MajorCode", this.ddl계열.SelectedValue);
                parameters.Add("@sppoClsCode", this.ddl전형.SelectedValue);
                parameters.Add("@RecpNo", this.StudSearch.학번);
                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();
            
                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        ds = dataCommands[0].DataSet;
                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            // Do something
                            this.ucSMS.DataBind(ds.Tables[0]);
                        }
                        else
                        {
                            this.ucSMS.ClearDataSource();
                        }
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




        #endregion 메소드

    }
}