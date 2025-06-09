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
    public partial class highSchoolScoreInput6 : WebFormBase
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
                if (!string.IsNullOrEmpty(Request["Season"]))
                {
                    ddlSearchApplSeason.SelectedValue = HttpUtility.UrlDecode(Request["Season"] as string);
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

                this.RetrieveAttendance(true);

            }
            this.SetScriptForClientEvent();

            btnUpload.Attributes.Add("onClick", "return OpenModal();");
        }

        private void InitPageSetting()
        {
            try
            {
                /*
                DataSet ds = new COMMBiz().GetApplicationConfig();

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    txt연도조회.Text = ds.Tables[0].Rows[0]["ApplYear"] == DBNull.Value ? string.Empty : ds.Tables[0].Rows[0]["ApplYear"].ToString();
                }
                */

                // 지원연도, 지원시기 셋팅
                COMMMethod.SetApplicationYearSeason(txt연도조회, ddlSearchApplSeason);
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
            this.RetrieveAttendance(false);
            this.ClearDetail("CUD");
        }

        /// <summary>
        /// 저장 버튼 클릭 시 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            if (((Button)sender).Parent.ID.Equals(ExToolBar2.ID))
            {
                // 상세정보 입력항목 저장
                this.SaveAttendance();
            }
            else
            {
                // 상세정보 입력항목 저장
                //this.SaveScore();
            }
        }

        /// <summary>
        /// 삭제 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007입시이전_성적_삭제_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                foreach (GridViewRow item in grdList3.Rows)
                {
                    parameters = new DataParameterCollection();

                    if (COMMCommon.IsDataItem(item.RowType))
                    {
                        if (((CheckBox)item.Cells[16].Controls[1]).Checked)
                        {
                            parameters.Add("@year", this.hdnYear.Value);
                            parameters.Add("@recpNo", this.hdnRecpNo.Value);
                            parameters.Add("@SeqNumber", item.Cells[15].Text.Trim());

                            shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                        }
                    }
                }

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    RetrieveScore();
                    this.ClearDetail("CUDscore");
                    CommonMessage.AlertMessage(this, 203);
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

                RetrieveScore();
            }
        }

        protected void grdList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridView gv = (GridView)sender;
            var rowIndex = gv.SelectedIndex;
            if (rowIndex >= 0)
            {
                SetControlValue(gv, rowIndex, "CUDscore");
            }
        }


        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void RetrieveAttendance(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007입시이전_출석_조회_업그레이드"; //2007학년이전 프로시저와 동일
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@year", this.txt연도조회.Text.Trim());
                parameters.Add("@ApplSeason", ddlSearchApplSeason.SelectedValue);
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

            /*
            ds = null;
            spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2021입시이후_성적_조회_업그레이드"; //2007학년이전 프로시저와 동일
            parameters = new DataParameterCollection();
            shell = new DataCommandShell();
            dataCommands = new List<DataCommand>();

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
                            this.grdList3.DataBindGrid(ds, this.ExDataCounter3);
                            ExDataCounter3.DataCount = strTotalCount.ToInt32(); //ds.Tables[0].Rows.Count;
                        }
                        else
                        {
                            this.grdList3.ClearDataSource();
                            ExDataCounter3.DataCount = 0;
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
            */
        }

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void RetrieveScore()
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007입시이전_성적_조회_업그레이드"; //2007학년이전 프로시저와 동일
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {

                parameters.Add("@year", this.hdnYear.Value);
                parameters.Add("@recpNo", this.hdnRecpNo.Value);
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
                            ExDataCounter3.DataCount = strTotalCount.ToInt32(); //ds.Tables[0].Rows.Count;

                            this.grdList3.DataSource = ds;
                            this.grdList3.DataBind();
                        }
                        else
                        {
                            this.grdList3.ClearDataSource();
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
        private void SaveAttendance()
        {

            #region 저장 전 입력 값 체크
            string year = string.Empty;
            string recpNo = string.Empty;

            year = this.hdnYear.Value;
            recpNo = this.hdnRecpNo.Value;

            int absence_Disease_1, absence_Accident_1, absence_Etc_1;
            int absence_Disease_2, absence_Accident_2, absence_Etc_2;
            int absence_Disease_3, absence_Accident_3, absence_Etc_3;

            int lateness_Disease_1, lateness_Accident_1, lateness_Etc_1;
            int lateness_Disease_2, lateness_Accident_2, lateness_Etc_2;
            int lateness_Disease_3, lateness_Accident_3, lateness_Etc_3;

            int earlyLeaving_Disease_1, earlyLeaving_Accident_1, earlyLeaving_Etc_1;
            int earlyLeaving_Disease_2, earlyLeaving_Accident_2, earlyLeaving_Etc_2;
            int earlyLeaving_Disease_3, earlyLeaving_Accident_3, earlyLeaving_Etc_3;

            int result_Disease_1, result_Accident_1, result_Etc_1;
            int result_Disease_2, result_Accident_2, result_Etc_2;
            int result_Disease_3, result_Accident_3, result_Etc_3;


            /*   if (this.txtAbsence_Accident_1.Text.ToString().Trim() == "") absence_Accident_1 = 0;
                 else absence_Accident_1 = Convert.ToInt32(this.txtAbsence_Accident_1.Text);

                 if (this.txtAbsence_Accident_2.Text.ToString().Trim() == "") absence_Accident_2 = 0;
                 else absence_Accident_2 = Convert.ToInt32(this.txtAbsence_Accident_2.Text);

                 if (this.txtAbsence_Accident_3.Text.ToString().Trim() == "") absence_Accident_3 = 0;
                 else absence_Accident_3 = Convert.ToInt32(this.txtAbsence_Accident_3.Text);

                 if (this.txtLateness_Accident_1.Text.ToString().Trim() == "") lateness_Accident_1 = 0;
                 else lateness_Accident_1 = Convert.ToInt32(this.txtLateness_Accident_1.Text);

                 if (this.txtLateness_Accident_2.Text.ToString().Trim() == "") lateness_Accident_2 = 0;
                 else lateness_Accident_2 = Convert.ToInt32(this.txtLateness_Accident_2.Text);

                 if (this.txtLateness_Accident_3.Text.ToString().Trim() == "") lateness_Accident_3 = 0;
                 else lateness_Accident_3 = Convert.ToInt32(this.txtLateness_Accident_3.Text);

                 if (this.txtEarlyLeaving_Accident_1.Text.ToString().Trim() == "") earlyLeaving_Accident_1 = 0;
                 else earlyLeaving_Accident_1 = Convert.ToInt32(this.txtEarlyLeaving_Accident_1.Text);

                 if (this.txtEarlyLeaving_Accident_2.Text.ToString().Trim() == "") earlyLeaving_Accident_2 = 0;
                 else earlyLeaving_Accident_2 = Convert.ToInt32(this.txtEarlyLeaving_Accident_2.Text);

                 if (this.txtEarlyLeaving_Accident_3.Text.ToString().Trim() == "") earlyLeaving_Accident_3 = 0;
                 else earlyLeaving_Accident_3 = Convert.ToInt32(this.txtEarlyLeaving_Accident_3.Text);

                 if (this.txtResult_Accident_1.Text.ToString().Trim() == "") result_Accident_1 = 0;
                 else result_Accident_1 = Convert.ToInt32(this.txtResult_Accident_1.Text);

                 if (this.txtResult_Accident_2.Text.ToString().Trim() == "") result_Accident_2 = 0;
                 else result_Accident_2 = Convert.ToInt32(this.txtResult_Accident_2.Text);


                 if (this.txtResult_Accident_3.Text.ToString().Trim() == "") result_Accident_3 = 0;
                 else result_Accident_3 = Convert.ToInt32(this.txtResult_Accident_3.Text); */

            if (this.txtAbsence_Disease_1.Text.ToString().Trim() == "")
                absence_Disease_1 = 0;
            else absence_Disease_1 = Convert.ToInt32(this.txtAbsence_Disease_1.Text);

            if (this.txtAbsence_Accident_1.Text.ToString().Trim() == "") absence_Accident_1 = 0;
            else absence_Accident_1 = Convert.ToInt32(this.txtAbsence_Accident_1.Text);

            if (this.txtAbsence_Etc_1.Text.ToString().Trim() == "") absence_Etc_1 = 0;
            else absence_Etc_1 = Convert.ToInt32(this.txtAbsence_Etc_1.Text);


            if (this.txtAbsence_Disease_2.Text.ToString().Trim() == "") absence_Disease_2 = 0;
            else absence_Disease_2 = Convert.ToInt32(this.txtAbsence_Disease_2.Text);

            if (this.txtAbsence_Accident_2.Text.ToString().Trim() == "") absence_Accident_2 = 0;
            else absence_Accident_2 = Convert.ToInt32(this.txtAbsence_Accident_2.Text);

            if (this.txtAbsence_Etc_2.Text.ToString().Trim() == "") absence_Etc_2 = 0;
            else absence_Etc_2 = Convert.ToInt32(this.txtAbsence_Etc_2.Text);


            if (this.txtAbsence_Disease_3.Text.ToString().Trim() == "") absence_Disease_3 = 0;
            else absence_Disease_3 = Convert.ToInt32(this.txtAbsence_Disease_3.Text);

            if (this.txtAbsence_Accident_3.Text.ToString().Trim() == "") absence_Accident_3 = 0;
            else absence_Accident_3 = Convert.ToInt32(this.txtAbsence_Accident_3.Text);

            if (this.txtAbsence_Etc_3.Text.ToString().Trim() == "") absence_Etc_3 = 0;
            else absence_Etc_3 = Convert.ToInt32(this.txtAbsence_Etc_3.Text);


            if (this.txtLateness_Disease_1.Text.ToString().Trim() == "") lateness_Disease_1 = 0;
            else lateness_Disease_1 = Convert.ToInt32(this.txtLateness_Disease_1.Text);

            if (this.txtLateness_Accident_1.Text.ToString().Trim() == "") lateness_Accident_1 = 0;
            else lateness_Accident_1 = Convert.ToInt32(this.txtLateness_Accident_1.Text);

            if (this.txtLateness_Etc_1.Text.ToString().Trim() == "") lateness_Etc_1 = 0;
            else lateness_Etc_1 = Convert.ToInt32(this.txtLateness_Etc_1.Text);


            if (this.txtLateness_Disease_2.Text.ToString().Trim() == "") lateness_Disease_2 = 0;
            else lateness_Disease_2 = Convert.ToInt32(this.txtLateness_Disease_2.Text);

            if (this.txtLateness_Accident_2.Text.ToString().Trim() == "") lateness_Accident_2 = 0;
            else lateness_Accident_2 = Convert.ToInt32(this.txtLateness_Accident_2.Text);

            if (this.txtLateness_Etc_2.Text.ToString().Trim() == "") lateness_Etc_2 = 0;
            else lateness_Etc_2 = Convert.ToInt32(this.txtLateness_Etc_2.Text);


            if (this.txtLateness_Disease_3.Text.ToString().Trim() == "") lateness_Disease_3 = 0;
            else lateness_Disease_3 = Convert.ToInt32(this.txtLateness_Disease_3.Text);

            if (this.txtLateness_Accident_3.Text.ToString().Trim() == "") lateness_Accident_3 = 0;
            else lateness_Accident_3 = Convert.ToInt32(this.txtLateness_Accident_3.Text);

            if (this.txtLateness_Etc_3.Text.ToString().Trim() == "") lateness_Etc_3 = 0;
            else lateness_Etc_3 = Convert.ToInt32(this.txtLateness_Etc_3.Text);


            if (this.txtEarlyLeaving_Disease_1.Text.ToString().Trim() == "") earlyLeaving_Disease_1 = 0;
            else earlyLeaving_Disease_1 = Convert.ToInt32(this.txtEarlyLeaving_Disease_1.Text);

            if (this.txtEarlyLeaving_Accident_1.Text.ToString().Trim() == "") earlyLeaving_Accident_1 = 0;
            else earlyLeaving_Accident_1 = Convert.ToInt32(this.txtEarlyLeaving_Accident_1.Text);

            if (this.txtEarlyLeaving_Etc_1.Text.ToString().Trim() == "") earlyLeaving_Etc_1 = 0;
            else earlyLeaving_Etc_1 = Convert.ToInt32(this.txtEarlyLeaving_Etc_1.Text);


            if (this.txtEarlyLeaving_Disease_2.Text.ToString().Trim() == "") earlyLeaving_Disease_2 = 0;
            else earlyLeaving_Disease_2 = Convert.ToInt32(this.txtEarlyLeaving_Disease_2.Text);

            if (this.txtEarlyLeaving_Accident_2.Text.ToString().Trim() == "") earlyLeaving_Accident_2 = 0;
            else earlyLeaving_Accident_2 = Convert.ToInt32(this.txtEarlyLeaving_Accident_2.Text);

            if (this.txtEarlyLeaving_Etc_2.Text.ToString().Trim() == "") earlyLeaving_Etc_2 = 0;
            else earlyLeaving_Etc_2 = Convert.ToInt32(this.txtEarlyLeaving_Etc_2.Text);


            if (this.txtEarlyLeaving_Disease_3.Text.ToString().Trim() == "") earlyLeaving_Disease_3 = 0;
            else earlyLeaving_Disease_3 = Convert.ToInt32(this.txtEarlyLeaving_Disease_3.Text);

            if (this.txtEarlyLeaving_Accident_3.Text.ToString().Trim() == "") earlyLeaving_Accident_3 = 0;
            else earlyLeaving_Accident_3 = Convert.ToInt32(this.txtEarlyLeaving_Accident_3.Text);

            if (this.txtEarlyLeaving_Etc_3.Text.ToString().Trim() == "") earlyLeaving_Etc_3 = 0;
            else earlyLeaving_Etc_3 = Convert.ToInt32(this.txtEarlyLeaving_Etc_3.Text);


            if (this.txtResult_Disease_1.Text.ToString().Trim() == "") result_Disease_1 = 0;
            else result_Disease_1 = Convert.ToInt32(this.txtResult_Disease_1.Text);

            if (this.txtResult_Accident_1.Text.ToString().Trim() == "") result_Accident_1 = 0;
            else result_Accident_1 = Convert.ToInt32(this.txtResult_Accident_1.Text);

            if (this.txtResult_Etc_1.Text.ToString().Trim() == "") result_Etc_1 = 0;
            else result_Etc_1 = Convert.ToInt32(this.txtResult_Etc_1.Text);


            if (this.txtResult_Disease_2.Text.ToString().Trim() == "") result_Disease_2 = 0;
            else result_Disease_2 = Convert.ToInt32(this.txtResult_Disease_2.Text);

            if (this.txtResult_Accident_2.Text.ToString().Trim() == "") result_Accident_2 = 0;
            else result_Accident_2 = Convert.ToInt32(this.txtResult_Accident_2.Text);

            if (this.txtResult_Etc_2.Text.ToString().Trim() == "") result_Etc_2 = 0;
            else result_Etc_2 = Convert.ToInt32(this.txtResult_Etc_2.Text);


            if (this.txtResult_Disease_3.Text.ToString().Trim() == "") result_Disease_3 = 0;
            else result_Disease_3 = Convert.ToInt32(this.txtResult_Disease_3.Text);

            if (this.txtResult_Accident_3.Text.ToString().Trim() == "") result_Accident_3 = 0;
            else result_Accident_3 = Convert.ToInt32(this.txtResult_Accident_3.Text);

            if (this.txtResult_Etc_3.Text.ToString().Trim() == "") result_Etc_3 = 0;
            else result_Etc_3 = Convert.ToInt32(this.txtResult_Etc_3.Text);

            #endregion

            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2007입시이전_출석_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                #region 파라미터 설정
               parameters.Add("@year", year);
                parameters.Add("@recpNo", recpNo);

                /* parameters.Add("@absence_1", absence_Accident_1);
                   parameters.Add("@absence_2", absence_Accident_2);
                   parameters.Add("@absence_3", absence_Accident_3);

                   parameters.Add("@lateness_1", lateness_Accident_1);
                   parameters.Add("@lateness_2", lateness_Accident_2);
                   parameters.Add("@lateness_3", lateness_Accident_3);

                   parameters.Add("@earlyLeaving_1", earlyLeaving_Accident_1);
                   parameters.Add("@earlyLeaving_2", earlyLeaving_Accident_2);
                   parameters.Add("@earlyLeaving_3", earlyLeaving_Accident_3);

                   parameters.Add("@result_1", result_Accident_1);
                   parameters.Add("@result_2", result_Accident_2);
                   parameters.Add("@result_3", result_Accident_3);*/
                parameters.Add("@absence_Disease_1", absence_Disease_1);
                parameters.Add("@absence_Accident_1", absence_Accident_1);
                parameters.Add("@absence_Etc_1", absence_Etc_1);
                parameters.Add("@absence_Disease_2", absence_Disease_2);
                parameters.Add("@absence_Accident_2", absence_Accident_2);
                parameters.Add("@absence_Etc_2", absence_Etc_2);
                parameters.Add("@absence_Disease_3", absence_Disease_3);
                parameters.Add("@absence_Accident_3", absence_Accident_3);
                parameters.Add("@absence_Etc_3", absence_Etc_3);

                parameters.Add("@lateness_Disease_1", lateness_Disease_1);
                parameters.Add("@lateness_Accident_1", lateness_Accident_1);
                parameters.Add("@lateness_Etc_1", lateness_Etc_1);
                parameters.Add("@lateness_Disease_2", lateness_Disease_2);
                parameters.Add("@lateness_Accident_2", lateness_Accident_2);
                parameters.Add("@lateness_Etc_2", lateness_Etc_2);
                parameters.Add("@lateness_Disease_3", lateness_Disease_3);
                parameters.Add("@lateness_Accident_3", lateness_Accident_3);
                parameters.Add("@lateness_Etc_3", lateness_Etc_3);

                parameters.Add("@earlyLeaving_Disease_1", earlyLeaving_Disease_1);
                parameters.Add("@earlyLeaving_Accident_1", earlyLeaving_Accident_1);
                parameters.Add("@earlyLeaving_Etc_1", earlyLeaving_Etc_1);
                parameters.Add("@earlyLeaving_Disease_2", earlyLeaving_Disease_2);
                parameters.Add("@earlyLeaving_Accident_2", earlyLeaving_Accident_2);
                parameters.Add("@earlyLeaving_Etc_2", earlyLeaving_Etc_2);
                parameters.Add("@earlyLeaving_Disease_3", earlyLeaving_Disease_3);
                parameters.Add("@earlyLeaving_Accident_3", earlyLeaving_Accident_3);
                parameters.Add("@earlyLeaving_Etc_3", earlyLeaving_Etc_3);

                parameters.Add("@result_Disease_1", result_Disease_1);
                parameters.Add("@result_Accident_1", result_Accident_1);
                parameters.Add("@result_Etc_1", result_Etc_1);
                parameters.Add("@result_Disease_2", result_Disease_2);
                parameters.Add("@result_Accident_2", result_Accident_2);
                parameters.Add("@result_Etc_2", result_Etc_2);
                parameters.Add("@result_Disease_3", result_Disease_3);
                parameters.Add("@result_Accident_3", result_Accident_3);
                parameters.Add("@result_Etc_3", result_Etc_3);

                parameters.Add("@ProcessID", UserId);
                parameters.Add("@ProcessIP", UserIp); 
                #endregion

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.RetrieveAttendance(false);
                    ClearDetail("CUD");
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
                                + "&korName=" + HttpUtility.UrlEncode(this.txt성명조회.Text.Trim());
            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }

        /// <summary>
        /// 입력항목 초기화
        /// </summary>
        private void ClearDetail(string type)
        {
            try
            {
                if (type == "CUD")
                {
                    ResetControlsValue("CUD");
                    ResetControlsValue("CUDscore");
                    grdList3.ClearDataSource();

                    this.hdnYear.Value = string.Empty;
                    this.hdnRecpNo.Value = string.Empty;
                }
                if (type == "CUDscore")
                {
                    ResetControlsValue("CUDscore");
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드

    }
}