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
using System.Collections;
using System.Text;

namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highClassTest : WebFormBase
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
            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            this.initPage();
            // 지원연도, 지원시기 셋팅
            COMMMethod.SetApplicationYearSeason(txtApplyYear, ddlApplSeason);
        }

        private void SetScriptForClientEvent()
        {
        }

        #endregion 초기화

        #region 이벤트

        /// <summary>
        /// 저장 버튼 클릭시
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
                    string Year = txtApplyYear.Text.Trim();

                    int[] AllChar = new int[] {8, 8, 13,
                                               1, 1, 3, 3, 1,
                                               1, 1, 3, 3, 1,
                                               1, 1,
                                               1, 1,
                                               1, 1, 1,
                                               2, 3, 3, 1,
                                               2, 3, 3, 1,
                                               1, 1, 1 
                    }; //제2외국어/한문
                       // 29 30 31 32 33
                    ArrayList strArray = ByteToString(FilePath, AllChar);
                    ArrayList ReturnArray = new ArrayList();

                    int result = 0;
                    int Count = 0;
                    int Max_1 = 0, Max_2 = 0, Max_3 = 0;

                    string spName = "dbo.APL_Select_highSchoolInsert";
                    var parameters = new DataParameterCollection();
                    var shell = new DataCommandShell();
                    var dataCommands = new List<DataCommand>();

                    for (int i = 0; i < strArray.Count; i++)
                    {
                        string[] Line = (string[])strArray[i];

                        #region ###### 자료추출 변수 담기

                        string examNo = Line[0].ToString().Trim();
                        string resdNo = Line[2].ToString().Trim();
                        string examSelect4 = Line[23].ToString().Trim();
                        if (examSelect4 == "-") examSelect4 = "0";
                        if (examSelect4 == "*") examSelect4 = "0";
                        if (examSelect4 == "#") examSelect4 = "0";
                        string examSelect5 = Line[27].ToString().Trim();
                        if (examSelect5 == "-") examSelect5 = "0";
                        if (examSelect5 == "*") examSelect5 = "0";
                        if (examSelect5 == "#") examSelect5 = "0";
                        string examSelect6 = Line[30].ToString().Trim();
                        if (examSelect6 == "-") examSelect6 = "0";
                        if (examSelect6 == "*") examSelect6 = "0";
                        if (examSelect6 == "#") examSelect6 = "0";
                        string foreignpercentage = "0";
                        string mathGrade = Line[12].ToString().Trim();
                        if (mathGrade == "-") mathGrade = "0";
                        if (mathGrade == "*") mathGrade = "0";
                        if (mathGrade == "#") mathGrade = "0";
                        string foreignGrade = Line[14].ToString().Trim();
                        if (foreignGrade == "-") foreignGrade = "0";
                        if (foreignGrade == "*") foreignGrade = "0";
                        if (foreignGrade == "#") foreignGrade = "0";
                        string Class2 = Line[6].ToString().Trim();
                        if (Class2 == "-") Class2 = "0";
                        if (Class2 == "*") Class2 = "0";
                        if (Class2 == "#") Class2 = "0";
                        string Class3 = Line[3].ToString().Trim();
                        if (Class3 == "-") Class3 = "0";
                        if (Class3 == "*") Class3 = "0";
                        if (Class3 == "#") Class3 = "0";
                        string Class4 = Line[7].ToString().Trim();
                        if (Class4 == "-") Class4 = "0";
                        if (Class4 == "*") Class4 = "0";
                        if (Class4 == "#") Class4 = "0";
                        string Class5 = Line[8].ToString().Trim();
                        if (Class5 == "-") Class5 = "0";
                        if (Class5 == "*") Class5 = "0";
                        if (Class5 == "#") Class5 = "0";
                        string Class6 = Line[9].ToString().Trim();
                        if (Class6 == "-") Class6 = "0";
                        if (Class6 == "*") Class6 = "0";
                        if (Class6 == "#") Class6 = "0";
                        string examSelect14 = Line[11].ToString().Trim();
                        if (examSelect14 == "-") examSelect14 = "0";
                        if (examSelect14 == "*") examSelect14 = "0";
                        if (examSelect14 == "#") examSelect14 = "0";
                        string Class7 = Line[12].ToString().Trim();
                        if (Class7 == "-") Class7 = "0";
                        if (Class7 == "*") Class7 = "0";
                        if (Class7 == "#") Class7 = "0";
                        string Class8 = Line[13].ToString().Trim();
                        if (Class8 == "-") Class8 = "0";
                        if (Class8 == "*") Class8 = "0";
                        if (Class8 == "#") Class8 = "0";
                        string Class9 = Line[14].ToString().Trim();
                        if (Class9 == "-") Class9 = "0";
                        if (Class9 == "*") Class9 = "0";
                        if (Class9 == "#") Class9 = "0";
                        string historyType = Line[15].ToString().Trim();
                        if (historyType == "-") historyType = "0";
                        if (historyType == "*") historyType = "0";
                        if (historyType == "#") historyType = "0";
                        string historyGrade = Line[16].ToString().Trim();
                        if (historyGrade == "-") historyGrade = "0";
                        if (historyGrade == "*") historyGrade = "0";
                        if (historyGrade == "#") historyGrade = "0";
                        string Class10 = Line[17].ToString().Trim();
                        if (Class10 == "-") Class10 = "0";
                        if (Class10 == "*") Class10 = "0";
                        if (Class10 == "#") Class10 = "0";
                        string Class11 = Line[18].ToString().Trim();
                        if (Class11 == "-") Class11 = "0";
                        if (Class11 == "*") Class11 = "0";
                        if (Class11 == "#") Class11 = "0";
                        string Class12 = Line[19].ToString().Trim();
                        if (Class12 == "-") Class12 = "0";
                        if (Class12 == "*") Class12 = "0";
                        if (Class12 == "#") Class12 = "0";
                        string Class13 = Line[20].ToString().Trim();
                        if (Class13 == "-") Class13 = "0";
                        if (Class13 == "*") Class13 = "0";
                        if (Class13 == "#") Class13 = "0";
                        string Class14 = Line[23].ToString().Trim();
                        if (Class14 == "-") Class14 = "0";
                        if (Class14 == "*") Class14 = "0";
                        if (Class14 == "#") Class14 = "0";
                        string Class15 = Line[24].ToString().Trim();
                        if (Class15 == "-") Class15 = "0";
                        if (Class15 == "*") Class15 = "0";
                        if (Class15 == "#") Class15 = "0";
                        string Class16 = Line[27].ToString().Trim();
                        if (Class16 == "-") Class16 = "0";
                        if (Class16 == "*") Class16 = "0";
                        if (Class16 == "#") Class16 = "0";
                        string Class17 = Line[29].ToString().Trim();
                        if (Class17 == "-") Class17 = "0";
                        if (Class17 == "*") Class17 = "0";
                        if (Class17 == "#") Class17 = "0";
                        string Class18 = Line[30].ToString().Trim();
                        if (Class18 == "-") Class18 = "0";
                        if (Class18 == "*") Class18 = "0";
                        if (Class18 == "#") Class18 = "0";
                        string Class24 = "0";
                        string examSelect20 = Line[6].ToString().Trim();
                        if (examSelect20 == "-") examSelect20 = "0";
                        if (examSelect20 == "*") examSelect20 = "0";
                        if (examSelect20 == "#") examSelect20 = "0";
                        string examSelect21 = Line[11].ToString().Trim();
                        if (examSelect21 == "-") examSelect21 = "0";
                        if (examSelect21 == "*") examSelect21 = "0";
                        if (examSelect21 == "#") examSelect21 = "0";
                        string examSelect22 = Line[22].ToString().Trim();
                        if (examSelect22 == "-") examSelect22 = "0";
                        if (examSelect22 == "*") examSelect22 = "0";
                        if (examSelect22 == "#") examSelect22 = "0";
                        string examSelect23 = Line[26].ToString().Trim();
                        if (examSelect23 == "-") examSelect23 = "0";
                        if (examSelect23 == "*") examSelect23 = "0";
                        if (examSelect23 == "#") examSelect23 = "0";
                        //                    string examSelect24 = Line[30].ToString().Trim(); 2022학년도 수능파일에서 외국어/한문 백분위삭제
                        //                    if (examSelect24 == "-") examSelect24 = "0";
                        //                    if (examSelect24 == "*") examSelect24 = "0";
                        //                    if (examSelect24 == "#") examSelect24 = "0";
                        string examSelect24 = "0";
                        string examSelect7 = "0";
                        string examSelect12 = "0";
                        string Class19 = "0";
                        string Class20 = "0";
                        string Class21 = "0";
                        string Class22 = "0";
                        string Class23 = "0";
                        string examSelect25 = "0";
                        string mathType = Line[9].ToString().Trim();
                        if (mathType == "-") mathType = "0";
                        if (mathType == "*") mathType = "0";
                        if (mathType == "#") mathType = "0";

                        #region 기존 kaims 주석처리 부분

                        //				string englishType = Line[14].ToString().Trim();// 영어 선택유형
                        //				if(englishType == "-") englishType = "0";
                        //				if(englishType == "*") englishType = "0";
                        /*
                        Response.Write(
                            Year
                            +","+
                            resdNo
                            +","+
                            examNo
                            +","+
                            examSelect1
                            +","+
                            examSelect2
                            +","+
                            examSelect3
                            +","+
                            examSelect4
                            +","+
                            examSelect5
                            +","+
                            examSelect6
                            +","+
                            examSelect7
                            +","+
                            foreignpercentage
                            +","+
                            mathGrade
                            +","+
                            foreignGrade
                            +","+
                            examSelect9
                            +","+
                            examSelect10
                            +","+
                            examSelect11
                            +","+
                            examSelect12
                            +","+
                            Class1
                            +","+
                            Class2
                            +","+
                            Class3
                            +","+
                            Class4
                            +","+
                            Class5
                            +","+
                            Class6
                            +","+
                            Class7
                            +","+
                            Class8
                            +","+
                            Class9
                            +","+
                            Class10
                            +","+
                            Class11
                            +","+
                            Class12
                            +","+
                            Class13
                            +","+
                            Class14
                            +","+
                            Class15
                            +","+
                            Class16
                            +","+
                            Class17
                            +","+
                            Class18
                            +","+
                            Class19
                            +","+
                            Class20
                            +","+
                            Class21
                            +","+
                            Class22
                            +","+
                            Class23
                            +","+
                            Class24
                            +","+
                            examSelect13
                            +","+
                            examSelect20
                            +","+
                            examSelect21
                            +","+
                            examSelect22
                            +","+
                            examSelect23
                            +","+
                            examSelect24
                            +","+
                            examSelect25
                            +","+
                            examSelect26
                            +","+
                            examSelect14
                            +","+
                            koreanType
                            +","+
                            mathType
                            +","+
                            englishType
                            +"<br>");
                    */

                        #endregion 기존 kaims 주석처리 부분

                        #endregion ###### 자료추출 변수 담기

                        Count++;

                        parameters = new DataParameterCollection();

                        parameters.Add("@Year", Year);
                        parameters.Add("@resdNo", resdNo);
                        parameters.Add("@examNo", examNo);
                        parameters.Add("@examSelect1", "0");
                        parameters.Add("@examSelect2", "0");
                        parameters.Add("@examSelect3", "0");
                        parameters.Add("@examSelect4", examSelect4);
                        parameters.Add("@examSelect5", examSelect5);
                        parameters.Add("@examSelect6", examSelect6);
                        parameters.Add("@examSelect7", examSelect7);
                        parameters.Add("@foreignpercentage", foreignpercentage);
                        parameters.Add("@mathGrade", mathGrade);
                        parameters.Add("@foreignGrade", foreignGrade);
                        parameters.Add("@examSelect9", "0");
                        parameters.Add("@examSelect10", "0");
                        parameters.Add("@examSelect11", "0");
                        parameters.Add("@examSelect12", examSelect12);
                        parameters.Add("@Class1", "0");
                        parameters.Add("@Class2", Class2);
                        parameters.Add("@Class3", Class3);
                        parameters.Add("@Class4", Class4);
                        parameters.Add("@Class5", Class5);
                        parameters.Add("@Class6", Class6);
                        parameters.Add("@Class7", Class7);
                        parameters.Add("@Class8", Class8);
                        parameters.Add("@Class9", Class9);
                        parameters.Add("@Class10", Class10);
                        parameters.Add("@Class11", Class11);
                        parameters.Add("@Class12", Class12);
                        parameters.Add("@Class13", Class13);
                        parameters.Add("@Class14", Class14);
                        parameters.Add("@Class15", Class15);
                        parameters.Add("@Class16", Class16);
                        parameters.Add("@Class17", Class17);
                        parameters.Add("@Class18", Class18);
                        parameters.Add("@Class19", Class19);
                        parameters.Add("@Class20", Class20);
                        parameters.Add("@Class21", Class21);
                        parameters.Add("@Class22", Class22);
                        parameters.Add("@Class23", Class23);
                        parameters.Add("@Class24", Class24);
                        parameters.Add("@examSelect13", "0");
                        parameters.Add("@examSelect20", examSelect20);
                        parameters.Add("@examSelect21", examSelect21);
                        parameters.Add("@examSelect22", examSelect22);
                        parameters.Add("@examSelect23", examSelect23);
                        parameters.Add("@examSelect24", examSelect24);
                        parameters.Add("@examSelect25", examSelect25);
                        parameters.Add("@examSelect26", "0");
                        parameters.Add("@examSelect14", examSelect14);
                        parameters.Add("@koreanType", "0");
                        parameters.Add("@mathType", mathType);
                        parameters.Add("@englishType", "0");
                        parameters.Add("@historyType", historyType);
                        parameters.Add("@historyGrade", historyGrade);

                        shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                    }

                    dataCommands = shell.Execute();

                    if (shell.ErrorCode == 0)
                    {
                        CommonMessage.AlertMessage(this, "수능자료 업데이트가 완료 되었습니다.");
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

        private void initPage()
        {
            try
            {
                txtApplyYear.Text = string.Empty;
                ddlApplSeason.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                throw ex;
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

        private ArrayList ByteToString(string strFile, int[] AllChar)
        {
            using (StreamReader sr = new StreamReader(strFile, Encoding.Default))
            {
                string line;
                string[] sum = null;
                ArrayList SumList = new ArrayList();
                while ((line = sr.ReadLine()) != null)
                {
                    Byte[] ByteStr = System.Text.Encoding.Default.GetBytes(line);//한줄 전체를 표준바이트로 변환한다(한글은 2,숫자나영문은 1)
                    ArrayList array = new ArrayList();
                    int start = 0;

                    for (int i = 0; i < AllChar.Length; i++)
                    {
                        Byte[] ByteSpilt = new Byte[AllChar[i]];//차례대로 {2,2,12,1,17,7...}크기만큼 넣는다.
                        for (int j = 0; j < AllChar[i]; j++)
                        {
                            ByteSpilt[j] = ByteStr[start];

                            start = start + 1;
                        }
                        array.Add(ByteSpilt);
                    }
                    sum = new string[array.Count];
                    for (int k = 0; k < array.Count; k++)
                    {
                        sum[k] = System.Text.Encoding.Default.GetString((Byte[])array[k]);
                    }
                    //					=========여기까지 하나의 행 작업 ==================================
                    SumList.Add(sum);//작업한 행들을 뭉친다.
                }
                return SumList;
            }
        }

        #endregion 메소드
    }
}