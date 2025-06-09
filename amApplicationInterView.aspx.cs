using KJC.IMS.COFF.CONTROL.COFF;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL;
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

namespace KJC.IMS.ENTR.StaffMngr
{
    /// <summary>
    /// 메뉴정보 : 입시 > 면접관리 > 면접점수 입력
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 2017.11.21 / 박영지 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    /// </summary>
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amApplicationInterView : WebFormBase
    {
        #region 전역변수

        protected int _pagePerRowCount = 15;
        protected int _pageNumber;
        private int iRowNum = 0;

        #endregion 전역변수

        //private Dictionary<string, WebControl> ControlParams
        //{
        //    get
        //    {
        //        Dictionary<string, WebControl> returnValue = new Dictionary<string, WebControl>();

        //        returnValue.Add("strApplyYear", txt지원연도조회);
        //        returnValue.Add("strApplySeason", ddl지원시기조회);
        //        returnValue.Add("strSearchGubun", ddl전형구분조회);
        //        returnValue.Add("strSearchApplyOrgID", ddl지원학과조회);
        //        returnValue.Add("strChulsinGoGyo", ddl출신고교);
        //        //returnValue.Add("strExaminNo", StudNoSearch);
        //        returnValue.Add("strGugun2", rbl구분조회);

        //        return returnValue;
        //    }
        //}

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
            // 예) this.btnNameSearch.Click += new System.EventHandler(this.btnNameSearch_Click);
            // 예) this.ddlchaeyong_gb.SelectedIndexChanged += new System.EventHandler(this.ddlchaeyong_gb_SelectedIndexChanged);
            btnReBindDdl.Click += BtnReBindDdl_Click;   //[조회조건] 지원연도 변경기 전형구분, 지원학과 바인딩
        }

        /// <summary>
        /// Page_Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.InitPageSetting();
                SetControlValueByParam();
                Retrieve(true);
            }

            //// 면접점수입력 기간 조회
            //if (!RetrieveScoreInputTerm())
            //{
            //	ExToolBar2.Visible = false;
            //}

            SetScriptForClientEvent();
        }

        /// <summary>
        /// UI Page 초기 셋팅
        /// </summary>
        private void InitPageSetting()
        {
            // 지원연도, 지원시기
            COMMMethod.SetApplicationYearSeason(this.txt지원연도조회, this.ddl지원시기조회);
            // 전형구분
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분조회, this.txt지원연도조회.Text.Trim());
            // 지원학과
            COMMMethod.SetDDLMajorCode(this.ddl지원학과조회, this.txt지원연도조회.Text.Trim());
            // 리스트 타이틀
            //string strYear = string.IsNullOrEmpty(this.txt지원연도조회.Text) ? string.Empty : this.txt지원연도조회.Text.Trim();
            //string strSeason = this.ddl지원시기조회.SelectedItem == null ? string.Empty : this.ddl지원시기조회.SelectedItem.Text.Trim();
            //this.headtitle.InnerText = "면접점수 입력 리스트(지원연도:" + strYear + "년, 지원시기:" + strSeason + ")";

            //ddl지원시기조회.Items.Insert(0, new ListItem("학교장추천", "A"));    // 2018-09-13 9:30 제과장님과 동균쌤 통화 후 학교장 추천은 빼기로 함

            ((StudSearchControl)StudNoSearch).Year = txt지원연도조회.Text;
            ((StudSearchControl)StudNoSearch).Season = "";
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
            //((Button)ExToolBar3.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
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
            this.Retrieve(false);
        }

        /// <summary>
        /// 저장버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            // 면접점수입력 기간 조회
            if (!RetrieveScoreInputTerm())
            {
                CommonMessage.AlertMessage(this, "면접 점수 입력 기간이 아닙니다.");
                //ExToolBar2.Visible = false;
                return;
            }

            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();
            string sql = string.Empty;
            try
            {
                string strinterViewDate = this.edp일괄면접일자.SelectedDate;
                foreach (GridViewRow gvr in this.grdList.Rows)
                {
                    if (COMMCommon.IsDataItem(gvr.RowType))
                    {
                        ExTextBox txt면접점수 = (ExTextBox)gvr.FindControl("txt면접점수");
                        ExTextBox txt부가점수 = (ExTextBox)gvr.FindControl("txt부가점수");
                        ExDatePicker edp면접일자 = (ExDatePicker)gvr.FindControl("edp면접일자");

                        if (gvr.Cells[11] != null)
                        {
                            //pass=30 면접대상인 데이터만 저장
                            if (gvr.Cells[11].Text.Trim().Equals("30"))
                            {
                                string interVeiwDate = edp면접일자.SelectedDate == null ? string.Empty : edp면접일자.SelectedDate.Trim();
                                if (strinterViewDate == "1900-01-01")
                                    strinterViewDate = "";

                                sql += string.Format(@"
                                          UPDATE [dbo].[applicationMaster]
                                             SET
                                                  AdditionalScore = isNull('{0}',0)
                                                 ,InterView = isNull('{1}',0)
                                                 ,InterViewDate = CASE WHEN '{2}' = '' THEN null ELSE convert(VARCHAR,'{2}',121) END
                                           WHERE year = '{3}'
                                             AND recpNo  = '{4}'
                                       ", txt부가점수.Text.Trim(), txt면접점수.Text.Trim(), interVeiwDate, gvr.Cells[12].Text.Trim(), gvr.Cells[2].Text.Trim());
                            }
                        }
                    }
                }

                if (!string.IsNullOrEmpty(sql))
                {
                    shell.SetCommand(sql, DbCommandType.ExecuteQuery);
                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        this.Retrieve(true);
                        CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, shell.ErrorMessage);
                    }
                }
                else
                {
                    CommonMessage.AlertMessage(this, "저장 할 데이터가 없습니다.");
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        /// <summary>
        /// 인쇄 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            if (rbl인쇄구분.SelectedValue == "3")
            {
                PrintEnterAppTesttag(); //수험표
            }
            else if (rbl인쇄구분.SelectedValue == "%")
            {
                PrintAll(); //전체
            }
            else if (rbl인쇄구분.SelectedValue == "1")
            {
                PrintOne(); //개인
            }
            else if (rbl인쇄구분.SelectedValue == "2")
            {
                PrintScore();
            }
            else if (rbl인쇄구분.SelectedValue == "4")
            {
                Print20Persent();   // 개인(20%)
            }
            else if (rbl인쇄구분.SelectedValue == "5")
            {
                Print100Persent();  // 개인(100%)
            }
        }

        /// <summary>
        /// 일괄입력 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc2Cmd(object sender, CommandEventArgs e)
        {
            try
            {
                string strinterViewDate = this.edp일괄면접일자.SelectedDate;
                foreach (GridViewRow gvr in this.grdList.Rows)
                {
                    ExDatePicker edp면접일자 = (ExDatePicker)gvr.FindControl("edp면접일자");
                    if (gvr.Cells[11] != null)
                    {
                        //pass=30 면접대상인 경우만 면접일자 입력 가능 및 일괄입력 적용
                        if (gvr.Cells[11].Text.Trim().Equals("30"))
                        {
                            edp면접일자.SelectedDate = strinterViewDate;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        /// <summary>
        /// [조회조건] 지원연도 변경시 전형구분, 지원학과 바인딩(UpdatePanel)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분조회, this.txt지원연도조회.Text.Trim());       //[조회조건] 지원연도 변경시 전형구분 바인딩
            COMMMethod.SetDDLMajorCode(this.ddl지원학과조회, this.txt지원연도조회.Text.Trim());                 //[조회조건] 지원연도 변경시 지원학과 바인딩
        }

        #endregion 이벤트

        #region 메소드

        private void SetControlValueByParam()
        {
            //foreach (KeyValuePair<string, WebControl> kv in ControlParams)
            //{
            //    if (kv.Value is IDataBindableControl)
            //    {
            //        var bindableControl = (IDataBindableControl)kv.Value;
            //        if (Request.Params[kv.Key] != null)
            //        {
            //            var paramValue = HttpUtility.UrlDecode(Request.Params[kv.Key]);
            //            bindableControl.SetValue(paramValue);
            //        }
            //    }
            //}

            if (!string.IsNullOrEmpty(Request["year"]))
                txt지원연도조회.Text = HttpUtility.UrlDecode(Request["year"].ToString());

            if (!string.IsNullOrEmpty(Request["season"]))
                ddl지원시기조회.SelectedValue = HttpUtility.UrlDecode(Request["season"].ToString());

            if (!string.IsNullOrEmpty(Request["sppoClsCode"]))
                ddl전형구분조회.SelectedValue = HttpUtility.UrlDecode(Request["sppoClsCode"].ToString());

            if (!string.IsNullOrEmpty(Request["orgID"]))
                ddl지원학과조회.SelectedValue = HttpUtility.UrlDecode(Request["orgID"].ToString());

            if (!string.IsNullOrEmpty(Request["highSchoolNM"]))
                txtNeisName.neisName = HttpUtility.UrlDecode(Request["highSchoolNM"].ToString());

            if (!string.IsNullOrEmpty(Request["highSchoolCd"]))
                txtNeisName.neisCode = HttpUtility.UrlDecode(Request["highSchoolCd"].ToString());

            if (!string.IsNullOrEmpty(Request["StudNo"]))
                StudNoSearch.학번 = HttpUtility.UrlDecode(Request["StudNo"].ToString());

            if (!string.IsNullOrEmpty(Request["StudNM"]))
                StudNoSearch.성명 = HttpUtility.UrlDecode(Request["StudNM"].ToString());

            if (!string.IsNullOrEmpty(Request["gubun"]))
                rbl구분조회.SelectedValue = HttpUtility.UrlDecode(Request["gubun"].ToString());

            if (!string.IsNullOrEmpty(Request["PageNo"]))
            {
                _pageNumber = Convert.ToInt32(Request["PageNo"] as string);
                hdnPageNo.Value = Request["PageNo"] as string;
            }
            else
            {
                _pageNumber = 1;
                hdnPageNo.Value = "1";
            }
        }

        private void SetPage(int pageNo, int totalCnt)
        {
            //var currentPath = new System.Text.StringBuilder();
            //currentPath.Append($"{Request.Url.AbsolutePath}?");

            //foreach (KeyValuePair<string, WebControl> kv in ControlParams)
            //{
            //    var parmaValue = $"{GetValue(kv.Value)}";
            //    //parmaValue = (parmaValue == "%" ? string.Empty : parmaValue);

            //    if (kv.Key == ControlParams.LastOrDefault().Key)
            //    {
            //        currentPath.Append($"{kv.Key}={parmaValue}");
            //    }
            //    else
            //    {
            //        currentPath.Append($"{kv.Key}={parmaValue}&");
            //    }
            //}

            string currentPath = Request.Url.AbsolutePath + "?year=" + HttpUtility.UrlEncode(txt지원연도조회.Text)
                                                          + "&season=" + HttpUtility.UrlEncode(ddl지원시기조회.SelectedValue)
                                                          + "&sppoClsCode=" + HttpUtility.UrlEncode(ddl전형구분조회.SelectedValue)
                                                          + "&orgID=" + HttpUtility.UrlEncode(ddl지원학과조회.SelectedValue)
                                                          + "&highSchoolNM=" + HttpUtility.UrlEncode(txtNeisName.neisName)
                                                          + "&highSchoolCd=" + HttpUtility.UrlEncode(txtNeisName.neisCode)
                                                          + "&StudNo=" + HttpUtility.UrlEncode(StudNoSearch.학번)
                                                          + "&StudNM=" + HttpUtility.UrlEncode(StudNoSearch.성명)
                                                          + "&gubun=" + HttpUtility.UrlEncode(rbl구분조회.SelectedValue);

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = _pagePerRowCount;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        private Object GetValue(WebControl wc)
        {
            Object returnValue = string.Empty;

            if (wc is IDataBindableControl)
            {
                if (wc is ExDatePicker)
                {
                    returnValue = ((ExDatePicker)wc).SelectedDate;
                }
                else
                {
                    if (((IDataBindableControl)wc).ParamaterValue == DBNull.Value)
                    {
                        returnValue = string.Empty;
                    }
                    else
                    {
                        returnValue = ((IDataBindableControl)wc).ParamaterValue;
                    }
                }
            }

            return returnValue;
        }

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve(bool isPage)
        {
            DataSet ds = null;
            //string spName = "dbo.USP_학사행정_입시_면접관리_면접점수입력_조회_업그레이드";
            string spName = "dbo.USP_학사행정_입시_면접관리_면접점수입력페이징_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            //this.hdnRowNum.Value = Convert.ToString(this.page_num);

            try
            {
                parameters.Add("@year", this.txt지원연도조회.Text.Trim());
                parameters.Add("@season", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@sppoClsCode", this.ddl전형구분조회.SelectedValue);
                parameters.Add("@majorCode", this.ddl지원학과조회.SelectedValue);
                parameters.Add("@neisCode", txtNeisName.neisCode);
                parameters.Add("@korNamerecpNo", this.StudNoSearch.학번.Trim());
                parameters.Add("@pass", this.rbl구분조회.SelectedValue);
                parameters.Add("@CurrentPage", isPage ? hdnPageNo.Value.ToInt32() : 1);
                parameters.Add("@TotalRecord", _pagePerRowCount);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    var totalRecord = dataCommands[0].ListOfParameters[0]["@@TotalRecord"].Value.StringValue();

                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        ds = dataCommands[0].DataSet;

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            SetPage(isPage ? hdnPageNo.Value.ToInt32() : 1, totalRecord.ToInt32());
                            grdList.DataBindGrid(ds, "면접점수 입력 리스트", "면접점수 입력 리스트", this.ExDataCounter1);
                            ExDataCounter1.DataCount = totalRecord.ToInt32();

                            lblInterviewInfo.Text = ds.Tables[0].Rows[0]["InterviewData"].ToString();
                        }
                        else
                        {
                            grdList.ClearDataSource(ExDataCounter1);
                            SetPage(1, 0);
                        }
                    }
                }
                else
                {
                    CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
                string strYear = string.IsNullOrEmpty(this.txt지원연도조회.Text) ? string.Empty : this.txt지원연도조회.Text.Trim();
                string strSeason = this.ddl지원시기조회.SelectedItem == null ? string.Empty : this.ddl지원시기조회.SelectedItem.Text.Trim();
                this.headtitle.InnerText = "면접점수 입력 리스트(지원연도:" + strYear + "년, 지원시기:" + strSeason + ")";
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        private bool RetrieveScoreInputTerm()
        {
            bool result = false;
            DataSet ds = null;
            //string spName = "dbo.USP_학사행정_입시_면접관리_면접점수입력_조회_업그레이드";
            string spName = "dbo.USP_학사행정_입시_면접관리_면접점수입력_면접입력기간_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", this.txt지원연도조회.Text.Trim());
                parameters.Add("@season", this.ddl지원시기조회.SelectedValue);

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
                            DateTime today = COMMCommon.GetDBToday;

                            if (ds.Tables[0].Rows[0]["InterViewScoreStartDate"] == DBNull.Value || ds.Tables[0].Rows[0]["InterViewScoreEndDate"] == DBNull.Value)
                            {
                                result = false;
                            }
                            else
                            {
                                DateTime StartDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["InterViewScoreStartDate"]);
                                DateTime EndDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["InterViewScoreEndDate"]);

                                if ((today < StartDate || today > EndDate))
                                {
                                    result = false;
                                }
                                else
                                {
                                    result = true;
                                }
                            }
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
                CommonMessage.AlertMessage(this, ex.Message);
            }

            return result;
        }

        private void PrintEnterAppTesttag()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@recpNo", StudNoSearch.학번);

                Report1.ShowReportByStoredProcedure("0001363001", "dbo.APL_Select_TestTag", dataParams);
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void PrintAll()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@sppoClsCode", ddl전형구분조회.SelectedValue);
                dataParams.Add("@major", ddl지원학과조회.SelectedValue);
                dataParams.Add("@Neis", txtNeisName.neisCode);
                dataParams.Add("@RecpNo", "%");

                if (ddl지원시기조회.SelectedValue == "9")
                    Report1.ShowReportByStoredProcedure("0001363009", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView9
                else if (ddl지원시기조회.SelectedValue == "8")
                    Report1.ShowReportByStoredProcedure("0001363008", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView8All
                else if (ddl지원시기조회.SelectedValue == "7")
                    Report1.ShowReportByStoredProcedure("0001363006", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView7All
                else
                    Report1.ShowReportByStoredProcedure("0001363002", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void PrintOne()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@sppoClsCode", ddl전형구분조회.SelectedValue);
                dataParams.Add("@major", ddl지원학과조회.SelectedValue);
                dataParams.Add("@Neis", txtNeisName.neisCode);
                dataParams.Add("@RecpNo", "%");

                if (ddl지원시기조회.SelectedValue == "A")
                    Report1.ShowReportByStoredProcedure("0001363011", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView10
                else if (ddl지원시기조회.SelectedValue == "9")
                    Report1.ShowReportByStoredProcedure("0001363012", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView9_one
                else if (ddl지원시기조회.SelectedValue == "8")
                    Report1.ShowReportByStoredProcedure("0001363007", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView8
                else if (ddl지원시기조회.SelectedValue == "7")
                    Report1.ShowReportByStoredProcedure("0001363005", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView7
                else
                    Report1.ShowReportByStoredProcedure("0001363004", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView2
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void PrintScore()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@major", ddl지원학과조회.SelectedValue);
                dataParams.Add("@Neis", txtNeisName.neisCode);
                dataParams.Add("@RecpNo", "%");

                if (ddl지원시기조회.SelectedValue == "9")
                    Report1.ShowReportByStoredProcedure("0001363010", "dbo.USP_학사행정_입시_면접관리_면접점수입력_성적_출력_업그레이드", dataParams);  //rptamAppicationScoreListInterView9_score
                else
                    Report1.ShowReportByStoredProcedure("0001363003", "dbo.USP_학사행정_입시_면접관리_면접점수입력_성적_출력_업그레이드", dataParams);  //rptamAppicationScoreListInterView_score
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void Print20Persent()
        {
            Dictionary<string, object> dataParams = new Dictionary<string, object>();
            dataParams.Add("@Year", txt지원연도조회.Text);
            dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
            dataParams.Add("@sppoClsCode", ddl전형구분조회.SelectedValue);
            dataParams.Add("@major", ddl지원학과조회.SelectedValue);
            dataParams.Add("@Neis", txtNeisName.neisCode);
            //dataParams.Add("@RecpNo", "%");
            dataParams.Add("@RecpNo", StudNoSearch.학번);

            Report1.ShowReportByStoredProcedure("0001363004", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView2
        }

        private void Print100Persent()
        {
            Dictionary<string, object> dataParams = new Dictionary<string, object>();
            dataParams.Add("@Year", txt지원연도조회.Text);
            dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
            dataParams.Add("@sppoClsCode", ddl전형구분조회.SelectedValue);
            dataParams.Add("@major", ddl지원학과조회.SelectedValue);
            dataParams.Add("@Neis", txtNeisName.neisCode);
            //dataParams.Add("@RecpNo", "%");
            dataParams.Add("@RecpNo", StudNoSearch.학번);

            Report1.ShowReportByStoredProcedure("0001363011", "dbo.USP_학사행정_입시_면접관리_면접점수입력_출력_업그레이드", dataParams);    //rptamAppicationScoreListInterView10
        }

        #endregion 메소드
    }
}