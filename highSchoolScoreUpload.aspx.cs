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
using System.Web.UI.HtmlControls;
using System.Data.SQLite;

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreUpload : WebFormBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.InitPageSetting();
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            string ApplYear = Convert.ToString(Request["ApplYear"]);
            string ApplSeason = Convert.ToString(Request["ApplSeason"]);

            txtApplyYear.Text = ApplYear;
            ddlApplSeason.SelectedValue = ApplSeason;
        }

        private void SetScriptForClientEvent()
        {
        }

        #region 이벤트

        /// <summary>
        /// 파일 업로드 버튼 클릭 시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            try
            {
                if (this.upload_file.PostedFile != null && this.upload_file.PostedFile.ContentLength > 0)
                {
                    // 파일을 서버에 저장
                    string FilePath = this.SaveFile(this.upload_file);
                    //string strConn = @"Data Source=C:\WORK\KJC.IDINO\src\WebApplication\ENTR\StaffMngr\UploadTemp\StudentCarrer.db3;Initial Catalog=sqlite;Integrated Security=True;Max Pool Size=10";
                    string strConn = @"Data Source={0};Initial Catalog=sqlite;Integrated Security=True;Max Pool Size=10";
                    strConn = string.Format(strConn, FilePath);

                    //SQLiteDataAdapter 클래스를 이용 비연결 모드로 데이타 읽기
                    DataSet ds = new DataSet();
                    string sql = string.Empty;
                    SQLiteDataAdapter adpt = null;
                    //string[] arrTableName = new string[] { "StudentBaseInfo",   "PersonalInfo",     "StudyHistory",     "AttendingSchool",  "PrizeHistory",             "Qualification",
                    //                                       "NCSComptSittn",     "CareerGuidance",   "CreativeActivity", "SpecialActivity",  "CreativeExperActivity",    "ServiceActivity",
                    //                                       "ExperienceActivity","SubjectScore",     "LastYearScore",    "DetailAbility",    "ReadingActivity",  "TeacherComment", "CorrectionList"
                    //                                      };
                    //string[] arrTableName = new string[] { "StudentBaseInfo",   "PersonalInfo",     "StudyHistory",     "AttendingSchool",  "PrizeHistory",             "Qualification",
                    //                                       "CareerGuidance",   "CreativeActivity", "SpecialActivity",  "CreativeExperActivity",    "ServiceActivity",
                    //                                       "ExperienceActivity","SubjectScore",     "LastYearScore",    "DetailAbility",    "ReadingActivity",  "TeacherComment", "CorrectionList"
                    //                                      };

                    //string[] arrTableName = new string[] { "StudentBaseInfo",   "PersonalInfo",     "AttendingSchool",   "SubjectScore"
                    //                                      };

                    //string[] arrSPName = new string[] {  "USP_학사행정_입시_성적사정_고교학생부이관_기본정보_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_인적사항_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_학적사항_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_출결사항_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_수상경력_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_자격증_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_국가직무능력표준_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_진로지도상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_창의적재량활동상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_특별활동상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_창의적체험활동상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_봉사활동실적_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_교외체험학습상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_교과학습발달상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_과년도성적_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_세부능력_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_독서활동상황_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_행동특성_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_정정대장_등록_업그레이드"
                    //                                   };

                    //string[] arrSPName = new string[] {  "USP_학사행정_입시_성적사정_고교학생부이관_기본정보_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_인적사항_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_학적사항_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_출결사항_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_수상경력_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_자격증_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_진로지도상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_창의적재량활동상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_특별활동상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_창의적체험활동상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_봉사활동실적_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_교외체험학습상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_교과학습발달상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_과년도성적_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_세부능력_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_독서활동상황_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_행동특성_등록_업그레이드"
                    //                                                   ,"USP_학사행정_입시_성적사정_고교학생부이관_정정대장_등록_업그레이드"
                    //                                                  };
                    //string[] arrSPName = new string[] {  "USP_학사행정_입시_성적사정_고교학생부이관_기본정보_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_인적사항_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_출결사항_등록_업그레이드"
                    //                                    ,"USP_학사행정_입시_성적사정_고교학생부이관_교과학습발달상황_등록_업그레이드"
                    //                                   };
                    string[] arrTableName = new string[18];
                    arrTableName[0] = chkGubun1.Checked ? "StudentBaseInfo" : string.Empty;
                    arrTableName[1] = chkGubun2.Checked ? "PersonalInfo" : string.Empty;
                    arrTableName[2] = chkGubun3.Checked ? "AttendingSchool" : string.Empty;
                    arrTableName[3] = chkGubun4.Checked ? "SubjectScore" : string.Empty;
                    arrTableName[4] = chkGubun5.Checked ? "StudyHistory" : string.Empty;
                    arrTableName[5] = chkGubun6.Checked ? "PrizeHistory" : string.Empty;
                    arrTableName[6] = chkGubun7.Checked ? "Qualification" : string.Empty;
                    arrTableName[7] = chkGubun8.Checked ? "CareerGuidance" : string.Empty;
                    arrTableName[8] = chkGubun9.Checked ? "CreativeActivity" : string.Empty;
                    arrTableName[9] = chkGubun10.Checked ? "SpecialActivity" : string.Empty;
                    arrTableName[10] = chkGubun11.Checked ? "CreativeExperActivity" : string.Empty;
                    arrTableName[11] = chkGubun12.Checked ? "ServiceActivity" : string.Empty;
                    arrTableName[12] = chkGubun13.Checked ? "ExperienceActivity" : string.Empty;
                    arrTableName[13] = chkGubun14.Checked ? "LastYearScore" : string.Empty;
                    arrTableName[14] = chkGubun15.Checked ? "DetailAbility" : string.Empty;
                    arrTableName[15] = chkGubun16.Checked ? "ReadingActivity" : string.Empty;
                    arrTableName[16] = chkGubun17.Checked ? "TeacherComment" : string.Empty;
                    arrTableName[17] = chkGubun18.Checked ? "CorrectionList" : string.Empty;

                    string[] arrSpName = new string[18];
                    arrSpName[0] = chkGubun1.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_기본정보_등록_업그레이드" : string.Empty;
                    arrSpName[1] = chkGubun2.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_인적사항_등록_업그레이드" : string.Empty;
                    arrSpName[2] = chkGubun3.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_출결사항_등록_업그레이드" : string.Empty;
                    arrSpName[3] = chkGubun4.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_교과학습발달상황_등록_업그레이드" : string.Empty;
                    arrSpName[4] = chkGubun5.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_학적사항_등록_업그레이드" : string.Empty;
                    arrSpName[5] = chkGubun6.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_수상경력_등록_업그레이드" : string.Empty;
                    arrSpName[6] = chkGubun7.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_자격증_등록_업그레이드" : string.Empty;
                    arrSpName[7] = chkGubun8.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_진로지도상황_등록_업그레이드" : string.Empty;
                    arrSpName[8] = chkGubun9.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_창의적재량활동상황_등록_업그레이드" : string.Empty;
                    arrSpName[9] = chkGubun10.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_특별활동상황_등록_업그레이드" : string.Empty;
                    arrSpName[10] = chkGubun11.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_창의적체험활동상황_등록_업그레이드" : string.Empty;
                    arrSpName[11] = chkGubun12.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_봉사활동실적_등록_업그레이드" : string.Empty;
                    arrSpName[12] = chkGubun13.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_교외체험학습상황_등록_업그레이드" : string.Empty;
                    arrSpName[13] = chkGubun14.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_과년도성적_등록_업그레이드" : string.Empty;
                    arrSpName[14] = chkGubun15.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_세부능력_등록_업그레이드" : string.Empty;
                    arrSpName[15] = chkGubun16.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_독서활동상황_등록_업그레이드" : string.Empty;
                    arrSpName[16] = chkGubun17.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_행동특성_등록_업그레이드" : string.Empty;
                    arrSpName[17] = chkGubun18.Checked ? "USP_학사행정_입시_성적사정_고교학생부이관_정정대장_등록_업그레이드" : string.Empty;

                    // 원데이터 DataSet에 담기
                    for (int i = 0; i < arrTableName.Length; i++)
                    {
                        if (!string.IsNullOrEmpty(arrTableName[i]))
                        {
                            sql = @"SELECT * FROM " + arrTableName[i];
                            adpt = new SQLiteDataAdapter(sql, strConn);
                            adpt.MissingSchemaAction = MissingSchemaAction.AddWithKey;

                            adpt.Fill(ds, arrTableName[i]);
                        }
                        else
                        {
                            continue;
                        }
                    }

                    // 원데이터 DB 저장
                    string spName = string.Empty;
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    //spName = "USP_학사행정_입시_성적사정_고교학생부이관_삭제_업그레이드";
                    //parameters = new DataParameterCollection();
                    //parameters.Add("@ApplYear", txtApplyYear.Text.Trim());
                    //parameters.Add("@ApplSeason", ddlApplSeason.SelectedValue.Trim());
                    //shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);

                    DataTable dt = null;
                    for (int i = 0; i < arrTableName.Length; i++)
                    {
                        if (!string.IsNullOrEmpty(arrTableName[i]))
                        {
                            dt = new DataTable();
                            dt = ds.Tables[arrTableName[i]].Copy();

                            spName = arrSpName[i];

                            // 하나의 데이터 테이블당 Loof
                            foreach (DataRow row in dt.Rows)
                            {
                                parameters = new DataParameterCollection();
                                parameters.Add("@ApplYear", txtApplyYear.Text.Trim());
                                parameters.Add("@ApplSeason", ddlApplSeason.SelectedValue.Trim());

                                for (int c = 2; c < dt.Columns.Count; c++)
                                {
                                    parameters.Add("@" + dt.Columns[c].ColumnName, row[c]);
                                }

                                parameters.Add("@ProcessID", UserId);
                                parameters.Add("@ProcessIP", UserIp);

                                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }

                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        CommonMessage.AlertMessage(this, "고교학생부 이관 작업이 완료 되었습니다.");

                        //var script = "";
                        //script += "if(parent.modalCallback) { ";
                        //script += "     parent.CompleteUpload();";
                        //script += "}";
                        //
                        //AddClientScriptjQueryDocumentReady(script);
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

        private string SaveFile(HtmlInputFile objFile)
        {
            try
            {
                string retVal = "";

                if (objFile.PostedFile == null || objFile.PostedFile.FileName == "")
                    return retVal;

                string strRootDir = Server.MapPath(".\\UploadTemp");
                string strFileName = Path.GetFileName(upload_file.PostedFile.FileName);
                string strName = Path.GetFileNameWithoutExtension(upload_file.PostedFile.FileName);
                string strExt = Path.GetExtension(upload_file.PostedFile.FileName);

                //폴더가 있는지 검사 한다.
                if (!Directory.Exists(strRootDir))
                    Directory.CreateDirectory(strRootDir);

                //중복된 파일이 있는지 검사루틴
                int i = 0;
                while (File.Exists(strRootDir + "\\" + strFileName))
                {
                    i++;
                    strFileName = strName + "(" + i.ToString() + ")" + strExt;
                }

                //파일 저장
                upload_file.PostedFile.SaveAs(strRootDir + "\\" + strFileName);

                return strRootDir + "\\" + strFileName;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 삭제 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void DeleteCmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부이관_삭제_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                parameters.Add("@ApplYear", txtApplyYear.Text);
                parameters.Add("@ApplSeason", ddlApplSeason.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, 203);
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
        /// 성적산출로 이관 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void Etc1Cmd(object sender, CommandEventArgs e)
        {
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부이관_성적산출로이관_등록_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();

            try
            {
                parameters.Add("@ApplYear", txtApplyYear.Text);
                parameters.Add("@ApplSeason", ddlApplSeason.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    CommonMessage.AlertMessage(this, "이관이 완료되었습니다.");
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

        #endregion 이벤트
    }
}