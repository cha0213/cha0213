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

/// <summary>
/// 메뉴정보 : 입시 > 성적사정 > 내신 성적 산출
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.23 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreInput3 : WebFormBase
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

        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar2.FindControl("Save")).Attributes["onClick"] = "StudentFileUpload(); return false;";
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 확인하기 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnComfirm_Click(object sender, EventArgs e)
        {
            try
            {
                Save();
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        #endregion 이벤트

        #region 메소드

        private void Save()
        {

            #region 저장 전 입력 값 체크
            string year = string.Empty;
            string season = string.Empty;
            ConfigInfo configinfo = new ConfigInfo();
            year = configinfo.applYear;
            season = "1";

            int absence_1_A, absence_1_B, absence_1_C, absence_1_D;
            int absence_2_A, absence_2_B, absence_2_C, absence_2_D;
            int absence_3_A, absence_3_B, absence_3_C, absence_3_D;

            decimal v11_01_ISU, v11_02_ISU, v11_03_ISU, v11_04_ISU, v11_05_ISU, v11_06_ISU, v11_07_ISU, v11_08_ISU, v11_09_ISU, v11_10_ISU;
            decimal v11_11_ISU, v11_12_ISU, v11_13_ISU, v11_14_ISU, v11_15_ISU, v11_16_ISU, v11_17_ISU, v11_18_ISU, v11_19_ISU, v11_20_ISU;

            decimal v11_01_SEK, v11_02_SEK, v11_03_SEK, v11_04_SEK, v11_05_SEK, v11_06_SEK, v11_07_SEK, v11_08_SEK, v11_09_SEK, v11_10_SEK;
            decimal v11_11_SEK, v11_12_SEK, v11_13_SEK, v11_14_SEK, v11_15_SEK;
            decimal v11_16_SEK, v11_17_SEK, v11_18_SEK, v11_19_SEK, v11_20_SEK;

            decimal v11_01_JAE, v11_02_JAE, v11_03_JAE, v11_04_JAE, v11_05_JAE;
            decimal v11_06_JAE, v11_07_JAE, v11_08_JAE, v11_09_JAE, v11_10_JAE;
            decimal v11_11_JAE, v11_12_JAE, v11_13_JAE, v11_14_JAE, v11_15_JAE;
            decimal v11_16_JAE, v11_17_JAE, v11_18_JAE, v11_19_JAE, v11_20_JAE;

            decimal v12_01_ISU, v12_02_ISU, v12_03_ISU, v12_04_ISU, v12_05_ISU;
            decimal v12_06_ISU, v12_07_ISU, v12_08_ISU, v12_09_ISU, v12_10_ISU;
            decimal v12_11_ISU, v12_12_ISU, v12_13_ISU, v12_14_ISU, v12_15_ISU;
            decimal v12_16_ISU, v12_17_ISU, v12_18_ISU, v12_19_ISU, v12_20_ISU;

            decimal v12_01_SEK, v12_02_SEK, v12_03_SEK, v12_04_SEK, v12_05_SEK;
            decimal v12_06_SEK, v12_07_SEK, v12_08_SEK, v12_09_SEK, v12_10_SEK;
            decimal v12_11_SEK, v12_12_SEK, v12_13_SEK, v12_14_SEK, v12_15_SEK;
            decimal v12_16_SEK, v12_17_SEK, v12_18_SEK, v12_19_SEK, v12_20_SEK;

            decimal v12_01_JAE, v12_02_JAE, v12_03_JAE, v12_04_JAE, v12_05_JAE;
            decimal v12_06_JAE, v12_07_JAE, v12_08_JAE, v12_09_JAE, v12_10_JAE;
            decimal v12_11_JAE, v12_12_JAE, v12_13_JAE, v12_14_JAE, v12_15_JAE;
            decimal v12_16_JAE, v12_17_JAE, v12_18_JAE, v12_19_JAE, v12_20_JAE;

            decimal v21_01_ISU, v21_02_ISU, v21_03_ISU, v21_04_ISU, v21_05_ISU;
            decimal v21_06_ISU, v21_07_ISU, v21_08_ISU, v21_09_ISU, v21_10_ISU;
            decimal v21_11_ISU, v21_12_ISU, v21_13_ISU, v21_14_ISU, v21_15_ISU;
            decimal v21_16_ISU, v21_17_ISU, v21_18_ISU, v21_19_ISU, v21_20_ISU;

            decimal v21_01_SEK, v21_02_SEK, v21_03_SEK, v21_04_SEK, v21_05_SEK;
            decimal v21_06_SEK, v21_07_SEK, v21_08_SEK, v21_09_SEK, v21_10_SEK;
            decimal v21_11_SEK, v21_12_SEK, v21_13_SEK, v21_14_SEK, v21_15_SEK;
            decimal v21_16_SEK, v21_17_SEK, v21_18_SEK, v21_19_SEK, v21_20_SEK;

            decimal v21_01_JAE, v21_02_JAE, v21_03_JAE, v21_04_JAE, v21_05_JAE;
            decimal v21_06_JAE, v21_07_JAE, v21_08_JAE, v21_09_JAE, v21_10_JAE;
            decimal v21_11_JAE, v21_12_JAE, v21_13_JAE, v21_14_JAE, v21_15_JAE;
            decimal v21_16_JAE, v21_17_JAE, v21_18_JAE, v21_19_JAE, v21_20_JAE;

            decimal v22_01_ISU, v22_02_ISU, v22_03_ISU, v22_04_ISU, v22_05_ISU;
            decimal v22_06_ISU, v22_07_ISU, v22_08_ISU, v22_09_ISU, v22_10_ISU;
            decimal v22_11_ISU, v22_12_ISU, v22_13_ISU, v22_14_ISU, v22_15_ISU;
            decimal v22_16_ISU, v22_17_ISU, v22_18_ISU, v22_19_ISU, v22_20_ISU;
            decimal v22_01_SEK, v22_02_SEK, v22_03_SEK, v22_04_SEK, v22_05_SEK;
            decimal v22_06_SEK, v22_07_SEK, v22_08_SEK, v22_09_SEK, v22_10_SEK;
            decimal v22_11_SEK, v22_12_SEK, v22_13_SEK, v22_14_SEK, v22_15_SEK;
            decimal v22_16_SEK, v22_17_SEK, v22_18_SEK, v22_19_SEK, v22_20_SEK;
            decimal v22_01_JAE, v22_02_JAE, v22_03_JAE, v22_04_JAE, v22_05_JAE;
            decimal v22_06_JAE, v22_07_JAE, v22_08_JAE, v22_09_JAE, v22_10_JAE;
            decimal v22_11_JAE, v22_12_JAE, v22_13_JAE, v22_14_JAE, v22_15_JAE;
            decimal v22_16_JAE, v22_17_JAE, v22_18_JAE, v22_19_JAE, v22_20_JAE;

            decimal v31_01_ISU, v31_02_ISU, v31_03_ISU, v31_04_ISU, v31_05_ISU;
            decimal v31_06_ISU, v31_07_ISU, v31_08_ISU, v31_09_ISU, v31_10_ISU;
            decimal v31_11_ISU, v31_12_ISU, v31_13_ISU, v31_14_ISU, v31_15_ISU;
            decimal v31_16_ISU, v31_17_ISU, v31_18_ISU, v31_19_ISU, v31_20_ISU;

            decimal v31_01_SEK, v31_02_SEK, v31_03_SEK, v31_04_SEK, v31_05_SEK;
            decimal v31_06_SEK, v31_07_SEK, v31_08_SEK, v31_09_SEK, v31_10_SEK;
            decimal v31_11_SEK, v31_12_SEK, v31_13_SEK, v31_14_SEK, v31_15_SEK;
            decimal v31_16_SEK, v31_17_SEK, v31_18_SEK, v31_19_SEK, v31_20_SEK;

            decimal v31_01_JAE, v31_02_JAE, v31_03_JAE, v31_04_JAE, v31_05_JAE;
            decimal v31_06_JAE, v31_07_JAE, v31_08_JAE, v31_09_JAE, v31_10_JAE;
            decimal v31_11_JAE, v31_12_JAE, v31_13_JAE, v31_14_JAE, v31_15_JAE;
            decimal v31_16_JAE, v31_17_JAE, v31_18_JAE, v31_19_JAE, v31_20_JAE;

            decimal v32_01_ISU, v32_02_ISU, v32_03_ISU, v32_04_ISU, v32_05_ISU;
            decimal v32_06_ISU, v32_07_ISU, v32_08_ISU, v32_09_ISU, v32_10_ISU;
            decimal v32_11_ISU, v32_12_ISU, v32_13_ISU, v32_14_ISU, v32_15_ISU;
            decimal v32_16_ISU, v32_17_ISU, v32_18_ISU, v32_19_ISU, v32_20_ISU;

            decimal v32_01_SEK, v32_02_SEK, v32_03_SEK, v32_04_SEK, v32_05_SEK;
            decimal v32_06_SEK, v32_07_SEK, v32_08_SEK, v32_09_SEK, v32_10_SEK;
            decimal v32_11_SEK, v32_12_SEK, v32_13_SEK, v32_14_SEK, v32_15_SEK;
            decimal v32_16_SEK, v32_17_SEK, v32_18_SEK, v32_19_SEK, v32_20_SEK;

            decimal v32_01_JAE, v32_02_JAE, v32_03_JAE, v32_04_JAE, v32_05_JAE;
            decimal v32_06_JAE, v32_07_JAE, v32_08_JAE, v32_09_JAE, v32_10_JAE;
            decimal v32_11_JAE, v32_12_JAE, v32_13_JAE, v32_14_JAE, v32_15_JAE;
            decimal v32_16_JAE, v32_17_JAE, v32_18_JAE, v32_19_JAE, v32_20_JAE;

            if (this.txtabsence_1_A.Text == "") absence_1_A = 0;
            else absence_1_A = Convert.ToInt32(this.txtabsence_1_A.Text);


            if (this.txtabsence_1_B.Text == "") absence_1_B = 0;
            else absence_1_B = Convert.ToInt32(this.txtabsence_1_B.Text);

            if (this.txtabsence_1_C.Text == "") absence_1_C = 0;
            else absence_1_C = Convert.ToInt32(this.txtabsence_1_C.Text);

            if (this.txtabsence_1_D.Text == "") absence_1_D = 0;
            else absence_1_D = Convert.ToInt32(this.txtabsence_1_D.Text);

            if (this.txtabsence_2_A.Text == "") absence_2_A = 0;
            else absence_2_A = Convert.ToInt32(this.txtabsence_2_A.Text);

            if (this.txtabsence_2_B.Text == "") absence_2_B = 0;
            else absence_2_B = Convert.ToInt32(this.txtabsence_2_B.Text);

            if (this.txtabsence_2_C.Text == "") absence_2_C = 0;
            else absence_2_C = Convert.ToInt32(this.txtabsence_2_C.Text);

            if (this.txtabsence_2_D.Text == "") absence_2_D = 0;
            else absence_2_D = Convert.ToInt32(this.txtabsence_2_D.Text);

            if (this.txtabsence_3_A.Text == "") absence_3_A = 0;
            else absence_3_A = Convert.ToInt32(this.txtabsence_3_A.Text);

            if (this.txtabsence_3_B.Text == "") absence_3_B = 0;
            else absence_3_B = Convert.ToInt32(this.txtabsence_3_B.Text);

            if (this.txtabsence_3_C.Text == "") absence_3_C = 0;
            else absence_3_C = Convert.ToInt32(this.txtabsence_3_C.Text);

            if (this.txtabsence_3_D.Text == "") absence_3_D = 0;
            else absence_3_D = Convert.ToInt32(this.txtabsence_3_D.Text);

            if (this.txt_11_01_ISU.Text == "")
            {
                v11_01_ISU = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_01_ISU = Convert.ToDecimal(this.txt_11_01_ISU.Text);
            }


            if (this.txt_11_02_ISU.Text == "")
            {
                v11_02_ISU = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_02_ISU = Convert.ToDecimal(this.txt_11_02_ISU.Text);
            }
            if (this.txt_11_03_ISU.Text == "") v11_03_ISU = 0; else v11_03_ISU = Convert.ToDecimal(this.txt_11_03_ISU.Text);
            if (this.txt_11_04_ISU.Text == "") v11_04_ISU = 0; else v11_04_ISU = Convert.ToDecimal(this.txt_11_04_ISU.Text);
            if (this.txt_11_05_ISU.Text == "") v11_05_ISU = 0; else v11_05_ISU = Convert.ToDecimal(this.txt_11_05_ISU.Text);
            if (this.txt_11_06_ISU.Text == "") v11_06_ISU = 0; else v11_06_ISU = Convert.ToDecimal(this.txt_11_06_ISU.Text);
            if (this.txt_11_07_ISU.Text == "") v11_07_ISU = 0; else v11_07_ISU = Convert.ToDecimal(this.txt_11_07_ISU.Text);
            if (this.txt_11_08_ISU.Text == "") v11_08_ISU = 0; else v11_08_ISU = Convert.ToDecimal(this.txt_11_08_ISU.Text);
            if (this.txt_11_09_ISU.Text == "") v11_09_ISU = 0; else v11_09_ISU = Convert.ToDecimal(this.txt_11_09_ISU.Text);
            if (this.txt_11_10_ISU.Text == "") v11_10_ISU = 0; else v11_10_ISU = Convert.ToDecimal(this.txt_11_10_ISU.Text);
            if (this.txt_11_11_ISU.Text == "") v11_11_ISU = 0; else v11_11_ISU = Convert.ToDecimal(this.txt_11_11_ISU.Text);
            if (this.txt_11_12_ISU.Text == "") v11_12_ISU = 0; else v11_12_ISU = Convert.ToDecimal(this.txt_11_12_ISU.Text);
            if (this.txt_11_13_ISU.Text == "") v11_13_ISU = 0; else v11_13_ISU = Convert.ToDecimal(this.txt_11_13_ISU.Text);
            if (this.txt_11_14_ISU.Text == "") v11_14_ISU = 0; else v11_14_ISU = Convert.ToDecimal(this.txt_11_14_ISU.Text);
            if (this.txt_11_15_ISU.Text == "") v11_15_ISU = 0; else v11_15_ISU = Convert.ToDecimal(this.txt_11_15_ISU.Text);
            if (this.txt_11_16_ISU.Text == "") v11_16_ISU = 0; else v11_16_ISU = Convert.ToDecimal(this.txt_11_16_ISU.Text);
            if (this.txt_11_17_ISU.Text == "") v11_17_ISU = 0; else v11_17_ISU = Convert.ToDecimal(this.txt_11_17_ISU.Text);
            if (this.txt_11_18_ISU.Text == "") v11_18_ISU = 0; else v11_18_ISU = Convert.ToDecimal(this.txt_11_18_ISU.Text);
            if (this.txt_11_19_ISU.Text == "") v11_19_ISU = 0; else v11_19_ISU = Convert.ToDecimal(this.txt_11_19_ISU.Text);
            if (this.txt_11_20_ISU.Text == "") v11_20_ISU = 0; else v11_20_ISU = Convert.ToDecimal(this.txt_11_20_ISU.Text);
            if (this.txt_11_01_SEK.Text == "")
            {
                v11_01_SEK = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_01_SEK = Convert.ToDecimal(this.txt_11_01_SEK.Text);
            }

            if (this.txt_11_02_SEK.Text == "")
            {
                v11_02_SEK = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_02_SEK = Convert.ToDecimal(this.txt_11_02_SEK.Text);
            }

            if (this.txt_11_03_SEK.Text == "") v11_03_SEK = 0; else v11_03_SEK = Convert.ToDecimal(this.txt_11_03_SEK.Text);
            if (this.txt_11_04_SEK.Text == "") v11_04_SEK = 0; else v11_04_SEK = Convert.ToDecimal(this.txt_11_04_SEK.Text);
            if (this.txt_11_05_SEK.Text == "") v11_05_SEK = 0; else v11_05_SEK = Convert.ToDecimal(this.txt_11_05_SEK.Text);
            if (this.txt_11_06_SEK.Text == "") v11_06_SEK = 0; else v11_06_SEK = Convert.ToDecimal(this.txt_11_06_SEK.Text);
            if (this.txt_11_07_SEK.Text == "") v11_07_SEK = 0; else v11_07_SEK = Convert.ToDecimal(this.txt_11_07_SEK.Text);
            if (this.txt_11_08_SEK.Text == "") v11_08_SEK = 0; else v11_08_SEK = Convert.ToDecimal(this.txt_11_08_SEK.Text);
            if (this.txt_11_09_SEK.Text == "") v11_09_SEK = 0; else v11_09_SEK = Convert.ToDecimal(this.txt_11_09_SEK.Text);
            if (this.txt_11_10_SEK.Text == "") v11_10_SEK = 0; else v11_10_SEK = Convert.ToDecimal(this.txt_11_10_SEK.Text);
            if (this.txt_11_11_SEK.Text == "") v11_11_SEK = 0; else v11_11_SEK = Convert.ToDecimal(this.txt_11_11_SEK.Text);
            if (this.txt_11_12_SEK.Text == "") v11_12_SEK = 0; else v11_12_SEK = Convert.ToDecimal(this.txt_11_12_SEK.Text);
            if (this.txt_11_13_SEK.Text == "") v11_13_SEK = 0; else v11_13_SEK = Convert.ToDecimal(this.txt_11_13_SEK.Text);
            if (this.txt_11_14_SEK.Text == "") v11_14_SEK = 0; else v11_14_SEK = Convert.ToDecimal(this.txt_11_14_SEK.Text);
            if (this.txt_11_15_SEK.Text == "") v11_15_SEK = 0; else v11_15_SEK = Convert.ToDecimal(this.txt_11_15_SEK.Text);
            if (this.txt_11_16_SEK.Text == "") v11_16_SEK = 0; else v11_16_SEK = Convert.ToDecimal(this.txt_11_16_SEK.Text);
            if (this.txt_11_17_SEK.Text == "") v11_17_SEK = 0; else v11_17_SEK = Convert.ToDecimal(this.txt_11_17_SEK.Text);
            if (this.txt_11_18_SEK.Text == "") v11_18_SEK = 0; else v11_18_SEK = Convert.ToDecimal(this.txt_11_18_SEK.Text);
            if (this.txt_11_19_SEK.Text == "") v11_19_SEK = 0; else v11_19_SEK = Convert.ToDecimal(this.txt_11_19_SEK.Text);
            if (this.txt_11_20_SEK.Text == "") v11_20_SEK = 0; else v11_20_SEK = Convert.ToDecimal(this.txt_11_20_SEK.Text);

            if (this.txt_11_01_JAE.Text == "")
            {
                v11_01_JAE = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_01_JAE = Convert.ToDecimal(this.txt_11_01_JAE.Text);
            }
            if (this.txt_11_02_JAE.Text == "")
            {
                v11_02_JAE = 0;
                CommonMessage.AlertMessage(this, "1학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v11_02_JAE = Convert.ToDecimal(this.txt_11_02_JAE.Text);
            }
            if (this.txt_11_03_JAE.Text == "") v11_03_JAE = 0; else v11_03_JAE = Convert.ToDecimal(this.txt_11_03_JAE.Text);
            if (this.txt_11_04_JAE.Text == "") v11_04_JAE = 0; else v11_04_JAE = Convert.ToDecimal(this.txt_11_04_JAE.Text);
            if (this.txt_11_05_JAE.Text == "") v11_05_JAE = 0; else v11_05_JAE = Convert.ToDecimal(this.txt_11_05_JAE.Text);
            if (this.txt_11_06_JAE.Text == "") v11_06_JAE = 0; else v11_06_JAE = Convert.ToDecimal(this.txt_11_06_JAE.Text);
            if (this.txt_11_07_JAE.Text == "") v11_07_JAE = 0; else v11_07_JAE = Convert.ToDecimal(this.txt_11_07_JAE.Text);
            if (this.txt_11_08_JAE.Text == "") v11_08_JAE = 0; else v11_08_JAE = Convert.ToDecimal(this.txt_11_08_JAE.Text);
            if (this.txt_11_09_JAE.Text == "") v11_09_JAE = 0; else v11_09_JAE = Convert.ToDecimal(this.txt_11_09_JAE.Text);
            if (this.txt_11_10_JAE.Text == "") v11_10_JAE = 0; else v11_10_JAE = Convert.ToDecimal(this.txt_11_10_JAE.Text);
            if (this.txt_11_11_JAE.Text == "") v11_11_JAE = 0; else v11_11_JAE = Convert.ToDecimal(this.txt_11_11_JAE.Text);
            if (this.txt_11_12_JAE.Text == "") v11_12_JAE = 0; else v11_12_JAE = Convert.ToDecimal(this.txt_11_12_JAE.Text);
            if (this.txt_11_13_JAE.Text == "") v11_13_JAE = 0; else v11_13_JAE = Convert.ToDecimal(this.txt_11_13_JAE.Text);
            if (this.txt_11_14_JAE.Text == "") v11_14_JAE = 0; else v11_14_JAE = Convert.ToDecimal(this.txt_11_14_JAE.Text);
            if (this.txt_11_15_JAE.Text == "") v11_15_JAE = 0; else v11_15_JAE = Convert.ToDecimal(this.txt_11_15_JAE.Text);
            if (this.txt_11_16_JAE.Text == "") v11_16_JAE = 0; else v11_16_JAE = Convert.ToDecimal(this.txt_11_16_JAE.Text);
            if (this.txt_11_17_JAE.Text == "") v11_17_JAE = 0; else v11_17_JAE = Convert.ToDecimal(this.txt_11_17_JAE.Text);
            if (this.txt_11_18_JAE.Text == "") v11_18_JAE = 0; else v11_18_JAE = Convert.ToDecimal(this.txt_11_18_JAE.Text);
            if (this.txt_11_19_JAE.Text == "") v11_19_JAE = 0; else v11_19_JAE = Convert.ToDecimal(this.txt_11_19_JAE.Text);
            if (this.txt_11_20_JAE.Text == "") v11_20_JAE = 0; else v11_20_JAE = Convert.ToDecimal(this.txt_11_20_JAE.Text);

            if (this.txt_12_01_ISU.Text == "")
            {
                v12_01_ISU = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_01_ISU = Convert.ToDecimal(this.txt_12_01_ISU.Text);
            }


            if (this.txt_12_02_ISU.Text == "")
            {
                v12_02_ISU = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_02_ISU = Convert.ToDecimal(this.txt_12_02_ISU.Text);
            }

            if (this.txt_12_03_ISU.Text == "") v12_03_ISU = 0; else v12_03_ISU = Convert.ToDecimal(this.txt_12_03_ISU.Text);
            if (this.txt_12_04_ISU.Text == "") v12_04_ISU = 0; else v12_04_ISU = Convert.ToDecimal(this.txt_12_04_ISU.Text);
            if (this.txt_12_05_ISU.Text == "") v12_05_ISU = 0; else v12_05_ISU = Convert.ToDecimal(this.txt_12_05_ISU.Text);
            if (this.txt_12_06_ISU.Text == "") v12_06_ISU = 0; else v12_06_ISU = Convert.ToDecimal(this.txt_12_06_ISU.Text);
            if (this.txt_12_07_ISU.Text == "") v12_07_ISU = 0; else v12_07_ISU = Convert.ToDecimal(this.txt_12_07_ISU.Text);
            if (this.txt_12_08_ISU.Text == "") v12_08_ISU = 0; else v12_08_ISU = Convert.ToDecimal(this.txt_12_08_ISU.Text);
            if (this.txt_12_09_ISU.Text == "") v12_09_ISU = 0; else v12_09_ISU = Convert.ToDecimal(this.txt_12_09_ISU.Text);
            if (this.txt_12_10_ISU.Text == "") v12_10_ISU = 0; else v12_10_ISU = Convert.ToDecimal(this.txt_12_10_ISU.Text);
            if (this.txt_12_11_ISU.Text == "") v12_11_ISU = 0; else v12_11_ISU = Convert.ToDecimal(this.txt_12_11_ISU.Text);
            if (this.txt_12_12_ISU.Text == "") v12_12_ISU = 0; else v12_12_ISU = Convert.ToDecimal(this.txt_12_12_ISU.Text);
            if (this.txt_12_13_ISU.Text == "") v12_13_ISU = 0; else v12_13_ISU = Convert.ToDecimal(this.txt_12_13_ISU.Text);
            if (this.txt_12_14_ISU.Text == "") v12_14_ISU = 0; else v12_14_ISU = Convert.ToDecimal(this.txt_12_14_ISU.Text);
            if (this.txt_12_15_ISU.Text == "") v12_15_ISU = 0; else v12_15_ISU = Convert.ToDecimal(this.txt_12_15_ISU.Text);
            if (this.txt_12_16_ISU.Text == "") v12_16_ISU = 0; else v12_16_ISU = Convert.ToDecimal(this.txt_12_16_ISU.Text);
            if (this.txt_12_17_ISU.Text == "") v12_17_ISU = 0; else v12_17_ISU = Convert.ToDecimal(this.txt_12_17_ISU.Text);
            if (this.txt_12_18_ISU.Text == "") v12_18_ISU = 0; else v12_18_ISU = Convert.ToDecimal(this.txt_12_18_ISU.Text);
            if (this.txt_12_19_ISU.Text == "") v12_19_ISU = 0; else v12_19_ISU = Convert.ToDecimal(this.txt_12_19_ISU.Text);
            if (this.txt_12_20_ISU.Text == "") v12_20_ISU = 0; else v12_20_ISU = Convert.ToDecimal(this.txt_12_20_ISU.Text);

            if (this.txt_12_01_SEK.Text == "")
            {
                v12_01_SEK = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_01_SEK = Convert.ToDecimal(this.txt_12_01_SEK.Text);
            }

            if (this.txt_12_02_SEK.Text == "")
            {
                v12_02_SEK = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_02_SEK = Convert.ToDecimal(this.txt_12_02_SEK.Text);
            }

            if (this.txt_12_03_SEK.Text == "") v12_03_SEK = 0; else v12_03_SEK = Convert.ToDecimal(this.txt_12_03_SEK.Text);
            if (this.txt_12_04_SEK.Text == "") v12_04_SEK = 0; else v12_04_SEK = Convert.ToDecimal(this.txt_12_04_SEK.Text);
            if (this.txt_12_05_SEK.Text == "") v12_05_SEK = 0; else v12_05_SEK = Convert.ToDecimal(this.txt_12_05_SEK.Text);
            if (this.txt_12_06_SEK.Text == "") v12_06_SEK = 0; else v12_06_SEK = Convert.ToDecimal(this.txt_12_06_SEK.Text);
            if (this.txt_12_07_SEK.Text == "") v12_07_SEK = 0; else v12_07_SEK = Convert.ToDecimal(this.txt_12_07_SEK.Text);
            if (this.txt_12_08_SEK.Text == "") v12_08_SEK = 0; else v12_08_SEK = Convert.ToDecimal(this.txt_12_08_SEK.Text);
            if (this.txt_12_09_SEK.Text == "") v12_09_SEK = 0; else v12_09_SEK = Convert.ToDecimal(this.txt_12_09_SEK.Text);
            if (this.txt_12_10_SEK.Text == "") v12_10_SEK = 0; else v12_10_SEK = Convert.ToDecimal(this.txt_12_10_SEK.Text);
            if (this.txt_12_11_SEK.Text == "") v12_11_SEK = 0; else v12_11_SEK = Convert.ToDecimal(this.txt_12_11_SEK.Text);
            if (this.txt_12_12_SEK.Text == "") v12_12_SEK = 0; else v12_12_SEK = Convert.ToDecimal(this.txt_12_12_SEK.Text);
            if (this.txt_12_13_SEK.Text == "") v12_13_SEK = 0; else v12_13_SEK = Convert.ToDecimal(this.txt_12_13_SEK.Text);
            if (this.txt_12_14_SEK.Text == "") v12_14_SEK = 0; else v12_14_SEK = Convert.ToDecimal(this.txt_12_14_SEK.Text);
            if (this.txt_12_15_SEK.Text == "") v12_15_SEK = 0; else v12_15_SEK = Convert.ToDecimal(this.txt_12_15_SEK.Text);
            if (this.txt_12_16_SEK.Text == "") v12_16_SEK = 0; else v12_16_SEK = Convert.ToDecimal(this.txt_12_16_SEK.Text);
            if (this.txt_12_17_SEK.Text == "") v12_17_SEK = 0; else v12_17_SEK = Convert.ToDecimal(this.txt_12_17_SEK.Text);
            if (this.txt_12_18_SEK.Text == "") v12_18_SEK = 0; else v12_18_SEK = Convert.ToDecimal(this.txt_12_18_SEK.Text);
            if (this.txt_12_19_SEK.Text == "") v12_19_SEK = 0; else v12_19_SEK = Convert.ToDecimal(this.txt_12_19_SEK.Text);
            if (this.txt_12_20_SEK.Text == "") v12_20_SEK = 0; else v12_20_SEK = Convert.ToDecimal(this.txt_12_20_SEK.Text);

            if (this.txt_12_01_JAE.Text == "")
            {
                v12_01_JAE = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_01_JAE = Convert.ToDecimal(this.txt_12_01_JAE.Text);
            }
            if (this.txt_12_02_JAE.Text == "")
            {
                v12_02_JAE = 0;
                CommonMessage.AlertMessage(this, "1학년 2학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v12_02_JAE = Convert.ToDecimal(this.txt_12_02_JAE.Text);
            }

            if (this.txt_12_03_JAE.Text == "") v12_03_JAE = 0; else v12_03_JAE = Convert.ToDecimal(this.txt_12_03_JAE.Text);
            if (this.txt_12_04_JAE.Text == "") v12_04_JAE = 0; else v12_04_JAE = Convert.ToDecimal(this.txt_12_04_JAE.Text);
            if (this.txt_12_05_JAE.Text == "") v12_05_JAE = 0; else v12_05_JAE = Convert.ToDecimal(this.txt_12_05_JAE.Text);
            if (this.txt_12_06_JAE.Text == "") v12_06_JAE = 0; else v12_06_JAE = Convert.ToDecimal(this.txt_12_06_JAE.Text);
            if (this.txt_12_07_JAE.Text == "") v12_07_JAE = 0; else v12_07_JAE = Convert.ToDecimal(this.txt_12_07_JAE.Text);
            if (this.txt_12_08_JAE.Text == "") v12_08_JAE = 0; else v12_08_JAE = Convert.ToDecimal(this.txt_12_08_JAE.Text);
            if (this.txt_12_09_JAE.Text == "") v12_09_JAE = 0; else v12_09_JAE = Convert.ToDecimal(this.txt_12_09_JAE.Text);
            if (this.txt_12_10_JAE.Text == "") v12_10_JAE = 0; else v12_10_JAE = Convert.ToDecimal(this.txt_12_10_JAE.Text);
            if (this.txt_12_11_JAE.Text == "") v12_11_JAE = 0; else v12_11_JAE = Convert.ToDecimal(this.txt_12_11_JAE.Text);
            if (this.txt_12_12_JAE.Text == "") v12_12_JAE = 0; else v12_12_JAE = Convert.ToDecimal(this.txt_12_12_JAE.Text);
            if (this.txt_12_13_JAE.Text == "") v12_13_JAE = 0; else v12_13_JAE = Convert.ToDecimal(this.txt_12_13_JAE.Text);
            if (this.txt_12_14_JAE.Text == "") v12_14_JAE = 0; else v12_14_JAE = Convert.ToDecimal(this.txt_12_14_JAE.Text);
            if (this.txt_12_15_JAE.Text == "") v12_15_JAE = 0; else v12_15_JAE = Convert.ToDecimal(this.txt_12_15_JAE.Text);
            if (this.txt_12_16_JAE.Text == "") v12_16_JAE = 0; else v12_16_JAE = Convert.ToDecimal(this.txt_12_16_JAE.Text);
            if (this.txt_12_17_JAE.Text == "") v12_17_JAE = 0; else v12_17_JAE = Convert.ToDecimal(this.txt_12_17_JAE.Text);
            if (this.txt_12_18_JAE.Text == "") v12_18_JAE = 0; else v12_18_JAE = Convert.ToDecimal(this.txt_12_18_JAE.Text);
            if (this.txt_12_19_JAE.Text == "") v12_19_JAE = 0; else v12_19_JAE = Convert.ToDecimal(this.txt_12_19_JAE.Text);
            if (this.txt_12_20_JAE.Text == "") v12_20_JAE = 0; else v12_20_JAE = Convert.ToDecimal(this.txt_12_20_JAE.Text);

            if (this.txt_21_01_ISU.Text == "")
            {
                v21_01_ISU = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_01_ISU = Convert.ToDecimal(this.txt_21_01_ISU.Text);
            }

            if (this.txt_21_02_ISU.Text == "")
            {
                v21_02_ISU = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_02_ISU = Convert.ToDecimal(this.txt_21_02_ISU.Text);
            }

            if (this.txt_21_03_ISU.Text == "") v21_03_ISU = 0; else v21_03_ISU = Convert.ToDecimal(this.txt_21_03_ISU.Text);
            if (this.txt_21_04_ISU.Text == "") v21_04_ISU = 0; else v21_04_ISU = Convert.ToDecimal(this.txt_21_04_ISU.Text);
            if (this.txt_21_05_ISU.Text == "") v21_05_ISU = 0; else v21_05_ISU = Convert.ToDecimal(this.txt_21_05_ISU.Text);
            if (this.txt_21_06_ISU.Text == "") v21_06_ISU = 0; else v21_06_ISU = Convert.ToDecimal(this.txt_21_06_ISU.Text);
            if (this.txt_21_07_ISU.Text == "") v21_07_ISU = 0; else v21_07_ISU = Convert.ToDecimal(this.txt_21_07_ISU.Text);
            if (this.txt_21_08_ISU.Text == "") v21_08_ISU = 0; else v21_08_ISU = Convert.ToDecimal(this.txt_21_08_ISU.Text);
            if (this.txt_21_09_ISU.Text == "") v21_09_ISU = 0; else v21_09_ISU = Convert.ToDecimal(this.txt_21_09_ISU.Text);
            if (this.txt_21_10_ISU.Text == "") v21_10_ISU = 0; else v21_10_ISU = Convert.ToDecimal(this.txt_21_10_ISU.Text);
            if (this.txt_21_11_ISU.Text == "") v21_11_ISU = 0; else v21_11_ISU = Convert.ToDecimal(this.txt_21_11_ISU.Text);
            if (this.txt_21_12_ISU.Text == "") v21_12_ISU = 0; else v21_12_ISU = Convert.ToDecimal(this.txt_21_12_ISU.Text);
            if (this.txt_21_13_ISU.Text == "") v21_13_ISU = 0; else v21_13_ISU = Convert.ToDecimal(this.txt_21_13_ISU.Text);
            if (this.txt_21_14_ISU.Text == "") v21_14_ISU = 0; else v21_14_ISU = Convert.ToDecimal(this.txt_21_14_ISU.Text);
            if (this.txt_21_15_ISU.Text == "") v21_15_ISU = 0; else v21_15_ISU = Convert.ToDecimal(this.txt_21_15_ISU.Text);
            if (this.txt_21_16_ISU.Text == "") v21_16_ISU = 0; else v21_16_ISU = Convert.ToDecimal(this.txt_21_16_ISU.Text);
            if (this.txt_21_17_ISU.Text == "") v21_17_ISU = 0; else v21_17_ISU = Convert.ToDecimal(this.txt_21_17_ISU.Text);
            if (this.txt_21_18_ISU.Text == "") v21_18_ISU = 0; else v21_18_ISU = Convert.ToDecimal(this.txt_21_18_ISU.Text);
            if (this.txt_21_19_ISU.Text == "") v21_19_ISU = 0; else v21_19_ISU = Convert.ToDecimal(this.txt_21_19_ISU.Text);
            if (this.txt_21_20_ISU.Text == "") v21_20_ISU = 0; else v21_20_ISU = Convert.ToDecimal(this.txt_21_20_ISU.Text);

            if (this.txt_21_01_SEK.Text == "")
            {
                v21_01_SEK = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_01_SEK = Convert.ToDecimal(this.txt_21_01_SEK.Text);
            }

            if (this.txt_21_02_SEK.Text == "")
            {
                v21_02_SEK = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_02_SEK = Convert.ToDecimal(this.txt_21_02_SEK.Text);
            }


            if (this.txt_21_03_SEK.Text == "") v21_03_SEK = 0; else v21_03_SEK = Convert.ToDecimal(this.txt_21_03_SEK.Text);
            if (this.txt_21_04_SEK.Text == "") v21_04_SEK = 0; else v21_04_SEK = Convert.ToDecimal(this.txt_21_04_SEK.Text);
            if (this.txt_21_05_SEK.Text == "") v21_05_SEK = 0; else v21_05_SEK = Convert.ToDecimal(this.txt_21_05_SEK.Text);
            if (this.txt_21_06_SEK.Text == "") v21_06_SEK = 0; else v21_06_SEK = Convert.ToDecimal(this.txt_21_06_SEK.Text);
            if (this.txt_21_07_SEK.Text == "") v21_07_SEK = 0; else v21_07_SEK = Convert.ToDecimal(this.txt_21_07_SEK.Text);
            if (this.txt_21_08_SEK.Text == "") v21_08_SEK = 0; else v21_08_SEK = Convert.ToDecimal(this.txt_21_08_SEK.Text);
            if (this.txt_21_09_SEK.Text == "") v21_09_SEK = 0; else v21_09_SEK = Convert.ToDecimal(this.txt_21_09_SEK.Text);
            if (this.txt_21_10_SEK.Text == "") v21_10_SEK = 0; else v21_10_SEK = Convert.ToDecimal(this.txt_21_10_SEK.Text);
            if (this.txt_21_11_SEK.Text == "") v21_11_SEK = 0; else v21_11_SEK = Convert.ToDecimal(this.txt_21_11_SEK.Text);
            if (this.txt_21_12_SEK.Text == "") v21_12_SEK = 0; else v21_12_SEK = Convert.ToDecimal(this.txt_21_12_SEK.Text);
            if (this.txt_21_13_SEK.Text == "") v21_13_SEK = 0; else v21_13_SEK = Convert.ToDecimal(this.txt_21_13_SEK.Text);
            if (this.txt_21_14_SEK.Text == "") v21_14_SEK = 0; else v21_14_SEK = Convert.ToDecimal(this.txt_21_14_SEK.Text);
            if (this.txt_21_15_SEK.Text == "") v21_15_SEK = 0; else v21_15_SEK = Convert.ToDecimal(this.txt_21_15_SEK.Text);
            if (this.txt_21_16_SEK.Text == "") v21_16_SEK = 0; else v21_16_SEK = Convert.ToDecimal(this.txt_21_16_SEK.Text);
            if (this.txt_21_17_SEK.Text == "") v21_17_SEK = 0; else v21_17_SEK = Convert.ToDecimal(this.txt_21_17_SEK.Text);
            if (this.txt_21_18_SEK.Text == "") v21_18_SEK = 0; else v21_18_SEK = Convert.ToDecimal(this.txt_21_18_SEK.Text);
            if (this.txt_21_19_SEK.Text == "") v21_19_SEK = 0; else v21_19_SEK = Convert.ToDecimal(this.txt_21_19_SEK.Text);
            if (this.txt_21_20_SEK.Text == "") v21_20_SEK = 0; else v21_20_SEK = Convert.ToDecimal(this.txt_21_20_SEK.Text);

            if (this.txt_21_01_JAE.Text == "")
            {
                v21_01_JAE = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_01_JAE = Convert.ToDecimal(this.txt_21_01_JAE.Text);
            }
            if (this.txt_21_02_JAE.Text == "")
            {
                v21_02_JAE = 0;
                CommonMessage.AlertMessage(this, "2학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v21_02_JAE = Convert.ToDecimal(this.txt_21_02_JAE.Text);
            }

            if (this.txt_21_03_JAE.Text == "") v21_03_JAE = 0; else v21_03_JAE = Convert.ToDecimal(this.txt_21_03_JAE.Text);
            if (this.txt_21_04_JAE.Text == "") v21_04_JAE = 0; else v21_04_JAE = Convert.ToDecimal(this.txt_21_04_JAE.Text);
            if (this.txt_21_05_JAE.Text == "") v21_05_JAE = 0; else v21_05_JAE = Convert.ToDecimal(this.txt_21_05_JAE.Text);
            if (this.txt_21_06_JAE.Text == "") v21_06_JAE = 0; else v21_06_JAE = Convert.ToDecimal(this.txt_21_06_JAE.Text);
            if (this.txt_21_07_JAE.Text == "") v21_07_JAE = 0; else v21_07_JAE = Convert.ToDecimal(this.txt_21_07_JAE.Text);
            if (this.txt_21_08_JAE.Text == "") v21_08_JAE = 0; else v21_08_JAE = Convert.ToDecimal(this.txt_21_08_JAE.Text);
            if (this.txt_21_09_JAE.Text == "") v21_09_JAE = 0; else v21_09_JAE = Convert.ToDecimal(this.txt_21_09_JAE.Text);
            if (this.txt_21_10_JAE.Text == "") v21_10_JAE = 0; else v21_10_JAE = Convert.ToDecimal(this.txt_21_10_JAE.Text);
            if (this.txt_21_11_JAE.Text == "") v21_11_JAE = 0; else v21_11_JAE = Convert.ToDecimal(this.txt_21_11_JAE.Text);
            if (this.txt_21_12_JAE.Text == "") v21_12_JAE = 0; else v21_12_JAE = Convert.ToDecimal(this.txt_21_12_JAE.Text);
            if (this.txt_21_13_JAE.Text == "") v21_13_JAE = 0; else v21_13_JAE = Convert.ToDecimal(this.txt_21_13_JAE.Text);
            if (this.txt_21_14_JAE.Text == "") v21_14_JAE = 0; else v21_14_JAE = Convert.ToDecimal(this.txt_21_14_JAE.Text);
            if (this.txt_21_15_JAE.Text == "") v21_15_JAE = 0; else v21_15_JAE = Convert.ToDecimal(this.txt_21_15_JAE.Text);
            if (this.txt_21_16_JAE.Text == "") v21_16_JAE = 0; else v21_16_JAE = Convert.ToDecimal(this.txt_21_16_JAE.Text);
            if (this.txt_21_17_JAE.Text == "") v21_17_JAE = 0; else v21_17_JAE = Convert.ToDecimal(this.txt_21_17_JAE.Text);
            if (this.txt_21_18_JAE.Text == "") v21_18_JAE = 0; else v21_18_JAE = Convert.ToDecimal(this.txt_21_18_JAE.Text);
            if (this.txt_21_19_JAE.Text == "") v21_19_JAE = 0; else v21_19_JAE = Convert.ToDecimal(this.txt_21_19_JAE.Text);
            if (this.txt_21_20_JAE.Text == "") v21_20_JAE = 0; else v21_20_JAE = Convert.ToDecimal(this.txt_21_20_JAE.Text);

            if (this.txt_22_01_ISU.Text == "")
            {
                v22_01_ISU = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_01_ISU = Convert.ToDecimal(this.txt_22_01_ISU.Text);
            }

            if (this.txt_22_02_ISU.Text == "")
            {
                v22_02_ISU = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_02_ISU = Convert.ToDecimal(this.txt_22_02_ISU.Text);
            }

            if (this.txt_22_03_ISU.Text == "") v22_03_ISU = 0; else v22_03_ISU = Convert.ToDecimal(this.txt_22_03_ISU.Text);
            if (this.txt_22_04_ISU.Text == "") v22_04_ISU = 0; else v22_04_ISU = Convert.ToDecimal(this.txt_22_04_ISU.Text);
            if (this.txt_22_05_ISU.Text == "") v22_05_ISU = 0; else v22_05_ISU = Convert.ToDecimal(this.txt_22_05_ISU.Text);
            if (this.txt_22_06_ISU.Text == "") v22_06_ISU = 0; else v22_06_ISU = Convert.ToDecimal(this.txt_22_06_ISU.Text);
            if (this.txt_22_07_ISU.Text == "") v22_07_ISU = 0; else v22_07_ISU = Convert.ToDecimal(this.txt_22_07_ISU.Text);
            if (this.txt_22_08_ISU.Text == "") v22_08_ISU = 0; else v22_08_ISU = Convert.ToDecimal(this.txt_22_08_ISU.Text);
            if (this.txt_22_09_ISU.Text == "") v22_09_ISU = 0; else v22_09_ISU = Convert.ToDecimal(this.txt_22_09_ISU.Text);
            if (this.txt_22_10_ISU.Text == "") v22_10_ISU = 0; else v22_10_ISU = Convert.ToDecimal(this.txt_22_10_ISU.Text);
            if (this.txt_22_11_ISU.Text == "") v22_11_ISU = 0; else v22_11_ISU = Convert.ToDecimal(this.txt_22_11_ISU.Text);
            if (this.txt_22_12_ISU.Text == "") v22_12_ISU = 0; else v22_12_ISU = Convert.ToDecimal(this.txt_22_12_ISU.Text);
            if (this.txt_22_13_ISU.Text == "") v22_13_ISU = 0; else v22_13_ISU = Convert.ToDecimal(this.txt_22_13_ISU.Text);
            if (this.txt_22_14_ISU.Text == "") v22_14_ISU = 0; else v22_14_ISU = Convert.ToDecimal(this.txt_22_14_ISU.Text);
            if (this.txt_22_15_ISU.Text == "") v22_15_ISU = 0; else v22_15_ISU = Convert.ToDecimal(this.txt_22_15_ISU.Text);
            if (this.txt_22_16_ISU.Text == "") v22_16_ISU = 0; else v22_16_ISU = Convert.ToDecimal(this.txt_22_16_ISU.Text);
            if (this.txt_22_17_ISU.Text == "") v22_17_ISU = 0; else v22_17_ISU = Convert.ToDecimal(this.txt_22_17_ISU.Text);
            if (this.txt_22_18_ISU.Text == "") v22_18_ISU = 0; else v22_18_ISU = Convert.ToDecimal(this.txt_22_18_ISU.Text);
            if (this.txt_22_19_ISU.Text == "") v22_19_ISU = 0; else v22_19_ISU = Convert.ToDecimal(this.txt_22_19_ISU.Text);
            if (this.txt_22_20_ISU.Text == "") v22_20_ISU = 0; else v22_20_ISU = Convert.ToDecimal(this.txt_22_20_ISU.Text);

            if (this.txt_22_01_SEK.Text == "")
            {
                v22_01_SEK = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_01_SEK = Convert.ToDecimal(this.txt_22_01_SEK.Text);
            }

            if (this.txt_22_02_SEK.Text == "")
            {
                v22_02_SEK = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_02_SEK = Convert.ToDecimal(this.txt_22_02_SEK.Text);
            }


            if (this.txt_22_03_SEK.Text == "") v22_03_SEK = 0; else v22_03_SEK = Convert.ToDecimal(this.txt_22_03_SEK.Text);
            if (this.txt_22_04_SEK.Text == "") v22_04_SEK = 0; else v22_04_SEK = Convert.ToDecimal(this.txt_22_04_SEK.Text);
            if (this.txt_22_05_SEK.Text == "") v22_05_SEK = 0; else v22_05_SEK = Convert.ToDecimal(this.txt_22_05_SEK.Text);
            if (this.txt_22_06_SEK.Text == "") v22_06_SEK = 0; else v22_06_SEK = Convert.ToDecimal(this.txt_22_06_SEK.Text);
            if (this.txt_22_07_SEK.Text == "") v22_07_SEK = 0; else v22_07_SEK = Convert.ToDecimal(this.txt_22_07_SEK.Text);
            if (this.txt_22_08_SEK.Text == "") v22_08_SEK = 0; else v22_08_SEK = Convert.ToDecimal(this.txt_22_08_SEK.Text);
            if (this.txt_22_09_SEK.Text == "") v22_09_SEK = 0; else v22_09_SEK = Convert.ToDecimal(this.txt_22_09_SEK.Text);
            if (this.txt_22_10_SEK.Text == "") v22_10_SEK = 0; else v22_10_SEK = Convert.ToDecimal(this.txt_22_10_SEK.Text);
            if (this.txt_22_11_SEK.Text == "") v22_11_SEK = 0; else v22_11_SEK = Convert.ToDecimal(this.txt_22_11_SEK.Text);
            if (this.txt_22_12_SEK.Text == "") v22_12_SEK = 0; else v22_12_SEK = Convert.ToDecimal(this.txt_22_12_SEK.Text);
            if (this.txt_22_13_SEK.Text == "") v22_13_SEK = 0; else v22_13_SEK = Convert.ToDecimal(this.txt_22_13_SEK.Text);
            if (this.txt_22_14_SEK.Text == "") v22_14_SEK = 0; else v22_14_SEK = Convert.ToDecimal(this.txt_22_14_SEK.Text);
            if (this.txt_22_15_SEK.Text == "") v22_15_SEK = 0; else v22_15_SEK = Convert.ToDecimal(this.txt_22_15_SEK.Text);
            if (this.txt_22_16_SEK.Text == "") v22_16_SEK = 0; else v22_16_SEK = Convert.ToDecimal(this.txt_22_16_SEK.Text);
            if (this.txt_22_17_SEK.Text == "") v22_17_SEK = 0; else v22_17_SEK = Convert.ToDecimal(this.txt_22_17_SEK.Text);
            if (this.txt_22_18_SEK.Text == "") v22_18_SEK = 0; else v22_18_SEK = Convert.ToDecimal(this.txt_22_18_SEK.Text);
            if (this.txt_22_19_SEK.Text == "") v22_19_SEK = 0; else v22_19_SEK = Convert.ToDecimal(this.txt_22_19_SEK.Text);
            if (this.txt_22_20_SEK.Text == "") v22_20_SEK = 0; else v22_20_SEK = Convert.ToDecimal(this.txt_22_20_SEK.Text);

            if (this.txt_22_01_JAE.Text == "")
            {
                v22_01_JAE = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_01_JAE = Convert.ToDecimal(this.txt_22_01_JAE.Text);
            }
            if (this.txt_22_02_JAE.Text == "")
            {
                v22_02_JAE = 0;
                CommonMessage.AlertMessage(this, "2학년 2학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v22_02_JAE = Convert.ToDecimal(this.txt_22_02_JAE.Text);
            }

            if (this.txt_22_03_JAE.Text == "") v22_03_JAE = 0; else v22_03_JAE = Convert.ToDecimal(this.txt_22_03_JAE.Text);
            if (this.txt_22_04_JAE.Text == "") v22_04_JAE = 0; else v22_04_JAE = Convert.ToDecimal(this.txt_22_04_JAE.Text);
            if (this.txt_22_05_JAE.Text == "") v22_05_JAE = 0; else v22_05_JAE = Convert.ToDecimal(this.txt_22_05_JAE.Text);
            if (this.txt_22_06_JAE.Text == "") v22_06_JAE = 0; else v22_06_JAE = Convert.ToDecimal(this.txt_22_06_JAE.Text);
            if (this.txt_22_07_JAE.Text == "") v22_07_JAE = 0; else v22_07_JAE = Convert.ToDecimal(this.txt_22_07_JAE.Text);
            if (this.txt_22_08_JAE.Text == "") v22_08_JAE = 0; else v22_08_JAE = Convert.ToDecimal(this.txt_22_08_JAE.Text);
            if (this.txt_22_09_JAE.Text == "") v22_09_JAE = 0; else v22_09_JAE = Convert.ToDecimal(this.txt_22_09_JAE.Text);
            if (this.txt_22_10_JAE.Text == "") v22_10_JAE = 0; else v22_10_JAE = Convert.ToDecimal(this.txt_22_10_JAE.Text);
            if (this.txt_22_11_JAE.Text == "") v22_11_JAE = 0; else v22_11_JAE = Convert.ToDecimal(this.txt_22_11_JAE.Text);
            if (this.txt_22_12_JAE.Text == "") v22_12_JAE = 0; else v22_12_JAE = Convert.ToDecimal(this.txt_22_12_JAE.Text);
            if (this.txt_22_13_JAE.Text == "") v22_13_JAE = 0; else v22_13_JAE = Convert.ToDecimal(this.txt_22_13_JAE.Text);
            if (this.txt_22_14_JAE.Text == "") v22_14_JAE = 0; else v22_14_JAE = Convert.ToDecimal(this.txt_22_14_JAE.Text);
            if (this.txt_22_15_JAE.Text == "") v22_15_JAE = 0; else v22_15_JAE = Convert.ToDecimal(this.txt_22_15_JAE.Text);
            if (this.txt_22_16_JAE.Text == "") v22_16_JAE = 0; else v22_16_JAE = Convert.ToDecimal(this.txt_22_16_JAE.Text);
            if (this.txt_22_17_JAE.Text == "") v22_17_JAE = 0; else v22_17_JAE = Convert.ToDecimal(this.txt_22_17_JAE.Text);
            if (this.txt_22_18_JAE.Text == "") v22_18_JAE = 0; else v22_18_JAE = Convert.ToDecimal(this.txt_22_18_JAE.Text);
            if (this.txt_22_19_JAE.Text == "") v22_19_JAE = 0; else v22_19_JAE = Convert.ToDecimal(this.txt_22_19_JAE.Text);
            if (this.txt_22_20_JAE.Text == "") v22_20_JAE = 0; else v22_20_JAE = Convert.ToDecimal(this.txt_22_20_JAE.Text);

            if (this.txt_31_01_ISU.Text == "")
            {
                v31_01_ISU = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_01_ISU = Convert.ToDecimal(this.txt_31_01_ISU.Text);
            }

            if (this.txt_31_02_ISU.Text == "")
            {
                v31_02_ISU = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 원점수를 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_02_ISU = Convert.ToDecimal(this.txt_31_02_ISU.Text);
            }

            if (this.txt_31_03_ISU.Text == "") v31_03_ISU = 0; else v31_03_ISU = Convert.ToDecimal(this.txt_31_03_ISU.Text);
            if (this.txt_31_04_ISU.Text == "") v31_04_ISU = 0; else v31_04_ISU = Convert.ToDecimal(this.txt_31_04_ISU.Text);
            if (this.txt_31_05_ISU.Text == "") v31_05_ISU = 0; else v31_05_ISU = Convert.ToDecimal(this.txt_31_05_ISU.Text);
            if (this.txt_31_06_ISU.Text == "") v31_06_ISU = 0; else v31_06_ISU = Convert.ToDecimal(this.txt_31_06_ISU.Text);
            if (this.txt_31_07_ISU.Text == "") v31_07_ISU = 0; else v31_07_ISU = Convert.ToDecimal(this.txt_31_07_ISU.Text);
            if (this.txt_31_08_ISU.Text == "") v31_08_ISU = 0; else v31_08_ISU = Convert.ToDecimal(this.txt_31_08_ISU.Text);
            if (this.txt_31_09_ISU.Text == "") v31_09_ISU = 0; else v31_09_ISU = Convert.ToDecimal(this.txt_31_09_ISU.Text);
            if (this.txt_31_10_ISU.Text == "") v31_10_ISU = 0; else v31_10_ISU = Convert.ToDecimal(this.txt_31_10_ISU.Text);
            if (this.txt_31_11_ISU.Text == "") v31_11_ISU = 0; else v31_11_ISU = Convert.ToDecimal(this.txt_31_11_ISU.Text);
            if (this.txt_31_12_ISU.Text == "") v31_12_ISU = 0; else v31_12_ISU = Convert.ToDecimal(this.txt_31_12_ISU.Text);
            if (this.txt_31_13_ISU.Text == "") v31_13_ISU = 0; else v31_13_ISU = Convert.ToDecimal(this.txt_31_13_ISU.Text);
            if (this.txt_31_14_ISU.Text == "") v31_14_ISU = 0; else v31_14_ISU = Convert.ToDecimal(this.txt_31_14_ISU.Text);
            if (this.txt_31_15_ISU.Text == "") v31_15_ISU = 0; else v31_15_ISU = Convert.ToDecimal(this.txt_31_15_ISU.Text);
            if (this.txt_31_16_ISU.Text == "") v31_16_ISU = 0; else v31_16_ISU = Convert.ToDecimal(this.txt_31_16_ISU.Text);
            if (this.txt_31_17_ISU.Text == "") v31_17_ISU = 0; else v31_17_ISU = Convert.ToDecimal(this.txt_31_17_ISU.Text);
            if (this.txt_31_18_ISU.Text == "") v31_18_ISU = 0; else v31_18_ISU = Convert.ToDecimal(this.txt_31_18_ISU.Text);
            if (this.txt_31_19_ISU.Text == "") v31_19_ISU = 0; else v31_19_ISU = Convert.ToDecimal(this.txt_31_19_ISU.Text);
            if (this.txt_31_20_ISU.Text == "") v31_20_ISU = 0; else v31_20_ISU = Convert.ToDecimal(this.txt_31_20_ISU.Text);

            if (this.txt_31_01_SEK.Text == "")
            {
                v31_01_SEK = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_01_SEK = Convert.ToDecimal(this.txt_31_01_SEK.Text);
            }

            if (this.txt_31_02_SEK.Text == "")
            {
                v31_02_SEK = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 과목평균을 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_02_SEK = Convert.ToDecimal(this.txt_31_02_SEK.Text);
            }


            if (this.txt_31_03_SEK.Text == "") v31_03_SEK = 0; else v31_03_SEK = Convert.ToDecimal(this.txt_31_03_SEK.Text);
            if (this.txt_31_04_SEK.Text == "") v31_04_SEK = 0; else v31_04_SEK = Convert.ToDecimal(this.txt_31_04_SEK.Text);
            if (this.txt_31_05_SEK.Text == "") v31_05_SEK = 0; else v31_05_SEK = Convert.ToDecimal(this.txt_31_05_SEK.Text);
            if (this.txt_31_06_SEK.Text == "") v31_06_SEK = 0; else v31_06_SEK = Convert.ToDecimal(this.txt_31_06_SEK.Text);
            if (this.txt_31_07_SEK.Text == "") v31_07_SEK = 0; else v31_07_SEK = Convert.ToDecimal(this.txt_31_07_SEK.Text);
            if (this.txt_31_08_SEK.Text == "") v31_08_SEK = 0; else v31_08_SEK = Convert.ToDecimal(this.txt_31_08_SEK.Text);
            if (this.txt_31_09_SEK.Text == "") v31_09_SEK = 0; else v31_09_SEK = Convert.ToDecimal(this.txt_31_09_SEK.Text);
            if (this.txt_31_10_SEK.Text == "") v31_10_SEK = 0; else v31_10_SEK = Convert.ToDecimal(this.txt_31_10_SEK.Text);
            if (this.txt_31_11_SEK.Text == "") v31_11_SEK = 0; else v31_11_SEK = Convert.ToDecimal(this.txt_31_11_SEK.Text);
            if (this.txt_31_12_SEK.Text == "") v31_12_SEK = 0; else v31_12_SEK = Convert.ToDecimal(this.txt_31_12_SEK.Text);
            if (this.txt_31_13_SEK.Text == "") v31_13_SEK = 0; else v31_13_SEK = Convert.ToDecimal(this.txt_31_13_SEK.Text);
            if (this.txt_31_14_SEK.Text == "") v31_14_SEK = 0; else v31_14_SEK = Convert.ToDecimal(this.txt_31_14_SEK.Text);
            if (this.txt_31_15_SEK.Text == "") v31_15_SEK = 0; else v31_15_SEK = Convert.ToDecimal(this.txt_31_15_SEK.Text);
            if (this.txt_31_16_SEK.Text == "") v31_16_SEK = 0; else v31_16_SEK = Convert.ToDecimal(this.txt_31_16_SEK.Text);
            if (this.txt_31_17_SEK.Text == "") v31_17_SEK = 0; else v31_17_SEK = Convert.ToDecimal(this.txt_31_17_SEK.Text);
            if (this.txt_31_18_SEK.Text == "") v31_18_SEK = 0; else v31_18_SEK = Convert.ToDecimal(this.txt_31_18_SEK.Text);
            if (this.txt_31_19_SEK.Text == "") v31_19_SEK = 0; else v31_19_SEK = Convert.ToDecimal(this.txt_31_19_SEK.Text);
            if (this.txt_31_20_SEK.Text == "") v31_20_SEK = 0; else v31_20_SEK = Convert.ToDecimal(this.txt_31_20_SEK.Text);

            if (this.txt_31_01_JAE.Text == "")
            {
                v31_01_JAE = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_01_JAE = Convert.ToDecimal(this.txt_31_01_JAE.Text);
            }
            if (this.txt_31_02_JAE.Text == "")
            {
                v31_02_JAE = 0;
                CommonMessage.AlertMessage(this, "3학년 1학기 표준편차을 정확히 입력하세요..");
                return;
            }
            else
            {
                v31_02_JAE = Convert.ToDecimal(this.txt_31_02_JAE.Text);
            }


            if (this.txt_31_03_JAE.Text == "") v31_03_JAE = 0; else v31_03_JAE = Convert.ToDecimal(this.txt_31_03_JAE.Text);
            if (this.txt_31_04_JAE.Text == "") v31_04_JAE = 0; else v31_04_JAE = Convert.ToDecimal(this.txt_31_04_JAE.Text);
            if (this.txt_31_05_JAE.Text == "") v31_05_JAE = 0; else v31_05_JAE = Convert.ToDecimal(this.txt_31_05_JAE.Text);
            if (this.txt_31_06_JAE.Text == "") v31_06_JAE = 0; else v31_06_JAE = Convert.ToDecimal(this.txt_31_06_JAE.Text);
            if (this.txt_31_07_JAE.Text == "") v31_07_JAE = 0; else v31_07_JAE = Convert.ToDecimal(this.txt_31_07_JAE.Text);
            if (this.txt_31_08_JAE.Text == "") v31_08_JAE = 0; else v31_08_JAE = Convert.ToDecimal(this.txt_31_08_JAE.Text);
            if (this.txt_31_09_JAE.Text == "") v31_09_JAE = 0; else v31_09_JAE = Convert.ToDecimal(this.txt_31_09_JAE.Text);
            if (this.txt_31_10_JAE.Text == "") v31_10_JAE = 0; else v31_10_JAE = Convert.ToDecimal(this.txt_31_10_JAE.Text);
            if (this.txt_31_11_JAE.Text == "") v31_11_JAE = 0; else v31_11_JAE = Convert.ToDecimal(this.txt_31_11_JAE.Text);
            if (this.txt_31_12_JAE.Text == "") v31_12_JAE = 0; else v31_12_JAE = Convert.ToDecimal(this.txt_31_12_JAE.Text);
            if (this.txt_31_13_JAE.Text == "") v31_13_JAE = 0; else v31_13_JAE = Convert.ToDecimal(this.txt_31_13_JAE.Text);
            if (this.txt_31_14_JAE.Text == "") v31_14_JAE = 0; else v31_14_JAE = Convert.ToDecimal(this.txt_31_14_JAE.Text);
            if (this.txt_31_15_JAE.Text == "") v31_15_JAE = 0; else v31_15_JAE = Convert.ToDecimal(this.txt_31_15_JAE.Text);
            if (this.txt_31_16_JAE.Text == "") v31_16_JAE = 0; else v31_16_JAE = Convert.ToDecimal(this.txt_31_16_JAE.Text);
            if (this.txt_31_17_JAE.Text == "") v31_17_JAE = 0; else v31_17_JAE = Convert.ToDecimal(this.txt_31_17_JAE.Text);
            if (this.txt_31_18_JAE.Text == "") v31_18_JAE = 0; else v31_18_JAE = Convert.ToDecimal(this.txt_31_18_JAE.Text);
            if (this.txt_31_19_JAE.Text == "") v31_19_JAE = 0; else v31_19_JAE = Convert.ToDecimal(this.txt_31_19_JAE.Text);
            if (this.txt_31_20_JAE.Text == "") v31_20_JAE = 0; else v31_20_JAE = Convert.ToDecimal(this.txt_31_20_JAE.Text);
            if (this.txt_32_01_ISU.Text == "") v32_01_ISU = 0; else v32_01_ISU = Convert.ToDecimal(this.txt_32_01_ISU.Text);
            if (this.txt_32_02_ISU.Text == "") v32_02_ISU = 0; else v32_02_ISU = Convert.ToDecimal(this.txt_32_02_ISU.Text);
            if (this.txt_32_03_ISU.Text == "") v32_03_ISU = 0; else v32_03_ISU = Convert.ToDecimal(this.txt_32_03_ISU.Text);
            if (this.txt_32_04_ISU.Text == "") v32_04_ISU = 0; else v32_04_ISU = Convert.ToDecimal(this.txt_32_04_ISU.Text);
            if (this.txt_32_05_ISU.Text == "") v32_05_ISU = 0; else v32_05_ISU = Convert.ToDecimal(this.txt_32_05_ISU.Text);
            if (this.txt_32_06_ISU.Text == "") v32_06_ISU = 0; else v32_06_ISU = Convert.ToDecimal(this.txt_32_06_ISU.Text);
            if (this.txt_32_07_ISU.Text == "") v32_07_ISU = 0; else v32_07_ISU = Convert.ToDecimal(this.txt_32_07_ISU.Text);
            if (this.txt_32_08_ISU.Text == "") v32_08_ISU = 0; else v32_08_ISU = Convert.ToDecimal(this.txt_32_08_ISU.Text);
            if (this.txt_32_09_ISU.Text == "") v32_09_ISU = 0; else v32_09_ISU = Convert.ToDecimal(this.txt_32_09_ISU.Text);
            if (this.txt_32_10_ISU.Text == "") v32_10_ISU = 0; else v32_10_ISU = Convert.ToDecimal(this.txt_32_10_ISU.Text);
            if (this.txt_32_11_ISU.Text == "") v32_11_ISU = 0; else v32_11_ISU = Convert.ToDecimal(this.txt_32_11_ISU.Text);
            if (this.txt_32_12_ISU.Text == "") v32_12_ISU = 0; else v32_12_ISU = Convert.ToDecimal(this.txt_32_12_ISU.Text);
            if (this.txt_32_13_ISU.Text == "") v32_13_ISU = 0; else v32_13_ISU = Convert.ToDecimal(this.txt_32_13_ISU.Text);
            if (this.txt_32_14_ISU.Text == "") v32_14_ISU = 0; else v32_14_ISU = Convert.ToDecimal(this.txt_32_14_ISU.Text);
            if (this.txt_32_15_ISU.Text == "") v32_15_ISU = 0; else v32_15_ISU = Convert.ToDecimal(this.txt_32_15_ISU.Text);
            if (this.txt_32_16_ISU.Text == "") v32_16_ISU = 0; else v32_16_ISU = Convert.ToDecimal(this.txt_32_16_ISU.Text);
            if (this.txt_32_17_ISU.Text == "") v32_17_ISU = 0; else v32_17_ISU = Convert.ToDecimal(this.txt_32_17_ISU.Text);
            if (this.txt_32_18_ISU.Text == "") v32_18_ISU = 0; else v32_18_ISU = Convert.ToDecimal(this.txt_32_18_ISU.Text);
            if (this.txt_32_19_ISU.Text == "") v32_19_ISU = 0; else v32_19_ISU = Convert.ToDecimal(this.txt_32_19_ISU.Text);
            if (this.txt_32_20_ISU.Text == "") v32_20_ISU = 0; else v32_20_ISU = Convert.ToDecimal(this.txt_32_20_ISU.Text);
            if (this.txt_32_01_SEK.Text == "") v32_01_SEK = 0; else v32_01_SEK = Convert.ToDecimal(this.txt_32_01_SEK.Text);
            if (this.txt_32_02_SEK.Text == "") v32_02_SEK = 0; else v32_02_SEK = Convert.ToDecimal(this.txt_32_02_SEK.Text);
            if (this.txt_32_03_SEK.Text == "") v32_03_SEK = 0; else v32_03_SEK = Convert.ToDecimal(this.txt_32_03_SEK.Text);
            if (this.txt_32_04_SEK.Text == "") v32_04_SEK = 0; else v32_04_SEK = Convert.ToDecimal(this.txt_32_04_SEK.Text);
            if (this.txt_32_05_SEK.Text == "") v32_05_SEK = 0; else v32_05_SEK = Convert.ToDecimal(this.txt_32_05_SEK.Text);
            if (this.txt_32_06_SEK.Text == "") v32_06_SEK = 0; else v32_06_SEK = Convert.ToDecimal(this.txt_32_06_SEK.Text);
            if (this.txt_32_07_SEK.Text == "") v32_07_SEK = 0; else v32_07_SEK = Convert.ToDecimal(this.txt_32_07_SEK.Text);
            if (this.txt_32_08_SEK.Text == "") v32_08_SEK = 0; else v32_08_SEK = Convert.ToDecimal(this.txt_32_08_SEK.Text);
            if (this.txt_32_09_SEK.Text == "") v32_09_SEK = 0; else v32_09_SEK = Convert.ToDecimal(this.txt_32_09_SEK.Text);
            if (this.txt_32_10_SEK.Text == "") v32_10_SEK = 0; else v32_10_SEK = Convert.ToDecimal(this.txt_32_10_SEK.Text);
            if (this.txt_32_11_SEK.Text == "") v32_11_SEK = 0; else v32_11_SEK = Convert.ToDecimal(this.txt_32_11_SEK.Text);
            if (this.txt_32_12_SEK.Text == "") v32_12_SEK = 0; else v32_12_SEK = Convert.ToDecimal(this.txt_32_12_SEK.Text);
            if (this.txt_32_13_SEK.Text == "") v32_13_SEK = 0; else v32_13_SEK = Convert.ToDecimal(this.txt_32_13_SEK.Text);
            if (this.txt_32_14_SEK.Text == "") v32_14_SEK = 0; else v32_14_SEK = Convert.ToDecimal(this.txt_32_14_SEK.Text);
            if (this.txt_32_15_SEK.Text == "") v32_15_SEK = 0; else v32_15_SEK = Convert.ToDecimal(this.txt_32_15_SEK.Text);
            if (this.txt_32_16_SEK.Text == "") v32_16_SEK = 0; else v32_16_SEK = Convert.ToDecimal(this.txt_32_16_SEK.Text);
            if (this.txt_32_17_SEK.Text == "") v32_17_SEK = 0; else v32_17_SEK = Convert.ToDecimal(this.txt_32_17_SEK.Text);
            if (this.txt_32_18_SEK.Text == "") v32_18_SEK = 0; else v32_18_SEK = Convert.ToDecimal(this.txt_32_18_SEK.Text);
            if (this.txt_32_19_SEK.Text == "") v32_19_SEK = 0; else v32_19_SEK = Convert.ToDecimal(this.txt_32_19_SEK.Text);
            if (this.txt_32_20_SEK.Text == "") v32_20_SEK = 0; else v32_20_SEK = Convert.ToDecimal(this.txt_32_20_SEK.Text);
            if (this.txt_32_01_JAE.Text == "") v32_01_JAE = 0; else v32_01_JAE = Convert.ToDecimal(this.txt_32_01_JAE.Text);
            if (this.txt_32_02_JAE.Text == "") v32_02_JAE = 0; else v32_02_JAE = Convert.ToDecimal(this.txt_32_02_JAE.Text);
            if (this.txt_32_03_JAE.Text == "") v32_03_JAE = 0; else v32_03_JAE = Convert.ToDecimal(this.txt_32_03_JAE.Text);
            if (this.txt_32_04_JAE.Text == "") v32_04_JAE = 0; else v32_04_JAE = Convert.ToDecimal(this.txt_32_04_JAE.Text);
            if (this.txt_32_05_JAE.Text == "") v32_05_JAE = 0; else v32_05_JAE = Convert.ToDecimal(this.txt_32_05_JAE.Text);
            if (this.txt_32_06_JAE.Text == "") v32_06_JAE = 0; else v32_06_JAE = Convert.ToDecimal(this.txt_32_06_JAE.Text);
            if (this.txt_32_07_JAE.Text == "") v32_07_JAE = 0; else v32_07_JAE = Convert.ToDecimal(this.txt_32_07_JAE.Text);
            if (this.txt_32_08_JAE.Text == "") v32_08_JAE = 0; else v32_08_JAE = Convert.ToDecimal(this.txt_32_08_JAE.Text);
            if (this.txt_32_09_JAE.Text == "") v32_09_JAE = 0; else v32_09_JAE = Convert.ToDecimal(this.txt_32_09_JAE.Text);
            if (this.txt_32_10_JAE.Text == "") v32_10_JAE = 0; else v32_10_JAE = Convert.ToDecimal(this.txt_32_10_JAE.Text);
            if (this.txt_32_11_JAE.Text == "") v32_11_JAE = 0; else v32_11_JAE = Convert.ToDecimal(this.txt_32_11_JAE.Text);
            if (this.txt_32_12_JAE.Text == "") v32_12_JAE = 0; else v32_12_JAE = Convert.ToDecimal(this.txt_32_12_JAE.Text);
            if (this.txt_32_13_JAE.Text == "") v32_13_JAE = 0; else v32_13_JAE = Convert.ToDecimal(this.txt_32_13_JAE.Text);
            if (this.txt_32_14_JAE.Text == "") v32_14_JAE = 0; else v32_14_JAE = Convert.ToDecimal(this.txt_32_14_JAE.Text);
            if (this.txt_32_15_JAE.Text == "") v32_15_JAE = 0; else v32_15_JAE = Convert.ToDecimal(this.txt_32_15_JAE.Text);
            if (this.txt_32_16_JAE.Text == "") v32_16_JAE = 0; else v32_16_JAE = Convert.ToDecimal(this.txt_32_16_JAE.Text);
            if (this.txt_32_17_JAE.Text == "") v32_17_JAE = 0; else v32_17_JAE = Convert.ToDecimal(this.txt_32_17_JAE.Text);
            if (this.txt_32_18_JAE.Text == "") v32_18_JAE = 0; else v32_18_JAE = Convert.ToDecimal(this.txt_32_18_JAE.Text);
            if (this.txt_32_19_JAE.Text == "") v32_19_JAE = 0; else v32_19_JAE = Convert.ToDecimal(this.txt_32_19_JAE.Text);
            if (this.txt_32_20_JAE.Text == "") v32_20_JAE = 0; else v32_20_JAE = Convert.ToDecimal(this.txt_32_20_JAE.Text);
            #endregion

            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_내신성적산출_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                #region 파라미터 설정
                parameters.Add("@year", year + this.rblType.SelectedValue.ToString().Trim());
                parameters.Add("@season", season);
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
                parameters.Add("@Grade_T", DBNull.Value, ParameterDirection.Output);
                parameters.Add("@Tot_T", DBNull.Value, ParameterDirection.Output);
                #endregion

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    txtGrade.Text = dataCommands[0].ListOfParameters[0]["@@Grade_T"].Value.StringValue();
                    txtTot.Text = dataCommands[0].ListOfParameters[0]["@@Tot_T"].Value.StringValue();
                    CommonMessage.AlertMessage(this, "처리 완료. 내신등급과 교과백분위를 확인하세요..!");
                }
                else
                {
                    switch (shell.ErrorCode)
                    {
                        case 1:
                            CommonMessage.AlertMessage(this, "처리 완료. 내신등급과 교과백분위를 확인하세요..!");
                            break;
                        case 2:
                            CommonMessage.AlertMessage(this, "처리 완료. 내신등급과 교과백분위를 확인하세요..!");
                            break;
                        case 2627:
                            CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                            break;
                        //default:
                        //    CommonMessage.AlertMessage(this, "처리 완료. 내신등급과 교과백분위를 확인하세요..!");
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

        #endregion 메소드


    }
}