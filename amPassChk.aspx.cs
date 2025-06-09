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

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amPassChk : WebFormBase
    {
        protected int _pagePerRowCount = 20;
        protected int _pageNumber;

        private Dictionary<string, WebControl> ControlParams
        {
            get
            {
                Dictionary<string, WebControl> returnValue = new Dictionary<string, WebControl>();

                returnValue.Add("strApplyYear", txtSearchApplyYear);
                returnValue.Add("strApplySeason", ddlSearchApplySeason);
                returnValue.Add("strSearchGubun", ddlSearchGubun);
                returnValue.Add("strSearchApplyOrgID", ddlSearchApplyOrgID);
                returnValue.Add("strSearchStud", txtSearchStud);
                returnValue.Add("strPass", ddlPass);
                returnValue.Add("strSchool", txtSearchSchool);
                returnValue.Add("strPhone", txtPhone);

                return returnValue;
            }
        }

        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            grdList.RowDataBound += GrdList_RowDataBound;
            btnReBindDdl.Click += BtnReBindDdl_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
                SetControlValueByParam();
                Retrieve(true);
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txtSearchApplyYear, ddlSearchApplySeason);
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);

            lblInwon.Text = "0";
            lblApplyCnt.Text = "0";
            lblPassFirst.Text = "0";
            lblPassPlus.Text = "0";
            lblPassFirstJoin.Text = "0";
            lblPassPlusJoin.Text = "0";

            if (string.IsNullOrEmpty(txtSearchSchool.Text))
            {
                this.txtSearchSchool.Text = "";
            }

            this.ddlPass.Items.Add(new ListItem("최종등록자(최초+충원)", "31"));
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

        private void GrdList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    e.Row.Cells[24].ToolTip = e.Row.Cells[31].Text;
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void BtnReBindDdl_Click(object sender, EventArgs e)
        {
            COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);
        }

        #endregion 이벤트

        #region 메소드

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

        public void Retrieve(bool isPage)
        {
            //string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역_조회_업그레이드";
            string spName = "dbo.USP_학사행정_입시_지원자관리_지원자처리내역페이징_조회_업그레이드";
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
                parameters.Add("@Pass", ddlPass.SelectedValue);
                parameters.Add("@CurrentPage", isPage ? _pageNumber : 1);
                parameters.Add("@TotalRecord", _pagePerRowCount);
                parameters.Add("@school", txtSearchSchool.Text);
                parameters.Add("@PhoneNo", string.IsNullOrEmpty(this.txtPhone.Text) ? null : this.txtPhone.Text);
                parameters.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;
                    var outParams = dataCommands[0].ListOfParameters[0];

                    lblInwon.Text = outParams["@@RecruitmentCount"].Value.StringValue();
                    lblApplyCnt.Text = outParams["@@CNT_00"].Value.StringValue();
                    lblPassFirst.Text = outParams["@@CNT_09"].Value.StringValue();
                    lblPassPlus.Text = outParams["@@CNT_08"].Value.StringValue();
                    lblPassFirstJoin.Text = outParams["@@CNT_01"].Value.StringValue();
                    lblPassPlusJoin.Text = outParams["@@CNT_02"].Value.StringValue();
                    var totalRecord = outParams["@@TotalRecord"].Value.StringValue();

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        SetPage(isPage ? _pageNumber : 1, totalRecord.ToInt32());
                        grdList.DataBindGrid(ds, "입시지원자 리스트", "입시지원자 리스트", this.ExDataCounter1);
                        ExDataCounter1.DataCount = totalRecord.ToInt32();
                    }
                    else
                    {
                        grdList.ClearDataSource(ExDataCounter1);
                        SetPage(1, 0);
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
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

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
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

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
                dataParams.Add("@school", txtSearchSchool.Text);
                dataParams.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

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

            parameters.Add("@Year", txtSearchApplyYear.Text);
            parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
            parameters.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
            parameters.Add("@pass", ddlPass.SelectedValue);
            parameters.Add("@Stud", txtSearchStud.Text);
            parameters.Add("@school", txtSearchSchool.Text);
            parameters.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

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

        /// <summary>
        /// 예치금 고지서 출력
        /// </summary>
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

                parameters.Add("@recpNo", txtSearchStud.Text);
                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@pass", ddlPass.SelectedValue);
                parameters.Add("@Major", ddlSearchApplyOrgID.SelectedValue);
                parameters.Add("@school", txtSearchSchool.Text);
                parameters.Add("@GraduYear", string.IsNullOrEmpty(this.txtGraduYear.Text) ? null : this.txtGraduYear.Text);

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

                    // 개발시
                }
                else
                {
                    throw new HttpException(shell.ErrorMessage);
                }
            }
            else {
                CommonMessage.AlertMessage(this, "예치금고지서출력은 합격자, 등록자만 가능합니다.");
                return;
            }

        }

        #endregion 메소드
    }
}