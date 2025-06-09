using IFW.Data;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KJC.IMS.ENTR.StaffMngr
{
    public partial class ApplSearchReportPeriodCheck : System.Web.UI.Page
    {
        private String Gubun { get { return Request.Params["gubun"].StringValue(); } }
        private String Year { get { return Request.Params["year"].StringValue(); } }
        private String Season { get { return Request.Params["season"].StringValue(); } }
        private String RecpNo { get { return Request.Params["recpNo"].StringValue(); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                hidYear.Value = Request.Params["year"].StringValue();
                hidSeason.Value = Request.Params["season"].StringValue();
                hidRecpNo.Value = Request.Params["recpNo"].StringValue();
                hidGubun.Value = Request.Params["gubun"].StringValue();

                if (CheckPrintPeriod()) // 전형일정 확인
                    CheckPrintPerson(); // 출력 대상자 여부 확인
            }
        }

        #region 메소드

        /// <summary>
        /// 출력 대상자 여부 확인
        /// </summary>
        private void CheckPrintPerson()
        {
            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_대상자_확인_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

            try
            {
                parameters.Add("@Year", hidYear.Value);
                parameters.Add("@Season", hidSeason.Value);
                parameters.Add("@RecpNo", hidRecpNo.Value);
                parameters.Add("@PrintGb", hidGubun.Value);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = dataCommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow dr = ds.Tables[0].Rows[0];

                        if (dr["ResultCode"].ToString().Equals("N"))
                        {
                            lblInfo.Text = dr["ResultName"].ToString();
                        }
                        else
                        {
                            string url = "/ENTR/StaffMngr/ApplSearchReportView.aspx?year=" + hidYear.Value + "&season=" + hidSeason.Value + "&recpNo=" + hidRecpNo.Value + "&gubun=" + hidGubun.Value;
                            Response.Redirect(url, true);
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

        /// <summary>
        /// 전형일정 확인
        /// </summary>
        private bool CheckPrintPeriod()
        {
            bool returnCode = false;

            string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_전형일정_확인_업그레이드";
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var datacommands = new List<DataCommand>();

            try
            {
                parameters.Add("@PrintGb", hidGubun.Value);
                parameters.Add("@Year", hidYear.Value);
                parameters.Add("@Season", hidSeason.Value);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
                datacommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    DataSet ds = datacommands[0].DataSet;

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        string result = ds.Tables[0].Rows[0]["ResultCode"].ToString();

                        if (result.Equals("N"))
                        {
                            lblInfo.Text = ds.Tables[0].Rows[0]["ResultName"].ToString();
                        }
                        else
                        {
                            returnCode = true;
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

            return returnCode;
        }

        #endregion 메소드
    }
}