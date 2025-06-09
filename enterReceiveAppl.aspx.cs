using KJC.IMS.COFF.CONTROL.COFF;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL;
using System.IO;
using IFW.Data;
using IFW.WebUI;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Security.Permissions;
using System.Net;


namespace KJC.IMS.ENTR.StaffMngr
{
    /// <summary>
    /// 메뉴정보 : 입시 > 원서접수 > 입시 지원자 관리
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 2017.11.14 / 박영지 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class enterReceiveAppl : WebFormBase
    {
        #region 전역변수

        protected int ROW_NUM = 10;
        protected int page_num;
        private ConfigInfo configinfo = new ConfigInfo();

        #endregion 전역변수

        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        /// <summary>
        /// 컴퍼넌트 초기 세팅 (이벤트핸들러 정의 등)
        /// </summary>
        private void InitializeComponent()
        {
            this.btnResdChk.Click += new System.EventHandler(this.btnResdChk_Click);
            this.btnDownFile1.Click += BtnDownFile_Click1;
            this.btnDownFile2.Click += BtnDownFile_Click2;
            // 예) this.btnNameSearch.Click += new System.EventHandler(this.btnNameSearch_Click);
            // 예) this.ddlchaeyong_gb.SelectedIndexChanged += new System.EventHandler(this.ddlchaeyong_gb_SelectedIndexChanged);
        }

        /// <summary>
        /// Page_Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.ExToolBar6.Attributes.Add("onclick", "return isValidJuminNo2(Form1.txtResdNo1.value+Form1.txtResdNo2.value);");
            //this.ExToolBar6.Attributes.Add("onclick", "alert('test')");
            //this.txt주민등록번호앞자리.Attributes.Add("onkeyup", "ResdKeyUp();");

            if (!Page.IsPostBack)
            {
                this.InitPageSetting();

                if (!string.IsNullOrEmpty(Request["Year"]))
                {
                    this.txt지원연도조회.Text = HttpUtility.UrlDecode(Request["Year"] as string);
                }
                if (!string.IsNullOrEmpty(Request["Season"]))
                {
                    this.ddl지원시기조회.SelectedValue = HttpUtility.UrlDecode(Request["Season"] as string);
                }
                if (!string.IsNullOrEmpty(Request["sppoClsCode"]))
                {
                    this.ddl전형구분조회.SelectedValue = HttpUtility.UrlDecode(Request["sppoClsCode"] as string);
                }
                if (!string.IsNullOrEmpty(Request["majorCode"]))
                {
                    this.ddl지원학과조회.SelectedValue = HttpUtility.UrlDecode(Request["majorCode"] as string);
                }
                if (!string.IsNullOrEmpty(Request["resdNo"]))
                {
                    this.txt주민등록번호뒷자리조회.Text = HttpUtility.UrlDecode(Request["resdNo"] as string);
                }
                if (!string.IsNullOrEmpty(Request["NamerecpNo"]))
                {
                    this.txt성명수험번호조회.Text = HttpUtility.UrlDecode(Request["NamerecpNo"] as string);
                }
                string duplicateYN = "N";
                if (!string.IsNullOrEmpty(Request["duplicateYN"]))
                {
                    duplicateYN = HttpUtility.UrlDecode(Request["duplicateYN"] as string);
                }
                this.chk중복지원여부조회.Checked = duplicateYN.Equals("Y") ? true : false;

                if (!string.IsNullOrEmpty(Request["PageNo"]))
                    this.page_num = Convert.ToInt32(Request["PageNo"] as string);
                else
                    this.page_num = 1;

                this.Retrieve(true);
            }
            SetScriptForClientEvent();
        }

        /// <summary>
        /// UI Page 초기 셋팅
        /// </summary>
        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(this.txt지원연도조회, this.ddl지원시기조회);
            COMMMethod.SetApplicationYearSeason(this.txt지원연도, this.ddl지원시기);
            // 전형구분
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분조회, this.txt지원연도조회.Text.Trim());
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분, this.txt지원연도.Text.Trim());
            // 지원학과
            COMMMethod.SetDDLMajorCode(this.ddl지원학과조회, this.txt지원연도조회.Text.Trim());

			Util.BindCommonCodeList(ddl전형료, "SA06");
			ddl전형료.SelectedIndex = 0;
			//GetSeasonMaster();
			//BindDDL_SppoClsCode();
		}

        /// <summary>
        /// 클라이언트 이벤트 핸들러 등록
        /// </summary>
        private void SetScriptForClientEvent()
        {
            /*****************************************
            -- toolBar의 Button ID별 ClientScript 등록
            Etc1   = 기타1,
            Etc2   = 기타2,
            Etc3   = 기타3,
            Etc4   = 기타4,
            Etc5   = 기타5,
            Search = 조회,
            List   = 목록,
            Print  = 인쇄,
            New    = 추가(신규),
            Save   = 저장,
            Modify = 수정,
            Delete = 삭제,
            Cancel = 취소,
            ******************************************/

            ((Button)ExToolBar3.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
            btnReBindDdl.Click += BtnReBindDdl_Click;                       //[입력항목] 지원연도 변경시 전형구분, 지원학과 바인딩
            btnReBindSearchDdl.Click += BtnReBindSearchDdl_Click;                       //[조회항목] 지원연도 변경시 전형구분, 지원학과 바인딩
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 조회버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            ClearDetail();
            grdList.SelectedIndex = -1;
            this.Retrieve(false);
        }

        /// <summary>
        /// 신규버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void NewCmd(object sender, CommandEventArgs e)
        {
            ClearDetail();
            grdList.SelectedIndex = -1;
        }

        /// <summary>
        /// 삭제 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_원서접수_입시지원자관리_삭제_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            string returnCode = string.Empty;
            string returnMessage = string.Empty;

            try
            {
                foreach (GridViewRow item in grdList.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[11].Controls[1]).Checked)
                        {
                            parameters.Add("@year", item.Cells[12].Text);
                            parameters.Add("@season", item.Cells[13].Text);
                            parameters.Add("@recpNo", ((LinkButton)item.Cells[5].Controls[1]).Text);
                            parameters.Add("@ReturnCd", DBNull.Value, ParameterDirection.Output);
                            parameters.Add("@ReturnMsg", DBNull.Value, ParameterDirection.Output);

                            shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    var msg = dataCommands[0].ListOfParameters[0]["@@ReturnMsg"].Value.StringValue();

                    if (msg.Length > 0)
                    {
                        CommonMessage.AlertMessage(this, msg); // 삭제 실패
                    }
                    else
                    {
                        SetControlState("C");
                        this.Retrieve(false);
                        CommonMessage.AlertMessage(this, 203); // 삭제 되었습니다.
                    }
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
        /// 저장버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_원서접수_입시지원자관리_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            string returnCode = string.Empty;
            string returnMessage = string.Empty;

            try
            {

                //문구(링크 텍스트) 100byte 초과
                //if (System.Text.Encoding.Default.GetBytes(this.txt문구.Text).Length > 100)
                //{
                //    CommonMessage.AlertMessage(this, "문구(링크 텍스트)가 100 byte를 초과했습니다.");
                //    return;
                //}

                parameters.Add("@year", this.txt지원연도.Text.Trim());
                parameters.Add("@season", this.ddl지원시기.SelectedValue);
                parameters.Add("@term", this.configinfo.Term);
                parameters.Add("@time", this.configinfo.Time);
                parameters.Add("@sppoDt", System.DateTime.Now);
                parameters.Add("@recpNo", this.txt수험번호.Text.Trim());
                parameters.Add("@StaffNo", UserId);
                parameters.Add("@korName", this.txt성명.Text.Trim());
                parameters.Add("@chinName", string.Empty);
                parameters.Add("@resdNo", this.txt주민등록번호앞자리.Text.Trim() + this.txt주민등록번호뒷자리.Text.Trim());
                parameters.Add("@sppoClsCode", this.ddl전형구분.SelectedValue.Trim());
                parameters.Add("@majorCode1", this.ddl1지망지원학과.SelectedValue.Trim());
                parameters.Add("@majorCode2", this.ddl2지망지원학과.SelectedValue.Trim());
                parameters.Add("@military", this.rdo병역사항.SelectedValue);
                parameters.Add("@boarding", this.rdo생활관기숙사.SelectedValue.Equals("0") ? this.rdo생활관기숙사.SelectedValue : "1"); //0:미신청, 1:신청
                parameters.Add("@ListSelect", this.rdo생활관기숙사.SelectedValue);
                parameters.Add("@CSCode", this.txtNeisName.csCode);
                parameters.Add("@neisCode", this.txtNeisName.neisCode);
                parameters.Add("@graduYN", this.rdo고교졸업.SelectedValue);
                parameters.Add("@graduYear", this.txt고교졸업년도.Text.Trim());
                parameters.Add("@LstGradu", this.rdo고교유형.SelectedValue);
                parameters.Add("@graduLesson", this.txt고교과.Text.Trim());
                parameters.Add("@graduMonth", this.ddl고교졸업월.SelectedValue);
                parameters.Add("@email", this.txt이메일.Text.Trim());
                parameters.Add("@guardName", string.Empty);
                parameters.Add("@guardRele", string.Empty);
                parameters.Add("@guardCelPhone", this.txt휴대폰1.Text.Trim());
                parameters.Add("@guardOfficePhone", this.txt직장전화1.Text.Trim());
                parameters.Add("@zipCode", this.txtPostCode.ParamaterValue.ToString().Trim());
                parameters.Add("@address", this.txtAddress.ParamaterValue.ToString().Trim());
                parameters.Add("@addressDetail", this.txtDetailAddress.Text.Trim());
                parameters.Add("@phone", this.txt자택전화.Text.Trim());
                parameters.Add("@celPhone", this.txt휴대폰.Text.Trim());
                parameters.Add("@pass", string.Empty);//30 09 ???  //insert '30'  season='9' 이면 pass='30'
                parameters.Add("@passPlus", string.Empty); // 00 09 ???  insert '30'
                //parameters.Add("@passPlusPlus", );
                //parameters.Add("@JapanStudy", );
                parameters.Add("@rank", 0);
                parameters.Add("@passKey", string.Empty);//Insert'00'
                parameters.Add("@certificate", this.txt자격증.Text.Trim());
                parameters.Add("@office", this.txt산업체명.Text.Trim());
                parameters.Add("@majorCodeFinal", string.Empty);
                //parameters.Add("@examYearM", ); =@year
                parameters.Add("@SubRank", 0);
                parameters.Add("@PassOLD", string.Empty);
                parameters.Add("@UnivName", this.txt대학명.Text.Trim());
                parameters.Add("@UnivYear", this.txt대학졸업년도.Text.Trim());
                parameters.Add("@UnivYN", this.rdo대학졸업.SelectedValue);
                parameters.Add("@UnivLesson", this.txt대학과명.Text.Trim());
                //
                parameters.Add("@UnivCompletion", string.IsNullOrEmpty(this.txt대학수료년수.Text.ToString().Trim()) ? 0 : Convert.ToInt32(this.txt대학수료년수.Text.Trim()));
                parameters.Add("@UnivDiv", string.IsNullOrEmpty(this.ddl대학구분.SelectedValue.ToString()) ? 0 : Convert.ToInt32(this.ddl대학구분.SelectedValue));
                //2019-01-18 추가
                parameters.Add("@Score", string.IsNullOrEmpty(this.txt기준평점.Text.Trim()) ? 0 : Convert.ToDecimal(this.txt기준평점.Text.Trim()));
                parameters.Add("@AvgScore", string.IsNullOrEmpty(this.txt본인평점평균.Text.Trim()) ? 0 : Convert.ToDecimal(this.txt본인평점평균.Text.Trim()));
                parameters.Add("@ModifyDate", System.DateTime.Now.ToString());
                parameters.Add("@ModifyIP", string.Empty);
                parameters.Add("@ModifyName", string.Empty);
                //parameters.Add("@StudentNo", string.Empty);
                //parameters.Add("@PYD", "N");
                parameters.Add("@qualificationScore", string.IsNullOrEmpty(this.txt검정고시점수.Text.Trim()) ? 0 : Convert.ToDecimal(this.txt검정고시점수.Text.Trim()));
                //parameters.Add("@highSchoolScore1", );
                //parameters.Add("@highSchoolScore1_2", );
                //parameters.Add("@highSchoolScore2", );
                //parameters.Add("@highSchoolScore2_2", );
                //parameters.Add("@highSchoolScore3", );
                //parameters.Add("@highSchoolScore3_2", );
                //parameters.Add("@highSchoolSumScore", );
                //parameters.Add("@highSchoolGrade", );
                //parameters.Add("@highSchoolScore", );
                //parameters.Add("@absenceDay", );
                //parameters.Add("@absenceScore", );
                //parameters.Add("@examNo", );
                //parameters.Add("@examScore", );
                //parameters.Add("@examScoreSum", );
                //parameters.Add("@foreignpercentage", );
                //parameters.Add("@foreignGrade", );
                //parameters.Add("@mathGrade", );
                //parameters.Add("@examSelect1", );
                //parameters.Add("@examSelect2", );
                //parameters.Add("@examSelect3", );
                //parameters.Add("@examSelect4", );
                //parameters.Add("@examSelect5", );
                //parameters.Add("@examSelect6", );
                //parameters.Add("@examSelect7", );
                //parameters.Add("@examSelect8", );
                //parameters.Add("@examSelect9", );
                //parameters.Add("@examSelect10", );
                //parameters.Add("@examSelect11", );
                //parameters.Add("@examSelect12", );
                //parameters.Add("@examSelect13", );
                //parameters.Add("@examSelect14", );
                //parameters.Add("@examSelect15", );
                //parameters.Add("@examSelect16", );
                //parameters.Add("@examSelect17", );
                //parameters.Add("@examSelect18", );
                //parameters.Add("@examSelect19", );
                //parameters.Add("@examSelect20", );
                //parameters.Add("@examSelect21", );
                //parameters.Add("@examSelect22", );
                //parameters.Add("@examSelect23", );
                //parameters.Add("@examSelect24", );
                //parameters.Add("@examSelect25", );
                //parameters.Add("@examSelect26", );
                //parameters.Add("@examSelect27", );
                //parameters.Add("@examSelect28", );
                //parameters.Add("@examSelect29", );
                //parameters.Add("@examSelect30", );
                //parameters.Add("@UnivScore", );
                //parameters.Add("@qualificationScoreSum", );
                //parameters.Add("@qualificationGrade", );
                //parameters.Add("@totalScore", );
                //parameters.Add("@totalScoreFinal", );
                //parameters.Add("@highSchoolRank_1_1", );
                //parameters.Add("@highSchoolPerson_1_1", );
                //parameters.Add("@highSchoolRank_1_2", );
                //parameters.Add("@highSchoolPerson_1_2", );
                //parameters.Add("@highSchoolRank_2_1", );
                //parameters.Add("@highSchoolPerson_2_1", );
                //parameters.Add("@highSchoolRank_2_2", );
                //parameters.Add("@highSchoolPerson_2_2", );
                //parameters.Add("@highSchoolRank_3_1", );
                //parameters.Add("@highSchoolPerson_3_1", );
                //parameters.Add("@highSchoolRank_3_2", );
                //parameters.Add("@highSchoolPerson_3_2", );
                //parameters.Add("@absence_1_A", );
                //parameters.Add("@absence_1_B", );
                //parameters.Add("@absence_1_C", );
                //parameters.Add("@absence_1_D", );
                //parameters.Add("@absence_2_A", );
                //parameters.Add("@absence_2_B", );
                //parameters.Add("@absence_2_C", );
                //parameters.Add("@absence_2_D", );
                //parameters.Add("@absence_3_A", );
                //parameters.Add("@absence_3_B", );
                //parameters.Add("@absence_3_C", );
                //parameters.Add("@absence_3_D", );
                parameters.Add("@ReMark", this.txt특기사항.Text.Trim());
				//parameters.Add("@CompanyCode", );
				//parameters.Add("@CompanyDeptName", );
				//parameters.Add("@CompanyGradeName", );
				//parameters.Add("@CompanyWork", );
				//parameters.Add("@finalRank", );
				//parameters.Add("@scholarship", );
				//parameters.Add("@Class1", );
				//parameters.Add("@Class2", );
				//parameters.Add("@Class3", );
				//parameters.Add("@Class4", );
				//parameters.Add("@Class5", );
				//parameters.Add("@Class6", );
				//parameters.Add("@Class7", );
				//parameters.Add("@Class8", );
				//parameters.Add("@Class9", );
				//parameters.Add("@Class10", );
				//parameters.Add("@Class11", );
				//parameters.Add("@Class12", );
				//parameters.Add("@Class13", );
				//parameters.Add("@Class14", );
				//parameters.Add("@Class15", );
				//parameters.Add("@Class16", );
				//parameters.Add("@Class17", );
				//parameters.Add("@Class18", );
				//parameters.Add("@Class19", );
				//parameters.Add("@Class20", );
				//parameters.Add("@Class21", );
				//parameters.Add("@Class22", );
				//parameters.Add("@Class23", );
				//parameters.Add("@Class24", );
				//parameters.Add("@Class25", );
				//parameters.Add("@Class26", );
				//parameters.Add("@Class27", );
				//parameters.Add("@Class28", );
				//parameters.Add("@Class29", );
				//parameters.Add("@Class30", );
				//parameters.Add("@InterView1", );
				//parameters.Add("@InterView2", );
				//parameters.Add("@InterView3", );
				//parameters.Add("@InterView4", );
				//parameters.Add("@InterView5", );
				//parameters.Add("@InterView6", );
				//parameters.Add("@InterView7", );
				//parameters.Add("@InterView", );
				//parameters.Add("@HighGrade_1_1", );
				//parameters.Add("@HighGrade_1_2", );
				//parameters.Add("@HighGrade_2_1", );
				//parameters.Add("@HighGrade_2_2", );
				//parameters.Add("@HighGrade_3_1", );
				//parameters.Add("@HighGrade", );
				parameters.Add("@ApplyFee", Convert.ToDecimal(this.ddl전형료.SelectedValue));
				//parameters.Add("@ApplyFee", string.IsNullOrEmpty(this.rdo전형료.SelectedValue) ? 0 : Convert.ToDecimal(this.rdo전형료.SelectedValue));
				//parameters.Add("@transferGrade", );
				//parameters.Add("@SumGrade1", );
				//parameters.Add("@SumGrade2", );
				//parameters.Add("@SumScore1", );
				//parameters.Add("@SumScore2", );
				//parameters.Add("@UnivGraduYear", );
				//parameters.Add("@UnivDiv", );
				//parameters.Add("@UnivCompletion", );
				//parameters.Add("@InterViewDate", );
				//parameters.Add("@NeatGrade", );
				//parameters.Add("@koreanType", );
				//parameters.Add("@mathType", );
				//parameters.Add("@englishType", );
				//parameters.Add("@ProcessID", );
				//parameters.Add("@ProcessIP", );
				//parameters.Add("@ProcessDate", );
				//parameters.Add("@CompanyType", );
				//parameters.Add("@UpdateID", );
				//parameters.Add("@UpdateIP", );
				//parameters.Add("@UpdateDate", );

				parameters.Add("@RefundAccountNo", this.txt계좌번호.Text.Trim());
                parameters.Add("@RefundAccountName", this.txt계좌명의.Text.Trim());
                parameters.Add("@BankCode", this.ddl은행.SelectedValue);

                parameters.Add("@guardCelPhone2", this.txt휴대폰2.Text.Trim());
                parameters.Add("@guardOfficePhone2", this.txt직장전화2.Text.Trim());
                parameters.Add("@guardCelPhone3", this.txt휴대폰3.Text.Trim());
                parameters.Add("@guardOfficePhone3", this.txt직장전화3.Text.Trim());
                parameters.Add("@guardCelPhone4", this.txt휴대폰4.Text.Trim());
                parameters.Add("@guardOfficePhone4", this.txt직장전화4.Text.Trim());

                parameters.Add("@UseScoreForPass", this.rdo동의여부1.SelectedValue);
                parameters.Add("@UseExamForPass", this.rdo동의여부2.SelectedValue);
                parameters.Add("@UseScoreForScholarShip", this.rdo동의여부3.SelectedValue);
                parameters.Add("@UseExamForScholarShip", this.rdo동의여부4.SelectedValue);
                parameters.Add("@UseApplicantData", this.rdo동의여부5.SelectedValue);

                parameters.Add("@recpInfo1", "2"); //수험번호 생성시 필요한 접수처 1자리  1:관리자접수 / 7:Web접수
                parameters.Add("@ChkCUD", this.txt지원연도.Enabled == true ? "C" : "U");
                parameters.Add("@UserId", UserId);
                parameters.Add("@UserIp", UserIp);

                // 2018.05.03 추가 항목
                parameters.Add("@transferGrade", this.ddl편입학년.SelectedValue == string.Empty ? null : this.ddl편입학년.SelectedValue);
                parameters.Add("@CompanyCode", this.CompanySearch1.CompanyCode);
                parameters.Add("@CompanyDeptName", this.txtCompanyDept.Text);
                parameters.Add("@CompanyGradeName", this.txtCompanyGrade.Text);
                parameters.Add("@CompanyWork", this.txtCompanyWork.Text.Replace(",","") == string.Empty ? 0 : Convert.ToInt32(this.txtCompanyWork.Text.Replace(",", "")));

                parameters.Add("@ReturnCd", DBNull.Value, ParameterDirection.Output);
                parameters.Add("@ReturnMsg", DBNull.Value, ParameterDirection.Output);
                parameters.Add("@ReturnRecpNo ", DBNull.Value, ParameterDirection.Output);


				// 2018.10.04 추가.. 검정고시 연도, 회차
				string GEDYear = string.Empty;
				string GEDCount = string.Empty;

				if(txtNeisName.neisCode.IndexOf("100000001") > -1)
				{
					GEDYear = this.txt고교졸업년도.Text.Trim();
					GEDCount = this.ddl검정고시회차.SelectedValue;
				}

				parameters.Add("@GEDYear", GEDYear);
				parameters.Add("@GEDCount", GEDCount);


                if (upload_file1.PostedFile.ContentLength > 0)
                {
                    var fileName = Path.GetFileNameWithoutExtension(upload_file1.PostedFile.FileName);
                    var extensionName = Path.GetExtension(upload_file1.PostedFile.FileName);//확장자

                    var serverFileName = Guid.NewGuid().StringValue() + extensionName;
                    var serverPath = "/ENTR/StaffMngr/Files/"+ txt지원연도.Text.Trim()+"/"+ txt수험번호.Text.Trim();

                    var realFileName = fileName + extensionName;
                    var savePath = Server.MapPath(serverPath);
                    var saverFile = savePath + "\\" + serverFileName;

                    if (!Directory.Exists(savePath))
                    {
                        Directory.CreateDirectory(savePath);
                    }

                    upload_file1.PostedFile.SaveAs($"{savePath}\\{serverFileName}");

                    this.subfile1.Text = realFileName;
                    this.txtServerFilePath1.Text = serverPath + "/" + serverFileName;
                    this.txtRealFileName1.Text = realFileName;


                    parameters.Add("@FILE1_PATH", serverPath+"/"+ serverFileName);
                    parameters.Add("@FILE1_NAME", realFileName);
                }

                if (upload_file2.PostedFile.ContentLength > 0)
                {
                    var fileName = Path.GetFileNameWithoutExtension(upload_file2.PostedFile.FileName);
                    var extensionName = Path.GetExtension(upload_file2.PostedFile.FileName);//확장자

                    var serverFileName = Guid.NewGuid().StringValue() + extensionName;
                    var serverPath = "/ENTR/StaffMngr/Files/" + txt지원연도.Text.Trim() + "/" + txt수험번호.Text.Trim();

                    var realFileName = fileName + extensionName;
                    var savePath = Server.MapPath(serverPath);
                    var saverFile = savePath + "\\" + serverFileName;

                    if (!Directory.Exists(savePath))
                    {
                        Directory.CreateDirectory(savePath);
                    }

                    upload_file2.PostedFile.SaveAs($"{savePath}\\{serverFileName}");

                    this.subfile2.Text = realFileName;
                    this.txtServerFilePath2.Text = serverPath + "/" + serverFileName;
                    this.txtRealFileName2.Text = realFileName;

                    parameters.Add("@FILE2_PATH", serverPath + "/" + serverFileName);
                    parameters.Add("@FILE2_NAME", realFileName);
                }
                


                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    var msg = dataCommands[0].ListOfParameters[0]["@@ReturnMsg"].Value.StringValue();

                    if (msg.Length > 0)
                    {
                        SetControlState("C");
                        CommonMessage.AlertMessage(this, msg); // 저장 실패
                    }
                    else
                    {
                        SetControlState("U");
                        this.lbl결과.Text = string.Empty;
                        this.hdnResult.Value = this.lbl결과.Text;
                        this.Retrieve(false);
                        this.txt수험번호.Text = dataCommands[0].ListOfParameters[0]["@@ReturnRecpNo"].Value.StringValue();
                        CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                    }
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

        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            try
            {
                try
                {
                    Dictionary<string, object> dataParams = new Dictionary<string, object>();
                    dataParams.Add("@Year", txt지원연도.Text);
                    dataParams.Add("@recpNo", txt수험번호.Text);

                    Report1.ShowReportByStoredProcedure("0001363001", "dbo.APL_Select_TestTag", dataParams);
                }
                catch (Exception ex)
                {
                    CommonMessage.AlertMessage(this, ex.ToString());
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분, this.txt지원연도.Text.Trim());
            // 1지망 지원학과
            COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl1지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
            // 2지망 지원학과
            COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl2지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
        }

        private void BtnReBindSearchDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분조회, this.txt지원연도조회.Text.Trim());
            COMMMethod.SetDDLMajorCode(this.ddl지원학과조회, this.txt지원연도조회.Text.Trim());
        }

        protected void ddl전형구분_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                // 1지망 지원학과
                COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl1지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
                // 2지망 지원학과
                COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl2지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(Page, ex.ToString());
            }
        }

        /// <summary>
        /// 주민번호 체크
        /// </summary>
        /// <param name="s">주민번호 문자열</param>
        /// <returns>true:정상, false:오류</returns>
        public bool cisJuMin_Chk(string RRN)
        {
            //공백 제거
            RRN = RRN.Replace(" ", "");
            //문자 '-' 제거
            RRN = RRN.Replace("-", "");
            //주민등록번호가 13자리인가?
            if (RRN.Length != 13)
            {
                return false;
            }
            int sum = 0;
            for (int i = 0; i < RRN.Length - 1; i++)
            {
                char c = RRN[i];
                //숫자로 이루어져 있는가?
                if (!char.IsNumber(c))
                {
                    return false;
                }
                else
                {
                    if (i < RRN.Length)
                    {
                        //지정된 숫자로 각 자리를 나눈 후 더한다. 
                        sum += int.Parse(c.ToString()) * ((i % 8) + 2);
                    }
                }
            }
            // 검증코드와 결과 값이 같은가?
            if (!((((11 - (sum % 11)) % 10).ToString()) == ((RRN[RRN.Length - 1]).ToString())))
            {
                return false;
            }
            return true;
        }

        private void btnResdChk_Click(object sender, System.EventArgs e)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_원서접수_입시지원자관리_검사_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            if (Int32.Parse(this.txt주민등록번호뒷자리.Text.Trim().Substring(0,1)) < 5)
            { 
                if (!cisJuMin_Chk(this.txt주민등록번호앞자리.Text.Trim() + this.txt주민등록번호뒷자리.Text.Trim()))
                {
                    this.lbl결과.Text = "사용이 불가능한 주민등록번호입니다.";
                    return;
                }
            }

            try
            {
                parameters.Add("@year", this.txt지원연도.Text.Trim());
                parameters.Add("@season", this.ddl지원시기.SelectedValue);
                parameters.Add("@resdNo", this.txt주민등록번호앞자리.Text.Trim() + this.txt주민등록번호뒷자리.Text.Trim());

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        ds = dataCommands[0].DataSet;
                        string returnValue = dataCommands[0].ListOfParameters[0]["@@RETURN_VALUE"].Value.ToString();
                        int resdCnt = (int)dataCommands[0].ListOfParameters[0]["@@RETURN_CODE"].Value; 
                        //같은연도, 지원시기에 등록된 건 수 조회

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            if (resdCnt > 2)
                            {
                                this.lbl결과.Text = resdCnt + "건의 지원정보가 존재합니다. (등록불가)";
                                //"수험번호, 지원전형, 지원학과" + returnValue.Replace(":", " < br /> ")
                                hdnResult.Value = "등록불가";
                            }
                            else
                            {
                                this.lbl결과.Text = resdCnt + "건의 지원정보가 존재합니다. (등록가능)";
                                hdnResult.Value = "등록가능";
                            }

                            //this.lbl결과.Text = "수험번호, 지원전형, 지원학과" + returnValue.Replace(":", " < br /> ");
                            string strScript = "javascript: alert('[수험번호, 지원전형, 지원학과]" + returnValue.Replace(":", "\\r") +"');";
                            ScriptManager.RegisterStartupScript(this.UpdatePanel4, this.GetType(), "strScript", strScript, true);


                        }
                        else
                        {
                            this.lbl결과.Text = "등록가능";
                            hdnResult.Value = "등록가능";
                        }
                        //this.hdnResult.Value = this.lbl결과.Text;
                    }
                    else {
                        this.lbl결과.Text = "등록가능";
                        hdnResult.Value = "등록가능";
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

        private void BtnDownFile_Click1(object sender, EventArgs e)
        {
            try
            {
                DownLoadResultFile(txtServerFilePath1.Text, txtRealFileName1.Text);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(Page, ex.ToString());
            }
        }

        private void BtnDownFile_Click2(object sender, EventArgs e)
        {
            try
            {
                DownLoadResultFile(txtServerFilePath2.Text, txtRealFileName2.Text);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(Page, ex.ToString());
            }
        }

        #endregion 이벤트

        #region 메소드

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

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_원서접수_입시지원자관리_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            this.hdnRowNum.Value = Convert.ToString(this.page_num);

            try
            {
                parameters.Add("@Year", this.txt지원연도조회.Text.Trim());
                parameters.Add("@Season", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@sppoClsCode", this.ddl전형구분조회.SelectedValue);
                parameters.Add("@majorCode", this.ddl지원학과조회.SelectedValue);
                parameters.Add("@resdNo", this.txt주민등록번호뒷자리조회.Text.Trim());
                parameters.Add("@NamerecpNo", this.txt성명수험번호조회.Text.Trim());
                parameters.Add("@duplicateYN", this.chk중복지원여부조회.Checked == true ? "Y" : "N");
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
                            ExDataCounter1.DataCount = strTotalCount.ToInt32();
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
        /// 그리드 클릭 시 상세정보 조회
        /// </summary>
        /// <param name="dgi">DataGridItem </param>
        private void SelectItem(GridViewRow grv)
        {
            try
            {
                //입시지원 입력항목
                this.txt지원연도.Text = Util.GetGridViewString(grv.Cells[12].Text);
                this.ddl지원시기.SelectedValue = Util.GetGridViewString(grv.Cells[13].Text);

                this.BtnReBindDdl_Click(null, null);

                this.txt수험번호.Text = Util.GetGridViewString(((LinkButton)grv.Cells[5].Controls[1]).Text);
                this.txt성명.Text = Util.GetGridViewString(grv.Cells[6].Text);
                this.txt주민등록번호앞자리.Text = Util.GetGridViewString(grv.Cells[17].Text);
                this.txt주민등록번호뒷자리.Text = Util.GetGridViewString(grv.Cells[18].Text);
                this.lbl결과.Text = string.Empty;
                this.hdnResult.Value = this.lbl결과.Text;
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[14].Text)))
                {
                    this.ddl전형구분.SelectedValue = Util.GetGridViewString(grv.Cells[14].Text);
                }
                COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl1지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
                COMMMethod.SetDDLMajorCodeBySeasonSppoClsCode(this.ddl2지망지원학과, this.txt지원연도.Text.Trim(), this.ddl지원시기.SelectedValue, this.ddl전형구분.SelectedValue);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[15].Text)) && ddl1지망지원학과.Items.Count > 1)
                {
                    this.ddl1지망지원학과.SelectedValue = Util.GetGridViewString(grv.Cells[15].Text.Trim());
                }
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[16].Text)) && ddl2지망지원학과.Items.Count > 1)
                {
                    this.ddl2지망지원학과.SelectedValue = Util.GetGridViewString(grv.Cells[16].Text.Trim());
                }
                //입시지원자 정보 입력항목
                this.txtNeisName.csCode = Util.GetGridViewString(grv.Cells[61].Text);
                this.txtNeisName.csName = Util.GetGridViewString(grv.Cells[62].Text);
                this.txtNeisName.neisCode = Util.GetGridViewString(grv.Cells[63].Text);
                this.txtNeisName.neisName = Util.GetGridViewString(grv.Cells[64].Text);
                this.txtNeisName.state = Util.GetGridViewString(grv.Cells[65].Text);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[21].Text)) && (Util.GetGridViewString(grv.Cells[21].Text) == "1" || Util.GetGridViewString(grv.Cells[21].Text) == "2"))
                {
                    this.rdo고교유형.SelectedValue = Util.GetGridViewString(grv.Cells[21].Text);
                }
                this.txt고교과.Text = Util.GetGridViewString(grv.Cells[22].Text);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[23].Text)))
                {
                    this.rdo고교졸업.SelectedValue = Util.GetGridViewString(grv.Cells[23].Text);
                }
                this.txt고교졸업년도.Text = Util.GetGridViewString(grv.Cells[24].Text);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[25].Text)))
                {
                    this.ddl고교졸업월.SelectedValue = Util.GetGridViewString(grv.Cells[25].Text);
                }
                this.ddl검정고시회차.SelectedValue = Util.GetGridViewString(grv.Cells[72].Text);
                this.txt검정고시점수.Text = Util.GetGridViewString(grv.Cells[26].Text);
                this.txt계좌번호.Text = Util.GetGridViewString(grv.Cells[27].Text);
                this.txt계좌명의.Text = Util.GetGridViewString(grv.Cells[28].Text);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[29].Text)))
                {
                    this.ddl은행.SelectedValue = Util.GetGridViewString(grv.Cells[29].Text);
                }
                this.txt대학명.Text = Util.GetGridViewString(grv.Cells[30].Text);
                this.txt대학과명.Text = Util.GetGridViewString(grv.Cells[31].Text);
                this.txt대학수료년수.Text = Util.GetGridViewString(grv.Cells[73].Text);
                if (Util.GetGridViewString(grv.Cells[74].Text) == "0"){
                    this.ddl대학구분.SelectedIndex = 0;
                }
                else {
                    this.ddl대학구분.SelectedValue = Util.GetGridViewString(grv.Cells[74].Text);
                }
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[32].Text)))
                {
					string temp = Util.GetGridViewString(grv.Cells[32].Text);

					if (temp == "0" || temp == "1" || temp == "2")
					{
						this.rdo대학졸업.SelectedValue = Util.GetGridViewString(grv.Cells[32].Text);
					}
                }
                this.txt대학졸업년도.Text = Util.GetGridViewString(grv.Cells[33].Text);
                this.txt기준평점.Text = Util.GetGridViewString(grv.Cells[34].Text);
                this.txt본인평점평균.Text = Util.GetGridViewString(grv.Cells[35].Text);
                this.txt자격증.Text = Util.GetGridViewString(grv.Cells[36].Text);
                this.txt산업체명.Text = Util.GetGridViewString(grv.Cells[37].Text);
                this.txt특기사항.Text = Util.GetGridViewString(grv.Cells[38].Text);
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[39].Text)))
                {
                    this.rdo생활관기숙사.SelectedValue = Util.GetGridViewString(grv.Cells[39].Text);
                }
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[40].Text)))
                {
                    this.rdo병역사항.SelectedValue = Util.GetGridViewString(grv.Cells[40].Text);
                }
                if (!string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[41].Text)))
                {
					this.ddl전형료.SelectedValue = Util.GetGridViewString(grv.Cells[41].Text);
					//this.rdo전형료.SelectedValue = Util.GetGridViewString(grv.Cells[41].Text);
				}
                this.txtPostCode.Text = Util.GetGridViewString(grv.Cells[42].Text);
                this.txtAddress.Text = Util.GetGridViewString(grv.Cells[43].Text);
                this.txtDetailAddress.Text = Util.GetGridViewString(grv.Cells[44].Text);
                this.txt자택전화.Text = Util.GetGridViewString(grv.Cells[45].Text);
                this.txt휴대폰.Text = Util.GetGridViewString(grv.Cells[46].Text);
                this.txt이메일.Text = Util.GetGridViewString(grv.Cells[47].Text);
                this.txt직장전화1.Text = Util.GetGridViewString(grv.Cells[48].Text);
                this.txt휴대폰1.Text = Util.GetGridViewString(grv.Cells[49].Text);
                this.txt직장전화2.Text = Util.GetGridViewString(grv.Cells[50].Text);
                this.txt휴대폰2.Text = Util.GetGridViewString(grv.Cells[51].Text);
                this.txt직장전화3.Text = Util.GetGridViewString(grv.Cells[52].Text);
                this.txt휴대폰3.Text = Util.GetGridViewString(grv.Cells[53].Text);
                this.txt직장전화4.Text = Util.GetGridViewString(grv.Cells[54].Text);
                this.txt휴대폰4.Text = Util.GetGridViewString(grv.Cells[55].Text);
                this.rdo동의여부1.SelectedValue = string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[56].Text)) ? "2" : Util.GetGridViewString(grv.Cells[56].Text);
                this.rdo동의여부2.SelectedValue = string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[57].Text)) ? "2" : Util.GetGridViewString(grv.Cells[57].Text);
                this.rdo동의여부3.SelectedValue = string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[58].Text)) ? "2" : Util.GetGridViewString(grv.Cells[58].Text);
                this.rdo동의여부4.SelectedValue = string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[59].Text)) ? "2" : Util.GetGridViewString(grv.Cells[59].Text);
                this.rdo동의여부5.SelectedValue = string.IsNullOrEmpty(Util.GetGridViewString(grv.Cells[60].Text)) ? "2" : Util.GetGridViewString(grv.Cells[60].Text);

                // 2018.05.03 추가 항목
                this.ddl편입학년.SelectedValue = Util.GetGridViewString(grv.Cells[66].Text) == "0" ? "" : Util.GetGridViewString(grv.Cells[66].Text);
                this.CompanySearch1.CompanyCode = Util.GetGridViewString(grv.Cells[67].Text);
                this.CompanySearch1.CompanyName = Util.GetGridViewString(grv.Cells[68].Text);
                this.txtCompanyDept.Text = Util.GetGridViewString(grv.Cells[69].Text);
                this.txtCompanyGrade.Text = Util.GetGridViewString(grv.Cells[70].Text);
                this.txtCompanyWork.Text = Util.GetGridViewString(grv.Cells[71].Text);

                this.subfile1.Text = Util.GetGridViewString(grv.Cells[76].Text);
                this.subfile2.Text = Util.GetGridViewString(grv.Cells[78].Text);

                this.txtServerFilePath1.Text = Util.GetGridViewString(grv.Cells[75].Text);
                this.txtRealFileName1.Text = Util.GetGridViewString(grv.Cells[76].Text);

                this.txtServerFilePath2.Text = Util.GetGridViewString(grv.Cells[77].Text);
                this.txtRealFileName2.Text = Util.GetGridViewString(grv.Cells[78].Text);


                this.SetControlState("U"); // 수정모드로
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath
                                + "?Year=" + HttpUtility.UrlEncode(this.txt지원연도조회.Text.Trim())
                                + "&Season=" + HttpUtility.UrlEncode(this.ddl지원시기조회.SelectedValue)
                                + "&sppoClsCode=" + HttpUtility.UrlEncode(this.ddl전형구분조회.SelectedValue)
                                + "&majorCode=" + HttpUtility.UrlEncode(this.ddl지원학과조회.SelectedValue)
                                + "&resdNo=" + HttpUtility.UrlEncode(this.txt주민등록번호뒷자리조회.Text.Trim())
                                + "&NamerecpNo=" + HttpUtility.UrlEncode(this.txt성명수험번호조회.Text.Trim())
                                + "&duplicateYN=" + HttpUtility.UrlEncode(this.chk중복지원여부조회.Checked == true ? "Y" : "N");
            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        /// <summary>
        /// 컨트롤 상태 세팅
        /// </summary>
        /// <param name="op">신규/수정 여부</param>
        private void SetControlState(string op)
        {
            try
            {
                switch (op)
                {
                    case "C":   // Create : 신규추가일 경우
                        this.txt지원연도.Enabled = true;
                        this.ddl지원시기.Enabled = true;
                        this.btnResdChk.Visible = true;
                        break;

                    case "U":   // Update : 수정일 경우
                        this.txt지원연도.Enabled = false;
                        this.ddl지원시기.Enabled = false;
                        this.btnResdChk.Visible = false;
                        break;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 입력항목 초기화
        /// </summary>
        private void ClearDetail()
        {
            try
            {
                //입시지원 입력항목
                this.txt지원연도.Text = configinfo.applYear;
                this.ddl지원시기.SelectedValue = configinfo.Season;
                this.txt수험번호.Text = string.Empty;
                this.txt성명.Text = string.Empty;
                this.txt주민등록번호앞자리.Text = string.Empty;
                this.txt주민등록번호뒷자리.Text = string.Empty;
                this.lbl결과.Text = string.Empty;
                this.hdnResult.Value = this.lbl결과.Text;
                this.ddl전형구분.SelectedIndex = 0;
                this.ddl1지망지원학과.Items.Clear();
                this.ddl2지망지원학과.Items.Clear();
                this.ddl1지망지원학과.SelectedIndex = -1;
                this.ddl2지망지원학과.SelectedIndex = -1;
                //입시지원자 정보 입력항목
                this.txtNeisName.csCode = string.Empty;
                this.txtNeisName.csName = string.Empty;
                this.txtNeisName.neisCode = string.Empty;
                this.txtNeisName.neisName = string.Empty;
                this.txtNeisName.state = string.Empty;
                this.rdo고교유형.SelectedIndex = -1;
                this.txt고교과.Text = string.Empty;
                this.rdo고교졸업.SelectedIndex = 0;
                this.txt고교졸업년도.Text = string.Empty;
                this.ddl고교졸업월.SelectedValue = "02";
                this.ddl검정고시회차.SelectedIndex = 0;
                this.txt검정고시점수.Text = string.Empty;
                this.txt계좌번호.Text = string.Empty;
                this.txt계좌명의.Text = string.Empty;
                this.ddl은행.SelectedIndex = 0;
                this.txt대학명.Text = string.Empty;
                this.txt대학과명.Text = string.Empty;
                this.txt대학수료년수.Text = string.Empty;
                this.ddl대학구분.SelectedIndex = 0;
                this.rdo대학졸업.SelectedIndex = -1;
                this.txt대학졸업년도.Text = string.Empty;
                this.txt기준평점.Text = string.Empty;
                this.txt본인평점평균.Text = string.Empty;
                this.txt자격증.Text = string.Empty;
                this.txt산업체명.Text = string.Empty;
                this.txt특기사항.Text = string.Empty;
                this.rdo생활관기숙사.SelectedIndex = 0;
                this.rdo병역사항.SelectedIndex = 0;
                this.ddl전형료.SelectedIndex = 0;
                this.txtPostCode.Text = string.Empty;
                this.txtAddress.Text = string.Empty;
                this.txtDetailAddress.Text = string.Empty;
                this.txt자택전화.Text = string.Empty;
                this.txt휴대폰.Text = string.Empty;
                this.txt이메일.Text = string.Empty;
                this.txt직장전화1.Text = string.Empty;
                this.txt휴대폰1.Text = string.Empty;
                this.txt직장전화2.Text = string.Empty;
                this.txt휴대폰2.Text = string.Empty;
                this.txt직장전화3.Text = string.Empty;
                this.txt휴대폰3.Text = string.Empty;
                this.txt직장전화4.Text = string.Empty;
                this.txt휴대폰4.Text = string.Empty;
                this.rdo동의여부1.SelectedIndex = 0;
                this.rdo동의여부2.SelectedIndex = 0;
                this.rdo동의여부3.SelectedIndex = 0;
                this.rdo동의여부4.SelectedIndex = 0;
                this.rdo동의여부5.SelectedIndex = 0;

                // 2018.05.03 추가 항목
                this.ddl편입학년.SelectedIndex = 0;
                this.CompanySearch1.CompanyCode = string.Empty;
                this.CompanySearch1.CompanyName = string.Empty;
                this.txtCompanyDept.Text = string.Empty;
                this.txtCompanyGrade.Text = string.Empty;
                this.txtCompanyWork.Text = string.Empty;

                this.subfile1.Text = string.Empty;
                this.subfile2.Text = string.Empty;

                this.txtServerFilePath1.Text = string.Empty;
                this.txtRealFileName1.Text = string.Empty;

                this.txtServerFilePath2.Text = string.Empty;
                this.txtRealFileName2.Text = string.Empty;

                this.SetControlState("C"); // 신규모드로
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void DownLoadResultFile(string filepath, string filename)
        {

            Stream stream = null;

            var realFilepath = Server.MapPath(filepath);
            var extenstion = Path.GetExtension(filename);
            var contentType = string.Empty;

            if (!File.Exists(realFilepath))
            {
                string fileUrl = "https://enter.koje.ac.kr"+ filepath.Replace('\\', '/');


                // HttpWebRequest를 사용하여 외부 도메인에서 파일 다운로드
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(fileUrl);
                request.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"; // User-Agent 헤더 추가
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        // 파일 이름과 MIME 타입 추출
                        //var fileName = Path.GetFileName(fileUrl);
                        //var mimeType = MimeMapping.GetMimeMapping(fileName);

                        // 파일 데이터를 메모리 스트림으로 읽기
                        using (stream = response.GetResponseStream())
                        {
                            using (var memoryStream = new MemoryStream())
                            {

                                // 클라이언트에 파일 응답 설정
                                HttpContext.Current.Response.ContentType = response.ContentType;
                                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + filename);
                                HttpContext.Current.Response.AddHeader("Content-Length", response.ContentLength.ToString());

                                // 응답 스트림을 클라이언트 응답으로 복사
                                stream.CopyTo(HttpContext.Current.Response.OutputStream);
                                HttpContext.Current.Response.Flush();
                                HttpContext.Current.Response.End();
                            }
                        }
                    }

                }

                CommonMessage.AlertMessage(Page, "파일이 존재하지 않습니다.");
                return;
            }
            else
            { 
                try
                {
                    Response.ClearContent();
                    Response.ClearHeaders();

                    stream = new FileStream(realFilepath, System.IO.FileMode.Open, System.IO.FileAccess.Read, System.IO.FileShare.Read);
                    long bytesToRead = stream.Length;
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("Content-Length", bytesToRead.ToString());
                    Response.AddHeader("Content-Disposition", $"attachment; filename={HttpUtility.UrlPathEncode(filename)}"); //You can set filename here

                    while (bytesToRead > 0)
                    {
                        if (Response.IsClientConnected)
                        {
                            byte[] buffer = new Byte[10000];
                            int length = stream.Read(buffer, 0, 10000);
                            Response.WriteFile(realFilepath);
                            Response.Flush();
                            bytesToRead = bytesToRead - length;
                        }
                        else
                        {
                            bytesToRead = -1;
                        }
                    }
                }
                catch (Exception ex)
                {
                    CommonMessage.AlertMessage(Page, ex.ToString());
                }
                finally
                {
                    if (stream != null)
                    {
                        stream.Close();
                    }
                }
            }
        }

        #endregion 메소드
    }
}