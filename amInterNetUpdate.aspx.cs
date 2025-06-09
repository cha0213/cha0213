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
using System.Web.UI.HtmlControls;
using System.IO;
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;
using KJC.IMS.COFF.CONTROL.COFF;

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amInterNetUpdate : WebFormBase
    {

        #region 전역변수

        protected int ROW_NUM = 10;
        protected int page_num = 1;
        protected string state ="1";
        private ConfigInfo configinfo = new ConfigInfo();

        #endregion 전역변수

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

                if (!string.IsNullOrEmpty(Request["Year"]))
                {
                    this.txtApplyYear.Text = HttpUtility.UrlDecode(Request["Year"] as string);
                }
                if (!string.IsNullOrEmpty(Request["Season"]))
                {
                    this.ddlApplySeason.SelectedValue = HttpUtility.UrlDecode(Request["Season"] as string);
                }

                if (!string.IsNullOrEmpty(Request["State"]))
                {
                    this.state = HttpUtility.UrlDecode(Request["State"] as string);
                }

                if (!string.IsNullOrEmpty(Request["PageNo"]))
                    this.page_num = Convert.ToInt32(Request["PageNo"] as string);
                else
                    this.page_num = 1;

                if(state == "1")
                    this.Retrieve(true);
                else
                    this.Retrieve2(true);

            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            this.BindApplyInfo();   //진행연도 바인딩
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>

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

        /// <summary>
        /// 조회버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            grdList.SelectedIndex = -1;
            state = "1";
            this.Retrieve(true);
        }

        /// <summary>
        /// 조회버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            grdList.SelectedIndex = -1;
            state = "2";
            this.Retrieve2(true);
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
                            parameters.Add("@recpNo", item.Cells[5].Text);
                            //parameters.Add("@recpNo", ((LinkButton)item.Cells[5].Controls[1]).Text);
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

        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            if (rbInfoType.SelectedValue == "0")
            {
                this.SaveApplicantInfo();   //접수정보
            }
            else
            {
                this.SaveApplicantSensitiveinfo();  //민감정보
            }
        }



        #endregion 이벤트

        #region 메소드

        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath
                                + "?Year=" + HttpUtility.UrlEncode(this.txtApplyYear.Text.Trim())
                                + "&Season=" + HttpUtility.UrlEncode(this.ddlApplySeason.SelectedValue)
                                + "&State=" + HttpUtility.UrlEncode(this.state);

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_원서접수_인터넷접수업로드_중복지원자_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            this.hdnRowNum.Value = Convert.ToString(this.page_num);

            try
            {
                parameters.Add("@Year", this.txtApplyYear.Text.Trim());
                parameters.Add("@Season", this.ddlApplySeason.SelectedValue);
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
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve2(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "USP_학사행정_입시_원서접수_인터넷접수업로드_3회이상_중복지원자_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            this.hdnRowNum.Value = Convert.ToString(this.page_num);

            try
            {
                parameters.Add("@Year", this.txtApplyYear.Text.Trim());
                parameters.Add("@Season", this.ddlApplySeason.SelectedValue);
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


        private void BindApplyInfo()
        {
            string spName = "dbo.APL_GetApplicationSeasonMaster";
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];
                        txtApplyYear.Text = dr["ApplYear"].ToString();
                        ddlApplySeason.SelectedValue = dr["Season"].ToString();
                    }
                    else
                    {
                        txtApplyYear.Text = DateTime.Now.Year.ToString();
                        ddlApplySeason.SelectedIndex = 0;
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

        private void SaveApplicantInfo()
        {
            try
            {
                string strFile = SaveFile(upload_file);
                int[] AllChar;

                if (ddlApplySeason.SelectedValue == "9")
                {
                    AllChar = new int[]
                    {
                    4,  //년도                              0
					1,  //시즌                              1
				    17, //접수일                            2
				    8,  //수험번호                          3
				    20, //한글이름                          4
				    7,  //우편번호                          5
				    100,//주소                              6
				    100,//나머지주소                        7
				    20, //집전호                            8
				    20, //휴대전화                          9
				    13, //주민번호                          10
				    2,  //전형구분                          11
				    4,  //1지망(계열,전공)                  12
				    4,  //2지망(계열,전공)                  13
				    1, //병역사항 ---면제:0, 군필:1, 미필:2 14
				    1, //기숙사   --신청:1, 미신청:0        15
				    10,//CS고교코드                         16
				    10,//Nies고교코드                       17
				    1,  //고교졸업 -----1,졸업,0,예정       18
				    4,  //졸업년도                          19
				    30, //고교학과                          20
				    2,  //졸업월                            21
				    80, //eMail                             22
				    10, //부모이름                          23
				    2,  //부모코드                          24
				    20, //보호자 휴대폰                     25
				    20, //보호자 회사전화                   26
				    4,  //수능년도                          27
				    4,  //대학졸업년도                      28
				    50, //대학명                            29
				    50, //대학전공                          30
				    1,  //대학졸업코드 예정:0,졸업:1,수료:2/                                              31
				    1,  //고교정보(인문계1, 전문계보통과2, 전문계3)                                       32
				    1,  //대학 구분--4년제 대학교 : 4, 전문대 4년 : 5, 전문대 3년 : 3, 전문대 2년 : 2     33
				    1,  //수료년수--졸업, 수료에 관계 없이 수료한 년수                                    34

				    100,//전형료환불계좌번호             35
				    20, //전형료환불계좌 명의            36
				    2,  //전형료환불은행코드             37

				    10, //부모이름                       38
				    2,  //부모코드                       39
				    20, //보호자 휴대폰                  40
				    20, //보호자 회사전화                41

				    10, //부모이름                       42
				    2,  //부모코드                       43
				    20, //보호자 휴대폰                  44
				    20, //보호자 회사전화                45

				    10, //부모이름                       46
				    2,  //부모코드                       47
				    20, //보호자 휴대폰                  48
				    20, //보호자 회사전화                49

				    1,  //만학도구분                     50
				    1,  //장학생 선발 성적활용 동의      51
				    50, //산업체위탁 - 산업체명          52
				    50, //산업체위탁 - 업종              53
				    30, //산업체위탁 - 종업원수          54
				    50, //산업체위탁 - 근무부서          55
				    30, //산업체위탁 - 직책              56
				    50  //산업체위탁 - 근무월수          57
                    };
                }
                else if (ddlApplySeason.SelectedValue == "7")
                {
                    AllChar = new int[]
                    {
                    4,  //연도                                  0
                    1,  //시즌                                  1
                    17, //접수일                                2
                    8,  //수험번호                              3
                    20, //한글이름                              4
                    7,  //우편번호                              5
                    100,//주소                                  6
                    100,//나머지주소                            7
                    20, //집전호                                8
                    20, //휴대전화                              9
                    13, //주민번호                              10
                    2,  //전형구분                              11
                    4,  //1지망(계열,전공)                      12
                    4,  //2지망(계열,전공)                      13
                    1,  //병역사항 ---면제:0, 군필:1, 미필:2    14
                    1,  //기숙사   --신청:1, 미신청:0           15
                    10, //CS고교코드                            16
                    10, //Nies고교코드                          17
                    1,  //고교졸업 -----1,졸업,0,예정           18
                    4,  //졸업년도                              19
                    30, //고교학과                              20
                    2,  //졸업월                                21
                    80, //eMail                                 22
                    10, //부모이름                              23
                    2,  //부모코드                              24
                    20, //보호자 휴대폰                         25
                    20, //보호자 회사전화                       26
                    4,  //수능년도                              27
                    4,  //대학졸업년도                          28
                    50, //대학명                                29
                    50, //대학전공                              30
                    1,  //대학졸업코드 예정:0,졸업:1,수료:2/    31
                    1,  //고교정보(인문계1, 전문계보통과2, 전문계3)                                     32
                    1,  //대학 구분--4년제 대학교 : 4, 전문대 4년 : 5, 전문대 3년 : 3, 전문대 2년 : 2   33
                    1,  //수료년수--졸업, 수료에 관계 없이 수료한 년수                                  34

                    //100,//전형료환불계좌번호      35
                    //20, //전형료환불계좌 명의     36
                    //2,  //전형료환불은행코드      37

                    1,  //자격증1                 38
                    1,  //급수1                   39
                    1,  //발급기관1               40
                    1,  //자격증2                 41
                    1,  //급수2                   42
                    1,  //발급기관2               43
                    1,  //자격증3                 44
                    1,  //급수3                   45
                    1,  //발급기관3               46
                    1,  //자격증4                 47
                    1,  //급수4                   48
                    1,  //발급기관4               49
                    1,  //경력사항-회사명1        50
                    1,  //경력사항-년1            51
                    1,  //경력사항-개월1          52
                    1,  //경력사항-회사명2        53
                    1,  //경력사항-년2            54
                    1,  //경력사항-개월2          55
                    1,  //재직중인 회사명         56
                    1,  //재직중인 회사 전화      57
                    1,  //재직중인 회사 주소      58
                    1,  //재직중인 회사 담당부서  59
                    1,  //재직중인 회사 담당직무  60
                    1   //재직중인 회사 근무월수  61
                    };
                }
                else if (ddlApplySeason.SelectedValue == "8")
                {
                    AllChar = new int[]
                    {
                    4,  //년도                                  0
                    1,  //시즌                                  1
                    17, //접수일                                2
                    8,  //수험번호                              3
                    20, //한글이름                              4
                    7,  //우편번호                              5
                    100,//주소                                  6
                    100,//나머지주소                            7
                    20, //집전호                                8
                    20, //휴대전화                              9
                    13, //주민번호                              10
                    2,  //전형구분                              11
                    4,  //1지망(계열,전공)                      12
                    4,  //2지망(계열,전공)                      13
                    1,  //병역사항 ---면제:0, 군필:1, 미필:2    14
                    1,  //기숙사   --신청:1, 미신청:0           15
                    10, //CS고교코드                            16
                    10, //Nies고교코드                          17
                    1,  //고교졸업 -----1,졸업,0,예정           18
                    4,  //졸업년도                              19
                    30, //고교학과                              20
                    2,  //졸업월                                21
                    80, //eMail                                 22
                    10, //부모이름                              23
                    2,  //부모코드                              24
                    20, //보호자 휴대폰                         25
                    20, //보호자 회사전화                       26
                    4,  //수능년도                              27
                    4,  //대학졸업년도                          28
                    50, //대학명                                29
                    50, //대학전공                              30
                    1,  //대학졸업코드 예정:0,졸업:1,수료:2/    31
                    1,  //고교정보(인문계1, 전문계보통과2, 전문계3)                                   32
                    1,  //대학 구분--4년제 대학교 : 4, 전문대 4년 : 5, 전문대 3년 : 3, 전문대 2년 : 2 33
                    1,  //수료년수--졸업, 수료에 관계 없이 수료한 년수                                34
                    100,//전형료환불계좌번호                                                          35
                    20, //전형료환불계좌 명의                                                         36
                    2,  //전형료환불은행코드                                                          37
                    };
                }
                else
                {
                    AllChar = new int[]
                    {
                    4,  //년도                                 0
                    1,  //시즌                                 1
                    17, //접수일                               2
                    8,  //수험번호                             3
                    20, //한글이름                             4
                    7,  //우편번호                             5
                    100,//주소                                 6
                    100,//나머지주소                           7
                    20, //집전호                               8
                    20, //휴대전화                             9
                    13, //주민번호                             10
                    2,  //전형구분                             11
                    4,  //1지망(계열,전공)                     12
                    4,  //2지망(계열,전공)                     13
                    1,  //병역사항 ---면제:0, 군필:1, 미필:2   14
                    1,  //기숙사   --신청:0, 미신청:1          15
                    10, //CS고교코드                           16
                    10, //Nies고교코드                         17
                    1,  //고교졸업 -----1,졸업,0,예정          18
                    4,  //졸업년도                             19
                    30, //고교학과                             20
                    2,  //졸업월                               21
                    80, //eMail                                22
                    4,  //수능년도                             23
                    4,  //대학졸업년도                         24
                    50, //대학명                               25
                    50, //대학전공                             26
                    1,  //대학졸업코드 예정:0,졸업:1,수료:2/   27
                    1,  //고교정보(인문계1, 전문계보통과2, 전문계3)                                      28
                    1,  //대학 구분--4년제 대학교 : 4, 전문대 4년 : 5, 전문대 3년 : 3, 전문대 2년 : 2    29
                    1,  //수료년수--졸업, 수료에 관계 없이 수료한 년수                                   30

                    100,//전형료환불계좌번호                   31
                    20, //전형료환불계좌 명의                  32
                    2,  //전형료환불은행코드                   33

                    20, //추가연락처1                          34
                    20, //추가연락처2                          35
                    20, //추가연락처3                          36
                    20, //추가연락처4                          37

                    1,  //만학도구분                           38
                    1,  //학생부 합격사정 활용 동의            39
                    1,  //수능 합격사정 활용 동의              40
                    1,  //학생부 장학 선발 동의                41
                    1,  //수능 장학선발 동의                   42
                    1,  //유웨이 데이터 입학전형 활용 동의     43
                    1,  //유웨이 데이터 입학전형 활용 동의
                    4,  //검정고시년도 44      /* 2018.10.02 기존 Kaims에서 주석 처리 되어있는데... 해당 항목이 필요함.  */
                    1   //검정고시횟차 45
                    };
                }
                ArrayList array;

                array = StringSplit(strFile);   //문자열 "|"으로 정리

                ArrayList ReturnArray = new ArrayList();

                int Count = 0;

                for (int i = 0; i < array.Count; i++)
                {
                    string[] Line = (string[])array[i];

                    if (Line.Length > 1)
                    {
                        string Year = txtApplyYear.Text.Trim();
                        string Season = ddlApplySeason.SelectedValue.ToString();
                        string sppoDt = Line[2].ToString().Trim();                  //접수일
                        string recpNo = Line[3].ToString().Trim();                  //수험번호
                        string korName = Line[4].ToString().Trim();                 //한글이름
                        string zipCode = Line[5].ToString().Trim();                 //우편번호
                        string address = Line[6].ToString().Trim();                 //주소
                        string addressDetail = Line[7].ToString().Trim();           //상세주소
                        string phone = Line[8].ToString().Trim();                   //집전화
                        string celPhone = Line[9].ToString().Trim();                //휴대전화
                        string resdNo = Line[10].ToString().Trim();                 //주민번호
                        string sppoClsCode = Line[11].ToString().Trim();            //전형구분
                        string majorCode1 = Line[12].ToString().Trim();             //1지망
                        string majorCode2 = Line[13].ToString().Trim();             //2지망
                        string military = Line[14].ToString();                      //병역------면제:0, 군필:1, 미필:2
                        if (military == " ") military = "0";                        //면제...(여자)

                        string boarding = Line[15].ToString().Trim();               //기숙사-----신청:0, 미신청:1

                        string CSCode = Line[16].ToString().Trim();                 //CS 고교코드
                        string neisCode = Line[17].ToString().Trim();               //neis 고교코드
                        string graduYN = Line[18].ToString().Trim();                //----uWay 데이타 이상(uWay에서 1이면 졸업,2이면 예정 이렇게 넘어옴...)
                        if (graduYN == "2")
                        {
                            graduYN = "0";      //0=>졸업예정, 1=>졸업
                        }
                        else if (graduYN == " ")
                        {
                            graduYN = "1";      //0=>졸업예정, 1=>졸업
                        }

                        string graduYear = Line[19].ToString().Trim();              //고교졸업년도
                        string graduLesson = Line[20].ToString().Trim();            //고교졸업학과
                        string graduMonth = Line[21].ToString().Trim();             //고교졸업월
                        string email = Line[22].ToString().Trim();                  //이메일

                        string examYearM = Line[23].ToString().Trim();              //수능년도

                        string UnivYear = "", UnivName = "", UnivLesson = "", UnivYN = "", LstGradu = "", UnivDiv = "", UnivCompletion = "";

                        if (Season != "7" && Season != "8" && Season != "9")
                        {
                            UnivYear = Line[24].ToString().Trim();                  //대학졸업년도
                            UnivName = Line[25].ToString().Trim();                  //대학명
                            UnivLesson = Line[26].ToString().Trim();                //대학전공
                            UnivYN = Line[27].ToString().Trim();                    //대학코드

                            LstGradu = Line[28].ToString().Trim();                  //고교정보(인문계1, 전문계보통과2, 전문계3)32
                            UnivDiv = Line[29].ToString().Trim();                   //대학 구분--4년제 대학교 : 4, 전문대 3년 : 3, 전문대 2년 : 2
                            UnivCompletion = Line[30].ToString().Trim();            //수료년수--졸업, 수료에 관계 없이 수료한 년수
                        }
                        else
                        {
                            UnivYear = Line[28].ToString().Trim();                  //대학졸업년도
                            UnivName = Line[29].ToString().Trim();                  //대학명
                            UnivLesson = Line[30].ToString().Trim();                //대학전공
                            UnivYN = Line[31].ToString().Trim();                    //대학코드

                            LstGradu = Line[32].ToString().Trim();                  //고교정보(인문계1, 전문계보통과2, 전문계3)32
                            UnivDiv = Line[33].ToString().Trim();                   //대학 구분--4년제 대학교 : 4, 전문대 3년 : 3, 전문대 2년 : 2
                            UnivCompletion = Line[34].ToString().Trim();            //수료년수--졸업, 수료에 관계 없이 수료한 년수
                        }

                        string companyName = "", companyType = "", companyDeptName = "", companyGradeName = "";
                        int companyWork = 0;

                        string refundAccountNo = "";    //환불계좌
                        string refundAccountName = "";  //환불계좌명의
                        string bankCode = "";           //은행코드
                        string guardCelPhoneA = "";     //추가연락처1
                        string guardNameB = "";         //추가연락처2
                        string guardRoleB = "";         //추가연락처2
                        string guardCelPhoneB = "";     //추가연락처2
                        string guardOfficePhoneB = "";  //추가연락처2
                        string guardNameC = "";         //추가연락처3
                        string guardRoleC = "";         //추가연락처3
                        string guardCelPhoneC = "";     //추가연락처3
                        string guardOfficePhoneC = "";  //추가연락처3
                        string guardNameD = "";         //추가연락처4
                        string guardRoleD = "";         //추가연락처4
                        string guardCelPhoneD = "";     //추가연락처4
                        string guardOfficePhoneD = "";  //추가연락처4
                        string studyingLateDiv = "";    //만학도구분

                        string passScoreAgree = "", passExamAgree = "", scholarShipScoreAgree = "", scholarShipExamAgree = "", uwayDataAgree = "", GEDYear = "", GEDCount = "";

                        if (Season != "7" && Season != "8" && Season != "9")
                        {
                            refundAccountNo = Line[31].ToString().Trim();           //환불계좌
                            refundAccountName = Line[32].ToString().Trim();         //환불계좌명의
                            bankCode = Line[33].ToString().Trim();                  //은행코드

                            guardCelPhoneA = Line[34].ToString().Trim();            //추가연락처1
                            guardCelPhoneB = Line[35].ToString().Trim();            //추가연락처2
                            guardCelPhoneC = Line[36].ToString().Trim();            //추가연락처3
                            guardCelPhoneD = Line[37].ToString().Trim();            //추가연락처4

                            studyingLateDiv = Line[38].ToString().Trim();           //만학도구분

                            passScoreAgree = Line[39].ToString().Trim();            //학생부 합격사정 활용 동의
                            passExamAgree = Line[40].ToString().Trim();             //수능 합격사정 활용 동의
                            scholarShipScoreAgree = Line[41].ToString().Trim();     //학생부 장학 선발 동의
                            scholarShipExamAgree = Line[42].ToString().Trim();      //수능 장학선발 동의
                            uwayDataAgree = Line[43].ToString().Trim();             //유웨이 데이터 입학전형 활용 동의

							/* 2018.10.02 기존 Kaims에서 주석 처리 되어있는데... 해당 항목이 필요함.  */
							GEDYear = Line[45].ToString().Trim(); //유웨이 데이터 입학전형 활용 동의,  /* 2018.10.02 검정고시 연도임... */
							GEDCount = Line[46].ToString().Trim(); //유웨이 데이터 입학전형 활용 동의 /* 2018.10.02 검정고시 차수임... */
						}
						else
                        {
                            guardCelPhoneA = Line[25].ToString().Trim();    //추가 연락처1
                            refundAccountNo = Line[35].ToString().Trim();   //환불계좌
                            refundAccountName = Line[36].ToString().Trim(); //환불계좌명의
                            bankCode = Line[37].ToString().Trim();          //은행코드
                        }

                        if (Season == "7")
                        {
                            int operand1 = 0, operand2 = 0, operand3 = 0;

                            if (Line[49].ToString().Trim() != "")
                                operand1 = Int32.Parse(Regex.Replace(Line[49].ToString().Trim(), @"\D", ""));

                            if (Line[52].ToString().Trim() != "")
                                operand2 = Int32.Parse(Regex.Replace(Line[52].ToString().Trim(), @"\D", ""));

                            if (Line[58].ToString().Trim() != "")
                                operand3 = Int32.Parse(Regex.Replace(Line[58].ToString().Trim(), @"\D", ""));

                            refundAccountNo = (operand1 + operand2 + operand3).ToString(); //근무월수 - 전공심화에서는 환불계좌를 근무월 수로 임시 사용

                            companyName = Line[53].ToString().Trim();               //산업체명
                            companyDeptName = Line[56].ToString().Trim();           //근무부서
                            companyGradeName = Line[57].ToString().Trim();          //직책
                        }

                        if (Season == "9")
                        {
                            guardCelPhoneA = Line[25].ToString().Trim();
                            companyName = Line[52].ToString().Trim();               //산업체명
                            companyType = Line[53].ToString().Trim();               //업종

                            companyWork = Int32.Parse(Regex.Replace(Line[57].ToString().Trim(), @"\D", ""));
                            //companyWork = Int32.Parse(Line[54].ToString().Trim());  //종업원수

                            companyDeptName = Line[55].ToString().Trim();           //근무부서
                            companyGradeName = Line[56].ToString().Trim();          //직책
                            //refundAccountNo = Regex.Replace(Line[57].ToString().Trim(), @"\D", ""); //근무월수 - 산업체위탁에서는 환불계좌를 근무월 수로 임시 사용
                        }

                        string ListSelect = Line[15].ToString().Trim();         //2009.11.5 추가 기숙사 1인실,2인실,3인실,4인실(I1,I2,E32,E4)33

                        Count++;

                        string spName = "dbo.USP_학사행정_입시_원서접수_인터넷접수업로드_접수정보_업그레이드";
                        var parameters = new DataParameterCollection();
                        var shell = new DataCommandShell();

                        parameters.Add("@Year", Year);
                        parameters.Add("@Season", Season);
                        parameters.Add("@sppoDt", sppoDt);
                        parameters.Add("@recpNo", recpNo);
                        parameters.Add("@korName", korName);
                        parameters.Add("@zipCode", zipCode);
                        parameters.Add("@address", address);
                        parameters.Add("@addressDetail", addressDetail);
                        parameters.Add("@phone", phone);
                        parameters.Add("@celPhone", celPhone);
                        parameters.Add("@resdNo", resdNo);
                        parameters.Add("@sppoClsCode", sppoClsCode);
                        parameters.Add("@majorCode1", majorCode1);
                        parameters.Add("@majorCode2", majorCode2);
                        parameters.Add("@military", military);
                        parameters.Add("@boarding", boarding);
                        parameters.Add("@CSCode", CSCode);
                        parameters.Add("@neisCode", neisCode);
                        parameters.Add("@graduYN", graduYN);
                        parameters.Add("@graduYear", graduYear);
                        parameters.Add("@graduLesson", graduLesson);
                        parameters.Add("@graduMonth", graduMonth);
                        parameters.Add("@email", email);
                        //parameters.Add("@guardName", "");
                        //parameters.Add("@guardRole", "");
                        parameters.Add("@guardCelPhone", guardCelPhoneA);   //추가연락처1
                        //parameters.Add("@guardOfficePhone", "");
                        parameters.Add("@examYearM", examYearM);

                        parameters.Add("@UnivYear", UnivYear);
                        parameters.Add("@UnivName", UnivName);
                        parameters.Add("@UnivLesson", UnivLesson);
                        parameters.Add("@UnivYN", UnivYN);
                        parameters.Add("@LstGradu", LstGradu);
                        parameters.Add("@ListSelect", ListSelect);
                        parameters.Add("@UnivDiv", UnivDiv);
                        parameters.Add("@UnivCompletion", UnivCompletion);

                        parameters.Add("@companyName", companyName);
                        parameters.Add("@companyType", companyType);
                        parameters.Add("@companyWork", companyWork);
                        parameters.Add("@companyDeptName", companyDeptName);
                        parameters.Add("@companyGradeName", companyGradeName);

                        parameters.Add("@refundAccountNo", refundAccountNo);    //환불계좌
                        parameters.Add("@refundAccountName", refundAccountName);//환불계좌명의
                        parameters.Add("@bankCode", bankCode);                  //은행코드

                        parameters.Add("@guardNameB", guardNameB);              //추가연락처2
                        parameters.Add("@guardRoleB", guardRoleB);              //추가연락처2
                        parameters.Add("@guardCelPhoneB", guardCelPhoneB);      //추가연락처2
                        parameters.Add("@guardOfficePhoneB", guardOfficePhoneB);//추가연락처2

                        parameters.Add("@guardNameC", guardNameC);              //추가연락처3
                        parameters.Add("@guardRoleC", guardRoleC);              //추가연락처3
                        parameters.Add("@guardCelPhoneC", guardCelPhoneC);      //추가연락처3
                        parameters.Add("@guardOfficePhoneC", guardOfficePhoneC);//추가연락처3

                        parameters.Add("@guardNameD", guardNameD);              //추가연락처4
                        parameters.Add("@guardRoleD", guardRoleD);              //추가연락처4
                        parameters.Add("@guardCelPhoneD", guardCelPhoneD);      //추가연락처4
                        parameters.Add("@guardOfficePhoneD", guardOfficePhoneD);//추가연락처4

                        parameters.Add("@studyingLateDiv", studyingLateDiv);    //만학도 구분

                        parameters.Add("@PassScoreAgree", passScoreAgree);
                        parameters.Add("@PassExamAgree", passExamAgree);
                        parameters.Add("@ScholarShipScoreAgree", scholarShipScoreAgree);
                        parameters.Add("@ScholarShipExamAgree", scholarShipExamAgree);
                        parameters.Add("@uwayDataAgree", uwayDataAgree);

                        parameters.Add("@GEDYear", GEDYear);
                        parameters.Add("@GEDCount", GEDCount);

                        shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        shell.Execute();

                        if (shell.ErrorCode == 0)
                        {
                            CommonMessage.AlertMessage(this, 202);
                        }
                        else
                        {
                            CommonMessage.AlertMessage(this, shell.ErrorMessage);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "인덱스가 배열 범위를 벗어났습니다.")
                    CommonMessage.AlertMessage(this, "파일 양식이 다릅니다.");
                else
                    CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void SaveApplicantSensitiveinfo()
        {
            try
            {
                string strFile = SaveFile(upload_file);
                int[] AllChar;

                AllChar = new int[]
                {
                    8,  //수험번호               0
                    13, //주민번호               1
                    20, //휴대전화               2
                    3,  //전형료환불은행코드     3
                    50, //은행명			     4
                    50, //전형료환불계좌 명의    5
                    100,//전형료환불계좌번호     6
                };

                ArrayList array = StringSplit(strFile);

                string Year = txtApplyYear.Text.Trim();
                string Season = ddlApplySeason.SelectedValue.ToString();

                for (int i = 0; i < array.Count; i++)
                {
                    string[] Line = (string[])array[i];

                    string recpNo = Line[0].ToString().Trim();              //수험번호
                    string resdNo = Line[1].ToString().Trim();              //주민번호
                    string celPhone = Line[2].ToString().Trim();            //휴대전화
                    string bankCode = Line[3].ToString().Trim();            //은행코드
                    string refundAccountName = Line[5].ToString().Trim();   //환불계좌명의
                    string refundAccountNo = Line[6].ToString().Trim();     //환불계좌

                    string spName = "dbo.APL_InterNetUpdateSensitiveInfo";
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();

                    parameters.Add("@Year", Year);
                    parameters.Add("@Season", Season);
                    parameters.Add("@resdNo", resdNo);                          //주민번호
                    parameters.Add("@recpNo", recpNo);                          //수험번호
                    parameters.Add("@celPhone", celPhone);                      //휴대전화
                    parameters.Add("@refundAccountNo", refundAccountNo);        //환불계좌
                    parameters.Add("@refundAccountName", refundAccountName);    //환불계좌명의
                    parameters.Add("@bankCode", bankCode);                      //은행코드

                    shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                    shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        CommonMessage.AlertMessage(this, 202);
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, shell.ErrorMessage);
                    }
                }
            }
            catch (Exception ex)
            {
                if (ex.Message == "인덱스가 배열 범위를 벗어났습니다.")
                    CommonMessage.AlertMessage(this, "파일 양식이 다릅니다.");
                else
                    CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private ArrayList StringSplit(string strFile)
        {
            using (StreamReader sr = new StreamReader(strFile, Encoding.Default))
            {
                string line;
                ArrayList SumList = new ArrayList();

                while ((line = sr.ReadLine()) != null)
                {
                    string[] array = line.Split('|');

                    SumList.Add(array);//작업한 행들을 뭉친다.
                }
                return SumList;
            }
        }

        private string SaveFile(HtmlInputFile objFile)
        {
            int i;
            string retVal = "", strRootDir = "", strFileName = "", strName = "", strExt = "";

            if (objFile.PostedFile == null || objFile.PostedFile.FileName == "")    //PostedFile : 클라이언트에서 지정한 업로드된 파일에 대한 엑세스 권한을 가져옴
                return retVal;

            //@"E:\KAIMS\SAM\WebProjects\StudentFee\SAM\"
            strRootDir = Server.MapPath(".\\SAM");
            strFileName = Path.GetFileName(objFile.PostedFile.FileName);
            //"SAM"
            strName = Path.GetFileNameWithoutExtension(objFile.PostedFile.FileName);
            //".txt"
            strExt = Path.GetExtension(objFile.PostedFile.FileName);

            //폴더가 있는지 검사 한다.
            if (!Directory.Exists(strRootDir))
                Directory.CreateDirectory(strRootDir);

            //중복된 파일이 있는지 검사루틴
            i = 0;
            while (File.Exists(strRootDir + "\\" + strFileName))
            {
                i++;
                strFileName = strName + "(" + i.ToString() + ")" + strExt;
            }

            //파일 저장
            objFile.PostedFile.SaveAs(strRootDir + "\\" + strFileName);

            return strRootDir + "\\" + strFileName;
        }

        #endregion 메소드
    }
}