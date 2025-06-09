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
/// 메뉴정보 : 입시 > 성적사정 > 성적사정표 출력
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.28 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class amApplicationScoreList : WebFormBase
    {
        #region 전역변수

        protected int _pagePerRowCount = 15;
        protected int _pageNumber;

        #endregion 전역변수

        private Dictionary<string, WebControl> ControlParams
        {
            get
            {
                Dictionary<string, WebControl> returnValue = new Dictionary<string, WebControl>();

                returnValue.Add("strApplyYear", txt지원연도조회);
                returnValue.Add("strApplySeason", ddl지원시기조회);
                returnValue.Add("strSearchGubun", ddl전형구분조회);
                returnValue.Add("strSearchApplyOrgID", ddl지원학과조회);
                
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
            COMMMethod.SetApplicationYearSeason(txt지원연도조회, ddl지원시기조회);
            COMMMethod.SetDDLMajorCode(ddl지원학과조회, txt지원연도조회.Text);
            COMMMethod.SetDDLSppoClsCodeWithType(ddl전형구분조회, txt지원연도조회.Text);
        }

        private void SetScriptForClientEvent()
        {
            //((Button)ExToolBar4.FindControl("Save")).Attributes["onClick"] = "return SaveEventHandler();";
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
                        var paramValue = HttpUtility.UrlDecode(Request.Params[kv.Key]);
                        bindableControl.SetValue(paramValue);
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
                var parmaValue = $"{GetValue(kv.Value)}";
                //parmaValue = (parmaValue == "%" ? string.Empty : parmaValue);

                if (kv.Key == ControlParams.LastOrDefault().Key)
                {
                    currentPath.Append($"{kv.Key}={parmaValue}");
                }
                else
                {
                    currentPath.Append($"{kv.Key}={parmaValue}&");
                }
            }

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
            switch (ddl지원시기조회.SelectedValue)
            {
                case "9":
                case "E":
                case "I":
                case "H":
                    Print1();       //sp : APL_Select_applicationMasterInterViewList(Year, Season, major(""), Neis(""))
                    break;

                default:
                    Print2();       //sp : APL_Select_applicationMasterScoreList(Year, Season, pass(09))
                    break;
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
        }

        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        public void Retrieve(bool isPage)
        {
            DataSet ds = null;
            //string spName = "dbo.USP_학사행정_입시_성적사정_성작사정표출력_조회_업그레이드";
            string spName = "dbo.USP_학사행정_입시_성적사정_성작사정표출력페이징_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", this.txt지원연도조회.Text.Trim());
                parameters.Add("@season", this.ddl지원시기조회.SelectedValue);
                parameters.Add("@sppoClsCode", this.ddl전형구분조회.SelectedValue);
                parameters.Add("@majorCode", this.ddl지원학과조회.SelectedValue);
                parameters.Add("@CurrentPage", isPage ? _pageNumber : 1);
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
                            // Do something
                            SetPage(isPage ? _pageNumber : 1, totalRecord.ToInt32());
                            this.grdList.DataBindGrid(ds, this.ExDataCounter1);
                            ExDataCounter1.DataCount = totalRecord.ToInt32();
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
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }
        }

        private void Print1()
        {
            string season = ddl지원시기조회.SelectedValue;
            string spName = "dbo.USP_학사행정_입시_성적사정_성적사정표출력_출력2_업그레이드";
            Dictionary<string, object> dataParams = new Dictionary<string, object>();
            dataParams.Add("Year", txt지원연도조회.Text);
            dataParams.Add("Season", ddl지원시기조회.SelectedValue);
			dataParams.Add("Type", ddl전형구분조회.SelectedValue);
			dataParams.Add("Major", ddl지원학과조회.SelectedValue);
			//dataParams.Add("major", "");
            dataParams.Add("Neis", "");

            if (season == "9" || season == "E")
                rv1.ShowReportByStoredProcedure("0001436001", spName, dataParams);    //rptamAppicationScoreListInterView9_1
            //else if (season == "E")
            //    Report1.ShowReportByStoredProcedure("", spName, dataParams);    //rptamAppicationScoreListInterViewE_1
            else if (season == "I" || season == "H")
                rv1.ShowReportByStoredProcedure("0001436002", spName, dataParams);    //rptamAppicationScoreListInterViewI
        }

        private void Print2()
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_성적사정표출력_출력_업그레이드";
            string season = ddl지원시기조회.SelectedValue;

            Dictionary<string, object> dataParams = new Dictionary<string, object>();
            dataParams.Add("Year", txt지원연도조회.Text);
            dataParams.Add("Season", ddl지원시기조회.SelectedValue);
			dataParams.Add("Type", ddl전형구분조회.SelectedValue);
			dataParams.Add("Major", ddl지원학과조회.SelectedValue);
            //dataParams.Add("pass", "09");

            if (season == "8")
                rv1.ShowReportByStoredProcedure("0001436003", spName, dataParams);    //rptamAppicationScoreList_8
            else if (season == "7")
                rv1.ShowReportByStoredProcedure("0001436004", spName, dataParams);    //rptamAppicationScoreList_7
            else if (season == "B")
                rv1.ShowReportByStoredProcedure("0001436005", spName, dataParams);    //rptamAppicationScoreList_B
            else
            {
                if(txt지원연도조회.Text == "2019")
                    rv1.ShowReportByStoredProcedure("0001436007", spName, dataParams);    //rptamAppicationScoreList1101_2019
                else
                    rv1.ShowReportByStoredProcedure("0001436006", spName, dataParams);    //rptamAppicationScoreList1101
            }
        }

        #endregion 메소드
    }
}