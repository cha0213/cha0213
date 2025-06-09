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
    public partial class ApplSearchPrintInfo : WebFormBase
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
            COMMMethod.SetApplicationYearSeason(txtApplyYear, ddlApplySeason);

        }

        private void SetScriptForClientEvent()
        {
            if (rblSearchPrintGubun.SelectedValue == "3" || rblSearchPrintGubun.SelectedValue == "4")
            {
                rblSearchPassGubun.Enabled = true;
            }
            if (rblPrintGubun.SelectedValue == "3" || rblPrintGubun.SelectedValue == "4")
            {
                rblPassGubun.Enabled = true;
            }
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
            this.ClearDetail();

            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회출력정보관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@PrintGubun", rblSearchPrintGubun.SelectedValue);
                parameters.Add("@PassGubun", rblSearchPrintGubun.SelectedValue != "3" && rblSearchPrintGubun.SelectedValue != "4" ? "01" : rblSearchPassGubun.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    txtApplyYear.Text = txtSearchApplyYear.Text;
                    ddlApplySeason.SelectedValue = ddlSearchApplySeason.SelectedValue;
                    rblPrintGubun.SelectedValue = rblSearchPrintGubun.SelectedValue;
                    rblPassGubun.SelectedValue = rblSearchPassGubun.SelectedValue;
                    if (rblSearchPrintGubun.SelectedValue == "4")
                    {
                        rblSearchPassGubun.Enabled = true;
                        rblPassGubun.Enabled = true;
                    }
                    else {
                        rblSearchPassGubun.Enabled = false;
                        rblPassGubun.Enabled = false;
                    }
                    if (rblPrintGubun.SelectedValue == "3" || rblPrintGubun.SelectedValue == "4")
                        this.ControlReadonly(false); //컨트롤 readonly 처리 : ControlReadonly(TextBox)
                    else
                        this.ControlReadonly(true);

                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];

                        //txtApplyYear.Text = dr["Year"].ToString();
                        //ddlApplySeason.SelectedValue = dr["Season"].ToString();
                        //rblPrintGubun.SelectedValue = dr["ReportGubun"].ToString();

                        if (rblSearchPrintGubun.SelectedValue == "3" || rblPrintGubun.SelectedValue == "4")
                        {
                            txtText1.Text = dr["Text1"].ToString();
                            txtText2.Text = dr["Text2"].ToString();
                            txtText3.Text = dr["Text3"].ToString();
                            txtText4.Text = dr["Text4"].ToString();
                            txtText5.Text = dr["Text5"].ToString();
                            txtText6.Text = dr["Text6"].ToString();
                            txtText7.Text = dr["Text7"].ToString();
                            txtText8.Text = dr["Text8"].ToString();
                            txtText9.Text = dr["Text9"].ToString();
                            txtText10.Text = dr["Text10"].ToString();
                            txtText11.Text = dr["Text11"].ToString();
                            txtText12.Text = dr["Text12"].ToString();
                            txtText13.Text = dr["Text13"].ToString();
                            txtText14.Text = dr["Text14"].ToString();
                            txtText15.Text = dr["Text15"].ToString();
                            txtText16.Text = dr["Text16"].ToString();
                            txtText17.Text = dr["Text17"].ToString();
                            txtText18.Text = dr["Text18"].ToString();
                            txtText19.Text = dr["Text19"].ToString();
                            txtText20.Text = dr["Text20"].ToString();
                            txtText21.Text = dr["Text21"].ToString();
                            txtText22.Text = dr["Text22"].ToString();

                            rblImport1.SelectedValue = dr["Import1"].ToString();
                            rblImport2.SelectedValue = dr["Import2"].ToString();
                            rblImport3.SelectedValue = dr["Import3"].ToString();
                            rblImport4.SelectedValue = dr["Import4"].ToString();
                            rblImport5.SelectedValue = dr["Import5"].ToString();
                            rblImport6.SelectedValue = dr["Import6"].ToString();
                            rblImport7.SelectedValue = dr["Import7"].ToString();
                            rblImport8.SelectedValue = dr["Import8"].ToString();
                            rblImport9.SelectedValue = dr["Import9"].ToString();
                            rblImport10.SelectedValue = dr["Import10"].ToString();
                            rblImport11.SelectedValue = dr["Import11"].ToString();
                            rblImport12.SelectedValue = dr["Import12"].ToString();
                            rblImport13.SelectedValue = dr["Import13"].ToString();
                            rblImport14.SelectedValue = dr["Import14"].ToString();
                            rblImport15.SelectedValue = dr["Import15"].ToString();
                            rblImport16.SelectedValue = dr["Import16"].ToString();
                            rblImport17.SelectedValue = dr["Import17"].ToString();
                            rblImport18.SelectedValue = dr["Import18"].ToString();
                            rblImport19.SelectedValue = dr["Import19"].ToString();
                            rblImport20.SelectedValue = dr["Import20"].ToString();
                            rblImport21.SelectedValue = string.IsNullOrEmpty(dr["Import21"].ToString()) ? "N" : dr["Import21"].ToString();
                            rblImport22.SelectedValue = string.IsNullOrEmpty(dr["Import22"].ToString()) ? "N" : dr["Import22"].ToString();
                        }
                        else
                        {
                            txtPrintDate.SelectedDate = dr["Text1"].ToString();
                        }
                    }
                    //else {
                    //    this.txtApplyYear.ReadOnly = false;
                    //    this.ddlApplySeason.Enabled = true;
                    //    this.rblPassGubun.Enabled = true;
                    //    this.rblPrintGubun.Enabled = true;
                    //}

                    this.txtApplyYear.ReadOnly = true;
                    this.ddlApplySeason.Enabled = false;
                    this.rblPassGubun.Enabled = false;
                    this.rblPrintGubun.Enabled = false;
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

        public override void NewCmd(object sender, CommandEventArgs e)
        {
            ClearDetail();
            this.txtApplyYear.ReadOnly = false;
            this.ddlApplySeason.Enabled = true;
            this.rblPassGubun.Enabled = true;
            this.rblPrintGubun.Enabled = true;
        }

        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회출력정보관리_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                //if(txtApplyYear.ReadOnly == false) {
                //    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회출력정보관리_등록_업그레이드";
                //}
                //else {
                //    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회출력정보관리_수정_업그레이드";
                //}

                parameters.Add("@Year", txtApplyYear.Text);
                parameters.Add("@Season", ddlApplySeason.SelectedValue);
                parameters.Add("@PrintGubun", rblPrintGubun.SelectedValue);
                parameters.Add("@PassGubun", rblPrintGubun.SelectedValue != "3" && rblPrintGubun.SelectedValue != "4" ? "01" : rblPassGubun.SelectedValue);

                if (rblPrintGubun.SelectedValue != "3" && rblPrintGubun.SelectedValue != "4")
                    parameters.Add("@Text1", string.IsNullOrEmpty(txtPrintDate.SelectedDate) ? null : txtPrintDate.SelectedDate);

                else
                {
                    parameters.Add("@Text1", txtText1.Text);
                    parameters.Add("@Text2", txtText2.Text);
                    parameters.Add("@Text3", txtText3.Text);
                    parameters.Add("@Text4", txtText4.Text);
                    parameters.Add("@Text5", txtText5.Text);
                    parameters.Add("@Text6", txtText6.Text);
                    parameters.Add("@Text7", txtText7.Text);
                    parameters.Add("@Text8", txtText8.Text);
                    parameters.Add("@Text9", txtText9.Text);
                    parameters.Add("@Text10", txtText10.Text);
                    parameters.Add("@Text11", txtText11.Text);
                    parameters.Add("@Text12", txtText12.Text);
                    parameters.Add("@Text13", txtText13.Text);
                    parameters.Add("@Text14", txtText14.Text);
                    parameters.Add("@Text15", txtText15.Text);
                    parameters.Add("@Text16", txtText16.Text);
                    parameters.Add("@Text17", txtText17.Text);
                    parameters.Add("@Text18", txtText18.Text);
                    parameters.Add("@Text19", txtText19.Text);
                    parameters.Add("@Text20", txtText20.Text);
                    parameters.Add("@Text21", txtText21.Text);
                    parameters.Add("@Text22", txtText22.Text);

                    parameters.Add("@Import1", rblImport1.SelectedValue);
                    parameters.Add("@Import2", rblImport2.SelectedValue);
                    parameters.Add("@Import3", rblImport3.SelectedValue);
                    parameters.Add("@Import4", rblImport4.SelectedValue);
                    parameters.Add("@Import5", rblImport5.SelectedValue);
                    parameters.Add("@Import6", rblImport6.SelectedValue);
                    parameters.Add("@Import7", rblImport7.SelectedValue);
                    parameters.Add("@Import8", rblImport8.SelectedValue);
                    parameters.Add("@Import9", rblImport9.SelectedValue);
                    parameters.Add("@Import10", rblImport10.SelectedValue);
                    parameters.Add("@Import11", rblImport11.SelectedValue);
                    parameters.Add("@Import12", rblImport12.SelectedValue);
                    parameters.Add("@Import13", rblImport13.SelectedValue);
                    parameters.Add("@Import14", rblImport14.SelectedValue);
                    parameters.Add("@Import15", rblImport15.SelectedValue);
                    parameters.Add("@Import16", rblImport16.SelectedValue);
                    parameters.Add("@Import17", rblImport17.SelectedValue);
                    parameters.Add("@Import18", rblImport18.SelectedValue);
                    parameters.Add("@Import19", rblImport19.SelectedValue);
                    parameters.Add("@Import20", rblImport20.SelectedValue);
                    parameters.Add("@Import21", rblImport21.SelectedValue);
                    parameters.Add("@Import22", rblImport22.SelectedValue);
                }
                parameters.Add("@ID", UserId);
                parameters.Add("@IP", UserIp);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, 202);
                    this.txtApplyYear.ReadOnly = true;
                    this.ddlApplySeason.Enabled = false;
                    this.rblPassGubun.Enabled = false;
                    this.rblPrintGubun.Enabled = false;
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

        #region 메소드

        private void ControlReadonly(bool Btext)
        {
            try
            {
                txtText1.ReadOnly = Btext;
                txtText2.ReadOnly = Btext;
                txtText3.ReadOnly = Btext;
                txtText4.ReadOnly = Btext;
                txtText5.ReadOnly = Btext;
                txtText6.ReadOnly = Btext;
                txtText7.ReadOnly = Btext;
                txtText8.ReadOnly = Btext;
                txtText9.ReadOnly = Btext;
                txtText10.ReadOnly = Btext;
                txtText11.ReadOnly = Btext;
                txtText12.ReadOnly = Btext;
                txtText13.ReadOnly = Btext;
                txtText14.ReadOnly = Btext;
                txtText15.ReadOnly = Btext;
                txtText16.ReadOnly = Btext;
                txtText17.ReadOnly = Btext;
                txtText18.ReadOnly = Btext;
                txtText19.ReadOnly = Btext;
                txtText20.ReadOnly = Btext;
                txtText21.ReadOnly = Btext;
                txtText22.ReadOnly = Btext;

                rblImport1.Enabled = (Btext == true) ? false : true;
                rblImport2.Enabled = (Btext == true) ? false : true;
                rblImport3.Enabled = (Btext == true) ? false : true;
                rblImport4.Enabled = (Btext == true) ? false : true;
                rblImport5.Enabled = (Btext == true) ? false : true;
                rblImport6.Enabled = (Btext == true) ? false : true;
                rblImport7.Enabled = (Btext == true) ? false : true;
                rblImport8.Enabled = (Btext == true) ? false : true;
                rblImport9.Enabled = (Btext == true) ? false : true;
                rblImport10.Enabled = (Btext == true) ? false : true;
                rblImport11.Enabled = (Btext == true) ? false : true;
                rblImport12.Enabled = (Btext == true) ? false : true;
                rblImport13.Enabled = (Btext == true) ? false : true;
                rblImport14.Enabled = (Btext == true) ? false : true;
                rblImport15.Enabled = (Btext == true) ? false : true;
                rblImport16.Enabled = (Btext == true) ? false : true;
                rblImport17.Enabled = (Btext == true) ? false : true;
                rblImport18.Enabled = (Btext == true) ? false : true;
                rblImport19.Enabled = (Btext == true) ? false : true;
                rblImport20.Enabled = (Btext == true) ? false : true;
                rblImport21.Enabled = (Btext == true) ? false : true;
                rblImport22.Enabled = (Btext == true) ? false : true;

                txtPrintDate.ReadOnly = (Btext == true) ? false : true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void ClearDetail()
        {
            txtPrintDate.SelectedDate = string.Empty;

            txtText1.Text = string.Empty;
            txtText2.Text = string.Empty;
            txtText3.Text = string.Empty;
            txtText4.Text = string.Empty;
            txtText5.Text = string.Empty;
            txtText6.Text = string.Empty;
            txtText7.Text = string.Empty;
            txtText8.Text = string.Empty;
            txtText9.Text = string.Empty;
            txtText10.Text = string.Empty;
            txtText11.Text = string.Empty;
            txtText12.Text = string.Empty;
            txtText13.Text = string.Empty;
            txtText14.Text = string.Empty;
            txtText15.Text = string.Empty;
            txtText16.Text = string.Empty;
            txtText17.Text = string.Empty;
            txtText18.Text = string.Empty;
            txtText19.Text = string.Empty;
            txtText20.Text = string.Empty;
            txtText21.Text = string.Empty;
            txtText22.Text = string.Empty;

            rblImport1.SelectedValue = "N";
            rblImport2.SelectedValue = "N";
            rblImport3.SelectedValue = "N";
            rblImport4.SelectedValue = "N";
            rblImport5.SelectedValue = "N";
            rblImport6.SelectedValue = "N";
            rblImport7.SelectedValue = "N";
            rblImport8.SelectedValue = "N";
            rblImport9.SelectedValue = "N";
            rblImport10.SelectedValue = "N";
            rblImport11.SelectedValue = "N";
            rblImport12.SelectedValue = "N";
            rblImport13.SelectedValue = "N";
            rblImport14.SelectedValue = "N";
            rblImport15.SelectedValue = "N";
            rblImport16.SelectedValue = "N";
            rblImport17.SelectedValue = "N";
            rblImport18.SelectedValue = "N";
            rblImport19.SelectedValue = "N";
            rblImport20.SelectedValue = "N";
            rblImport21.SelectedValue = "N";
            rblImport22.SelectedValue = "N";
        }

        #endregion 메소드
    }
}