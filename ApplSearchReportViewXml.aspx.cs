using IFW.Data;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace KJC.IMS.ENTR.StaffMngr
{
    public partial class ApplSearchReportViewXml : System.Web.UI.Page
    {
        private string JqueryDocumentReadyOpen = "$(document).ready(function() {";
        private string JqueryDocumentReadyClose = "});";
        private String Gubun { get { return Request.Params["gubun"].StringValue(); } }
        private String Year { get { return Request.Params["year"].StringValue(); } }
        private String Season { get { return Request.Params["season"].StringValue(); } }
        private String RecpNo { get { return Request.Params["recpNo"].StringValue(); } }
        private String NeisCode { get { return Request.Params["neisCode"] != null ? Request.Params["neisCode"].StringValue() : ""; } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SetReport();
            }
        }

        private void SetReport()
        {
            try
            {
                var dataParams = new DataParameterCollection();
                string spName = string.Empty;
                string printNo = string.Empty;

                if (Gubun == "1")    // 합격통지서
                {
                    printNo = "0001364007";

                    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_합격통지서_출력_업그레이드";
                    dataParams.Add("@Year", Year);
                    dataParams.Add("@Season", Season);
                    dataParams.Add("@Major", "%");
                    dataParams.Add("@Stud", RecpNo);
                }
                else if (Gubun == "2") // 장학증서
                {
                    printNo = "0001364006";
                    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_장학증서_출력_업그레이드";
                    dataParams.Add("@Year", Year);
                    dataParams.Add("@Season", Season);
                    dataParams.Add("@Major", "%");
                    dataParams.Add("@Stud", RecpNo);
                }
                else if (Gubun == "3")    // 등록금 고지서
                {
                    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_등록금고지서_출력_업그레이드";
                    dataParams.Add("@recpNo", RecpNo);
                    dataParams.Add("@Year", Year);
                    dataParams.Add("@Season", Season);

                    /* 2020-12-23 김동균 입학처 요청으로 일단 통일, 각 시즌마다 발표 전 확인 필요
                    if (Season == "7" || Season == "8")
                        printNo = "0001364002";
                    else if (Season == "9")
                        printNo = "0001364003";
                    else if (Season == "E")
                        printNo = "0001364004";
                    else
                    */

                    printNo = "0001364001";
                }
                else if (Gubun == "5")   // 예치금 고지서
                {
                    spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_예치금고지서_출력_업그레이드";
                    dataParams.Add("@recpNo", RecpNo);
                    dataParams.Add("@Year", Year);
                    dataParams.Add("@Season", Season);
                    printNo = "0001364009";
                }
                else if (Gubun == "6")   // 고등학교 지원자 조회
                {
                    spName = "dbo.USP_학사행정_입시_지원자관리_고교별지원자명단_조회_업그레이드_홈페이지용";
                    dataParams.Add("@Year", Year);
                    dataParams.Add("@Season", Season);
                    dataParams.Add("@pass", "%");
                    dataParams.Add("@schoolName", NeisCode);

                    printNo = "0001538002";
                }

                DataParameterCollection dataParams1 = new DataParameterCollection();
                dataParams1.Add("@제목", "보고서");
                dataParams1.Add("@프로그램ID", "0001364");
                dataParams1.Add("@사용자ID", RecpNo);
                dataParams1.Add("@사용자IP", Request.ServerVariables["REMOTE_ADDR"]);
                dataParams1.Add("@사용자성명", string.Empty);

                var commandShell = new DataCommandShell();
                commandShell.SetSpCommand("dbo.USP_공통_출력기본정보_조회_업그레이드", DbCommandType.ExecuteQuery, dataParams1);
                commandShell.SetSpCommand(spName, DbCommandType.ExecuteQuery, dataParams);
                var excutedCommands = commandShell.Execute();
                if (commandShell.ErrorCode == 0)
                {
                    DataSet dataSource = DataUtil.GetDataSetFrom(excutedCommands);
                    if (dataSource != null && dataSource.Tables.Count > 0 && dataSource.Tables[0].Rows.Count > 0)
                    {
                        if (printNo == "0001364009")
                        {
                            if (dataSource.Tables[1].Rows.Count > 0)
                            {
                                dataSource.Tables[1].TableName = "주쿼리";
                                dataSource.Tables[2].TableName = "서브쿼리1";

                                DataUtil.AddDataRelation(dataSource, "Dataset", "주쿼리", "서브쿼리1", "recpNo");
                            }
                        }

                        /*2019-01-25 김동균 등록금고지서 장학내역 쿼리 추가*/
                        /*
                        if (printNo == "0001364001")
                        {
                            if (dataSource.Tables[1].Rows.Count > 0)
                            {
                                dataSource.Tables[1].TableName = "Table1";
                                dataSource.Tables[2].TableName = "Sub1";

                                DataUtil.AddDataRelation(dataSource, "Dataset", "Table1", "Sub1", "recpNo");
                            }
                        }
                        */

                        var xml = dataSource.GetXml();
                        Response.Write(xml);
                    }
                }
                else
                {
                    throw new Exception(commandShell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessageIfame(this, ex.ToString());
            }
        }
    }
}