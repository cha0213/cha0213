using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace KJC.IMS.ENTR.StaffMngr
{
    public partial class ApplScoreUpload : WebFormBase
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

                if (!string.IsNullOrEmpty(Request["year"]))
                {
                    this.txt연도조회.Text = HttpUtility.UrlDecode(Request["year"] as string);
                }
                if (!string.IsNullOrEmpty(Request["recpNo"]))
                {
                    this.txt수험번호조회.Text = HttpUtility.UrlDecode(Request["recpNo"] as string);
                }

                if (string.IsNullOrEmpty(this.txt연도조회.Text))
                {
                    CommonMessage.AlertMessage(this, "학생을 선택하고 업로드하시기 바랍니다.");
                    ExToolBar1.Visible = false;
                    ExToolBar2.Visible = false;
                    return;
                }

                if (string.IsNullOrEmpty(this.txt수험번호조회.Text))
                {
                    CommonMessage.AlertMessage(this, "학생을 선택하고 업로드하시기 바랍니다.");
                    ExToolBar1.Visible = false;
                    ExToolBar2.Visible = false;
                    return;
                }

            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트
        
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            try
            {

                string ErrorRow = string.Empty;

                if (this.grdList.Rows.Count == 0)
                {
                    CommonMessage.AlertMessage(this, "저장 할 업로드 내역이 없습니다.<br/> 파일을 선택 후 [엑셀 내용 확인] 버튼을 클릭하여 저장할 내역을 확인하세요.");
                    return;
                }


                    string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2021입시이후_성적_파일등록_업그레이드";
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    parameters.Add("@State", "C");
                    parameters.Add("@ApplYear", txt연도조회.Text);
                    parameters.Add("@recpNo", txt수험번호조회.Text);

                    shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        this.DeleteItem();
                        CommonMessage.AlertMessage(this, 202);
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
        
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            try
            {
                this.DeleteItem();

                if (this.upload_file.PostedFile != null && this.upload_file.PostedFile.ContentLength > 0)
                {
                    HttpPostedFile file = Request.Files[upload_file.Name];
                    DataTable dt = Util.ExcelImportDataTable(this, file.InputStream);
                    int rowsCount = dt.Rows.Count;
                    // 엑셀내용 확인

                    // 편제구분 확인
                    DataTable dtReductionDiv = CodeUtil.GetCommonCode("SA07").Tables[0];

                    /*
                    int iIdx = 2;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if( iIdx <= rowsCount)
                        { 
                            string ReductionDivName = Util.GetDataRowString(dr[4]);

                            if (ReductionDivName != string.Empty)
                            {
                                DataRow[] arrRow = dtReductionDiv.Select("CodeName='" + ReductionDivName + "'");

                                if (arrRow.Length == 0)
                                {    
                                        CommonMessage.AlertMessage(this, "편제명 내용 중 [" + ReductionDivName + "]이 존재 합니다. 확인 바랍니다.(엑셀 행 " + iIdx.ToString() + "번째)");
                                        return;     
                                }
                           
                            }
                            else
                            {
                                CommonMessage.AlertMessage(this, "편제명이 없습니다. 확인 바랍니다.(엑셀 행 " + iIdx.ToString() + "번째)");
                                return;
                            }

                        }
                        iIdx++;
                    }
                    */

                    int iIdx = 2;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (iIdx <= rowsCount)
                        {
                            string Year = Util.GetDataRowString(dr[0]);
                            string Grade = Util.GetDataRowString(dr[1]);
                            string Term = Util.GetDataRowString(dr[2]);
                            string Unit = Util.GetDataRowString(dr[3]);
                            string OrganizationName = Util.GetDataRowString(dr[4]);
                            string SubjectName = Util.GetDataRowString(dr[5]);
                            string OriginalScore = Util.GetDataRowString(dr[6]);
                            string AvgScore = Util.GetDataRowString(dr[7]);
                            string StandardDeviation = Util.GetDataRowString(dr[8]);
                            string RankingGrade = Util.GetDataRowString(dr[9]);

                            if (string.IsNullOrEmpty(Year) || string.IsNullOrEmpty(Grade) || string.IsNullOrEmpty(Term) || string.IsNullOrEmpty(OrganizationName) || string.IsNullOrEmpty(SubjectName) || string.IsNullOrEmpty(OriginalScore) || string.IsNullOrEmpty(AvgScore) || string.IsNullOrEmpty(StandardDeviation) || string.IsNullOrEmpty(RankingGrade))
                            {
                                CommonMessage.AlertMessage(this, "빈 칸이 있는 행이 존재 합니다. 확인 바랍니다.(엑셀 행 " + iIdx.ToString() + "번째)");
                                return;
                            }
                        }
                        iIdx++;
                    }

                    string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2021입시이후_성적_파일등록_업그레이드";
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    string PassTypeCode = string.Empty;

                    iIdx = 2;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (iIdx <= rowsCount)
                        {

                            string Year = Util.GetDataRowString(dr[0]);
                            string Grade = Util.GetDataRowString(dr[1]);
                            string Term = Util.GetDataRowString(dr[2]);
                            string Unit = Util.GetDataRowString(dr[3]);
                            string OrganizationName = Util.GetDataRowString(dr[4]);
                            string SubjectName = Util.GetDataRowString(dr[5]);
                            string OriginalScore = Util.GetDataRowString(dr[6]);
                            string AvgScore = Util.GetDataRowString(dr[7]);
                            string StandardDeviation = Util.GetDataRowString(dr[8]);
                            string RankingGrade = Util.GetDataRowString(dr[9]);


                            if (string.IsNullOrWhiteSpace(dr[0].ToString())) continue;

                            parameters = new DataParameterCollection();

                            parameters.Add("@State", "T");

                            parameters.Add("@ApplYear", txt연도조회.Text);
                            parameters.Add("@recpNo", txt수험번호조회.Text);
                            parameters.Add("@Year",  Year);
                            parameters.Add("@Grade", Grade);
                            parameters.Add("@Term", Term);
                            parameters.Add("@OrganizationName", OrganizationName);
                            parameters.Add("@SubjectName", SubjectName);
                            parameters.Add("@Unit", Unit);
                            parameters.Add("@OriginalScore", OriginalScore);
                            parameters.Add("@AvgScore", AvgScore);
                            parameters.Add("@StandardDeviation", StandardDeviation);
                            parameters.Add("@RankingGrade", RankingGrade);
                            parameters.Add("@ProcessID", UserId);
                            parameters.Add("@ProcessIP", UserIp);


                            shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                            
                        }
                        iIdx++;
                    }

                    dataCommands = shell.Execute();
                    if (shell.ErrorCode == 0)
                    {
                        //CommonMessage.AlertMessage(this, "파일 업로드가 완료 되었습니다");
                        this.Retrieve();
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, shell.ErrorMessage);
                    }
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.Message);
            }
        }

        #endregion 이벤트

        #region 메소드

        private void Retrieve()
        {
            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2021입시이후_성적_파일조회_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@ApplYear", txt연도조회.Text);
                parameters.Add("@recpNo", txt수험번호조회.Text);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    grdList.DataBindGrid(ds, "과목리스트", "성적관리", ExDataCounter);
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

        private void DeleteItem()
        {
            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력2021입시이후_성적_파일등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@STATE", "D");
                parameters.Add("@ApplYear", txt연도조회.Text);
                parameters.Add("@recpNo", txt수험번호조회.Text);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);

                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    //CommonMessage.AlertMessage(this, 203);
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

        #endregion 메소드
    }
}