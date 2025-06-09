using IFW.Data;
using IFW.WebUI;
using KJC.IMS.COFF.COMM.BIZ;
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

    public partial class amPassChkSubRankSMS : WebFormBase
    {

        #region 초기화

        protected override void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            btnReBindSearchDdl.Click += BtnReBindSearchDdl_Click;       //[조회조건] 지원연도 변경시 전형구분, 지원학과 바인딩
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.InitPageSetting();
            }
                        
            //this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            COMMMethod.SetApplicationYearSeason(txtSearchApplyYear, ddlSearchApplySeason);

            //COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //지원학과(조회조건) 바인딩
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);  //전형구분(조회조건) 바인딩
            ddlSearchGubun.SelectedIndex = 1;
        }

        #endregion 초기화

        #region 메서드

        /// <summary>
        /// 기본과목 리스트 조회
        /// </summary>
        private void Retrieve()
        {
            try
            {
                hidApplyYear.Value = txtSearchApplyYear.Text;
                hidApplySeason.Value = ddlSearchApplySeason.SelectedValue;
                hidGubun.Value = ddlSearchGubun.SelectedValue;

                lbl지원연도.Text = txtSearchApplyYear.Text + "년";
                lbl지원시기.Text = ddlSearchApplySeason.SelectedItem.Text;
                lbl전형구분.Text = ddlSearchGubun.SelectedItem.Text;

                string spName = "dbo.USP_학사행정_입시_지원자관리_예비후보SMS인원관리_조회_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                parameters.Add("@Year", txtSearchApplyYear.Text);
                parameters.Add("@Season", ddlSearchApplySeason.SelectedValue);
                parameters.Add("@SppoClsCode", ddlSearchGubun.SelectedValue);

                shell.SetSpCommand(spName, DbCommandType.ExecuteQuery, parameters);

                dataCommands = shell.Execute();
                DataSet ds = null;
                if (shell.ErrorCode != 0)
                {
                    dataCommands.Clear();

                    throw new Exception(shell.ErrorMessage);
                }
                else
                {
                    ds = dataCommands[0].DataSet;

                    grdList.DataSource = ds;
                    this.grdList.DataBindGrid(ds, this.ExDataCounter1);
                }
            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this.Page, ex.Message);
            }
        }

        #endregion 메서드

        #region 이벤트

        /// <summary>
        /// 조회 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SearchCmd(object sender, CommandEventArgs e)
        {
            this.Retrieve();
        }


        /// <summary>
        /// 저장 버튼 클릭시
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            try
            {
                string spName = "dbo.USP_학사행정_입시_지원자관리_예비후보SMS인원관리_등록_업그레이드";

                var parameters_D = new DataParameterCollection();
                var shell_D = new DataCommandShell();
                var dataCommands_D = new List<DataCommand>();

                //기존에 저장된 데이터 삭제 후 일괄 저장
                parameters_D.Add("@Gubun", "D");
                parameters_D.Add("@Year", hidApplyYear.Value);
                parameters_D.Add("@Season", hidApplySeason.Value);
                parameters_D.Add("@SppoClsCode", hidGubun.Value);

                shell_D.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters_D);
                dataCommands_D = shell_D.Execute();

                List<DataParameterCollection> pInsert = new List<DataParameterCollection>();
                foreach (GridViewRow gvr in grdList.Rows)
                {
                    ExTextBox txtSubRankCount = (ExTextBox)gvr.Cells[6].FindControl("txtSubRankCount");

                    var parameters_C = new DataParameterCollection();
                    parameters_C.Add("@Gubun", "C");
                    parameters_C.Add("@Year", hidApplyYear.Value);
                    parameters_C.Add("@Season", hidApplySeason.Value);                    
                    parameters_C.Add("@SppoClsCode", hidGubun.Value);
                    parameters_C.Add("@MajorCode", gvr.Cells[1].Text);
                    parameters_C.Add("@SubRankCount", string.IsNullOrEmpty(txtSubRankCount.ParamaterValue.ToString()) ? "0" : txtSubRankCount.ParamaterValue);
                    parameters_C.Add("@ID", UserId);
                    parameters_C.Add("@IP", UserIp);
                    pInsert.Add(parameters_C);
                }

                if(pInsert.Count > 0)
                {
                    var shell_C = new DataCommandShell();
                    var dataCommands_C = new List<DataCommand>();

                    shell_C.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, pInsert);
                    dataCommands_C = shell_C.Execute();

                    if(shell_C.ErrorCode == 0)
                    {
                        CommonMessage.AlertMessage(this, MessageEnum.NotifySaved);
                    }
                    else
                    {
                        CommonMessage.AlertMessage(this, shell_C.ErrorMessage);
                    }
                }

            }
            catch (Exception ex)
            {
                CommonMessage.AlertMessage(this.Page, ex.Message);
            }
        }

        /// <summary>
        /// [조회조건] 지원연도 변경시 전형구분, 지원학과 바인딩
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void BtnReBindSearchDdl_Click(object sender, EventArgs e)
        {
            //COMMMethod.SetDDLMajorCode(ddlSearchApplyOrgID, txtSearchApplyYear.Text);       //[조회조건] 지원연도 변경시 지원학과 방인딩
            COMMMethod.SetDDLSppoClsCodeWithType(ddlSearchGubun, txtSearchApplyYear.Text);  //[조회조건] 지원연도 변경시 전형구분 바인딩
        }

        #endregion 이벤트
    }
}