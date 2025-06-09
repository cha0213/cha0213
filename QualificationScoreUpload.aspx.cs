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
    public partial class QualificationScoreUpload : WebFormBase
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
                    
                    string[] arrTableName = new string[] { "GedStudentBaseInfo", "GedPersonalInfo", "AcceptedInfo", "SubjectScore"};
                    
                    string[] arrSPName = new string[] {  "USP_학사행정_입시_성적사정_검정고시이관_기본정보_등록_업그레이드"
                                                        ,"USP_학사행정_입시_성적사정_검정고시이관_인적사항_등록_업그레이드"
                                                        ,"USP_학사행정_입시_성적사정_검정고시이관_합격증명_등록_업그레이드"
                                                        ,"USP_학사행정_입시_성적사정_검정고시이관_성적증명_등록_업그레이드"                                                       
                                                       };

                    // 원데이터 DataSet에 담기
                    for (int i = 0; i < arrTableName.Length; i++)
                    {
                        sql = @"SELECT * FROM " + arrTableName[i];
                        adpt = new SQLiteDataAdapter(sql, strConn);
                        adpt.MissingSchemaAction = MissingSchemaAction.AddWithKey;

                        adpt.Fill(ds, arrTableName[i]);
                    }

                    // 원데이터 DB 저장
                    string spName = string.Empty;                    
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    DataTable dt = null;
                    for (int i = 0; i < arrTableName.Length; i++)
                    {
                        dt = new DataTable();
                        dt = ds.Tables[arrTableName[i]].Copy();

                        spName = arrSPName[i];

                        // 하나의 데이터 테이블당 Loof 
                        foreach(DataRow row in dt.Rows)
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
                    

                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        //CommonMessage.AlertMessage(this, "고교학생부 이관 작업이 완료 되었습니다.");

                        var script = "";
                        script += "if(parent.modalCallback) { ";
                        script += "     parent.CompleteUpload();";
                        script += "}";

                        AddClientScriptjQueryDocumentReady(script);
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
        
        #endregion 이벤트
    }
}