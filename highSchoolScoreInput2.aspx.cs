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

/// <summary>
/// 메뉴정보 : 입시 > 성적사정 > 고교학생부 입력(2007학년 이전)
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.23 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreInput2 : WebFormBase
    {
        #region 전역변수
        protected int ROW_NUM = 10;
        protected int page_num;
        #endregion


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

                if (!string.IsNullOrEmpty(Request["year"]))
                {
                    this.txt연도조회.Text = HttpUtility.UrlDecode(Request["year"] as string);
                }               
                if (!string.IsNullOrEmpty(Request["recpNo"]))
                {
                    this.txt수험번호조회.Text = HttpUtility.UrlDecode(Request["recpNo"] as string);
                }
                if (!string.IsNullOrEmpty(Request["korName"]))
                {
                    this.txt성명조회.Text = HttpUtility.UrlDecode(Request["korName"] as string);
                }                
                if (!string.IsNullOrEmpty(Request["PageNo"]))
                    this.page_num = Convert.ToInt32(Request["PageNo"] as string);
                else
                    this.page_num = 1;

                this.Retrieve(true);

            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            try
            {
                DataSet ds = new COMMBiz().GetApplicationConfig();

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    txt연도조회.Text = ds.Tables[0].Rows[0]["ApplYear"] == DBNull.Value ? string.Empty : ds.Tables[0].Rows[0]["ApplYear"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SetScriptForClientEvent()
        {
            ((Button)ExToolBar2.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 조회 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            this.Retrieve(false);
            this.ClearDetail();
        }


        /// <summary>
        /// 저장 버튼 클릭 시 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            this.Save();
        }


        protected void grdList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                this.grdList.SelectIndex(e, "SELECT");
                this.hdnYear.Value = string.Empty;
                this.hdnRecpNo.Value = string.Empty;
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }



        protected void grdList_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView gv = (GridView)sender;
            var rowIndex = gv.SelectedIndex;
            if (rowIndex >= 0)
            {
                SetControlValue(gv, rowIndex, "CUD");
                if (gv.DataKeys != null && gv.DataKeys.Count > rowIndex)
                {
                    this.hdnYear.Value = gv.DataKeys[gv.SelectedIndex].Values["year"].ToString();
                    this.hdnRecpNo.Value = gv.DataKeys[gv.SelectedIndex].Values["recpNo"].ToString();
                }               
            }
        }



        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007학년이전_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", this.txt연도조회.Text.Trim());
                parameters.Add("@recpNo", this.txt수험번호조회.Text.Trim());
                parameters.Add("@korName", this.txt성명조회.Text.Trim());
                parameters.Add("@Page", PAGE_YN ? this.page_num : 1);
                parameters.Add("@TotalRecord", ROW_NUM);
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
                            string strTotalCount = ds.Tables[0].Rows[0]["TOTAL_COUNT"].ToString();
                            this.grdList.DataBindGrid(ds, this.ExDataCounter1);
                            ExDataCounter1.DataCount = strTotalCount.ToInt32(); //ds.Tables[0].Rows.Count;
                            SetPage(PAGE_YN ? this.page_num : 1, Convert.ToInt32(strTotalCount));
                        }
                        else
                        {
                            this.grdList.ClearDataSource();
                            ExDataCounter1.DataCount = 0;
                            SetPage(1, 0);
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
                throw ex;
            }
        }


        /// <summary>
        /// 저장 버튼 클릭 시 
        /// </summary>
        private void Save()
        {

            #region 저장 전 입력 값 체크
            string year = string.Empty;
            string recpNo = string.Empty;

            year = this.hdnYear.Value;
            recpNo = this.hdnRecpNo.Value;

            int absence_1_A, absence_1_B, absence_1_C, absence_1_D;
            int absence_2_A, absence_2_B, absence_2_C, absence_2_D;
            int absence_3_A, absence_3_B, absence_3_C, absence_3_D;

            double v11_01_ISU, v11_02_ISU, v11_03_ISU, v11_04_ISU, v11_05_ISU,
                v11_06_ISU, v11_07_ISU, v11_08_ISU, v11_09_ISU, v11_10_ISU;
			double v11_11_ISU, v11_12_ISU, v11_13_ISU, v11_14_ISU, v11_15_ISU,
                v11_16_ISU, v11_17_ISU, v11_18_ISU, v11_19_ISU, v11_20_ISU;

			double v11_01_SEK, v11_02_SEK, v11_03_SEK, v11_04_SEK, v11_05_SEK,
                v11_06_SEK, v11_07_SEK, v11_08_SEK, v11_09_SEK, v11_10_SEK;
			double v11_11_SEK, v11_12_SEK, v11_13_SEK, v11_14_SEK, v11_15_SEK;
			double v11_16_SEK, v11_17_SEK, v11_18_SEK, v11_19_SEK, v11_20_SEK;

            double v11_01_JAE, v11_02_JAE, v11_03_JAE, v11_04_JAE, v11_05_JAE;
            double v11_06_JAE, v11_07_JAE, v11_08_JAE, v11_09_JAE, v11_10_JAE;
            double v11_11_JAE, v11_12_JAE, v11_13_JAE, v11_14_JAE, v11_15_JAE;
            double v11_16_JAE, v11_17_JAE, v11_18_JAE, v11_19_JAE, v11_20_JAE;
			
            double v12_01_ISU, v12_02_ISU, v12_03_ISU, v12_04_ISU, v12_05_ISU;
            double v12_06_ISU, v12_07_ISU, v12_08_ISU, v12_09_ISU, v12_10_ISU;
            double v12_11_ISU, v12_12_ISU, v12_13_ISU, v12_14_ISU, v12_15_ISU;
            double v12_16_ISU, v12_17_ISU, v12_18_ISU, v12_19_ISU, v12_20_ISU;
			
            double v12_01_SEK, v12_02_SEK, v12_03_SEK, v12_04_SEK, v12_05_SEK;
            double v12_06_SEK, v12_07_SEK, v12_08_SEK, v12_09_SEK, v12_10_SEK;
            double v12_11_SEK, v12_12_SEK, v12_13_SEK, v12_14_SEK, v12_15_SEK;
            double v12_16_SEK, v12_17_SEK, v12_18_SEK, v12_19_SEK, v12_20_SEK;
			
            double v12_01_JAE, v12_02_JAE, v12_03_JAE, v12_04_JAE, v12_05_JAE;
            double v12_06_JAE, v12_07_JAE, v12_08_JAE, v12_09_JAE, v12_10_JAE;
            double v12_11_JAE, v12_12_JAE, v12_13_JAE, v12_14_JAE, v12_15_JAE;
            double v12_16_JAE, v12_17_JAE, v12_18_JAE, v12_19_JAE, v12_20_JAE;
			
            double v21_01_ISU, v21_02_ISU, v21_03_ISU, v21_04_ISU, v21_05_ISU;
            double v21_06_ISU, v21_07_ISU, v21_08_ISU, v21_09_ISU, v21_10_ISU;
            double v21_11_ISU, v21_12_ISU, v21_13_ISU, v21_14_ISU, v21_15_ISU;
			double v21_16_ISU, v21_17_ISU, v21_18_ISU, v21_19_ISU, v21_20_ISU;

            double v21_01_SEK, v21_02_SEK, v21_03_SEK, v21_04_SEK, v21_05_SEK;
            double v21_06_SEK, v21_07_SEK, v21_08_SEK, v21_09_SEK, v21_10_SEK;
            double v21_11_SEK, v21_12_SEK, v21_13_SEK, v21_14_SEK, v21_15_SEK;
            double v21_16_SEK, v21_17_SEK, v21_18_SEK, v21_19_SEK, v21_20_SEK;
			
            double v21_01_JAE, v21_02_JAE, v21_03_JAE, v21_04_JAE, v21_05_JAE;
            double v21_06_JAE, v21_07_JAE, v21_08_JAE, v21_09_JAE, v21_10_JAE;
            double v21_11_JAE, v21_12_JAE, v21_13_JAE, v21_14_JAE, v21_15_JAE;
            double v21_16_JAE, v21_17_JAE, v21_18_JAE, v21_19_JAE, v21_20_JAE;
			
            double v22_01_ISU, v22_02_ISU, v22_03_ISU, v22_04_ISU, v22_05_ISU;
            double v22_06_ISU, v22_07_ISU, v22_08_ISU, v22_09_ISU, v22_10_ISU;
            double v22_11_ISU, v22_12_ISU, v22_13_ISU, v22_14_ISU, v22_15_ISU;
            double v22_16_ISU, v22_17_ISU, v22_18_ISU, v22_19_ISU, v22_20_ISU;
            double v22_01_SEK, v22_02_SEK, v22_03_SEK, v22_04_SEK, v22_05_SEK;
            double v22_06_SEK, v22_07_SEK, v22_08_SEK, v22_09_SEK, v22_10_SEK;
            double v22_11_SEK, v22_12_SEK, v22_13_SEK, v22_14_SEK, v22_15_SEK;
            double v22_16_SEK, v22_17_SEK, v22_18_SEK, v22_19_SEK, v22_20_SEK;
            double v22_01_JAE, v22_02_JAE, v22_03_JAE, v22_04_JAE, v22_05_JAE;
            double v22_06_JAE, v22_07_JAE, v22_08_JAE, v22_09_JAE, v22_10_JAE;
            double v22_11_JAE, v22_12_JAE, v22_13_JAE, v22_14_JAE, v22_15_JAE;
            double v22_16_JAE, v22_17_JAE, v22_18_JAE, v22_19_JAE, v22_20_JAE;
			
            double v31_01_ISU, v31_02_ISU, v31_03_ISU, v31_04_ISU, v31_05_ISU;
            double v31_06_ISU, v31_07_ISU, v31_08_ISU, v31_09_ISU, v31_10_ISU;
            double v31_11_ISU, v31_12_ISU, v31_13_ISU, v31_14_ISU, v31_15_ISU;
            double v31_16_ISU, v31_17_ISU, v31_18_ISU, v31_19_ISU, v31_20_ISU;
            double v31_01_SEK, v31_02_SEK, v31_03_SEK, v31_04_SEK, v31_05_SEK;
            double v31_06_SEK, v31_07_SEK, v31_08_SEK, v31_09_SEK, v31_10_SEK;
            double v31_11_SEK, v31_12_SEK, v31_13_SEK, v31_14_SEK, v31_15_SEK;
            double v31_16_SEK, v31_17_SEK, v31_18_SEK, v31_19_SEK, v31_20_SEK;
            double v31_01_JAE, v31_02_JAE, v31_03_JAE, v31_04_JAE, v31_05_JAE;
            double v31_06_JAE, v31_07_JAE, v31_08_JAE, v31_09_JAE, v31_10_JAE;
            double v31_11_JAE, v31_12_JAE, v31_13_JAE, v31_14_JAE, v31_15_JAE;
            double v31_16_JAE, v31_17_JAE, v31_18_JAE, v31_19_JAE, v31_20_JAE;
            double v32_01_ISU, v32_02_ISU, v32_03_ISU, v32_04_ISU, v32_05_ISU;
            double v32_06_ISU, v32_07_ISU, v32_08_ISU, v32_09_ISU, v32_10_ISU;
            double v32_11_ISU, v32_12_ISU, v32_13_ISU, v32_14_ISU, v32_15_ISU;
            double v32_16_ISU, v32_17_ISU, v32_18_ISU, v32_19_ISU, v32_20_ISU;
            double v32_01_SEK, v32_02_SEK, v32_03_SEK, v32_04_SEK, v32_05_SEK;
            double v32_06_SEK, v32_07_SEK, v32_08_SEK, v32_09_SEK, v32_10_SEK;
            double v32_11_SEK, v32_12_SEK, v32_13_SEK, v32_14_SEK, v32_15_SEK;
            double v32_16_SEK, v32_17_SEK, v32_18_SEK, v32_19_SEK, v32_20_SEK;
            double v32_01_JAE, v32_02_JAE, v32_03_JAE, v32_04_JAE, v32_05_JAE;
            double v32_06_JAE, v32_07_JAE, v32_08_JAE, v32_09_JAE, v32_10_JAE;
            double v32_11_JAE, v32_12_JAE, v32_13_JAE, v32_14_JAE, v32_15_JAE;
			double v32_16_JAE, v32_17_JAE, v32_18_JAE, v32_19_JAE, v32_20_JAE;

            if (this.txtabsence_1_A.Text.ToString().Trim() == "") absence_1_A = 0;
            else absence_1_A = Convert.ToInt32(this.txtabsence_1_A.Text);

            if (this.txtabsence_1_B.Text.ToString().Trim() == "") absence_1_B = 0;
            else absence_1_B = Convert.ToInt32(this.txtabsence_1_B.Text);

            if (this.txtabsence_1_C.Text.ToString().Trim() == "") absence_1_C = 0;
            else absence_1_C = Convert.ToInt32(this.txtabsence_1_C.Text);

            if (this.txtabsence_1_D.Text.ToString().Trim() == "") absence_1_D = 0;
            else absence_1_D = Convert.ToInt32(this.txtabsence_1_D.Text);

            if (this.txtabsence_2_A.Text.ToString().Trim() == "") absence_2_A = 0;
            else absence_2_A = Convert.ToInt32(this.txtabsence_2_A.Text);

            if (this.txtabsence_2_B.Text.ToString().Trim() == "") absence_2_B = 0;
            else absence_2_B = Convert.ToInt32(this.txtabsence_2_B.Text);

            if (this.txtabsence_2_C.Text.ToString().Trim() == "") absence_2_C = 0;
            else absence_2_C = Convert.ToInt32(this.txtabsence_2_C.Text);

            if (this.txtabsence_2_D.Text.ToString().Trim() == "") absence_2_D = 0;
            else absence_2_D = Convert.ToInt32(this.txtabsence_2_D.Text);

            if (this.txtabsence_3_A.Text.ToString().Trim() == "") absence_3_A = 0;
            else absence_3_A = Convert.ToInt32(this.txtabsence_3_A.Text);

            if (this.txtabsence_3_B.Text.ToString().Trim() == "") absence_3_B = 0;
            else absence_3_B = Convert.ToInt32(this.txtabsence_3_B.Text);

            if (this.txtabsence_3_C.Text.ToString().Trim() == "") absence_3_C = 0;
            else absence_3_C = Convert.ToInt32(this.txtabsence_3_C.Text);

            if (this.txtabsence_3_D.Text.ToString().Trim() == "") absence_3_D = 0;
            else absence_3_D = Convert.ToInt32(this.txtabsence_3_D.Text);

            if (this.txt_11_01_ISU.Text.ToString().Trim() == "") v11_01_ISU = 0; else v11_01_ISU = Convert.ToDouble(this.txt_11_01_ISU.Text);
            if (this.txt_11_02_ISU.Text.ToString().Trim() == "") v11_02_ISU = 0; else v11_02_ISU = Convert.ToDouble(this.txt_11_02_ISU.Text);
            if (this.txt_11_03_ISU.Text.ToString().Trim() == "") v11_03_ISU = 0; else v11_03_ISU = Convert.ToDouble(this.txt_11_03_ISU.Text);
            if (this.txt_11_04_ISU.Text.ToString().Trim() == "") v11_04_ISU = 0; else v11_04_ISU = Convert.ToDouble(this.txt_11_04_ISU.Text);
            if (this.txt_11_05_ISU.Text.ToString().Trim() == "") v11_05_ISU = 0; else v11_05_ISU = Convert.ToDouble(this.txt_11_05_ISU.Text);
            if (this.txt_11_06_ISU.Text.ToString().Trim() == "") v11_06_ISU = 0; else v11_06_ISU = Convert.ToDouble(this.txt_11_06_ISU.Text);
            if (this.txt_11_07_ISU.Text.ToString().Trim() == "") v11_07_ISU = 0; else v11_07_ISU = Convert.ToDouble(this.txt_11_07_ISU.Text);
            if (this.txt_11_08_ISU.Text.ToString().Trim() == "") v11_08_ISU = 0; else v11_08_ISU = Convert.ToDouble(this.txt_11_08_ISU.Text);
            if (this.txt_11_09_ISU.Text.ToString().Trim() == "") v11_09_ISU = 0; else v11_09_ISU = Convert.ToDouble(this.txt_11_09_ISU.Text);
            if (this.txt_11_10_ISU.Text.ToString().Trim() == "") v11_10_ISU = 0; else v11_10_ISU = Convert.ToDouble(this.txt_11_10_ISU.Text);
            if (this.txt_11_11_ISU.Text.ToString().Trim() == "") v11_11_ISU = 0; else v11_11_ISU = Convert.ToDouble(this.txt_11_11_ISU.Text);
            if (this.txt_11_12_ISU.Text.ToString().Trim() == "") v11_12_ISU = 0; else v11_12_ISU = Convert.ToDouble(this.txt_11_12_ISU.Text);
            if (this.txt_11_13_ISU.Text.ToString().Trim() == "") v11_13_ISU = 0; else v11_13_ISU = Convert.ToDouble(this.txt_11_13_ISU.Text);
            if (this.txt_11_14_ISU.Text.ToString().Trim() == "") v11_14_ISU = 0; else v11_14_ISU = Convert.ToDouble(this.txt_11_14_ISU.Text);
            if (this.txt_11_15_ISU.Text.ToString().Trim() == "") v11_15_ISU = 0; else v11_15_ISU = Convert.ToDouble(this.txt_11_15_ISU.Text);
            if (this.txt_11_16_ISU.Text.ToString().Trim() == "") v11_16_ISU = 0; else v11_16_ISU = Convert.ToDouble(this.txt_11_16_ISU.Text);
            if (this.txt_11_17_ISU.Text.ToString().Trim() == "") v11_17_ISU = 0; else v11_17_ISU = Convert.ToDouble(this.txt_11_17_ISU.Text);
            if (this.txt_11_18_ISU.Text.ToString().Trim() == "") v11_18_ISU = 0; else v11_18_ISU = Convert.ToDouble(this.txt_11_18_ISU.Text);
            if (this.txt_11_19_ISU.Text.ToString().Trim() == "") v11_19_ISU = 0; else v11_19_ISU = Convert.ToDouble(this.txt_11_19_ISU.Text);
            if (this.txt_11_20_ISU.Text.ToString().Trim() == "") v11_20_ISU = 0; else v11_20_ISU = Convert.ToDouble(this.txt_11_20_ISU.Text);
            if (this.txt_11_01_SEK.Text.ToString().Trim() == "") v11_01_SEK = 0; else v11_01_SEK = Convert.ToDouble(this.txt_11_01_SEK.Text);
            if (this.txt_11_02_SEK.Text.ToString().Trim() == "") v11_02_SEK = 0; else v11_02_SEK = Convert.ToDouble(this.txt_11_02_SEK.Text);
            if (this.txt_11_03_SEK.Text.ToString().Trim() == "") v11_03_SEK = 0; else v11_03_SEK = Convert.ToDouble(this.txt_11_03_SEK.Text);
            if (this.txt_11_04_SEK.Text.ToString().Trim() == "") v11_04_SEK = 0; else v11_04_SEK = Convert.ToDouble(this.txt_11_04_SEK.Text);
            if (this.txt_11_05_SEK.Text.ToString().Trim() == "") v11_05_SEK = 0; else v11_05_SEK = Convert.ToDouble(this.txt_11_05_SEK.Text);
            if (this.txt_11_06_SEK.Text.ToString().Trim() == "") v11_06_SEK = 0; else v11_06_SEK = Convert.ToDouble(this.txt_11_06_SEK.Text);
            if (this.txt_11_07_SEK.Text.ToString().Trim() == "") v11_07_SEK = 0; else v11_07_SEK = Convert.ToDouble(this.txt_11_07_SEK.Text);
            if (this.txt_11_08_SEK.Text.ToString().Trim() == "") v11_08_SEK = 0; else v11_08_SEK = Convert.ToDouble(this.txt_11_08_SEK.Text);
            if (this.txt_11_09_SEK.Text.ToString().Trim() == "") v11_09_SEK = 0; else v11_09_SEK = Convert.ToDouble(this.txt_11_09_SEK.Text);
            if (this.txt_11_10_SEK.Text.ToString().Trim() == "") v11_10_SEK = 0; else v11_10_SEK = Convert.ToDouble(this.txt_11_10_SEK.Text);
            if (this.txt_11_11_SEK.Text.ToString().Trim() == "") v11_11_SEK = 0; else v11_11_SEK = Convert.ToDouble(this.txt_11_11_SEK.Text);
            if (this.txt_11_12_SEK.Text.ToString().Trim() == "") v11_12_SEK = 0; else v11_12_SEK = Convert.ToDouble(this.txt_11_12_SEK.Text);
            if (this.txt_11_13_SEK.Text.ToString().Trim() == "") v11_13_SEK = 0; else v11_13_SEK = Convert.ToDouble(this.txt_11_13_SEK.Text);
            if (this.txt_11_14_SEK.Text.ToString().Trim() == "") v11_14_SEK = 0; else v11_14_SEK = Convert.ToDouble(this.txt_11_14_SEK.Text);
            if (this.txt_11_15_SEK.Text.ToString().Trim() == "") v11_15_SEK = 0; else v11_15_SEK = Convert.ToDouble(this.txt_11_15_SEK.Text);
            if (this.txt_11_16_SEK.Text.ToString().Trim() == "") v11_16_SEK = 0; else v11_16_SEK = Convert.ToDouble(this.txt_11_16_SEK.Text);
            if (this.txt_11_17_SEK.Text.ToString().Trim() == "") v11_17_SEK = 0; else v11_17_SEK = Convert.ToDouble(this.txt_11_17_SEK.Text);
            if (this.txt_11_18_SEK.Text.ToString().Trim() == "") v11_18_SEK = 0; else v11_18_SEK = Convert.ToDouble(this.txt_11_18_SEK.Text);
            if (this.txt_11_19_SEK.Text.ToString().Trim() == "") v11_19_SEK = 0; else v11_19_SEK = Convert.ToDouble(this.txt_11_19_SEK.Text);
            if (this.txt_11_20_SEK.Text.ToString().Trim() == "") v11_20_SEK = 0; else v11_20_SEK = Convert.ToDouble(this.txt_11_20_SEK.Text);
            if (this.txt_11_01_JAE.Text.ToString().Trim() == "") v11_01_JAE = 0; else v11_01_JAE = Convert.ToDouble(this.txt_11_01_JAE.Text);
            if (this.txt_11_02_JAE.Text.ToString().Trim() == "") v11_02_JAE = 0; else v11_02_JAE = Convert.ToDouble(this.txt_11_02_JAE.Text);
            if (this.txt_11_03_JAE.Text.ToString().Trim() == "") v11_03_JAE = 0; else v11_03_JAE = Convert.ToDouble(this.txt_11_03_JAE.Text);
            if (this.txt_11_04_JAE.Text.ToString().Trim() == "") v11_04_JAE = 0; else v11_04_JAE = Convert.ToDouble(this.txt_11_04_JAE.Text);
            if (this.txt_11_05_JAE.Text.ToString().Trim() == "") v11_05_JAE = 0; else v11_05_JAE = Convert.ToDouble(this.txt_11_05_JAE.Text);
            if (this.txt_11_06_JAE.Text.ToString().Trim() == "") v11_06_JAE = 0; else v11_06_JAE = Convert.ToDouble(this.txt_11_06_JAE.Text);
            if (this.txt_11_07_JAE.Text.ToString().Trim() == "") v11_07_JAE = 0; else v11_07_JAE = Convert.ToDouble(this.txt_11_07_JAE.Text);
            if (this.txt_11_08_JAE.Text.ToString().Trim() == "") v11_08_JAE = 0; else v11_08_JAE = Convert.ToDouble(this.txt_11_08_JAE.Text);
            if (this.txt_11_09_JAE.Text.ToString().Trim() == "") v11_09_JAE = 0; else v11_09_JAE = Convert.ToDouble(this.txt_11_09_JAE.Text);
            if (this.txt_11_10_JAE.Text.ToString().Trim() == "") v11_10_JAE = 0; else v11_10_JAE = Convert.ToDouble(this.txt_11_10_JAE.Text);
            if (this.txt_11_11_JAE.Text.ToString().Trim() == "") v11_11_JAE = 0; else v11_11_JAE = Convert.ToDouble(this.txt_11_11_JAE.Text);
            if (this.txt_11_12_JAE.Text.ToString().Trim() == "") v11_12_JAE = 0; else v11_12_JAE = Convert.ToDouble(this.txt_11_12_JAE.Text);
            if (this.txt_11_13_JAE.Text.ToString().Trim() == "") v11_13_JAE = 0; else v11_13_JAE = Convert.ToDouble(this.txt_11_13_JAE.Text);
            if (this.txt_11_14_JAE.Text.ToString().Trim() == "") v11_14_JAE = 0; else v11_14_JAE = Convert.ToDouble(this.txt_11_14_JAE.Text);
            if (this.txt_11_15_JAE.Text.ToString().Trim() == "") v11_15_JAE = 0; else v11_15_JAE = Convert.ToDouble(this.txt_11_15_JAE.Text);
            if (this.txt_11_16_JAE.Text.ToString().Trim() == "") v11_16_JAE = 0; else v11_16_JAE = Convert.ToDouble(this.txt_11_16_JAE.Text);
            if (this.txt_11_17_JAE.Text.ToString().Trim() == "") v11_17_JAE = 0; else v11_17_JAE = Convert.ToDouble(this.txt_11_17_JAE.Text);
            if (this.txt_11_18_JAE.Text.ToString().Trim() == "") v11_18_JAE = 0; else v11_18_JAE = Convert.ToDouble(this.txt_11_18_JAE.Text);
            if (this.txt_11_19_JAE.Text.ToString().Trim() == "") v11_19_JAE = 0; else v11_19_JAE = Convert.ToDouble(this.txt_11_19_JAE.Text);
            if (this.txt_11_20_JAE.Text.ToString().Trim() == "") v11_20_JAE = 0; else v11_20_JAE = Convert.ToDouble(this.txt_11_20_JAE.Text);
            if (this.txt_12_01_ISU.Text.ToString().Trim() == "") v12_01_ISU = 0; else v12_01_ISU = Convert.ToDouble(this.txt_12_01_ISU.Text);
            if (this.txt_12_02_ISU.Text.ToString().Trim() == "") v12_02_ISU = 0; else v12_02_ISU = Convert.ToDouble(this.txt_12_02_ISU.Text);
            if (this.txt_12_03_ISU.Text.ToString().Trim() == "") v12_03_ISU = 0; else v12_03_ISU = Convert.ToDouble(this.txt_12_03_ISU.Text);
            if (this.txt_12_04_ISU.Text.ToString().Trim() == "") v12_04_ISU = 0; else v12_04_ISU = Convert.ToDouble(this.txt_12_04_ISU.Text);
            if (this.txt_12_05_ISU.Text.ToString().Trim() == "") v12_05_ISU = 0; else v12_05_ISU = Convert.ToDouble(this.txt_12_05_ISU.Text);
            if (this.txt_12_06_ISU.Text.ToString().Trim() == "") v12_06_ISU = 0; else v12_06_ISU = Convert.ToDouble(this.txt_12_06_ISU.Text);
            if (this.txt_12_07_ISU.Text.ToString().Trim() == "") v12_07_ISU = 0; else v12_07_ISU = Convert.ToDouble(this.txt_12_07_ISU.Text);
            if (this.txt_12_08_ISU.Text.ToString().Trim() == "") v12_08_ISU = 0; else v12_08_ISU = Convert.ToDouble(this.txt_12_08_ISU.Text);
            if (this.txt_12_09_ISU.Text.ToString().Trim() == "") v12_09_ISU = 0; else v12_09_ISU = Convert.ToDouble(this.txt_12_09_ISU.Text);
            if (this.txt_12_10_ISU.Text.ToString().Trim() == "") v12_10_ISU = 0; else v12_10_ISU = Convert.ToDouble(this.txt_12_10_ISU.Text);
            if (this.txt_12_11_ISU.Text.ToString().Trim() == "") v12_11_ISU = 0; else v12_11_ISU = Convert.ToDouble(this.txt_12_11_ISU.Text);
            if (this.txt_12_12_ISU.Text.ToString().Trim() == "") v12_12_ISU = 0; else v12_12_ISU = Convert.ToDouble(this.txt_12_12_ISU.Text);
            if (this.txt_12_13_ISU.Text.ToString().Trim() == "") v12_13_ISU = 0; else v12_13_ISU = Convert.ToDouble(this.txt_12_13_ISU.Text);
            if (this.txt_12_14_ISU.Text.ToString().Trim() == "") v12_14_ISU = 0; else v12_14_ISU = Convert.ToDouble(this.txt_12_14_ISU.Text);
            if (this.txt_12_15_ISU.Text.ToString().Trim() == "") v12_15_ISU = 0; else v12_15_ISU = Convert.ToDouble(this.txt_12_15_ISU.Text);
            if (this.txt_12_16_ISU.Text.ToString().Trim() == "") v12_16_ISU = 0; else v12_16_ISU = Convert.ToDouble(this.txt_12_16_ISU.Text);
            if (this.txt_12_17_ISU.Text.ToString().Trim() == "") v12_17_ISU = 0; else v12_17_ISU = Convert.ToDouble(this.txt_12_17_ISU.Text);
            if (this.txt_12_18_ISU.Text.ToString().Trim() == "") v12_18_ISU = 0; else v12_18_ISU = Convert.ToDouble(this.txt_12_18_ISU.Text);
            if (this.txt_12_19_ISU.Text.ToString().Trim() == "") v12_19_ISU = 0; else v12_19_ISU = Convert.ToDouble(this.txt_12_19_ISU.Text);
            if (this.txt_12_20_ISU.Text.ToString().Trim() == "") v12_20_ISU = 0; else v12_20_ISU = Convert.ToDouble(this.txt_12_20_ISU.Text);
            if (this.txt_12_01_SEK.Text.ToString().Trim() == "") v12_01_SEK = 0; else v12_01_SEK = Convert.ToDouble(this.txt_12_01_SEK.Text);
            if (this.txt_12_02_SEK.Text.ToString().Trim() == "") v12_02_SEK = 0; else v12_02_SEK = Convert.ToDouble(this.txt_12_02_SEK.Text);
            if (this.txt_12_03_SEK.Text.ToString().Trim() == "") v12_03_SEK = 0; else v12_03_SEK = Convert.ToDouble(this.txt_12_03_SEK.Text);
            if (this.txt_12_04_SEK.Text.ToString().Trim() == "") v12_04_SEK = 0; else v12_04_SEK = Convert.ToDouble(this.txt_12_04_SEK.Text);
            if (this.txt_12_05_SEK.Text.ToString().Trim() == "") v12_05_SEK = 0; else v12_05_SEK = Convert.ToDouble(this.txt_12_05_SEK.Text);
            if (this.txt_12_06_SEK.Text.ToString().Trim() == "") v12_06_SEK = 0; else v12_06_SEK = Convert.ToDouble(this.txt_12_06_SEK.Text);
            if (this.txt_12_07_SEK.Text.ToString().Trim() == "") v12_07_SEK = 0; else v12_07_SEK = Convert.ToDouble(this.txt_12_07_SEK.Text);
            if (this.txt_12_08_SEK.Text.ToString().Trim() == "") v12_08_SEK = 0; else v12_08_SEK = Convert.ToDouble(this.txt_12_08_SEK.Text);
            if (this.txt_12_09_SEK.Text.ToString().Trim() == "") v12_09_SEK = 0; else v12_09_SEK = Convert.ToDouble(this.txt_12_09_SEK.Text);
            if (this.txt_12_10_SEK.Text.ToString().Trim() == "") v12_10_SEK = 0; else v12_10_SEK = Convert.ToDouble(this.txt_12_10_SEK.Text);
            if (this.txt_12_11_SEK.Text.ToString().Trim() == "") v12_11_SEK = 0; else v12_11_SEK = Convert.ToDouble(this.txt_12_11_SEK.Text);
            if (this.txt_12_12_SEK.Text.ToString().Trim() == "") v12_12_SEK = 0; else v12_12_SEK = Convert.ToDouble(this.txt_12_12_SEK.Text);
            if (this.txt_12_13_SEK.Text.ToString().Trim() == "") v12_13_SEK = 0; else v12_13_SEK = Convert.ToDouble(this.txt_12_13_SEK.Text);
            if (this.txt_12_14_SEK.Text.ToString().Trim() == "") v12_14_SEK = 0; else v12_14_SEK = Convert.ToDouble(this.txt_12_14_SEK.Text);
            if (this.txt_12_15_SEK.Text.ToString().Trim() == "") v12_15_SEK = 0; else v12_15_SEK = Convert.ToDouble(this.txt_12_15_SEK.Text);
            if (this.txt_12_16_SEK.Text.ToString().Trim() == "") v12_16_SEK = 0; else v12_16_SEK = Convert.ToDouble(this.txt_12_16_SEK.Text);
            if (this.txt_12_17_SEK.Text.ToString().Trim() == "") v12_17_SEK = 0; else v12_17_SEK = Convert.ToDouble(this.txt_12_17_SEK.Text);
            if (this.txt_12_18_SEK.Text.ToString().Trim() == "") v12_18_SEK = 0; else v12_18_SEK = Convert.ToDouble(this.txt_12_18_SEK.Text);
            if (this.txt_12_19_SEK.Text.ToString().Trim() == "") v12_19_SEK = 0; else v12_19_SEK = Convert.ToDouble(this.txt_12_19_SEK.Text);
            if (this.txt_12_20_SEK.Text.ToString().Trim() == "") v12_20_SEK = 0; else v12_20_SEK = Convert.ToDouble(this.txt_12_20_SEK.Text);
            if (this.txt_12_01_JAE.Text.ToString().Trim() == "") v12_01_JAE = 0; else v12_01_JAE = Convert.ToDouble(this.txt_12_01_JAE.Text);
            if (this.txt_12_02_JAE.Text.ToString().Trim() == "") v12_02_JAE = 0; else v12_02_JAE = Convert.ToDouble(this.txt_12_02_JAE.Text);
            if (this.txt_12_03_JAE.Text.ToString().Trim() == "") v12_03_JAE = 0; else v12_03_JAE = Convert.ToDouble(this.txt_12_03_JAE.Text);
            if (this.txt_12_04_JAE.Text.ToString().Trim() == "") v12_04_JAE = 0; else v12_04_JAE = Convert.ToDouble(this.txt_12_04_JAE.Text);
            if (this.txt_12_05_JAE.Text.ToString().Trim() == "") v12_05_JAE = 0; else v12_05_JAE = Convert.ToDouble(this.txt_12_05_JAE.Text);
            if (this.txt_12_06_JAE.Text.ToString().Trim() == "") v12_06_JAE = 0; else v12_06_JAE = Convert.ToDouble(this.txt_12_06_JAE.Text);
            if (this.txt_12_07_JAE.Text.ToString().Trim() == "") v12_07_JAE = 0; else v12_07_JAE = Convert.ToDouble(this.txt_12_07_JAE.Text);
            if (this.txt_12_08_JAE.Text.ToString().Trim() == "") v12_08_JAE = 0; else v12_08_JAE = Convert.ToDouble(this.txt_12_08_JAE.Text);
            if (this.txt_12_09_JAE.Text.ToString().Trim() == "") v12_09_JAE = 0; else v12_09_JAE = Convert.ToDouble(this.txt_12_09_JAE.Text);
            if (this.txt_12_10_JAE.Text.ToString().Trim() == "") v12_10_JAE = 0; else v12_10_JAE = Convert.ToDouble(this.txt_12_10_JAE.Text);
            if (this.txt_12_11_JAE.Text.ToString().Trim() == "") v12_11_JAE = 0; else v12_11_JAE = Convert.ToDouble(this.txt_12_11_JAE.Text);
            if (this.txt_12_12_JAE.Text.ToString().Trim() == "") v12_12_JAE = 0; else v12_12_JAE = Convert.ToDouble(this.txt_12_12_JAE.Text);
            if (this.txt_12_13_JAE.Text.ToString().Trim() == "") v12_13_JAE = 0; else v12_13_JAE = Convert.ToDouble(this.txt_12_13_JAE.Text);
            if (this.txt_12_14_JAE.Text.ToString().Trim() == "") v12_14_JAE = 0; else v12_14_JAE = Convert.ToDouble(this.txt_12_14_JAE.Text);
            if (this.txt_12_15_JAE.Text.ToString().Trim() == "") v12_15_JAE = 0; else v12_15_JAE = Convert.ToDouble(this.txt_12_15_JAE.Text);
            if (this.txt_12_16_JAE.Text.ToString().Trim() == "") v12_16_JAE = 0; else v12_16_JAE = Convert.ToDouble(this.txt_12_16_JAE.Text);
            if (this.txt_12_17_JAE.Text.ToString().Trim() == "") v12_17_JAE = 0; else v12_17_JAE = Convert.ToDouble(this.txt_12_17_JAE.Text);
            if (this.txt_12_18_JAE.Text.ToString().Trim() == "") v12_18_JAE = 0; else v12_18_JAE = Convert.ToDouble(this.txt_12_18_JAE.Text);
            if (this.txt_12_19_JAE.Text.ToString().Trim() == "") v12_19_JAE = 0; else v12_19_JAE = Convert.ToDouble(this.txt_12_19_JAE.Text);
            if (this.txt_12_20_JAE.Text.ToString().Trim() == "") v12_20_JAE = 0; else v12_20_JAE = Convert.ToDouble(this.txt_12_20_JAE.Text);

            if (this.txt_21_01_ISU.Text.ToString().Trim() == "") v21_01_ISU = 0; else v21_01_ISU = Convert.ToDouble(this.txt_21_01_ISU.Text);
            if (this.txt_21_02_ISU.Text.ToString().Trim() == "") v21_02_ISU = 0; else v21_02_ISU = Convert.ToDouble(this.txt_21_02_ISU.Text);
            if (this.txt_21_03_ISU.Text.ToString().Trim() == "") v21_03_ISU = 0; else v21_03_ISU = Convert.ToDouble(this.txt_21_03_ISU.Text);
            if (this.txt_21_04_ISU.Text.ToString().Trim() == "") v21_04_ISU = 0; else v21_04_ISU = Convert.ToDouble(this.txt_21_04_ISU.Text);
            if (this.txt_21_05_ISU.Text.ToString().Trim() == "") v21_05_ISU = 0; else v21_05_ISU = Convert.ToDouble(this.txt_21_05_ISU.Text);
            if (this.txt_21_06_ISU.Text.ToString().Trim() == "") v21_06_ISU = 0; else v21_06_ISU = Convert.ToDouble(this.txt_21_06_ISU.Text);
            if (this.txt_21_07_ISU.Text.ToString().Trim() == "") v21_07_ISU = 0; else v21_07_ISU = Convert.ToDouble(this.txt_21_07_ISU.Text);
            if (this.txt_21_08_ISU.Text.ToString().Trim() == "") v21_08_ISU = 0; else v21_08_ISU = Convert.ToDouble(this.txt_21_08_ISU.Text);
            if (this.txt_21_09_ISU.Text.ToString().Trim() == "") v21_09_ISU = 0; else v21_09_ISU = Convert.ToDouble(this.txt_21_09_ISU.Text);
            if (this.txt_21_10_ISU.Text.ToString().Trim() == "") v21_10_ISU = 0; else v21_10_ISU = Convert.ToDouble(this.txt_21_10_ISU.Text);
            if (this.txt_21_11_ISU.Text.ToString().Trim() == "") v21_11_ISU = 0; else v21_11_ISU = Convert.ToDouble(this.txt_21_11_ISU.Text);
            if (this.txt_21_12_ISU.Text.ToString().Trim() == "") v21_12_ISU = 0; else v21_12_ISU = Convert.ToDouble(this.txt_21_12_ISU.Text);
            if (this.txt_21_13_ISU.Text.ToString().Trim() == "") v21_13_ISU = 0; else v21_13_ISU = Convert.ToDouble(this.txt_21_13_ISU.Text);
            if (this.txt_21_14_ISU.Text.ToString().Trim() == "") v21_14_ISU = 0; else v21_14_ISU = Convert.ToDouble(this.txt_21_14_ISU.Text);
            if (this.txt_21_15_ISU.Text.ToString().Trim() == "") v21_15_ISU = 0; else v21_15_ISU = Convert.ToDouble(this.txt_21_15_ISU.Text);
            if (this.txt_21_16_ISU.Text.ToString().Trim() == "") v21_16_ISU = 0; else v21_16_ISU = Convert.ToDouble(this.txt_21_16_ISU.Text);
            if (this.txt_21_17_ISU.Text.ToString().Trim() == "") v21_17_ISU = 0; else v21_17_ISU = Convert.ToDouble(this.txt_21_17_ISU.Text);
            if (this.txt_21_18_ISU.Text.ToString().Trim() == "") v21_18_ISU = 0; else v21_18_ISU = Convert.ToDouble(this.txt_21_18_ISU.Text);
            if (this.txt_21_19_ISU.Text.ToString().Trim() == "") v21_19_ISU = 0; else v21_19_ISU = Convert.ToDouble(this.txt_21_19_ISU.Text);
            if (this.txt_21_20_ISU.Text.ToString().Trim() == "") v21_20_ISU = 0; else v21_20_ISU = Convert.ToDouble(this.txt_21_20_ISU.Text);
            if (this.txt_21_01_SEK.Text.ToString().Trim() == "") v21_01_SEK = 0; else v21_01_SEK = Convert.ToDouble(this.txt_21_01_SEK.Text);
            if (this.txt_21_02_SEK.Text.ToString().Trim() == "") v21_02_SEK = 0; else v21_02_SEK = Convert.ToDouble(this.txt_21_02_SEK.Text);
            if (this.txt_21_03_SEK.Text.ToString().Trim() == "") v21_03_SEK = 0; else v21_03_SEK = Convert.ToDouble(this.txt_21_03_SEK.Text);
            if (this.txt_21_04_SEK.Text.ToString().Trim() == "") v21_04_SEK = 0; else v21_04_SEK = Convert.ToDouble(this.txt_21_04_SEK.Text);
            if (this.txt_21_05_SEK.Text.ToString().Trim() == "") v21_05_SEK = 0; else v21_05_SEK = Convert.ToDouble(this.txt_21_05_SEK.Text);
            if (this.txt_21_06_SEK.Text.ToString().Trim() == "") v21_06_SEK = 0; else v21_06_SEK = Convert.ToDouble(this.txt_21_06_SEK.Text);
            if (this.txt_21_07_SEK.Text.ToString().Trim() == "") v21_07_SEK = 0; else v21_07_SEK = Convert.ToDouble(this.txt_21_07_SEK.Text);
            if (this.txt_21_08_SEK.Text.ToString().Trim() == "") v21_08_SEK = 0; else v21_08_SEK = Convert.ToDouble(this.txt_21_08_SEK.Text);
            if (this.txt_21_09_SEK.Text.ToString().Trim() == "") v21_09_SEK = 0; else v21_09_SEK = Convert.ToDouble(this.txt_21_09_SEK.Text);
            if (this.txt_21_10_SEK.Text.ToString().Trim() == "") v21_10_SEK = 0; else v21_10_SEK = Convert.ToDouble(this.txt_21_10_SEK.Text);
            if (this.txt_21_11_SEK.Text.ToString().Trim() == "") v21_11_SEK = 0; else v21_11_SEK = Convert.ToDouble(this.txt_21_11_SEK.Text);
            if (this.txt_21_12_SEK.Text.ToString().Trim() == "") v21_12_SEK = 0; else v21_12_SEK = Convert.ToDouble(this.txt_21_12_SEK.Text);
            if (this.txt_21_13_SEK.Text.ToString().Trim() == "") v21_13_SEK = 0; else v21_13_SEK = Convert.ToDouble(this.txt_21_13_SEK.Text);
            if (this.txt_21_14_SEK.Text.ToString().Trim() == "") v21_14_SEK = 0; else v21_14_SEK = Convert.ToDouble(this.txt_21_14_SEK.Text);
            if (this.txt_21_15_SEK.Text.ToString().Trim() == "") v21_15_SEK = 0; else v21_15_SEK = Convert.ToDouble(this.txt_21_15_SEK.Text);
            if (this.txt_21_16_SEK.Text.ToString().Trim() == "") v21_16_SEK = 0; else v21_16_SEK = Convert.ToDouble(this.txt_21_16_SEK.Text);
            if (this.txt_21_17_SEK.Text.ToString().Trim() == "") v21_17_SEK = 0; else v21_17_SEK = Convert.ToDouble(this.txt_21_17_SEK.Text);
            if (this.txt_21_18_SEK.Text.ToString().Trim() == "") v21_18_SEK = 0; else v21_18_SEK = Convert.ToDouble(this.txt_21_18_SEK.Text);
            if (this.txt_21_19_SEK.Text.ToString().Trim() == "") v21_19_SEK = 0; else v21_19_SEK = Convert.ToDouble(this.txt_21_19_SEK.Text);
            if (this.txt_21_20_SEK.Text.ToString().Trim() == "") v21_20_SEK = 0; else v21_20_SEK = Convert.ToDouble(this.txt_21_20_SEK.Text);
            if (this.txt_21_01_JAE.Text.ToString().Trim() == "") v21_01_JAE = 0; else v21_01_JAE = Convert.ToDouble(this.txt_21_01_JAE.Text);
            if (this.txt_21_02_JAE.Text.ToString().Trim() == "") v21_02_JAE = 0; else v21_02_JAE = Convert.ToDouble(this.txt_21_02_JAE.Text);
            if (this.txt_21_03_JAE.Text.ToString().Trim() == "") v21_03_JAE = 0; else v21_03_JAE = Convert.ToDouble(this.txt_21_03_JAE.Text);
            if (this.txt_21_04_JAE.Text.ToString().Trim() == "") v21_04_JAE = 0; else v21_04_JAE = Convert.ToDouble(this.txt_21_04_JAE.Text);
            if (this.txt_21_05_JAE.Text.ToString().Trim() == "") v21_05_JAE = 0; else v21_05_JAE = Convert.ToDouble(this.txt_21_05_JAE.Text);
            if (this.txt_21_06_JAE.Text.ToString().Trim() == "") v21_06_JAE = 0; else v21_06_JAE = Convert.ToDouble(this.txt_21_06_JAE.Text);
            if (this.txt_21_07_JAE.Text.ToString().Trim() == "") v21_07_JAE = 0; else v21_07_JAE = Convert.ToDouble(this.txt_21_07_JAE.Text);
            if (this.txt_21_08_JAE.Text.ToString().Trim() == "") v21_08_JAE = 0; else v21_08_JAE = Convert.ToDouble(this.txt_21_08_JAE.Text);
            if (this.txt_21_09_JAE.Text.ToString().Trim() == "") v21_09_JAE = 0; else v21_09_JAE = Convert.ToDouble(this.txt_21_09_JAE.Text);
            if (this.txt_21_10_JAE.Text.ToString().Trim() == "") v21_10_JAE = 0; else v21_10_JAE = Convert.ToDouble(this.txt_21_10_JAE.Text);
            if (this.txt_21_11_JAE.Text.ToString().Trim() == "") v21_11_JAE = 0; else v21_11_JAE = Convert.ToDouble(this.txt_21_11_JAE.Text);
            if (this.txt_21_12_JAE.Text.ToString().Trim() == "") v21_12_JAE = 0; else v21_12_JAE = Convert.ToDouble(this.txt_21_12_JAE.Text);
            if (this.txt_21_13_JAE.Text.ToString().Trim() == "") v21_13_JAE = 0; else v21_13_JAE = Convert.ToDouble(this.txt_21_13_JAE.Text);
            if (this.txt_21_14_JAE.Text.ToString().Trim() == "") v21_14_JAE = 0; else v21_14_JAE = Convert.ToDouble(this.txt_21_14_JAE.Text);
            if (this.txt_21_15_JAE.Text.ToString().Trim() == "") v21_15_JAE = 0; else v21_15_JAE = Convert.ToDouble(this.txt_21_15_JAE.Text);
            if (this.txt_21_16_JAE.Text.ToString().Trim() == "") v21_16_JAE = 0; else v21_16_JAE = Convert.ToDouble(this.txt_21_16_JAE.Text);
            if (this.txt_21_17_JAE.Text.ToString().Trim() == "") v21_17_JAE = 0; else v21_17_JAE = Convert.ToDouble(this.txt_21_17_JAE.Text);
            if (this.txt_21_18_JAE.Text.ToString().Trim() == "") v21_18_JAE = 0; else v21_18_JAE = Convert.ToDouble(this.txt_21_18_JAE.Text);
            if (this.txt_21_19_JAE.Text.ToString().Trim() == "") v21_19_JAE = 0; else v21_19_JAE = Convert.ToDouble(this.txt_21_19_JAE.Text);
            if (this.txt_21_20_JAE.Text.ToString().Trim() == "") v21_20_JAE = 0; else v21_20_JAE = Convert.ToDouble(this.txt_21_20_JAE.Text);
            if (this.txt_22_01_ISU.Text.ToString().Trim() == "") v22_01_ISU = 0; else v22_01_ISU = Convert.ToDouble(this.txt_22_01_ISU.Text);
            if (this.txt_22_02_ISU.Text.ToString().Trim() == "") v22_02_ISU = 0; else v22_02_ISU = Convert.ToDouble(this.txt_22_02_ISU.Text);
            if (this.txt_22_03_ISU.Text.ToString().Trim() == "") v22_03_ISU = 0; else v22_03_ISU = Convert.ToDouble(this.txt_22_03_ISU.Text);
            if (this.txt_22_04_ISU.Text.ToString().Trim() == "") v22_04_ISU = 0; else v22_04_ISU = Convert.ToDouble(this.txt_22_04_ISU.Text);
            if (this.txt_22_05_ISU.Text.ToString().Trim() == "") v22_05_ISU = 0; else v22_05_ISU = Convert.ToDouble(this.txt_22_05_ISU.Text);
            if (this.txt_22_06_ISU.Text.ToString().Trim() == "") v22_06_ISU = 0; else v22_06_ISU = Convert.ToDouble(this.txt_22_06_ISU.Text);
            if (this.txt_22_07_ISU.Text.ToString().Trim() == "") v22_07_ISU = 0; else v22_07_ISU = Convert.ToDouble(this.txt_22_07_ISU.Text);
            if (this.txt_22_08_ISU.Text.ToString().Trim() == "") v22_08_ISU = 0; else v22_08_ISU = Convert.ToDouble(this.txt_22_08_ISU.Text);
            if (this.txt_22_09_ISU.Text.ToString().Trim() == "") v22_09_ISU = 0; else v22_09_ISU = Convert.ToDouble(this.txt_22_09_ISU.Text);
            if (this.txt_22_10_ISU.Text.ToString().Trim() == "") v22_10_ISU = 0; else v22_10_ISU = Convert.ToDouble(this.txt_22_10_ISU.Text);
            if (this.txt_22_11_ISU.Text.ToString().Trim() == "") v22_11_ISU = 0; else v22_11_ISU = Convert.ToDouble(this.txt_22_11_ISU.Text);
            if (this.txt_22_12_ISU.Text.ToString().Trim() == "") v22_12_ISU = 0; else v22_12_ISU = Convert.ToDouble(this.txt_22_12_ISU.Text);
            if (this.txt_22_13_ISU.Text.ToString().Trim() == "") v22_13_ISU = 0; else v22_13_ISU = Convert.ToDouble(this.txt_22_13_ISU.Text);
            if (this.txt_22_14_ISU.Text.ToString().Trim() == "") v22_14_ISU = 0; else v22_14_ISU = Convert.ToDouble(this.txt_22_14_ISU.Text);
            if (this.txt_22_15_ISU.Text.ToString().Trim() == "") v22_15_ISU = 0; else v22_15_ISU = Convert.ToDouble(this.txt_22_15_ISU.Text);
            if (this.txt_22_16_ISU.Text.ToString().Trim() == "") v22_16_ISU = 0; else v22_16_ISU = Convert.ToDouble(this.txt_22_16_ISU.Text);
            if (this.txt_22_17_ISU.Text.ToString().Trim() == "") v22_17_ISU = 0; else v22_17_ISU = Convert.ToDouble(this.txt_22_17_ISU.Text);
            if (this.txt_22_18_ISU.Text.ToString().Trim() == "") v22_18_ISU = 0; else v22_18_ISU = Convert.ToDouble(this.txt_22_18_ISU.Text);
            if (this.txt_22_19_ISU.Text.ToString().Trim() == "") v22_19_ISU = 0; else v22_19_ISU = Convert.ToDouble(this.txt_22_19_ISU.Text);
            if (this.txt_22_20_ISU.Text.ToString().Trim() == "") v22_20_ISU = 0; else v22_20_ISU = Convert.ToDouble(this.txt_22_20_ISU.Text);
            if (this.txt_22_01_SEK.Text.ToString().Trim() == "") v22_01_SEK = 0; else v22_01_SEK = Convert.ToDouble(this.txt_22_01_SEK.Text);
            if (this.txt_22_02_SEK.Text.ToString().Trim() == "") v22_02_SEK = 0; else v22_02_SEK = Convert.ToDouble(this.txt_22_02_SEK.Text);
            if (this.txt_22_03_SEK.Text.ToString().Trim() == "") v22_03_SEK = 0; else v22_03_SEK = Convert.ToDouble(this.txt_22_03_SEK.Text);
            if (this.txt_22_04_SEK.Text.ToString().Trim() == "") v22_04_SEK = 0; else v22_04_SEK = Convert.ToDouble(this.txt_22_04_SEK.Text);
            if (this.txt_22_05_SEK.Text.ToString().Trim() == "") v22_05_SEK = 0; else v22_05_SEK = Convert.ToDouble(this.txt_22_05_SEK.Text);
            if (this.txt_22_06_SEK.Text.ToString().Trim() == "") v22_06_SEK = 0; else v22_06_SEK = Convert.ToDouble(this.txt_22_06_SEK.Text);
            if (this.txt_22_07_SEK.Text.ToString().Trim() == "") v22_07_SEK = 0; else v22_07_SEK = Convert.ToDouble(this.txt_22_07_SEK.Text);
            if (this.txt_22_08_SEK.Text.ToString().Trim() == "") v22_08_SEK = 0; else v22_08_SEK = Convert.ToDouble(this.txt_22_08_SEK.Text);
            if (this.txt_22_09_SEK.Text.ToString().Trim() == "") v22_09_SEK = 0; else v22_09_SEK = Convert.ToDouble(this.txt_22_09_SEK.Text);
            if (this.txt_22_10_SEK.Text.ToString().Trim() == "") v22_10_SEK = 0; else v22_10_SEK = Convert.ToDouble(this.txt_22_10_SEK.Text);
            if (this.txt_22_11_SEK.Text.ToString().Trim() == "") v22_11_SEK = 0; else v22_11_SEK = Convert.ToDouble(this.txt_22_11_SEK.Text);
            if (this.txt_22_12_SEK.Text.ToString().Trim() == "") v22_12_SEK = 0; else v22_12_SEK = Convert.ToDouble(this.txt_22_12_SEK.Text);
            if (this.txt_22_13_SEK.Text.ToString().Trim() == "") v22_13_SEK = 0; else v22_13_SEK = Convert.ToDouble(this.txt_22_13_SEK.Text);
            if (this.txt_22_14_SEK.Text.ToString().Trim() == "") v22_14_SEK = 0; else v22_14_SEK = Convert.ToDouble(this.txt_22_14_SEK.Text);
            if (this.txt_22_15_SEK.Text.ToString().Trim() == "") v22_15_SEK = 0; else v22_15_SEK = Convert.ToDouble(this.txt_22_15_SEK.Text);
            if (this.txt_22_16_SEK.Text.ToString().Trim() == "") v22_16_SEK = 0; else v22_16_SEK = Convert.ToDouble(this.txt_22_16_SEK.Text);
            if (this.txt_22_17_SEK.Text.ToString().Trim() == "") v22_17_SEK = 0; else v22_17_SEK = Convert.ToDouble(this.txt_22_17_SEK.Text);
            if (this.txt_22_18_SEK.Text.ToString().Trim() == "") v22_18_SEK = 0; else v22_18_SEK = Convert.ToDouble(this.txt_22_18_SEK.Text);
            if (this.txt_22_19_SEK.Text.ToString().Trim() == "") v22_19_SEK = 0; else v22_19_SEK = Convert.ToDouble(this.txt_22_19_SEK.Text);
            if (this.txt_22_20_SEK.Text.ToString().Trim() == "") v22_20_SEK = 0; else v22_20_SEK = Convert.ToDouble(this.txt_22_20_SEK.Text);
            if (this.txt_22_01_JAE.Text.ToString().Trim() == "") v22_01_JAE = 0; else v22_01_JAE = Convert.ToDouble(this.txt_22_01_JAE.Text);
            if (this.txt_22_02_JAE.Text.ToString().Trim() == "") v22_02_JAE = 0; else v22_02_JAE = Convert.ToDouble(this.txt_22_02_JAE.Text);
            if (this.txt_22_03_JAE.Text.ToString().Trim() == "") v22_03_JAE = 0; else v22_03_JAE = Convert.ToDouble(this.txt_22_03_JAE.Text);
            if (this.txt_22_04_JAE.Text.ToString().Trim() == "") v22_04_JAE = 0; else v22_04_JAE = Convert.ToDouble(this.txt_22_04_JAE.Text);
            if (this.txt_22_05_JAE.Text.ToString().Trim() == "") v22_05_JAE = 0; else v22_05_JAE = Convert.ToDouble(this.txt_22_05_JAE.Text);
            if (this.txt_22_06_JAE.Text.ToString().Trim() == "") v22_06_JAE = 0; else v22_06_JAE = Convert.ToDouble(this.txt_22_06_JAE.Text);
            if (this.txt_22_07_JAE.Text.ToString().Trim() == "") v22_07_JAE = 0; else v22_07_JAE = Convert.ToDouble(this.txt_22_07_JAE.Text);
            if (this.txt_22_08_JAE.Text.ToString().Trim() == "") v22_08_JAE = 0; else v22_08_JAE = Convert.ToDouble(this.txt_22_08_JAE.Text);
            if (this.txt_22_09_JAE.Text.ToString().Trim() == "") v22_09_JAE = 0; else v22_09_JAE = Convert.ToDouble(this.txt_22_09_JAE.Text);
            if (this.txt_22_10_JAE.Text.ToString().Trim() == "") v22_10_JAE = 0; else v22_10_JAE = Convert.ToDouble(this.txt_22_10_JAE.Text);
            if (this.txt_22_11_JAE.Text.ToString().Trim() == "") v22_11_JAE = 0; else v22_11_JAE = Convert.ToDouble(this.txt_22_11_JAE.Text);
            if (this.txt_22_12_JAE.Text.ToString().Trim() == "") v22_12_JAE = 0; else v22_12_JAE = Convert.ToDouble(this.txt_22_12_JAE.Text);
            if (this.txt_22_13_JAE.Text.ToString().Trim() == "") v22_13_JAE = 0; else v22_13_JAE = Convert.ToDouble(this.txt_22_13_JAE.Text);
            if (this.txt_22_14_JAE.Text.ToString().Trim() == "") v22_14_JAE = 0; else v22_14_JAE = Convert.ToDouble(this.txt_22_14_JAE.Text);
            if (this.txt_22_15_JAE.Text.ToString().Trim() == "") v22_15_JAE = 0; else v22_15_JAE = Convert.ToDouble(this.txt_22_15_JAE.Text);
            if (this.txt_22_16_JAE.Text.ToString().Trim() == "") v22_16_JAE = 0; else v22_16_JAE = Convert.ToDouble(this.txt_22_16_JAE.Text);
            if (this.txt_22_17_JAE.Text.ToString().Trim() == "") v22_17_JAE = 0; else v22_17_JAE = Convert.ToDouble(this.txt_22_17_JAE.Text);
            if (this.txt_22_18_JAE.Text.ToString().Trim() == "") v22_18_JAE = 0; else v22_18_JAE = Convert.ToDouble(this.txt_22_18_JAE.Text);
            if (this.txt_22_19_JAE.Text.ToString().Trim() == "") v22_19_JAE = 0; else v22_19_JAE = Convert.ToDouble(this.txt_22_19_JAE.Text);
            if (this.txt_22_20_JAE.Text.ToString().Trim() == "") v22_20_JAE = 0; else v22_20_JAE = Convert.ToDouble(this.txt_22_20_JAE.Text);

            if (this.txt_31_01_ISU.Text.ToString().Trim() == "") v31_01_ISU = 0; else v31_01_ISU = Convert.ToDouble(this.txt_31_01_ISU.Text);
            if (this.txt_31_02_ISU.Text.ToString().Trim() == "") v31_02_ISU = 0; else v31_02_ISU = Convert.ToDouble(this.txt_31_02_ISU.Text);
            if (this.txt_31_03_ISU.Text.ToString().Trim() == "") v31_03_ISU = 0; else v31_03_ISU = Convert.ToDouble(this.txt_31_03_ISU.Text);
            if (this.txt_31_04_ISU.Text.ToString().Trim() == "") v31_04_ISU = 0; else v31_04_ISU = Convert.ToDouble(this.txt_31_04_ISU.Text);
            if (this.txt_31_05_ISU.Text.ToString().Trim() == "") v31_05_ISU = 0; else v31_05_ISU = Convert.ToDouble(this.txt_31_05_ISU.Text);
            if (this.txt_31_06_ISU.Text.ToString().Trim() == "") v31_06_ISU = 0; else v31_06_ISU = Convert.ToDouble(this.txt_31_06_ISU.Text);
            if (this.txt_31_07_ISU.Text.ToString().Trim() == "") v31_07_ISU = 0; else v31_07_ISU = Convert.ToDouble(this.txt_31_07_ISU.Text);
            if (this.txt_31_08_ISU.Text.ToString().Trim() == "") v31_08_ISU = 0; else v31_08_ISU = Convert.ToDouble(this.txt_31_08_ISU.Text);
            if (this.txt_31_09_ISU.Text.ToString().Trim() == "") v31_09_ISU = 0; else v31_09_ISU = Convert.ToDouble(this.txt_31_09_ISU.Text);
            if (this.txt_31_10_ISU.Text.ToString().Trim() == "") v31_10_ISU = 0; else v31_10_ISU = Convert.ToDouble(this.txt_31_10_ISU.Text);
            if (this.txt_31_11_ISU.Text.ToString().Trim() == "") v31_11_ISU = 0; else v31_11_ISU = Convert.ToDouble(this.txt_31_11_ISU.Text);
            if (this.txt_31_12_ISU.Text.ToString().Trim() == "") v31_12_ISU = 0; else v31_12_ISU = Convert.ToDouble(this.txt_31_12_ISU.Text);
            if (this.txt_31_13_ISU.Text.ToString().Trim() == "") v31_13_ISU = 0; else v31_13_ISU = Convert.ToDouble(this.txt_31_13_ISU.Text);
            if (this.txt_31_14_ISU.Text.ToString().Trim() == "") v31_14_ISU = 0; else v31_14_ISU = Convert.ToDouble(this.txt_31_14_ISU.Text);
            if (this.txt_31_15_ISU.Text.ToString().Trim() == "") v31_15_ISU = 0; else v31_15_ISU = Convert.ToDouble(this.txt_31_15_ISU.Text);
            if (this.txt_31_16_ISU.Text.ToString().Trim() == "") v31_16_ISU = 0; else v31_16_ISU = Convert.ToDouble(this.txt_31_16_ISU.Text);
            if (this.txt_31_17_ISU.Text.ToString().Trim() == "") v31_17_ISU = 0; else v31_17_ISU = Convert.ToDouble(this.txt_31_17_ISU.Text);
            if (this.txt_31_18_ISU.Text.ToString().Trim() == "") v31_18_ISU = 0; else v31_18_ISU = Convert.ToDouble(this.txt_31_18_ISU.Text);
            if (this.txt_31_19_ISU.Text.ToString().Trim() == "") v31_19_ISU = 0; else v31_19_ISU = Convert.ToDouble(this.txt_31_19_ISU.Text);
            if (this.txt_31_20_ISU.Text.ToString().Trim() == "") v31_20_ISU = 0; else v31_20_ISU = Convert.ToDouble(this.txt_31_20_ISU.Text);
            if (this.txt_31_01_SEK.Text.ToString().Trim() == "") v31_01_SEK = 0; else v31_01_SEK = Convert.ToDouble(this.txt_31_01_SEK.Text);
            if (this.txt_31_02_SEK.Text.ToString().Trim() == "") v31_02_SEK = 0; else v31_02_SEK = Convert.ToDouble(this.txt_31_02_SEK.Text);
            if (this.txt_31_03_SEK.Text.ToString().Trim() == "") v31_03_SEK = 0; else v31_03_SEK = Convert.ToDouble(this.txt_31_03_SEK.Text);
            if (this.txt_31_04_SEK.Text.ToString().Trim() == "") v31_04_SEK = 0; else v31_04_SEK = Convert.ToDouble(this.txt_31_04_SEK.Text);
            if (this.txt_31_05_SEK.Text.ToString().Trim() == "") v31_05_SEK = 0; else v31_05_SEK = Convert.ToDouble(this.txt_31_05_SEK.Text);
            if (this.txt_31_06_SEK.Text.ToString().Trim() == "") v31_06_SEK = 0; else v31_06_SEK = Convert.ToDouble(this.txt_31_06_SEK.Text);
            if (this.txt_31_07_SEK.Text.ToString().Trim() == "") v31_07_SEK = 0; else v31_07_SEK = Convert.ToDouble(this.txt_31_07_SEK.Text);
            if (this.txt_31_08_SEK.Text.ToString().Trim() == "") v31_08_SEK = 0; else v31_08_SEK = Convert.ToDouble(this.txt_31_08_SEK.Text);
            if (this.txt_31_09_SEK.Text.ToString().Trim() == "") v31_09_SEK = 0; else v31_09_SEK = Convert.ToDouble(this.txt_31_09_SEK.Text);
            if (this.txt_31_10_SEK.Text.ToString().Trim() == "") v31_10_SEK = 0; else v31_10_SEK = Convert.ToDouble(this.txt_31_10_SEK.Text);
            if (this.txt_31_11_SEK.Text.ToString().Trim() == "") v31_11_SEK = 0; else v31_11_SEK = Convert.ToDouble(this.txt_31_11_SEK.Text);
            if (this.txt_31_12_SEK.Text.ToString().Trim() == "") v31_12_SEK = 0; else v31_12_SEK = Convert.ToDouble(this.txt_31_12_SEK.Text);
            if (this.txt_31_13_SEK.Text.ToString().Trim() == "") v31_13_SEK = 0; else v31_13_SEK = Convert.ToDouble(this.txt_31_13_SEK.Text);
            if (this.txt_31_14_SEK.Text.ToString().Trim() == "") v31_14_SEK = 0; else v31_14_SEK = Convert.ToDouble(this.txt_31_14_SEK.Text);
            if (this.txt_31_15_SEK.Text.ToString().Trim() == "") v31_15_SEK = 0; else v31_15_SEK = Convert.ToDouble(this.txt_31_15_SEK.Text);
            if (this.txt_31_16_SEK.Text.ToString().Trim() == "") v31_16_SEK = 0; else v31_16_SEK = Convert.ToDouble(this.txt_31_16_SEK.Text);
            if (this.txt_31_17_SEK.Text.ToString().Trim() == "") v31_17_SEK = 0; else v31_17_SEK = Convert.ToDouble(this.txt_31_17_SEK.Text);
            if (this.txt_31_18_SEK.Text.ToString().Trim() == "") v31_18_SEK = 0; else v31_18_SEK = Convert.ToDouble(this.txt_31_18_SEK.Text);
            if (this.txt_31_19_SEK.Text.ToString().Trim() == "") v31_19_SEK = 0; else v31_19_SEK = Convert.ToDouble(this.txt_31_19_SEK.Text);
            if (this.txt_31_20_SEK.Text.ToString().Trim() == "") v31_20_SEK = 0; else v31_20_SEK = Convert.ToDouble(this.txt_31_20_SEK.Text);
            if (this.txt_31_01_JAE.Text.ToString().Trim() == "") v31_01_JAE = 0; else v31_01_JAE = Convert.ToDouble(this.txt_31_01_JAE.Text);
            if (this.txt_31_02_JAE.Text.ToString().Trim() == "") v31_02_JAE = 0; else v31_02_JAE = Convert.ToDouble(this.txt_31_02_JAE.Text);
            if (this.txt_31_03_JAE.Text.ToString().Trim() == "") v31_03_JAE = 0; else v31_03_JAE = Convert.ToDouble(this.txt_31_03_JAE.Text);
            if (this.txt_31_04_JAE.Text.ToString().Trim() == "") v31_04_JAE = 0; else v31_04_JAE = Convert.ToDouble(this.txt_31_04_JAE.Text);
            if (this.txt_31_05_JAE.Text.ToString().Trim() == "") v31_05_JAE = 0; else v31_05_JAE = Convert.ToDouble(this.txt_31_05_JAE.Text);
            if (this.txt_31_06_JAE.Text.ToString().Trim() == "") v31_06_JAE = 0; else v31_06_JAE = Convert.ToDouble(this.txt_31_06_JAE.Text);
            if (this.txt_31_07_JAE.Text.ToString().Trim() == "") v31_07_JAE = 0; else v31_07_JAE = Convert.ToDouble(this.txt_31_07_JAE.Text);
            if (this.txt_31_08_JAE.Text.ToString().Trim() == "") v31_08_JAE = 0; else v31_08_JAE = Convert.ToDouble(this.txt_31_08_JAE.Text);
            if (this.txt_31_09_JAE.Text.ToString().Trim() == "") v31_09_JAE = 0; else v31_09_JAE = Convert.ToDouble(this.txt_31_09_JAE.Text);
            if (this.txt_31_10_JAE.Text.ToString().Trim() == "") v31_10_JAE = 0; else v31_10_JAE = Convert.ToDouble(this.txt_31_10_JAE.Text);
            if (this.txt_31_11_JAE.Text.ToString().Trim() == "") v31_11_JAE = 0; else v31_11_JAE = Convert.ToDouble(this.txt_31_11_JAE.Text);
            if (this.txt_31_12_JAE.Text.ToString().Trim() == "") v31_12_JAE = 0; else v31_12_JAE = Convert.ToDouble(this.txt_31_12_JAE.Text);
            if (this.txt_31_13_JAE.Text.ToString().Trim() == "") v31_13_JAE = 0; else v31_13_JAE = Convert.ToDouble(this.txt_31_13_JAE.Text);
            if (this.txt_31_14_JAE.Text.ToString().Trim() == "") v31_14_JAE = 0; else v31_14_JAE = Convert.ToDouble(this.txt_31_14_JAE.Text);
            if (this.txt_31_15_JAE.Text.ToString().Trim() == "") v31_15_JAE = 0; else v31_15_JAE = Convert.ToDouble(this.txt_31_15_JAE.Text);
            if (this.txt_31_16_JAE.Text.ToString().Trim() == "") v31_16_JAE = 0; else v31_16_JAE = Convert.ToDouble(this.txt_31_16_JAE.Text);
            if (this.txt_31_17_JAE.Text.ToString().Trim() == "") v31_17_JAE = 0; else v31_17_JAE = Convert.ToDouble(this.txt_31_17_JAE.Text);
            if (this.txt_31_18_JAE.Text.ToString().Trim() == "") v31_18_JAE = 0; else v31_18_JAE = Convert.ToDouble(this.txt_31_18_JAE.Text);
            if (this.txt_31_19_JAE.Text.ToString().Trim() == "") v31_19_JAE = 0; else v31_19_JAE = Convert.ToDouble(this.txt_31_19_JAE.Text);
            if (this.txt_31_20_JAE.Text.ToString().Trim() == "") v31_20_JAE = 0; else v31_20_JAE = Convert.ToDouble(this.txt_31_20_JAE.Text);
            if (this.txt_32_01_ISU.Text.ToString().Trim() == "") v32_01_ISU = 0; else v32_01_ISU = Convert.ToDouble(this.txt_32_01_ISU.Text);
            if (this.txt_32_02_ISU.Text.ToString().Trim() == "") v32_02_ISU = 0; else v32_02_ISU = Convert.ToDouble(this.txt_32_02_ISU.Text);
            if (this.txt_32_03_ISU.Text.ToString().Trim() == "") v32_03_ISU = 0; else v32_03_ISU = Convert.ToDouble(this.txt_32_03_ISU.Text);
            if (this.txt_32_04_ISU.Text.ToString().Trim() == "") v32_04_ISU = 0; else v32_04_ISU = Convert.ToDouble(this.txt_32_04_ISU.Text);
            if (this.txt_32_05_ISU.Text.ToString().Trim() == "") v32_05_ISU = 0; else v32_05_ISU = Convert.ToDouble(this.txt_32_05_ISU.Text);
            if (this.txt_32_06_ISU.Text.ToString().Trim() == "") v32_06_ISU = 0; else v32_06_ISU = Convert.ToDouble(this.txt_32_06_ISU.Text);
            if (this.txt_32_07_ISU.Text.ToString().Trim() == "") v32_07_ISU = 0; else v32_07_ISU = Convert.ToDouble(this.txt_32_07_ISU.Text);
            if (this.txt_32_08_ISU.Text.ToString().Trim() == "") v32_08_ISU = 0; else v32_08_ISU = Convert.ToDouble(this.txt_32_08_ISU.Text);
            if (this.txt_32_09_ISU.Text.ToString().Trim() == "") v32_09_ISU = 0; else v32_09_ISU = Convert.ToDouble(this.txt_32_09_ISU.Text);
            if (this.txt_32_10_ISU.Text.ToString().Trim() == "") v32_10_ISU = 0; else v32_10_ISU = Convert.ToDouble(this.txt_32_10_ISU.Text);
            if (this.txt_32_11_ISU.Text.ToString().Trim() == "") v32_11_ISU = 0; else v32_11_ISU = Convert.ToDouble(this.txt_32_11_ISU.Text);
            if (this.txt_32_12_ISU.Text.ToString().Trim() == "") v32_12_ISU = 0; else v32_12_ISU = Convert.ToDouble(this.txt_32_12_ISU.Text);
            if (this.txt_32_13_ISU.Text.ToString().Trim() == "") v32_13_ISU = 0; else v32_13_ISU = Convert.ToDouble(this.txt_32_13_ISU.Text);
            if (this.txt_32_14_ISU.Text.ToString().Trim() == "") v32_14_ISU = 0; else v32_14_ISU = Convert.ToDouble(this.txt_32_14_ISU.Text);
            if (this.txt_32_15_ISU.Text.ToString().Trim() == "") v32_15_ISU = 0; else v32_15_ISU = Convert.ToDouble(this.txt_32_15_ISU.Text);
            if (this.txt_32_16_ISU.Text.ToString().Trim() == "") v32_16_ISU = 0; else v32_16_ISU = Convert.ToDouble(this.txt_32_16_ISU.Text);
            if (this.txt_32_17_ISU.Text.ToString().Trim() == "") v32_17_ISU = 0; else v32_17_ISU = Convert.ToDouble(this.txt_32_17_ISU.Text);
            if (this.txt_32_18_ISU.Text.ToString().Trim() == "") v32_18_ISU = 0; else v32_18_ISU = Convert.ToDouble(this.txt_32_18_ISU.Text);
            if (this.txt_32_19_ISU.Text.ToString().Trim() == "") v32_19_ISU = 0; else v32_19_ISU = Convert.ToDouble(this.txt_32_19_ISU.Text);
            if (this.txt_32_20_ISU.Text.ToString().Trim() == "") v32_20_ISU = 0; else v32_20_ISU = Convert.ToDouble(this.txt_32_20_ISU.Text);
            if (this.txt_32_01_SEK.Text.ToString().Trim() == "") v32_01_SEK = 0; else v32_01_SEK = Convert.ToDouble(this.txt_32_01_SEK.Text);
            if (this.txt_32_02_SEK.Text.ToString().Trim() == "") v32_02_SEK = 0; else v32_02_SEK = Convert.ToDouble(this.txt_32_02_SEK.Text);
            if (this.txt_32_03_SEK.Text.ToString().Trim() == "") v32_03_SEK = 0; else v32_03_SEK = Convert.ToDouble(this.txt_32_03_SEK.Text);
            if (this.txt_32_04_SEK.Text.ToString().Trim() == "") v32_04_SEK = 0; else v32_04_SEK = Convert.ToDouble(this.txt_32_04_SEK.Text);
            if (this.txt_32_05_SEK.Text.ToString().Trim() == "") v32_05_SEK = 0; else v32_05_SEK = Convert.ToDouble(this.txt_32_05_SEK.Text);
            if (this.txt_32_06_SEK.Text.ToString().Trim() == "") v32_06_SEK = 0; else v32_06_SEK = Convert.ToDouble(this.txt_32_06_SEK.Text);
            if (this.txt_32_07_SEK.Text.ToString().Trim() == "") v32_07_SEK = 0; else v32_07_SEK = Convert.ToDouble(this.txt_32_07_SEK.Text);
            if (this.txt_32_08_SEK.Text.ToString().Trim() == "") v32_08_SEK = 0; else v32_08_SEK = Convert.ToDouble(this.txt_32_08_SEK.Text);
            if (this.txt_32_09_SEK.Text.ToString().Trim() == "") v32_09_SEK = 0; else v32_09_SEK = Convert.ToDouble(this.txt_32_09_SEK.Text);
            if (this.txt_32_10_SEK.Text.ToString().Trim() == "") v32_10_SEK = 0; else v32_10_SEK = Convert.ToDouble(this.txt_32_10_SEK.Text);
            if (this.txt_32_11_SEK.Text.ToString().Trim() == "") v32_11_SEK = 0; else v32_11_SEK = Convert.ToDouble(this.txt_32_11_SEK.Text);
            if (this.txt_32_12_SEK.Text.ToString().Trim() == "") v32_12_SEK = 0; else v32_12_SEK = Convert.ToDouble(this.txt_32_12_SEK.Text);
            if (this.txt_32_13_SEK.Text.ToString().Trim() == "") v32_13_SEK = 0; else v32_13_SEK = Convert.ToDouble(this.txt_32_13_SEK.Text);
            if (this.txt_32_14_SEK.Text.ToString().Trim() == "") v32_14_SEK = 0; else v32_14_SEK = Convert.ToDouble(this.txt_32_14_SEK.Text);
            if (this.txt_32_15_SEK.Text.ToString().Trim() == "") v32_15_SEK = 0; else v32_15_SEK = Convert.ToDouble(this.txt_32_15_SEK.Text);
            if (this.txt_32_16_SEK.Text.ToString().Trim() == "") v32_16_SEK = 0; else v32_16_SEK = Convert.ToDouble(this.txt_32_16_SEK.Text);
            if (this.txt_32_17_SEK.Text.ToString().Trim() == "") v32_17_SEK = 0; else v32_17_SEK = Convert.ToDouble(this.txt_32_17_SEK.Text);
            if (this.txt_32_18_SEK.Text.ToString().Trim() == "") v32_18_SEK = 0; else v32_18_SEK = Convert.ToDouble(this.txt_32_18_SEK.Text);
            if (this.txt_32_19_SEK.Text.ToString().Trim() == "") v32_19_SEK = 0; else v32_19_SEK = Convert.ToDouble(this.txt_32_19_SEK.Text);
            if (this.txt_32_20_SEK.Text.ToString().Trim() == "") v32_20_SEK = 0; else v32_20_SEK = Convert.ToDouble(this.txt_32_20_SEK.Text);
            if (this.txt_32_01_JAE.Text.ToString().Trim() == "") v32_01_JAE = 0; else v32_01_JAE = Convert.ToDouble(this.txt_32_01_JAE.Text);
            if (this.txt_32_02_JAE.Text.ToString().Trim() == "") v32_02_JAE = 0; else v32_02_JAE = Convert.ToDouble(this.txt_32_02_JAE.Text);
            if (this.txt_32_03_JAE.Text.ToString().Trim() == "") v32_03_JAE = 0; else v32_03_JAE = Convert.ToDouble(this.txt_32_03_JAE.Text);
            if (this.txt_32_04_JAE.Text.ToString().Trim() == "") v32_04_JAE = 0; else v32_04_JAE = Convert.ToDouble(this.txt_32_04_JAE.Text);
            if (this.txt_32_05_JAE.Text.ToString().Trim() == "") v32_05_JAE = 0; else v32_05_JAE = Convert.ToDouble(this.txt_32_05_JAE.Text);
            if (this.txt_32_06_JAE.Text.ToString().Trim() == "") v32_06_JAE = 0; else v32_06_JAE = Convert.ToDouble(this.txt_32_06_JAE.Text);
            if (this.txt_32_07_JAE.Text.ToString().Trim() == "") v32_07_JAE = 0; else v32_07_JAE = Convert.ToDouble(this.txt_32_07_JAE.Text);
            if (this.txt_32_08_JAE.Text.ToString().Trim() == "") v32_08_JAE = 0; else v32_08_JAE = Convert.ToDouble(this.txt_32_08_JAE.Text);
            if (this.txt_32_09_JAE.Text.ToString().Trim() == "") v32_09_JAE = 0; else v32_09_JAE = Convert.ToDouble(this.txt_32_09_JAE.Text);
            if (this.txt_32_10_JAE.Text.ToString().Trim() == "") v32_10_JAE = 0; else v32_10_JAE = Convert.ToDouble(this.txt_32_10_JAE.Text);
            if (this.txt_32_11_JAE.Text.ToString().Trim() == "") v32_11_JAE = 0; else v32_11_JAE = Convert.ToDouble(this.txt_32_11_JAE.Text);
            if (this.txt_32_12_JAE.Text.ToString().Trim() == "") v32_12_JAE = 0; else v32_12_JAE = Convert.ToDouble(this.txt_32_12_JAE.Text);
            if (this.txt_32_13_JAE.Text.ToString().Trim() == "") v32_13_JAE = 0; else v32_13_JAE = Convert.ToDouble(this.txt_32_13_JAE.Text);
            if (this.txt_32_14_JAE.Text.ToString().Trim() == "") v32_14_JAE = 0; else v32_14_JAE = Convert.ToDouble(this.txt_32_14_JAE.Text);
            if (this.txt_32_15_JAE.Text.ToString().Trim() == "") v32_15_JAE = 0; else v32_15_JAE = Convert.ToDouble(this.txt_32_15_JAE.Text);
            if (this.txt_32_16_JAE.Text.ToString().Trim() == "") v32_16_JAE = 0; else v32_16_JAE = Convert.ToDouble(this.txt_32_16_JAE.Text);
            if (this.txt_32_17_JAE.Text.ToString().Trim() == "") v32_17_JAE = 0; else v32_17_JAE = Convert.ToDouble(this.txt_32_17_JAE.Text);
            if (this.txt_32_18_JAE.Text.ToString().Trim() == "") v32_18_JAE = 0; else v32_18_JAE = Convert.ToDouble(this.txt_32_18_JAE.Text);
            if (this.txt_32_19_JAE.Text.ToString().Trim() == "") v32_19_JAE = 0; else v32_19_JAE = Convert.ToDouble(this.txt_32_19_JAE.Text);
            if (this.txt_32_20_JAE.Text.ToString().Trim() == "") v32_20_JAE = 0; else v32_20_JAE = Convert.ToDouble(this.txt_32_20_JAE.Text);

            #endregion

            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007학년이전_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                #region 파라미터 설정
                parameters.Add("@year", year);
                parameters.Add("@recpNo", recpNo);
                parameters.Add("@absence_1_A", absence_1_A);
                parameters.Add("@absence_1_B", absence_1_B);
                parameters.Add("@absence_1_C", absence_1_C);
                parameters.Add("@absence_1_D", absence_1_D);
                parameters.Add("@absence_2_A", absence_2_A);
                parameters.Add("@absence_2_B", absence_2_B);
                parameters.Add("@absence_2_C", absence_2_C);
                parameters.Add("@absence_2_D", absence_2_D);
                parameters.Add("@absence_3_A", absence_3_A);
                parameters.Add("@absence_3_B", absence_3_B);
                parameters.Add("@absence_3_C", absence_3_C);
                parameters.Add("@absence_3_D", absence_3_D);
                parameters.Add("@v11_01_ISU", v11_01_ISU);
                parameters.Add("@v11_02_ISU", v11_02_ISU);
                parameters.Add("@v11_03_ISU", v11_03_ISU);
                parameters.Add("@v11_04_ISU", v11_04_ISU);
                parameters.Add("@v11_05_ISU", v11_05_ISU);
                parameters.Add("@v11_06_ISU", v11_06_ISU);
                parameters.Add("@v11_07_ISU", v11_07_ISU);
                parameters.Add("@v11_08_ISU", v11_08_ISU);
                parameters.Add("@v11_09_ISU", v11_09_ISU);
                parameters.Add("@v11_10_ISU", v11_10_ISU);
                parameters.Add("@v11_11_ISU", v11_11_ISU);
                parameters.Add("@v11_12_ISU", v11_12_ISU);
                parameters.Add("@v11_13_ISU", v11_13_ISU);
                parameters.Add("@v11_14_ISU", v11_14_ISU);
                parameters.Add("@v11_15_ISU", v11_15_ISU);
                parameters.Add("@v11_16_ISU", v11_16_ISU);
                parameters.Add("@v11_17_ISU", v11_17_ISU);
                parameters.Add("@v11_18_ISU", v11_18_ISU);
                parameters.Add("@v11_19_ISU", v11_19_ISU);
                parameters.Add("@v11_20_ISU", v11_20_ISU);
                parameters.Add("@v11_01_SEK", v11_01_SEK);
                parameters.Add("@v11_02_SEK", v11_02_SEK);
                parameters.Add("@v11_03_SEK", v11_03_SEK);
                parameters.Add("@v11_04_SEK", v11_04_SEK);
                parameters.Add("@v11_05_SEK", v11_05_SEK);
                parameters.Add("@v11_06_SEK", v11_06_SEK);
                parameters.Add("@v11_07_SEK", v11_07_SEK);
                parameters.Add("@v11_08_SEK", v11_08_SEK);
                parameters.Add("@v11_09_SEK", v11_09_SEK);
                parameters.Add("@v11_10_SEK", v11_10_SEK);
                parameters.Add("@v11_11_SEK", v11_11_SEK);
                parameters.Add("@v11_12_SEK", v11_12_SEK);
                parameters.Add("@v11_13_SEK", v11_13_SEK);
                parameters.Add("@v11_14_SEK", v11_14_SEK);
                parameters.Add("@v11_15_SEK", v11_15_SEK);
                parameters.Add("@v11_16_SEK", v11_16_SEK);
                parameters.Add("@v11_17_SEK", v11_17_SEK);
                parameters.Add("@v11_18_SEK", v11_18_SEK);
                parameters.Add("@v11_19_SEK", v11_19_SEK);
                parameters.Add("@v11_20_SEK", v11_20_SEK);
                parameters.Add("@v11_01_JAE", v11_01_JAE);
                parameters.Add("@v11_02_JAE", v11_02_JAE);
                parameters.Add("@v11_03_JAE", v11_03_JAE);
                parameters.Add("@v11_04_JAE", v11_04_JAE);
                parameters.Add("@v11_05_JAE", v11_05_JAE);
                parameters.Add("@v11_06_JAE", v11_06_JAE);
                parameters.Add("@v11_07_JAE", v11_07_JAE);
                parameters.Add("@v11_08_JAE", v11_08_JAE);
                parameters.Add("@v11_09_JAE", v11_09_JAE);
                parameters.Add("@v11_10_JAE", v11_10_JAE);
                parameters.Add("@v11_11_JAE", v11_11_JAE);
                parameters.Add("@v11_12_JAE", v11_12_JAE);
                parameters.Add("@v11_13_JAE", v11_13_JAE);
                parameters.Add("@v11_14_JAE", v11_14_JAE);
                parameters.Add("@v11_15_JAE", v11_15_JAE);
                parameters.Add("@v11_16_JAE", v11_16_JAE);
                parameters.Add("@v11_17_JAE", v11_17_JAE);
                parameters.Add("@v11_18_JAE", v11_18_JAE);
                parameters.Add("@v11_19_JAE", v11_19_JAE);
                parameters.Add("@v11_20_JAE", v11_20_JAE);
                parameters.Add("@v12_01_ISU", v12_01_ISU);
                parameters.Add("@v12_02_ISU", v12_02_ISU);
                parameters.Add("@v12_03_ISU", v12_03_ISU);
                parameters.Add("@v12_04_ISU", v12_04_ISU);
                parameters.Add("@v12_05_ISU", v12_05_ISU);
                parameters.Add("@v12_06_ISU", v12_06_ISU);
                parameters.Add("@v12_07_ISU", v12_07_ISU);
                parameters.Add("@v12_08_ISU", v12_08_ISU);
                parameters.Add("@v12_09_ISU", v12_09_ISU);
                parameters.Add("@v12_10_ISU", v12_10_ISU);
                parameters.Add("@v12_11_ISU", v12_11_ISU);
                parameters.Add("@v12_12_ISU", v12_12_ISU);
                parameters.Add("@v12_13_ISU", v12_13_ISU);
                parameters.Add("@v12_14_ISU", v12_14_ISU);
                parameters.Add("@v12_15_ISU", v12_15_ISU);
                parameters.Add("@v12_16_ISU", v12_16_ISU);
                parameters.Add("@v12_17_ISU", v12_17_ISU);
                parameters.Add("@v12_18_ISU", v12_18_ISU);
                parameters.Add("@v12_19_ISU", v12_19_ISU);
                parameters.Add("@v12_20_ISU", v12_20_ISU);
                parameters.Add("@v12_01_SEK", v12_01_SEK);
                parameters.Add("@v12_02_SEK", v12_02_SEK);
                parameters.Add("@v12_03_SEK", v12_03_SEK);
                parameters.Add("@v12_04_SEK", v12_04_SEK);
                parameters.Add("@v12_05_SEK", v12_05_SEK);
                parameters.Add("@v12_06_SEK", v12_06_SEK);
                parameters.Add("@v12_07_SEK", v12_07_SEK);
                parameters.Add("@v12_08_SEK", v12_08_SEK);
                parameters.Add("@v12_09_SEK", v12_09_SEK);
                parameters.Add("@v12_10_SEK", v12_10_SEK);
                parameters.Add("@v12_11_SEK", v12_11_SEK);
                parameters.Add("@v12_12_SEK", v12_12_SEK);
                parameters.Add("@v12_13_SEK", v12_13_SEK);
                parameters.Add("@v12_14_SEK", v12_14_SEK);
                parameters.Add("@v12_15_SEK", v12_15_SEK);
                parameters.Add("@v12_16_SEK", v12_16_SEK);
                parameters.Add("@v12_17_SEK", v12_17_SEK);
                parameters.Add("@v12_18_SEK", v12_18_SEK);
                parameters.Add("@v12_19_SEK", v12_19_SEK);
                parameters.Add("@v12_20_SEK", v12_20_SEK);
                parameters.Add("@v12_01_JAE", v12_01_JAE);
                parameters.Add("@v12_02_JAE", v12_02_JAE);
                parameters.Add("@v12_03_JAE", v12_03_JAE);
                parameters.Add("@v12_04_JAE", v12_04_JAE);
                parameters.Add("@v12_05_JAE", v12_05_JAE);
                parameters.Add("@v12_06_JAE", v12_06_JAE);
                parameters.Add("@v12_07_JAE", v12_07_JAE);
                parameters.Add("@v12_08_JAE", v12_08_JAE);
                parameters.Add("@v12_09_JAE", v12_09_JAE);
                parameters.Add("@v12_10_JAE", v12_10_JAE);
                parameters.Add("@v12_11_JAE", v12_11_JAE);
                parameters.Add("@v12_12_JAE", v12_12_JAE);
                parameters.Add("@v12_13_JAE", v12_13_JAE);
                parameters.Add("@v12_14_JAE", v12_14_JAE);
                parameters.Add("@v12_15_JAE", v12_15_JAE);
                parameters.Add("@v12_16_JAE", v12_16_JAE);
                parameters.Add("@v12_17_JAE", v12_17_JAE);
                parameters.Add("@v12_18_JAE", v12_18_JAE);
                parameters.Add("@v12_19_JAE", v12_19_JAE);
                parameters.Add("@v12_20_JAE", v12_20_JAE);
                parameters.Add("@v21_01_ISU", v21_01_ISU);
                parameters.Add("@v21_02_ISU", v21_02_ISU);
                parameters.Add("@v21_03_ISU", v21_03_ISU);
                parameters.Add("@v21_04_ISU", v21_04_ISU);
                parameters.Add("@v21_05_ISU", v21_05_ISU);
                parameters.Add("@v21_06_ISU", v21_06_ISU);
                parameters.Add("@v21_07_ISU", v21_07_ISU);
                parameters.Add("@v21_08_ISU", v21_08_ISU);
                parameters.Add("@v21_09_ISU", v21_09_ISU);
                parameters.Add("@v21_10_ISU", v21_10_ISU);
                parameters.Add("@v21_11_ISU", v21_11_ISU);
                parameters.Add("@v21_12_ISU", v21_12_ISU);
                parameters.Add("@v21_13_ISU", v21_13_ISU);
                parameters.Add("@v21_14_ISU", v21_14_ISU);
                parameters.Add("@v21_15_ISU", v21_15_ISU);
                parameters.Add("@v21_16_ISU", v21_16_ISU);
                parameters.Add("@v21_17_ISU", v21_17_ISU);
                parameters.Add("@v21_18_ISU", v21_18_ISU);
                parameters.Add("@v21_19_ISU", v21_19_ISU);
                parameters.Add("@v21_20_ISU", v21_20_ISU);
                parameters.Add("@v21_01_SEK", v21_01_SEK);
                parameters.Add("@v21_02_SEK", v21_02_SEK);
                parameters.Add("@v21_03_SEK", v21_03_SEK);
                parameters.Add("@v21_04_SEK", v21_04_SEK);
                parameters.Add("@v21_05_SEK", v21_05_SEK);
                parameters.Add("@v21_06_SEK", v21_06_SEK);
                parameters.Add("@v21_07_SEK", v21_07_SEK);
                parameters.Add("@v21_08_SEK", v21_08_SEK);
                parameters.Add("@v21_09_SEK", v21_09_SEK);
                parameters.Add("@v21_10_SEK", v21_10_SEK);
                parameters.Add("@v21_11_SEK", v21_11_SEK);
                parameters.Add("@v21_12_SEK", v21_12_SEK);
                parameters.Add("@v21_13_SEK", v21_13_SEK);
                parameters.Add("@v21_14_SEK", v21_14_SEK);
                parameters.Add("@v21_15_SEK", v21_15_SEK);
                parameters.Add("@v21_16_SEK", v21_16_SEK);
                parameters.Add("@v21_17_SEK", v21_17_SEK);
                parameters.Add("@v21_18_SEK", v21_18_SEK);
                parameters.Add("@v21_19_SEK", v21_19_SEK);
                parameters.Add("@v21_20_SEK", v21_20_SEK);
                parameters.Add("@v21_01_JAE", v21_01_JAE);
                parameters.Add("@v21_02_JAE", v21_02_JAE);
                parameters.Add("@v21_03_JAE", v21_03_JAE);
                parameters.Add("@v21_04_JAE", v21_04_JAE);
                parameters.Add("@v21_05_JAE", v21_05_JAE);
                parameters.Add("@v21_06_JAE", v21_06_JAE);
                parameters.Add("@v21_07_JAE", v21_07_JAE);
                parameters.Add("@v21_08_JAE", v21_08_JAE);
                parameters.Add("@v21_09_JAE", v21_09_JAE);
                parameters.Add("@v21_10_JAE", v21_10_JAE);
                parameters.Add("@v21_11_JAE", v21_11_JAE);
                parameters.Add("@v21_12_JAE", v21_12_JAE);
                parameters.Add("@v21_13_JAE", v21_13_JAE);
                parameters.Add("@v21_14_JAE", v21_14_JAE);
                parameters.Add("@v21_15_JAE", v21_15_JAE);
                parameters.Add("@v21_16_JAE", v21_16_JAE);
                parameters.Add("@v21_17_JAE", v21_17_JAE);
                parameters.Add("@v21_18_JAE", v21_18_JAE);
                parameters.Add("@v21_19_JAE", v21_19_JAE);
                parameters.Add("@v21_20_JAE", v21_20_JAE);
                parameters.Add("@v22_01_ISU", v22_01_ISU);
                parameters.Add("@v22_02_ISU", v22_02_ISU);
                parameters.Add("@v22_03_ISU", v22_03_ISU);
                parameters.Add("@v22_04_ISU", v22_04_ISU);
                parameters.Add("@v22_05_ISU", v22_05_ISU);
                parameters.Add("@v22_06_ISU", v22_06_ISU);
                parameters.Add("@v22_07_ISU", v22_07_ISU);
                parameters.Add("@v22_08_ISU", v22_08_ISU);
                parameters.Add("@v22_09_ISU", v22_09_ISU);
                parameters.Add("@v22_10_ISU", v22_10_ISU);
                parameters.Add("@v22_11_ISU", v22_11_ISU);
                parameters.Add("@v22_12_ISU", v22_12_ISU);
                parameters.Add("@v22_13_ISU", v22_13_ISU);
                parameters.Add("@v22_14_ISU", v22_14_ISU);
                parameters.Add("@v22_15_ISU", v22_15_ISU);
                parameters.Add("@v22_16_ISU", v22_16_ISU);
                parameters.Add("@v22_17_ISU", v22_17_ISU);
                parameters.Add("@v22_18_ISU", v22_18_ISU);
                parameters.Add("@v22_19_ISU", v22_19_ISU);
                parameters.Add("@v22_20_ISU", v22_20_ISU);
                parameters.Add("@v22_01_SEK", v22_01_SEK);
                parameters.Add("@v22_02_SEK", v22_02_SEK);
                parameters.Add("@v22_03_SEK", v22_03_SEK);
                parameters.Add("@v22_04_SEK", v22_04_SEK);
                parameters.Add("@v22_05_SEK", v22_05_SEK);
                parameters.Add("@v22_06_SEK", v22_06_SEK);
                parameters.Add("@v22_07_SEK", v22_07_SEK);
                parameters.Add("@v22_08_SEK", v22_08_SEK);
                parameters.Add("@v22_09_SEK", v22_09_SEK);
                parameters.Add("@v22_10_SEK", v22_10_SEK);
                parameters.Add("@v22_11_SEK", v22_11_SEK);
                parameters.Add("@v22_12_SEK", v22_12_SEK);
                parameters.Add("@v22_13_SEK", v22_13_SEK);
                parameters.Add("@v22_14_SEK", v22_14_SEK);
                parameters.Add("@v22_15_SEK", v22_15_SEK);
                parameters.Add("@v22_16_SEK", v22_16_SEK);
                parameters.Add("@v22_17_SEK", v22_17_SEK);
                parameters.Add("@v22_18_SEK", v22_18_SEK);
                parameters.Add("@v22_19_SEK", v22_19_SEK);
                parameters.Add("@v22_20_SEK", v22_20_SEK);
                parameters.Add("@v22_01_JAE", v22_01_JAE);
                parameters.Add("@v22_02_JAE", v22_02_JAE);
                parameters.Add("@v22_03_JAE", v22_03_JAE);
                parameters.Add("@v22_04_JAE", v22_04_JAE);
                parameters.Add("@v22_05_JAE", v22_05_JAE);
                parameters.Add("@v22_06_JAE", v22_06_JAE);
                parameters.Add("@v22_07_JAE", v22_07_JAE);
                parameters.Add("@v22_08_JAE", v22_08_JAE);
                parameters.Add("@v22_09_JAE", v22_09_JAE);
                parameters.Add("@v22_10_JAE", v22_10_JAE);
                parameters.Add("@v22_11_JAE", v22_11_JAE);
                parameters.Add("@v22_12_JAE", v22_12_JAE);
                parameters.Add("@v22_13_JAE", v22_13_JAE);
                parameters.Add("@v22_14_JAE", v22_14_JAE);
                parameters.Add("@v22_15_JAE", v22_15_JAE);
                parameters.Add("@v22_16_JAE", v22_16_JAE);
                parameters.Add("@v22_17_JAE", v22_17_JAE);
                parameters.Add("@v22_18_JAE", v22_18_JAE);
                parameters.Add("@v22_19_JAE", v22_19_JAE);
                parameters.Add("@v22_20_JAE", v22_20_JAE);
                parameters.Add("@v31_01_ISU", v31_01_ISU);
                parameters.Add("@v31_02_ISU", v31_02_ISU);
                parameters.Add("@v31_03_ISU", v31_03_ISU);
                parameters.Add("@v31_04_ISU", v31_04_ISU);
                parameters.Add("@v31_05_ISU", v31_05_ISU);
                parameters.Add("@v31_06_ISU", v31_06_ISU);
                parameters.Add("@v31_07_ISU", v31_07_ISU);
                parameters.Add("@v31_08_ISU", v31_08_ISU);
                parameters.Add("@v31_09_ISU", v31_09_ISU);
                parameters.Add("@v31_10_ISU", v31_10_ISU);
                parameters.Add("@v31_11_ISU", v31_11_ISU);
                parameters.Add("@v31_12_ISU", v31_12_ISU);
                parameters.Add("@v31_13_ISU", v31_13_ISU);
                parameters.Add("@v31_14_ISU", v31_14_ISU);
                parameters.Add("@v31_15_ISU", v31_15_ISU);
                parameters.Add("@v31_16_ISU", v31_16_ISU);
                parameters.Add("@v31_17_ISU", v31_17_ISU);
                parameters.Add("@v31_18_ISU", v31_18_ISU);
                parameters.Add("@v31_19_ISU", v31_19_ISU);
                parameters.Add("@v31_20_ISU", v31_20_ISU);
                parameters.Add("@v31_01_SEK", v31_01_SEK);
                parameters.Add("@v31_02_SEK", v31_02_SEK);
                parameters.Add("@v31_03_SEK", v31_03_SEK);
                parameters.Add("@v31_04_SEK", v31_04_SEK);
                parameters.Add("@v31_05_SEK", v31_05_SEK);
                parameters.Add("@v31_06_SEK", v31_06_SEK);
                parameters.Add("@v31_07_SEK", v31_07_SEK);
                parameters.Add("@v31_08_SEK", v31_08_SEK);
                parameters.Add("@v31_09_SEK", v31_09_SEK);
                parameters.Add("@v31_10_SEK", v31_10_SEK);
                parameters.Add("@v31_11_SEK", v31_11_SEK);
                parameters.Add("@v31_12_SEK", v31_12_SEK);
                parameters.Add("@v31_13_SEK", v31_13_SEK);
                parameters.Add("@v31_14_SEK", v31_14_SEK);
                parameters.Add("@v31_15_SEK", v31_15_SEK);
                parameters.Add("@v31_16_SEK", v31_16_SEK);
                parameters.Add("@v31_17_SEK", v31_17_SEK);
                parameters.Add("@v31_18_SEK", v31_18_SEK);
                parameters.Add("@v31_19_SEK", v31_19_SEK);
                parameters.Add("@v31_20_SEK", v31_20_SEK);
                parameters.Add("@v31_01_JAE", v31_01_JAE);
                parameters.Add("@v31_02_JAE", v31_02_JAE);
                parameters.Add("@v31_03_JAE", v31_03_JAE);
                parameters.Add("@v31_04_JAE", v31_04_JAE);
                parameters.Add("@v31_05_JAE", v31_05_JAE);
                parameters.Add("@v31_06_JAE", v31_06_JAE);
                parameters.Add("@v31_07_JAE", v31_07_JAE);
                parameters.Add("@v31_08_JAE", v31_08_JAE);
                parameters.Add("@v31_09_JAE", v31_09_JAE);
                parameters.Add("@v31_10_JAE", v31_10_JAE);
                parameters.Add("@v31_11_JAE", v31_11_JAE);
                parameters.Add("@v31_12_JAE", v31_12_JAE);
                parameters.Add("@v31_13_JAE", v31_13_JAE);
                parameters.Add("@v31_14_JAE", v31_14_JAE);
                parameters.Add("@v31_15_JAE", v31_15_JAE);
                parameters.Add("@v31_16_JAE", v31_16_JAE);
                parameters.Add("@v31_17_JAE", v31_17_JAE);
                parameters.Add("@v31_18_JAE", v31_18_JAE);
                parameters.Add("@v31_19_JAE", v31_19_JAE);
                parameters.Add("@v31_20_JAE", v31_20_JAE);
                parameters.Add("@v32_01_ISU", v32_01_ISU);
                parameters.Add("@v32_02_ISU", v32_02_ISU);
                parameters.Add("@v32_03_ISU", v32_03_ISU);
                parameters.Add("@v32_04_ISU", v32_04_ISU);
                parameters.Add("@v32_05_ISU", v32_05_ISU);
                parameters.Add("@v32_06_ISU", v32_06_ISU);
                parameters.Add("@v32_07_ISU", v32_07_ISU);
                parameters.Add("@v32_08_ISU", v32_08_ISU);
                parameters.Add("@v32_09_ISU", v32_09_ISU);
                parameters.Add("@v32_10_ISU", v32_10_ISU);
                parameters.Add("@v32_11_ISU", v32_11_ISU);
                parameters.Add("@v32_12_ISU", v32_12_ISU);
                parameters.Add("@v32_13_ISU", v32_13_ISU);
                parameters.Add("@v32_14_ISU", v32_14_ISU);
                parameters.Add("@v32_15_ISU", v32_15_ISU);
                parameters.Add("@v32_16_ISU", v32_16_ISU);
                parameters.Add("@v32_17_ISU", v32_17_ISU);
                parameters.Add("@v32_18_ISU", v32_18_ISU);
                parameters.Add("@v32_19_ISU", v32_19_ISU);
                parameters.Add("@v32_20_ISU", v32_20_ISU);
                parameters.Add("@v32_01_SEK", v32_01_SEK);
                parameters.Add("@v32_02_SEK", v32_02_SEK);
                parameters.Add("@v32_03_SEK", v32_03_SEK);
                parameters.Add("@v32_04_SEK", v32_04_SEK);
                parameters.Add("@v32_05_SEK", v32_05_SEK);
                parameters.Add("@v32_06_SEK", v32_06_SEK);
                parameters.Add("@v32_07_SEK", v32_07_SEK);
                parameters.Add("@v32_08_SEK", v32_08_SEK);
                parameters.Add("@v32_09_SEK", v32_09_SEK);
                parameters.Add("@v32_10_SEK", v32_10_SEK);
                parameters.Add("@v32_11_SEK", v32_11_SEK);
                parameters.Add("@v32_12_SEK", v32_12_SEK);
                parameters.Add("@v32_13_SEK", v32_13_SEK);
                parameters.Add("@v32_14_SEK", v32_14_SEK);
                parameters.Add("@v32_15_SEK", v32_15_SEK);
                parameters.Add("@v32_16_SEK", v32_16_SEK);
                parameters.Add("@v32_17_SEK", v32_17_SEK);
                parameters.Add("@v32_18_SEK", v32_18_SEK);
                parameters.Add("@v32_19_SEK", v32_19_SEK);
                parameters.Add("@v32_20_SEK", v32_20_SEK);
                parameters.Add("@v32_01_JAE", v32_01_JAE);
                parameters.Add("@v32_02_JAE", v32_02_JAE);
                parameters.Add("@v32_03_JAE", v32_03_JAE);
                parameters.Add("@v32_04_JAE", v32_04_JAE);
                parameters.Add("@v32_05_JAE", v32_05_JAE);
                parameters.Add("@v32_06_JAE", v32_06_JAE);
                parameters.Add("@v32_07_JAE", v32_07_JAE);
                parameters.Add("@v32_08_JAE", v32_08_JAE);
                parameters.Add("@v32_09_JAE", v32_09_JAE);
                parameters.Add("@v32_10_JAE", v32_10_JAE);
                parameters.Add("@v32_11_JAE", v32_11_JAE);
                parameters.Add("@v32_12_JAE", v32_12_JAE);
                parameters.Add("@v32_13_JAE", v32_13_JAE);
                parameters.Add("@v32_14_JAE", v32_14_JAE);
                parameters.Add("@v32_15_JAE", v32_15_JAE);
                parameters.Add("@v32_16_JAE", v32_16_JAE);
                parameters.Add("@v32_17_JAE", v32_17_JAE);
                parameters.Add("@v32_18_JAE", v32_18_JAE);
                parameters.Add("@v32_19_JAE", v32_19_JAE);
                parameters.Add("@v32_20_JAE", v32_20_JAE);
                #endregion

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve(false);
                    ClearDetail();
                    CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                }
                else
                {
                    switch (shell.ErrorCode)
                    {
                        case 1:
                            CommonMessage.AlertMessage(this, 202);
                            break;
                        case 2:
                            CommonMessage.AlertMessage(this, 202);
                            break;
                        case 2627:
                            CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                            break;
                            //default:
                            //    CommonMessage.AlertMessage(this, "처리가 완료 되었습니다!");
                            //    break;
                    }

                    if (shell.ErrorCode < 0)
                        CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }

            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }



        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath
                                + "?year=" + HttpUtility.UrlEncode(this.txt연도조회.Text.Trim())
                                + "&recpNo=" + HttpUtility.UrlEncode(this.txt수험번호조회.Text.Trim())
                                + "&korName=" + HttpUtility.UrlEncode(this.txt성명조회.Text.Trim()) ;
            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }


        /// <summary>
        /// 입력항목 초기화
        /// </summary>
        private void ClearDetail()
        {
            try
            {
                ResetControlsValue("CUD");
                this.hdnYear.Value = string.Empty;
                this.hdnRecpNo.Value = string.Empty;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드

    }
}