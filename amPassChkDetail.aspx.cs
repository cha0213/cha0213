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
/// 메뉴정보 : 입시 > 지원자관리 > 지원자 처리(관리자)
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.28 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amPassChkDetail : WebFormBase
    {
        #region 변수선언

        private DataSet dsPass = new DataSet();
        private string strSmsNo = "055-680-1507";   //SMS발송 시 발신처 번호
        private int iRowNum = 0;    // 그리드 바운드 시 로우 인덱스

        protected int _pagePerRowCount = 20;
        protected int _pageNumber;

        private Dictionary<string, WebControl> ControlParams
        {
            get
            {
                Dictionary<string, WebControl> returnValue = new Dictionary<string, WebControl>();

                returnValue.Add("strApplyYear", txt지원연도조회);
                returnValue.Add("strApplySeason", ddl지원시기조회);
                returnValue.Add("strSearchGubun", ddl전형구분조회);
                returnValue.Add("strSearchApplyOrgID", ddl지원학과조회);
                returnValue.Add("strSearchStud", txt성명수험번호조회);
                returnValue.Add("strPass", ddl합격코드조회);
                returnValue.Add("strSchool", txtSearchSchool);
                returnValue.Add("strPhone", txtPhone);

                return returnValue;
            }
        }

        #endregion 변수선언

        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindDdl.Click += BtnReBindDdl_Click;
            btnFinalSave.Click += btnFinalSave_Click;
            btnBatchFinalSave.Click += btnBatchFinalSave_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
                SetControlValueByParam();   
                this.Retrieve(true);
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txt지원연도조회, ddl지원시기조회);
            COMMMethod.SetDDLMajorCode(ddl지원학과조회, txt지원연도조회.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(ddl전형구분조회, txt지원연도조회.Text);

            this.lbl모집인원.Text = "0";
            this.lbl지원자수.Text = "0";
            this.lbl최초합격자수.Text = "0";
            this.lbl충원합격자수.Text = "0";
            this.lbl최초합격최종등록수.Text = "0";
            this.lbl충원합격최종등록수.Text = "0";

            this.ucSMS.Visible = false;

            COMMMethod.SetDDLMajorCode(this.ddl일괄처리_지원학과, this.txt지원연도조회.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl일괄처리_전형구분, txt지원연도조회.Text);
            CodeUtil.DataBindCommonCode(this.ddl일괄처리_합격코드, "SA04", BindMode.Select);

            if (string.IsNullOrEmpty(txtSearchSchool.Text))
            {
                this.txtSearchSchool.Text = "";
            }

            this.ddl합격코드조회.Items.Add(new ListItem("최종등록자(최초+충원)", "31"));

        }

        private void SetScriptForClientEvent()
        {
            // SMS 문장관리
            ((Button)ExToolBar5.FindControl("Save")).Attributes["onClick"] = "return OpenModal();";
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
                Retrieve(false);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 인쇄 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void PrintCmd(object sender, CommandEventArgs e)
        {
            switch (this.rbl인쇄구분조회.SelectedValue)
            {
                case "1":   //합격통지서 출력
                    Print_Pass();
                    return;

                case "2":   //장학증서 출력
                    Print_Scholarship();
                    return;

                case "3":   //등록금 고지서 출력(주소있음)
                case "6":   //등록금 고지서 출력(주소없음)
                    Print_Tuition();
                    return;

                case "4":   //입학원서 출력
                    Print_Enter();
                    return;

                case "5":   // 예치금 고지서 출력(주소있음)
                case "7":   // 예치금 고지서 출력(주소없음)
                    Print_Deposit();
                    return;
            }
        }

        /// <summary>
        /// SMS 발송 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            try
            {
                IEnumerable<DataRow> dataRows = this.grdList.GetSelectedGridDataRows("chkRow");

                if (dataRows.Count() > 0)
                {
                    DataTable dt = GetSMSList();
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        this.ucSMS.Visible = true;
                        ((ExTextBox)this.ucSMS.FindControl("txt발신번호")).Text = strSmsNo;
                        ((Button)this.ucSMS.FindControl("btnClose")).Visible = true;
                        ExGridView grdSMS = ((ExGridView)this.ucSMS.FindControl("grdList"));
                        grdSMS.Columns[1].HeaderText = "수험번호";
                        this.ucSMS.DataBind(dt);
                    }
                }
                else
                {
                    CommonMessage.AlertMessage(Page, "전송할 대상자를 선택하시기 바랍니다.");
                    return;
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void btnFinalSave_Click(object sender, EventArgs e)
        {
            this.Save();
        }

        private void btnBatchFinalSave_Click(object sender, EventArgs e)
        {
            this.SaveBatch();
        }

        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
        }

        /// <summary>
        /// 일괄 변경 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            try
            {
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 그리드 행 데이타 바인딩
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void grdList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[24].ToolTip = e.Row.Cells[31].Text;

                    DataRowView drv = e.Row.DataItem as DataRowView;

                    ExDropDownList ddl합격코드 = (ExDropDownList)e.Row.FindControl("ddl합격코드");
                    ddl합격코드.DataValueField = this.ddl합격코드조회.DataValueField;
                    ddl합격코드.DataTextField = this.ddl합격코드조회.DataTextField;
                    ddl합격코드.DataSource = dsPass;
                    ddl합격코드.DataBind();
                    ddl합격코드.SelectedValue = drv["합격"].ToString();

                    ddl합격코드.Attributes["onchange"] = string.Format("javascript:SetChangePassCode('{0}')", iRowNum);

                    iRowNum++;
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 지원연도 변경 시 지원학과, 전형구분 데이터 변경
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(this.ddl지원학과조회, this.txt지원연도조회.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl전형구분조회, txt지원연도조회.Text);

            COMMMethod.SetDDLMajorCode(this.ddl일괄처리_지원학과, this.txt지원연도조회.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(this.ddl일괄처리_전형구분, txt지원연도조회.Text);
        }

        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        public void Retrieve(bool isPage)
        {
            DataSet ds = null;
            // string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역_조회_업그레이드";
            string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역페이징_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                this.dsPass = this.GetPass();

                parameters.Add("@Year", this.txt지원연도조회.Text.Trim());
                parameters.Add("@Season", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@SppoClsCode", this.ddl전형구분조회.SelectedValue);
                parameters.Add("@MajorCode", this.ddl지원학과조회.SelectedValue);
                parameters.Add("@Stud", this.txt성명수험번호조회.Text.Trim());
                parameters.Add("@Pass", this.ddl합격코드조회.SelectedValue);
                parameters.Add("@school", this.txtSearchSchool.Text);

                parameters.Add("@startRank", string.IsNullOrEmpty(this.txtStartRankS.Text) ? null : this.txtStartRankS.Text);
                parameters.Add("@EndRank", string.IsNullOrEmpty(this.txtEndRankS.Text) ? null : this.txtEndRankS.Text);

                parameters.Add("@PhoneNo", string.IsNullOrEmpty(this.txtPhone.Text) ? null : this.txtPhone.Text);

                parameters.Add("@CurrentPage", isPage ? _pageNumber : 1);
                parameters.Add("@TotalRecord", _pagePerRowCount);

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
                            //this.grdList.DataBindGrid(ds, this.ExDataCounter1);
                            //ExDataCounter1.DataCount = ds.Tables[0].Rows.Count;
                            var outParams = dataCommands[0].ListOfParameters[0];
                            var totalRecord = outParams["@@TotalRecord"].Value.StringValue();
                            SetPage(isPage ? _pageNumber : 1, totalRecord.ToInt32());
                            grdList.DataBindGrid(ds, "입시지원자 리스트", "입시지원자 리스트", this.ExDataCounter1);
                            this.ExDataCounter1.DataCount = totalRecord.ToInt32();

                            this.lbl모집인원.Text = outParams["@@RecruitmentCount"].Value.StringValue();
                            this.lbl지원자수.Text = outParams["@@CNT_00"].Value.StringValue();
                            this.lbl최초합격자수.Text = outParams["@@CNT_09"].Value.StringValue();
                            this.lbl충원합격자수.Text = outParams["@@CNT_08"].Value.StringValue();
                            this.lbl최초합격최종등록수.Text = outParams["@@CNT_01"].Value.StringValue();
                            this.lbl충원합격최종등록수.Text = outParams["@@CNT_02"].Value.StringValue();
                        }
                        else
                        {
                            this.grdList.ClearDataSource();
                            ExDataCounter1.DataCount = 0;
                            SetPage(1, 0);
                        }

                        // sms 발송 관련 초기화
                        txtPassCodeString.Text = string.Empty;
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

        /// <summary>
        ///합격통지서 출력
        /// </summary>
        private void Print_Pass()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@Major", ddl지원학과조회.SelectedValue);
                dataParams.Add("@pass", ddl합격코드조회.SelectedValue);
                dataParams.Add("@Stud", txt성명수험번호조회.Text);
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@SppoclsCode", ddl전형구분조회.SelectedValue);

                Report1.ShowReportByStoredProcedure("0001364007", "dbo.USP_학사행정_입시_지원자현황_지원자조회_합격통지서_출력_업그레이드", dataParams);  //rptPassNotice
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        ///장학증서 출력
        /// </summary>
        private void Print_Scholarship()
        {
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@Major", ddl지원학과조회.SelectedValue);
                dataParams.Add("@pass", ddl합격코드조회.SelectedValue);
                dataParams.Add("@Stud", txt성명수험번호조회.Text);
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@SppoclsCode", ddl전형구분조회.SelectedValue);

                Report1.ShowReportByStoredProcedure("0001364006", "dbo.USP_학사행정_입시_지원자현황_지원자조회_장학증서_출력_업그레이드", dataParams);    //rptScholarship
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// 등록금고지서 출력
        /// </summary>
        private void Print_Tuition()
        {
            string pass = ddl합격코드조회.SelectedValue;
            string season = ddl지원시기조회.SelectedValue;

            if (pass == "01" || pass == "02" || pass == "08" || pass == "09" || pass == "19")
            {
                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_등록금고지서_출력_업그레이드";
                string reportNo = string.Empty;

                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@recpNo", txt성명수험번호조회.Text);
                dataParams.Add("@Year", txt지원연도조회.Text);
                dataParams.Add("@Season", ddl지원시기조회.SelectedValue);
                dataParams.Add("@pass", ddl합격코드조회.SelectedValue);
                dataParams.Add("@majorCode1", ddl지원학과조회.SelectedValue);
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@SppoclsCode", ddl전형구분조회.SelectedValue);

                if (rbl인쇄구분조회.SelectedValue == "3") // 등록금 고지서(주소있음)
                {
                    /* 2020-12-23 김동균 입학처 요청으로 일단 통일, 각 시즌마다 발표 전 확인 필요
                    if (season == "7" || season == "8")
                        reportNo = "0001364002";    //PassInfo78
                    else if (season == "9")
                        reportNo = "0001364003";    //PassInfo9
                    else if (season == "E")
                        reportNo = "0001364004";    //PassInfoE
                    else
                    */
                    reportNo = "0001364001";    //PassInfo
                }
                else if (rbl인쇄구분조회.SelectedValue == "6")  // 등록금 고지서(주소없음)
                {
                    /* 2020-12-23 김동균 입학처 요청으로 일단 통일, 각 시즌마다 발표 전 확인 필요
                    if (season == "7" || season == "8")
                        reportNo = "0001364011";    //PassInfo78WithoutAddress
                    else if (season == "9")
                        reportNo = "0001364012";    //PassInfo9WithoutAddress
                    else if (season == "E")
                        reportNo = "0001364013";    //PassInfoEWithoutAddress
                    else
                    */
                    reportNo = "0001364010";    //PassInfoWithoutAddress
                }

                ReportInvoker1.ShowReportByStoredProcedure(reportNo, spName, dataParams);
            }
            else
            {
                CommonMessage.AlertMessage(this, "등록금고지서출력은 합격자, 등록자만 가능합니다.");
                return;
            }
        }

        /// <summary>
        /// 입학원서 출력
        /// </summary>
        private void Print_Enter()
        {
            DataSet ds = new DataSet();
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_입학원서_출력_업그레이드";
            var parameters = new DataParameterCollection(); //ReportUtil.GetReportParameter(strParams);
                                                            //var shell = new DataCommandShell();
            var shell = ReportUtil.GetRDCommandShell(this);
            var dataCommands = new List<DataCommand>();

            parameters.Add("@Year", txt지원연도조회.Text);
            parameters.Add("@Season", ddl지원시기조회.SelectedValue);
            parameters.Add("@Major", ddl지원학과조회.SelectedValue);
            parameters.Add("@pass", ddl합격코드조회.SelectedValue);
            parameters.Add("@Stud", txt성명수험번호조회.Text);
            parameters.Add("@school", txtSearchSchool.Text);
            parameters.Add("@SppoclsCode", ddl전형구분조회.SelectedValue);

            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
            dataCommands = shell.Execute();

            if (shell.ErrorCode == 0)
            {
                ds = DataUtil.GetDataSetFrom(dataCommands);

                if (ds.Tables[1].Rows.Count > 0)
                {
                    ds.Tables[1].TableName = "주쿼리";
                    ds.Tables[2].TableName = "서브쿼리1";
                    ds.Tables[3].TableName = "서브쿼리2";

                    DataUtil.AddDataRelation(ds, "Dataset", "주쿼리", "서브쿼리1", "수험번호");
                    DataUtil.AddDataRelation(ds, "Dataset1", "주쿼리", "서브쿼리2", "수험번호");

                    if(txt지원연도조회.Text.ToInt32() >= 2025)
                    {
                        ReportInvoker1.ShowReportByPage("0001364015", ds);
                    }
                    else
                    { 
                        ReportInvoker1.ShowReportByPage("0001364008", ds);
                    }

                }
                else
                {
                    CommonMessage.AlertMessage(this, "데이터가 없습니다.");
                }
            }
            else
            {
                throw new HttpException(shell.ErrorMessage);
            }
        }

        /// <summary>
        /// 예치금 고지서 출력
        /// </summary>
        private void Print_Deposit()
        {
            string pass = ddl합격코드조회.SelectedValue;

            if (pass == "01" || pass == "02" || pass == "08" || pass == "09" || pass == "19")
            {
                DataSet ds = new DataSet();
                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_예치금고지서_출력_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = ReportUtil.GetRDCommandShell(this);
                var dataCommands = new List<DataCommand>();

                parameters.Add("@recpNo", txt성명수험번호조회.Text == "" ? "%" : txt성명수험번호조회.Text);
                parameters.Add("@Year", txt지원연도조회.Text);
                parameters.Add("@Season", ddl지원시기조회.SelectedValue);
                parameters.Add("@Major", ddl지원학과조회.SelectedValue);
                parameters.Add("@pass", ddl합격코드조회.SelectedValue);
                parameters.Add("@school", txtSearchSchool.Text);
                parameters.Add("@SppoclsCode", ddl전형구분조회.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    ds = DataUtil.GetDataSetFrom(dataCommands);

                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        ds.Tables[1].TableName = "주쿼리";
                        ds.Tables[2].TableName = "서브쿼리1";

                        DataUtil.AddDataRelation(ds, "Dataset", "주쿼리", "서브쿼리1", "recpNo");

                        if (rbl인쇄구분조회.SelectedValue == "5")  // 예치금 고지서(주소있음)
                            ReportInvoker1.ShowReportByPage("0001364009", ds);
                        else if (rbl인쇄구분조회.SelectedValue == "7") // 예치금 고지서(주소없음)
                            ReportInvoker1.ShowReportByPage("0001364014", ds);
                    }

                    // 개발시
                }
                else
                {
                    throw new HttpException(shell.ErrorMessage);
                }

                //string pass = ddlPass.SelectedValue;
                //string season = ddlSearchApplySeason.SelectedValue;

                //if (pass == "03" || pass == "04" || pass == "05" || pass == "07" || pass == "10" || pass == "11" || pass == "12")
                //{
                //    CommonMessage.AlertMessage(this, "불합격자는 고지서를 출력할 수 없습니다.");
                //    return;
                //}
                //else
                //{
                //    Dictionary<string, object> dataParams = new Dictionary<string, object>();
                //    dataParams.Add("@recpNo", txtSearchStud.Text);
                //    dataParams.Add("@Year", txtSearchApplyYear.Text);
                //    dataParams.Add("@Season", ddlSearchApplySeason.SelectedValue);
                //    dataParams.Add("@pass", ddlPass.SelectedValue);

                //    Report1.ShowReportByStoredProcedure("0001364001", "dbo.USP_학사행정_입시_지원자현황_지원자조회_예치금고지서_출력_업그레이드", dataParams); //PassInfo
                //}
            }
            else
            {
                CommonMessage.AlertMessage(this, "예치금고지서출력은 합격자, 등록자만 가능합니다.");
                return;
            }
        }

        /// <summary>
        /// 저장 버튼 클릭 시 저장
        /// </summary>
        public void Save()
        {
            if (this.grdList.Rows.Count == 0)
            {
                CommonMessage.AlertMessage(this, "저장 할 데이터가 없습니다.");
                return;
            }

            string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역관리자_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            string[] arrPassCodeString = txtPassCodeString.Text.Trim().Split('|');
            string sendSmsYN1 = "N";    // SMS 발송 여부 (합격코드 변경 된 학생)
            string sendSmsYN2 = "N";    // SMS 발송 여부 (예비순위 변경 된 학생)

            for (int i = 0; i < arrPassCodeString.Length; i++)
            {
                if (arrPassCodeString[i].IndexOf("ZZ") > -1)
                {
                    sendSmsYN2 = (arrPassCodeString[i].Split('@'))[1].ToString();
                }
            }

            try
            {
                foreach (GridViewRow gvr in this.grdList.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(gvr.RowType))
                    {
                        if (Util.GetGridViewString(((TextBox)gvr.Cells[34].Controls[1]).Text) == "Y")
                        {
                            ExDropDownList ddl합격코드 = (ExDropDownList)gvr.FindControl("ddl합격코드");
                            parameters.Add("@Year", Util.GetGridViewString(gvr.Cells[32].Text));
                            parameters.Add("@Season", Util.GetGridViewString(gvr.Cells[33].Text));
                            parameters.Add("@recpNo", Util.GetGridViewString(gvr.Cells[1].Text));
                            parameters.Add("@pass", ddl합격코드.SelectedValue);

                            for (int i = 0; i < arrPassCodeString.Length; i++)
                            {
                                if (arrPassCodeString[i].IndexOf(ddl합격코드.SelectedValue) > -1)
                                {
                                    sendSmsYN1 = (arrPassCodeString[i].Split('@'))[1].ToString();
                                }
                            }

                            parameters.Add("@sendSmsYN", sendSmsYN1);
                            parameters.Add("@sendSmsYN2", sendSmsYN2);
                            parameters.Add("@ProcessID", UserId);
                            parameters.Add("@ProcessIP", UserIp);

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    // 예비후보에게 문자 보내기...
                    // 현재 합격코드 변경 시 한 학생의 정보를 변경하고, 해당 학생의 동일 계열,전형에 해당하는 예비 후보의 순위를 변경한다.
                    // 여기서 예비후보는 합격코드 변경한 학생에 따라 여러번 업데이트 쿼리가 발생 할 수 있기에... 예비후보 변경을 한 사람을 SP에서 받은 다음
                    // 중복을 제거하고, 예비후보 한명 당 하나의 메세지만 가도록 해야 한다.
                    if (sendSmsYN2 == "Y")
                    {
                        if (dataCommands.Count > 0)
                        {
                            DataTable dtUnion = new DataTable();
                            DataTable dtTemp = new DataTable();

                            for (int i = 0; i < dataCommands.Count; i++)
                            {
                                dtTemp = dataCommands[i].DataSet.Tables[0];

                                dtUnion.Merge(dtTemp);
                            }

                            var grouped = dtUnion.AsEnumerable()
                                 .GroupBy(r => r.Field<string>("recpNo"))
                                 .Select(grp =>
                                     new
                                     {
                                         recpNo = grp.Key
                                       ,
                                         Phone = grp.Min(e => e.Field<string>("Phone"))
                                       ,
                                         SubRank = grp.Min(e => e.Field<int>("SubRank"))
                                       ,
                                         Msg = grp.Min(e => e.Field<string>("Msg"))
                                       ,
                                         year = grp.Min(e => e.Field<string>("year"))
                                       ,
                                         season = grp.Min(e => e.Field<string>("season"))
                                     });

                            DataTable dtSMS = dtUnion.Clone();
                            foreach (var item in grouped)
                            {
                                dtSMS.Rows.Add(item.year, item.season, item.recpNo, item.Phone, item.SubRank, item.Msg);
                            }

                            if (dtSMS.Rows.Count > 0)
                            {
                                // 이때 주의 할 점은 예비후보로 문자를 발송 할 대상 중에도 합격코드가 예비합격대상이 아닌 다른 코드로 변경 된 경우가 있을 수 있음.
                                // SP에서 한번 더 걸러줘야 함.
                                spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역관리자_예비후보문자발송_업그레이드";
                                parameters = new DataParameterCollection();
                                shell = new DataCommandShell();
                                dataCommands = new List<DataCommand>();

                                foreach (DataRow row in dtSMS.Rows)
                                {
                                    parameters = new DataParameterCollection();

                                    parameters.Add("@Year", Util.GetDataRowString(row["year"]));
                                    parameters.Add("@Season", Util.GetDataRowString(row["season"]));
                                    parameters.Add("@recpNo", Util.GetDataRowString(row["recpNo"]));
                                    parameters.Add("@celPhone", Util.GetDataRowString(row["Phone"]));
                                    parameters.Add("@Message", Util.GetDataRowString(row["Msg"]));

                                    parameters.Add("@ProcessID", UserId);
                                    parameters.Add("@ProcessIP", UserIp);

                                    shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                                }

                                dataCommands = shell.Execute();

                                if (shell.ErrorCode == 0)
                                {
                                }
                            }
                        }
                    }

                    CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.

                    this.Retrieve(false);
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

        public void SaveBatch()
        {
            try
            {
                // 전형구분, 지원학과 별로 석차 N~N 까지 합격코드를 일괄 변경 한다.
                string sppoClsCode = ddl일괄처리_전형구분.SelectedValue;
                string majorCode = ddl일괄처리_지원학과.SelectedValue;
                string passCode = ddl일괄처리_합격코드.SelectedValue;
                string startRank = txtRankStart.Text;
                string endRank = txtRankEnd.Text;

                //string[] arrPassCodeString = txtPassCodeString.Text.Trim().Split('|');
                string sendSmsYN1 = "N";    // SMS 발송 여부 (합격코드 변경 된 학생)
                string sendSmsYN2 = "N";    // SMS 발송 여부 (예비순위 변경 된 학생)

                //for (int i = 0; i < arrPassCodeString.Length; i++)
                //{
                //	if (arrPassCodeString[i].IndexOf("ZZ") > -1)
                //	{
                //		sendSmsYN2 = (arrPassCodeString[i].Split('@'))[1].ToString();
                //	}
                //	else
                //	{
                //		sendSmsYN1 = (arrPassCodeString[i].Split('@'))[1].ToString();
                //	}
                //}

                string spName = "dbo.USP_학사행정_입시_지원자관리_지원자일괄변경_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@Year", this.txt지원연도조회.Text);
                parameters.Add("@Season", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@sppoClsCode", this.ddl일괄처리_전형구분.SelectedValue);
                parameters.Add("@majorCodeFinal", this.ddl일괄처리_지원학과.SelectedValue);
                parameters.Add("@pass", this.ddl일괄처리_합격코드.SelectedValue);
                parameters.Add("@startRank", this.txtRankStart.Text);
                parameters.Add("@endRank", this.txtRankEnd.Text);
                parameters.Add("@sendSmsYN", sendSmsYN1);
                parameters.Add("@sendSmsYN2", sendSmsYN2);
                parameters.Add("@ProcessID", UserId);
                parameters.Add("@ProcessIP", UserIp);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    // 예비후보에게 문자 보내기...
                    // 현재 합격코드 변경 시 한 학생의 정보를 변경하고, 해당 학생의 동일 계열,전형에 해당하는 예비 후보의 순위를 변경한다.
                    // 여기서 예비후보는 합격코드 변경한 학생에 따라 여러번 업데이트 쿼리가 발생 할 수 있기에... 예비후보 변경을 한 사람을 SP에서 받은 다음
                    // 중복을 제거하고, 예비후보 한명 당 하나의 메세지만 가도록 해야 한다.
                    if (sendSmsYN2 == "Y")
                    {
                        if (dataCommands.Count > 0)
                        {
                            DataTable dtUnion = new DataTable();
                            DataTable dtTemp = new DataTable();

                            for (int i = 0; i < dataCommands.Count; i++)
                            {
                                dtTemp = dataCommands[i].DataSet.Tables[0];

                                dtUnion.Merge(dtTemp);
                            }

                            var grouped = dtUnion.AsEnumerable()
                                 .GroupBy(r => r.Field<string>("recpNo"))
                                 .Select(grp =>
                                     new
                                     {
                                         recpNo = grp.Key
                                       ,
                                         Phone = grp.Min(e => e.Field<string>("Phone"))
                                       ,
                                         SubRank = grp.Min(e => e.Field<int>("SubRank"))
                                       ,
                                         Msg = grp.Min(e => e.Field<string>("Msg"))
                                       ,
                                         year = grp.Min(e => e.Field<string>("year"))
                                       ,
                                         season = grp.Min(e => e.Field<string>("season"))
                                     });

                            DataTable dtSMS = dtUnion.Clone();
                            foreach (var item in grouped)
                            {
                                dtSMS.Rows.Add(item.year, item.season, item.recpNo, item.Phone, item.SubRank, item.Msg);
                            }

                            if (dtSMS.Rows.Count > 0)
                            {
                                // 이때 주의 할 점은 예비후보로 문자를 발송 할 대상 중에도 합격코드가 예비합격대상이 아닌 다른 코드로 변경 된 경우가 있을 수 있음.
                                // SP에서 한번 더 걸러줘야 함.
                                spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역관리자_예비후보문자발송_업그레이드";
                                parameters = new DataParameterCollection();
                                shell = new DataCommandShell();
                                dataCommands = new List<DataCommand>();

                                foreach (DataRow row in dtSMS.Rows)
                                {
                                    parameters = new DataParameterCollection();

                                    parameters.Add("@Year", Util.GetDataRowString(row["year"]));
                                    parameters.Add("@Season", Util.GetDataRowString(row["season"]));
                                    parameters.Add("@recpNo", Util.GetDataRowString(row["recpNo"]));
                                    parameters.Add("@celPhone", Util.GetDataRowString(row["Phone"]));
                                    parameters.Add("@Message", Util.GetDataRowString(row["Msg"]));

                                    parameters.Add("@ProcessID", UserId);
                                    parameters.Add("@ProcessIP", UserIp);

                                    shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                                }

                                dataCommands = shell.Execute();

                                if (shell.ErrorCode == 0)
                                {
                                }
                            }
                        }
                    }

                    CommonMessage.AlertMessage(this, "일괄변경 처리가 완료 되었습니다.");
                    this.Retrieve(false);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 합격 코드 조회
        /// </summary>
        /// <returns></returns>
        private DataSet GetPass()
        {
            try
            {
                DataCommandShell shell = new DataCommandShell();
                DataParameterCollection P = new DataParameterCollection();

                P.Add("@SearchValue", "SA04");
                shell.SetSpCommand("dbo.usp_GetCommon_BaseCode", DbCommandType.ExecuteQuery, P);
                var executedCommands = shell.Execute();
                if (shell.ErrorCode == 0)
                {
                    dsPass = executedCommands[0].DataSet;
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

            return dsPass;
        }

        /// <summary>
        /// SMS 발송할 대상 조회
        /// </summary>
        /// <returns></returns>
        public DataTable GetSMSList()
        {
            DataTable dt = new DataTable();

            try
            {
                dt.Columns.AddRange(new DataColumn[3] { new DataColumn("StudentNO"), new DataColumn("StudentName"), new DataColumn("MobilePhoneNo") });

                foreach (GridViewRow item in this.grdList.Rows)
                {
                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[5].Controls[1]).Checked)
                        {
                            dt.Rows.Add(Util.GetGridViewString(item.Cells[1].Text), Util.GetGridViewString(item.Cells[2].Text), Util.GetGridViewString(item.Cells[26].Text));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }

            return dt;
        }

        private void SetControlValueByParam()
        {
            foreach (KeyValuePair<string, WebControl> kv in ControlParams)
            {
                if (kv.Value is IDataBindableControl)
                {
                    var bindableControl = (IDataBindableControl)kv.Value;
                    if (Request.Params[kv.Key] != null)
                    {
                        bindableControl.SetValue(HttpUtility.UrlDecode(Request.Params[kv.Key]));
                    }
                }
            }
            if (!string.IsNullOrEmpty(Request["PageNo"]))
                _pageNumber = Convert.ToInt32(Request["PageNo"] as string);
            else
                _pageNumber = 1;
        }

        private void SetPage(int pageNo, int totalCnt)
        {
            var currentPath = new System.Text.StringBuilder();
            currentPath.Append($"{Request.Url.AbsolutePath}?");

            foreach (KeyValuePair<string, WebControl> kv in ControlParams)
            {
                if (kv.Key == ControlParams.LastOrDefault().Key)
                {
                    currentPath.Append($"{kv.Key}={GetValue(kv.Value)}");
                }
                else
                {
                    currentPath.Append($"{kv.Key}={GetValue(kv.Value)}&");
                }
            }

            grdList.PageIndex = pageNo;
            grdList.PageSize = _pagePerRowCount;

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = _pagePerRowCount;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath.ToString());
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

        #endregion 메소드
    }
}