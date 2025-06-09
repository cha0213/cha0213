using System;
using System.Collections.Generic;
using System.Linq;
using KJC.IMS.COFF.COMM.BIZ;
using KJC.IMS.COFF.CONTROL.COFF;
using IFW.Data;
using IFW.WebUI;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Security.Permissions;

namespace KJC.IMS.ENTR.StaffMngr
{
    /// <summary>
    /// 메뉴정보 : 지원자 조회
    /// 수정이력
    /// 1. 작성일자/작성자/최초작성
    ///  - 2017.06.05 / 방성훈 / 최초작성
    /// 2. 수정일자/수정자/수정내용
    ///  - 2017.11.21/최세영/전체적으로
    /// </summary>
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class ApplSearch : WebFormBase
    {
        #region 초기화

        protected int ROW_NUM = 15;
        protected int page_num;

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
            grdList.RowDataBound += GrdList_RowDataBound;
            btnReBindDdl.Click += BtnReBindDdl_Click;  // [조회조건] 지원연도 변경시 전형구분, 지원학과 바인딩
            ddlHostelYN.SelectedIndexChanged += DdlHostelYN_SelectedIndexChanged;
        }

        /// <summary>
        /// Page_Load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                this.InitPageSetting();

                if (!string.IsNullOrEmpty(Request["SearchApplyYear"]))
                {
                    this.txtSearchApplyYear.Text = Request["SearchApplyYear"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchApplySeason"]))
                {
                    this.ddlSearchApplySeason.SelectedValue = Request["SearchApplySeason"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchGubun"]))
                {
                    this.ddlSearchGubun.SelectedValue = Request["SearchGubun"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchStud"]))
                {
                    this.txtSearchStud.Text = Request["SearchStud"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchHostelYN"]))
                {
                    this.ddlHostelYN.SelectedValue = Request["SearchHostelYN"].ToString();
                    if (Request["SearchHostelYN"].ToString() == "N")
                        this.ddlListSelect.Enabled = false;
                    else
                        this.ddlListSelect.Enabled = true;
                }

                if (!string.IsNullOrEmpty(Request["SearchListSelect"]))
                {
                    this.ddlListSelect.SelectedValue = Request["SearchListSelect"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchApplyOrgID"]))
                    ddlSearchApplyOrgID.SelectedValue = Request["SearchApplyOrgID"].ToString();

                if (!string.IsNullOrEmpty(Request["Pass"]))
                {
                    this.ddlPass.SelectedValue = Request["Pass"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["PrintGubun"]))
                {
                    this.rblPrintGubun.SelectedValue = Request["PrintGubun"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["SearchSchool"]))
                {
                    this.txtSearchSchool.Text = Request["SearchSchool"].ToString();
                }

                if (!string.IsNullOrEmpty(Request["PageNo"]))
                    this.page_num = Convert.ToInt32(Request["PageNo"] as string);
                else
                    this.page_num = 1;

                this.Retrieve(true);
            }

            this.SetScriptForClientEvent();
        }

        /// <summary>
        /// UI Page 초기 셋팅
        /// </summary>
        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txtSearchApplyYear, ddlSearchApplySeason);
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);

            //if (HasGroups("67", "68", "34" ,"61"))
            //{
            //    COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //[조회조건] 지원연도 변경시 지원학과 바인딩
            //}
            //else
            //    COMMMethod.SetDDLMajorCodeByStaffNo(ddlSearchApplyOrgID, txtSearchApplyYear.Text, ddlSearchApplySeason.SelectedValue, ddlSearchGubun.SelectedValue, UserId);

            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //[조회조건] 지원연도 변경시 지원학과 바인딩

            lblInwon.Text = "0";
            lblApplyCnt.Text = "0";
            lblPassFirst.Text = "0";
            lblPassPlus.Text = "0";
            lblPassFirstJoin.Text = "0";
            lblPassPlusJoin.Text = "0";

            this.ddlPass.Items.Add(new ListItem("최종등록자(최초+충원)", "31"));
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
        }

        #endregion 초기화

        #region 이벤트

        private void DdlHostelYN_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (ddlHostelYN.SelectedValue == "%")
                {
                    ddlListSelect.SelectedIndex = 0;
                    ddlListSelect.Enabled = true;
                }

                else if (ddlHostelYN.SelectedValue == "Y")
                {
                    ddlListSelect.SelectedIndex = 0;
                    ddlListSelect.Enabled = true;
                }

                else if (ddlHostelYN.SelectedValue == "N")
                {
                    ddlListSelect.SelectedIndex = 0;
                    ddlListSelect.Enabled = false;
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(Page, ex.Message);
            }
        }

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
            switch (this.rblPrintGubun.SelectedValue)
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
        /// 엑셀 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@SppoClsCode", ddlSearchGubun.SelectedValue);
                parameters.Add("@MajorCode", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@Stud", txtSearchStud.Text);
                parameters.Add("@HostelYN", ddlHostelYN.SelectedValue);
                parameters.Add("@ListSelect", ddlListSelect.SelectedValue);
                parameters.Add("@School", txtSearchSchool.Text);

                parameters.Add("@페이지넘버", 1);
                parameters.Add("@보여줄출력물갯수", 9999);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;
                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];

                        dt.Columns.Remove("SEQ_NUM");
                        dt.Columns["Year"].ColumnName = "연도";
                        dt.Columns.Remove("season");
                        dt.Columns.Remove("2지망");
                        dt.Columns.Remove("최종전공");
                        dt.Columns.Remove("보호자");
                        dt.Columns.Remove("관계");
                        dt.Columns.Remove("보호자휴대전화");
                        dt.Columns.Remove("보호자전화");
                        dt.Columns.Remove("주소");
                        dt.Columns["Address"].ColumnName = "주소";
                        dt.Columns.Remove("자격증");
                        dt.Columns.Remove("접수자");
                        dt.Columns.Remove("a00");
                        dt.Columns.Remove("a09");
                        dt.Columns.Remove("a08");
                        dt.Columns.Remove("a01");
                        dt.Columns.Remove("a02");
                        dt.Columns.Remove("Recruitment");
                        //dt.Columns.Remove("예비합격순위");
                        //dt.Columns.Remove("성적순위");
                        dt.Columns.Remove("TOTAL_COUNT");

                        dt.Columns["연도"].SetOrdinal(0);
                        dt.Columns["지원시기"].SetOrdinal(1);
                        dt.Columns["수험번호"].SetOrdinal(2);
                        dt.Columns["이름"].SetOrdinal(3);
                        dt.Columns["주민등록번호"].SetOrdinal(4);
                        dt.Columns["합격코드"].SetOrdinal(5);

                        dt.Columns["성적순위"].SetOrdinal(6);
                        dt.Columns["예비합격순위"].SetOrdinal(7);
                        

                        dt.Columns["전형구분"].SetOrdinal(8);
                        dt.Columns["1지망"].SetOrdinal(9);
                        dt.Columns["최종지망"].SetOrdinal(10);
                        dt.Columns["기숙사"].SetOrdinal(11);
                        dt.Columns["인실"].SetOrdinal(12);
                        dt.Columns["졸업연도"].SetOrdinal(13);
                        dt.Columns["출신고교(검정고시)"].SetOrdinal(14);
                        dt.Columns["고교과"].SetOrdinal(15);
                        dt.Columns["졸업"].SetOrdinal(16);
                        dt.Columns["이메일"].SetOrdinal(17);
                        dt.Columns["우편번호"].SetOrdinal(18);
                        dt.Columns["주소"].SetOrdinal(19);
                        dt.Columns["전화"].SetOrdinal(20);
                        dt.Columns["휴대전화"].SetOrdinal(21);
                        dt.Columns["산업체"].SetOrdinal(22);
                        dt.Columns["접수일"].SetOrdinal(23);
                        


                        Util.ExcelDownLoad(this, dt, "입시지원자 리스트");
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, "데이터가 존재하지 않습니다.");
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

        private void GrdList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[22].ToolTip = e.Row.Cells[29].Text;
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        /// <summary>
        /// [조회조건] 지원연도 변경시 전형구분, 지원학과 바인딩
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            if (HasGroups("67", "68", "34"))
            {
                COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //[조회조건] 지원연도 변경시 지원학과 바인딩
            }
            else
                COMMMethod.SetDDLMajorCodeByStaffNo(ddlSearchApplyOrgID, txtSearchApplyYear.Text, ddlSearchApplySeason.SelectedValue, ddlSearchGubun.SelectedValue, UserId);

            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);  //[조회조건] 지원연도 변경시 전형구분 바인딩
        }

        #endregion 이벤트

        #region 메소드

        public void Retrieve(bool PAGE_YN)
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@SppoClsCode", ddlSearchGubun.SelectedValue);
                parameters.Add("@MajorCode", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@Stud", txtSearchStud.Text);
                parameters.Add("@HostelYN", ddlHostelYN.SelectedValue);
                parameters.Add("@ListSelect", ddlListSelect.SelectedValue);
                parameters.Add("@School", txtSearchSchool.Text);
                parameters.Add("@Pass", ddlPass.SelectedValue);

                parameters.Add("@페이지넘버", PAGE_YN ? this.page_num : 1);
                parameters.Add("@보여줄출력물갯수", ROW_NUM);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                DataSet ds = null;
                DataTable table = null;
                if (shell.ErrorCode == 0)
                {
                    if (dataCommands.Count > 0 &&
                        dataCommands[0].DataSet != null &&
                        dataCommands[0].DataSet.Tables.Count > 0)
                    {
                        // Do something
                        foreach (DataTable tbl in dataCommands[0].DataSet.Tables)
                        {
                            table = tbl;
                        }

                        ds = table.DataSet;

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        {
                            string strTotalCount = ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0]["TOTAL_COUNT"].ToString() : "0";

                            DataRow dr = ds.Tables[0].Rows[0];
                            lblInwon.Text = dr["Recruitment"].ToString();
                            lblApplyCnt.Text = dr["a00"].ToString();
                            lblPassFirst.Text = dr["a09"].ToString();
                            lblPassPlus.Text = dr["a08"].ToString();
                            lblPassFirstJoin.Text = dr["a01"].ToString();
                            lblPassPlusJoin.Text = dr["a02"].ToString();

                            this.grdList.DataBindGrid(ds.Tables[0], "입시지원자 리스트", "입시지원자 리스트");
                            ExDataCounter1.DataCount = strTotalCount.ToInt32();
                            this.SetPage(PAGE_YN ? this.page_num : 1, Convert.ToInt32(strTotalCount));
                        }
                        else
                        {
                            lblInwon.Text = "0";
                            lblApplyCnt.Text = "0";
                            lblPassFirst.Text = "0";
                            lblPassPlus.Text = "0";
                            lblPassFirstJoin.Text = "0";
                            lblPassPlusJoin.Text = "0";
                            this.grdList.ClearDataSource(this.ExDataCounter1);
                            this.SetPage(1, 0);
                        }
                    }

                    //this.grdList.DataBindGrid(ds, "입시지원자 리스트", "입시지원자 리스트", this.ExDataCounter1);
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

        private void Print_Pass()
        {//합격통지서 출력
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txtSearchApplyYear.Text);
                dataParams.Add("@Season", ddlSearchApplySeason.SelectedValue);
                dataParams.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                dataParams.Add("@pass", ddlPass.SelectedValue);
                dataParams.Add("@Stud", txtSearchStud.Text);
                dataParams.Add("@HostelYN", ddlHostelYN.SelectedValue);
                dataParams.Add("@ListSelect", ddlListSelect.SelectedValue);
                dataParams.Add("@School", txtSearchSchool.Text);

                Report1.ShowReportByStoredProcedure("0001364007", "dbo.USP_학사행정_입시_지원자현황_지원자조회_합격통지서_출력_업그레이드", dataParams);  //rptPassNotice
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void Print_Scholarship()
        {//장학증서 출력
            try
            {
                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@Year", txtSearchApplyYear.Text);
                dataParams.Add("@Season", ddlSearchApplySeason.SelectedValue);
                dataParams.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                dataParams.Add("@pass", ddlPass.SelectedValue);
                dataParams.Add("@Stud", txtSearchStud.Text);
                dataParams.Add("@HostelYN", ddlHostelYN.SelectedValue);
                dataParams.Add("@ListSelect", ddlListSelect.SelectedValue);
                dataParams.Add("@School", txtSearchSchool.Text);

                Report1.ShowReportByStoredProcedure("0001364006", "dbo.USP_학사행정_입시_지원자현황_지원자조회_장학증서_출력_업그레이드", dataParams);    //rptScholarship
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void Print_Tuition()
        {//등록금고지서 출력
            string pass = ddlPass.SelectedValue;
            string season = ddlSearchApplySeason.SelectedValue;

            if (pass == "01" || pass == "02" || pass == "08" || pass == "09" || pass == "19")
            {
                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_등록금고지서_출력_업그레이드";
                string reportNo = string.Empty;

                Dictionary<string, object> dataParams = new Dictionary<string, object>();
                dataParams.Add("@recpNo", txtSearchStud.Text);
                dataParams.Add("@Year", txtSearchApplyYear.Text);
                dataParams.Add("@Season", ddlSearchApplySeason.SelectedValue);
                dataParams.Add("@pass", ddlPass.SelectedValue);
                dataParams.Add("@majorCode1", ddlSearchApplyOrgID.SelectedValue);
                dataParams.Add("@HostelYN", ddlHostelYN.SelectedValue);
                dataParams.Add("@ListSelect", ddlListSelect.SelectedValue);
                dataParams.Add("@School", txtSearchSchool.Text);

                var parameters = new DataParameterCollection();
                parameters.Add("@recpNo", txtSearchStud.Text);
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@pass", ddlPass.SelectedValue);
                parameters.Add("@majorCode1", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@HostelYN", ddlHostelYN.SelectedValue);
                parameters.Add("@ListSelect", ddlListSelect.SelectedValue);
                parameters.Add("@School", txtSearchSchool.Text);


                if (rblPrintGubun.SelectedValue == "3") // 등록금 고지서(주소있음)
                {
                    if (season == "7" || season == "8")
                        reportNo = "0001364002";    //PassInfo78
                    else if (season == "9")
                        reportNo = "0001364003";    //PassInfo9
                    else if (season == "E")
                        reportNo = "0001364004";    //PassInfoE
                    else
                        reportNo = "0001364001";    //PassInfo
                }
                else if (rblPrintGubun.SelectedValue == "6")  // 등록금 고지서(주소없음)
                {
                    if (season == "7" || season == "8")
                        reportNo = "0001364011";    //PassInfo78WithoutAddress
                    else if (season == "9")
                        reportNo = "0001364012";    //PassInfo9WithoutAddress
                    else if (season == "E")
                        reportNo = "0001364013";    //PassInfoEWithoutAddress
                    else
                        reportNo = "0001364010";    //PassInfoWithoutAddress
                }

                Report1.ShowReportByStoredProcedure(reportNo, spName, dataParams);

                /*
                DataSet ds = new DataSet();
                var shell = ReportUtil.GetRDCommandShell(this);
                var dataCommands = new List<DataCommand>();

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

                        ReportInvoker1.ShowReportByPage(reportNo, ds);
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, "데이터가 없습니다.");
                    }
                }
                    //ReportInvoker1.ShowReportByStoredProcedure(reportNo, spName, dataParams);
                */
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
            if (HasGroups("67", "68", "34"))
            {
                //Dictionary<string, object> dataParams = new Dictionary<string, object>();

                //dataParams.Add("@Year", txtSearchApplyYear.Text);
                //dataParams.Add("@Season", ddlSearchApplySeason.SelectedValue);
                //dataParams.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                //dataParams.Add("@pass", ddlPass.SelectedValue);
                //dataParams.Add("@Stud", txtSearchStud.Text);

                DataSet ds = new DataSet();
                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_입학원서_출력_업그레이드";
                var parameters = new DataParameterCollection(); //ReportUtil.GetReportParameter(strParams);
                                                                //var shell = new DataCommandShell();
                var shell = ReportUtil.GetRDCommandShell(this);
                var dataCommands = new List<DataCommand>();

                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@pass", ddlPass.SelectedValue);
                parameters.Add("@Stud", txtSearchStud.Text);
                parameters.Add("@HostelYN", ddlHostelYN.SelectedValue);
                parameters.Add("@ListSelect", ddlListSelect.SelectedValue);
                parameters.Add("@School", txtSearchSchool.Text);

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

                        if (txtSearchApplyYear.Text.ToInt32() >= 2025)
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
            else
                CommonMessage.AlertMessage(this, "입시담당자 외 출력불가");
        }

        private void Print_Deposit()
        {
            string pass = ddlPass.SelectedValue;
            if (pass == "01" || pass == "02" || pass == "08" || pass == "09" || pass == "19")
            {
                DataSet ds = new DataSet();
                string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_예치금고지서_출력_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = ReportUtil.GetRDCommandShell(this);
                var dataCommands = new List<DataCommand>();

                parameters.Add("@recpNo", txtSearchStud.Text == "" ? "%" : txtSearchStud.Text.Trim());
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@pass", ddlPass.SelectedValue);
                parameters.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@HostelYN", ddlHostelYN.SelectedValue);
                parameters.Add("@ListSelect", ddlListSelect.SelectedValue);
                parameters.Add("@School", txtSearchSchool.Text);

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

                        if (rblPrintGubun.SelectedValue == "5")  // 예치금 고지서(주소있음)
                            ReportInvoker1.ShowReportByPage("0001364009", ds);
                        else if (rblPrintGubun.SelectedValue == "7") // 예치금 고지서(주소없음)
                            ReportInvoker1.ShowReportByPage("0001364014", ds);
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, "데이터가 없습니다.");
                    }

                    // 개발시
                    //ds.WriteXml("E:/예치금고지서_제목.xml");
                }
                else
                {
                    throw new HttpException(shell.ErrorMessage);
                }
            }
            else
            {
                CommonMessage.AlertMessage(this, "예치금고지서출력은 합격자, 등록자만 가능합니다.");
                return;
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

        private void SetPage(int pageNo, int totalCnt)
        {
            string currentPath = Request.Url.AbsolutePath + "?SearchApplyYear=" + HttpUtility.UrlEncode(txtSearchApplyYear.Text)
                                                          + "&SearchApplySeason=" + HttpUtility.UrlEncode(ddlSearchApplySeason.SelectedValue)
                                                          + "&SearchGubun=" + HttpUtility.UrlEncode(ddlSearchGubun.SelectedValue)
                                                          + "&SearchStud=" + HttpUtility.UrlEncode(txtSearchStud.Text)
                                                          + "&SearchHostelYN=" + HttpUtility.UrlEncode(ddlHostelYN.SelectedValue)
                                                          + "&SearchListSelect=" + HttpUtility.UrlEncode(ddlListSelect.SelectedValue)
                                                          + "&Pass=" + HttpUtility.UrlEncode(ddlPass.SelectedValue)
                                                          + "&PrintGubun=" + HttpUtility.UrlEncode(rblPrintGubun.SelectedValue)
                                                          + "&SearchApplyOrgID=" + HttpUtility.UrlEncode(ddlSearchApplyOrgID.SelectedValue)
                                                          + "&SearchSchool=" + HttpUtility.UrlEncode(txtSearchSchool.Text)
                                                          ;

            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        #endregion 메소드
    }
}