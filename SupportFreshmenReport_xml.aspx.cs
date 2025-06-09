using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using KJC.IMS.COFF.CONTROL.COFF;
using System.Web.UI.WebControls;
using System.Security.Permissions;
using IFW.Data;
using System.Data;

namespace KJC.IMS.ENTR.StaffMngr
{
	[PrincipalPermission(SecurityAction.Demand)]
	public partial class SupportFreshmenReport_xml : WebFormBase
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			var strParams = Request.Params["params"];
			GetReportXml(strParams);
		}

		private void GetReportXml(string strParams)
		{
			string spName = "dbo.USP_학사행정_입시_지원자현황_지원자조회_입학원서_출력_업그레이드";
			var parameters = ReportUtil.GetReportParameter(strParams);
			//var shell = new DataCommandShell();
			var shell = ReportUtil.GetRDCommandShell(this);
			var dataCommands = new List<DataCommand>();

			shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);
			dataCommands = shell.Execute();

			if (shell.ErrorCode == 0)
			{
				DataSet ds = DataUtil.GetDataSetFrom(dataCommands);

				if (ds.Tables[1].Rows.Count > 0)
				{
					ds.Tables[1].TableName = "주쿼리";
					ds.Tables[2].TableName = "서브쿼리1";
					ds.Tables[3].TableName = "서브쿼리2";

					DataUtil.AddDataRelation(ds, "Dataset", "주쿼리", "서브쿼리1", "수험번호");
					DataUtil.AddDataRelation(ds, "Dataset1", "주쿼리", "서브쿼리2", "수험번호");

					//ds.WriteXml("C:/성적부2.xml");
					//ds.WriteXml("C:/WORK/입학원서.xml");
					string strXml = ds.GetXml();

					Response.Write(strXml);
				}

				// 개발시
				
			}
			else
			{
				throw new HttpException(shell.ErrorMessage);
			}
		}
	}
}