using IFW.AspNet.Lib.Security;
using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

namespace KJC.IMS.ENTR.StaffMngr
{
    public partial class ApplSearchReportView : System.Web.UI.Page
    {
        private String Gubun  { get { return  Request.Params["gubun"].StringValue(); } }
        private String Year   { get { return  Request.Params["year"].StringValue(); } }
        private String Season { get { return  Request.Params["season"].StringValue(); } }
        private String RecpNo { get { return Request.Params["recpNo"].StringValue();} }
        private String NeisCode { get { return Request.Params["neisCode"].ToString() != null ? Request.Params["neisCode"].ToString() : ""; } }





        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                try
                {

                    hidYear.Value   = Request.Params["year"].StringValue();
                    hidSeason.Value = Request.Params["season"].StringValue();
                    hidRecpNo.Value = Request.Params["recpNo"].StringValue();
                    hidGubun.Value  = Request.Params["gubun"].StringValue();
                    hiNeisCode.Value = Request.Params["neisCode"] != null ? Request.Params["neisCode"].StringValue() : "";
                    ShowReport();
                }
                catch(Exception ex)
            {
                    CommonMessage.AlertMessage(this, ex.ToString());
                }
            }
        }

        private void ShowReport()
        {
            string printNo = string.Empty;
            string spName = string.Empty;
            Dictionary<string, object> dataParams = new Dictionary<string, object>();

            if (hidGubun.Value == "1")  // 합격통지서
                printNo = "0001364007";
            else if (hidGubun.Value == "2") // 장학증서
                printNo = "0001364006";
            else if (hidGubun.Value == "3") // 등록금 고지서
            {

                /* 2020-12-23 김동균 입학처 요청으로 일단 통일, 각 시즌마다 발표 전 확인 필요
                if (hidSeason.Value == "7" || hidSeason.Value == "8")
                    printNo = "0001364011";
                else if (hidSeason.Value == "9")
                    printNo = "0001364012";
                else if (hidSeason.Value == "E")
                    printNo = "0001364013";
                else
                */
                    printNo = "0001364010";
            }
            else if (hidGubun.Value == "5") // 예치금 고지서
                printNo = "0001364014";
            else if (hidGubun.Value == "6") // 고등학교 지원자 조회
                printNo = "0001538002";

            if (printNo.Length > 0)
            {
                DataTable dt = GetPrintInfo(printNo);
                dt.CaseSensitive = true;

                if (dt.Rows.Count > 0)
                {
                    DataRow dr = dt.Rows[0];
                    hidMrdUrl.Value = $"{dr["BaseUrl"]}{dr["FilePath"]}{dr["FileName"]}";
                    hidReportServiceUrl.Value = dr["ReportServiceUrl"].ToString();
                }
            }
        }

        private DataTable GetPrintInfo(string printNo)
        {
            DataTable table = null;
            string spName = "dbo.USP_공통_출력물정보_조회_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@PrnNo", printNo);
                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0) 
                {
                    table = dataCommands[0].DataSet.Tables[0];
                }
                else
                {
                    throw new Exception(shell.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this, ex.ToString());
            }

            return table;
        }
    }
}