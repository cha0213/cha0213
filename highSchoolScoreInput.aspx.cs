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

/// <summary>
/// 메뉴정보 : 입시 > 성적사정 > 고교학생부 입력(1996년도 이전)
/// 수정이력
/// 1. 작성일자/작성자/최초작성
///  - 2017.11.24 / 박영지 / 최초작성
/// 2. 수정일자/수정자/수정내용
/// </summary>
namespace KJC.IMS.ENTR.StaffMngr
{
    [PrincipalPermission(SecurityAction.Demand)]
    public partial class highSchoolScoreInput : WebFormBase
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

                this.Retrieve(true);

            }
            this.SetScriptForClientEvent();
        }

        private void InitPageSetting()
        {
            try
            {
                DataSet ds = new COMMBiz().GetApplicationConfig();

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    txt연도조회.Text = ds.Tables[0].Rows[0]["ApplYear"] == DBNull.Value ? string.Empty : ds.Tables[0].Rows[0]["ApplYear"].ToString();
                }
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
            this.Retrieve(false);
            this.ClearDetail();
        }


        /// <summary>
        /// 저장 버튼 클릭 시 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        public override void SaveCmd(object sender, CommandEventArgs e)
        {
            this.Save();
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
            }
        }



        #endregion 이벤트

        #region 메소드

        /// <summary>
        /// 조회 버튼 클릭 시 조회
        /// </summary>
        private void Retrieve(bool PAGE_YN)
        {
            DataSet ds = null;
            string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력1996년도이전_조회_업그레이드"; 
            var parameters = new DataParameterCollection();
            var shell = new DataCommandShell();
            var dataCommands = new List<DataCommand>();

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
        }


        /// <summary>
        /// 저장 버튼 클릭 시 
        /// </summary>
        private void Save()
        {

            #region 저장 전 입력 값 체크
            string year = string.Empty;
            string recpNo = string.Empty;

            year = this.hdnYear.Value;
            recpNo = this.hdnRecpNo.Value;

            int absence_1_A, absence_1_B, absence_1_C, absence_1_D;
            int absence_2_A, absence_2_B, absence_2_C, absence_2_D;
            int absence_3_A, absence_3_B, absence_3_C, absence_3_D;

            double highSchoolRank_1_1, highSchoolPerson_1_1, highSchoolRank_1_2, highSchoolPerson_1_2;
            double highSchoolRank_2_1, highSchoolPerson_2_1, highSchoolRank_2_2, highSchoolPerson_2_2;
            double highSchoolRank_3_1, highSchoolPerson_3_1, highSchoolRank_3_2, highSchoolPerson_3_2;


            if (this.txthighSchoolRank_1_1.Text.Trim() == "")
            {
                //highSchoolRank_1_1 = 0;
                CommonMessage.AlertMessage(this, "1-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_1_1 = Convert.ToDouble(this.txthighSchoolRank_1_1.Text.Trim());

            if (this.txthighSchoolPerson_1_1.Text.Trim() == "")
            {
                //highSchoolPerson_1_1 = 0;
                CommonMessage.AlertMessage(this, "1-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_1_1 = Convert.ToDouble(this.txthighSchoolPerson_1_1.Text.Trim());

            if (this.txthighSchoolRank_1_2.Text.Trim() == "")
            {
                //highSchoolRank_1_2 = 0;
                CommonMessage.AlertMessage(this, "1-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_1_2 = Convert.ToDouble(this.txthighSchoolRank_1_2.Text.Trim());

            if (this.txthighSchoolPerson_1_2.Text.Trim() == "")
            {
                //highSchoolPerson_1_2 = 0;
                CommonMessage.AlertMessage(this, "1-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_1_2 = Convert.ToDouble(this.txthighSchoolPerson_1_2.Text.Trim());

            if (this.txthighSchoolRank_2_1.Text.Trim() == "")
            {
                //highSchoolRank_2_1 = 0;
                CommonMessage.AlertMessage(this, "2-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_2_1 = Convert.ToDouble(this.txthighSchoolRank_2_1.Text.Trim());

            if (this.txthighSchoolPerson_2_1.Text.Trim() == "")
            {
                //highSchoolPerson_2_1 = 0;
                CommonMessage.AlertMessage(this, "2-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_2_1 = Convert.ToDouble(this.txthighSchoolPerson_2_1.Text.Trim());

            if (this.txthighSchoolRank_2_2.Text.Trim() == "")
            {
                //highSchoolRank_2_2 = 0;
                CommonMessage.AlertMessage(this, "2-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_2_2 = Convert.ToDouble(this.txthighSchoolRank_2_2.Text.Trim());

            if (this.txthighSchoolPerson_2_2.Text.Trim() == "")
            {
                //highSchoolPerson_2_2 = 0;
                CommonMessage.AlertMessage(this, "2-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_2_2 = Convert.ToDouble(this.txthighSchoolPerson_2_2.Text.Trim());

            if (this.txthighSchoolRank_3_1.Text.Trim() == "")
            {
                //highSchoolRank_3_1 = 0;
                CommonMessage.AlertMessage(this, "3-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_3_1 = Convert.ToDouble(this.txthighSchoolRank_3_1.Text.Trim());

            if (this.txthighSchoolPerson_3_1.Text.Trim() == "")
            {
                //highSchoolPerson_3_1 = 0;
                CommonMessage.AlertMessage(this, "3-1 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_3_1 = Convert.ToDouble(this.txthighSchoolPerson_3_1.Text.Trim());

            if (this.txthighSchoolRank_3_2.Text.Trim() == "")
            {
                //highSchoolRank_3_2 = 0;
                CommonMessage.AlertMessage(this, "3-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolRank_3_2 = Convert.ToDouble(this.txthighSchoolRank_3_2.Text.Trim());

            if (this.txthighSchoolPerson_3_2.Text.Trim() == "")
            {
                //highSchoolPerson_3_2 = 0;
                CommonMessage.AlertMessage(this, "3-2 성적이 입력되지 않았습니다!");
                return;
            }
            else highSchoolPerson_3_2 = Convert.ToDouble(this.txthighSchoolPerson_3_2.Text.Trim());

            

            if (this.txtabsence_1_A.Text.Trim() == "") absence_1_A = 0;
            else absence_1_A = Convert.ToInt32(this.txtabsence_1_A.Text.Trim());

            if (this.txtabsence_1_B.Text.Trim() == "") absence_1_B = 0;
            else absence_1_B = Convert.ToInt32(this.txtabsence_1_B.Text.Trim());

            if (this.txtabsence_1_C.Text.Trim() == "") absence_1_C = 0;
            else absence_1_C = Convert.ToInt32(this.txtabsence_1_C.Text.Trim());

            if (this.txtabsence_1_D.Text.Trim() == "") absence_1_D = 0;
            else absence_1_D = Convert.ToInt32(this.txtabsence_1_D.Text.Trim());

            if (this.txtabsence_2_A.Text.Trim() == "") absence_2_A = 0;
            else absence_2_A = Convert.ToInt32(this.txtabsence_2_A.Text.Trim());

            if (this.txtabsence_2_B.Text.Trim() == "") absence_2_B = 0;
            else absence_2_B = Convert.ToInt32(this.txtabsence_2_B.Text.Trim());

            if (this.txtabsence_2_C.Text.Trim() == "") absence_2_C = 0;
            else absence_2_C = Convert.ToInt32(this.txtabsence_2_C.Text.Trim());

            if (this.txtabsence_2_D.Text.Trim() == "") absence_2_D = 0;
            else absence_2_D = Convert.ToInt32(this.txtabsence_2_D.Text.Trim());

            if (this.txtabsence_3_A.Text.Trim() == "") absence_3_A = 0;
            else absence_3_A = Convert.ToInt32(this.txtabsence_3_A.Text.Trim());

            if (this.txtabsence_3_B.Text.Trim() == "") absence_3_B = 0;
            else absence_3_B = Convert.ToInt32(this.txtabsence_3_B.Text.Trim());

            if (this.txtabsence_3_C.Text.Trim() == "") absence_3_C = 0;
            else absence_3_C = Convert.ToInt32(this.txtabsence_3_C.Text.Trim());

            if (this.txtabsence_3_D.Text.Trim() == "") absence_3_D = 0;
            else absence_3_D = Convert.ToInt32(this.txtabsence_3_D.Text.Trim());

            #endregion

            try
            {
                string spName = "dbo.USP_학사행정_입시_성적사정_고교학생부입력1996년도이전_등록_업그레이드";
                var parameters = new DataParameterCollection();
                var shell = new DataCommandShell();
                var dataCommands = new List<DataCommand>();

                #region 파라미터 설정
                parameters.Add("@year", year);
                parameters.Add("@recpNo", recpNo);
                parameters.Add("@highSchoolRank_1_1", highSchoolRank_1_1);
                parameters.Add("@highSchoolPerson_1_1", highSchoolPerson_1_1);
                parameters.Add("@highSchoolRank_1_2", highSchoolRank_1_2);
                parameters.Add("@highSchoolPerson_1_2", highSchoolPerson_1_2);
                parameters.Add("@highSchoolRank_2_1", highSchoolRank_2_1);
                parameters.Add("@highSchoolPerson_2_1", highSchoolPerson_2_1);
                parameters.Add("@highSchoolRank_2_2", highSchoolRank_2_2);
                parameters.Add("@highSchoolPerson_2_2", highSchoolPerson_2_2);
                parameters.Add("@highSchoolRank_3_1", highSchoolRank_3_1);
                parameters.Add("@highSchoolPerson_3_1", highSchoolPerson_3_1);
                parameters.Add("@highSchoolRank_3_2", highSchoolRank_3_2);
                parameters.Add("@highSchoolPerson_3_2", highSchoolPerson_3_2);
                parameters.Add("@absence_1_A", absence_1_A);
                parameters.Add("@absence_1_B", absence_1_B);
                parameters.Add("@absence_1_C", absence_1_C);
                parameters.Add("@absence_1_D", absence_1_D);
                parameters.Add("@absence_2_A", absence_2_A);
                parameters.Add("@absence_2_B", absence_2_B);
                parameters.Add("@absence_2_C", absence_2_C);
                parameters.Add("@absence_2_D", absence_2_D);
                parameters.Add("@absence_3_A", absence_3_A);
                parameters.Add("@absence_3_B", absence_3_B);
                parameters.Add("@absence_3_C", absence_3_C);
                parameters.Add("@absence_3_D", absence_3_D);         
                #endregion

                shell.SetSpCommand(spName, DbCommandType.ExecuteNonQuery, parameters);
                dataCommands = shell.Execute();

                if (shell.ErrorCode == 0)
                {
                    this.Retrieve(false);
                    ClearDetail();
                    CommonMessage.AlertMessage(this, 202); // 저장 되었습니다.
                }
                
                
                /*
                else
                {
                    switch (shell.ErrorCode)
                    {
                        case 1:
                            CommonMessage.AlertMessage(this, 202);
                            break;
                        case 2627:
                            CommonMessage.AlertMessage(this, "중복된 코드 입니다!");
                            break;
                    }

                    if (shell.ErrorCode < 0)
                        CommonMessage.AlertMessage(this, shell.ErrorMessage);
                }
                */

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
                                + "&korName=" + HttpUtility.UrlEncode(this.txt성명조회.Text.Trim()) ;
            ((CommonPager)CommonPager1).totalCnt = totalCnt;
            ((CommonPager)CommonPager1).itemsPerPage = ROW_NUM;
            ((CommonPager)CommonPager1).ViewPageList(pageNo, currentPath);
        }


        /// <summary>
        /// 입력항목 초기화
        /// </summary>
        private void ClearDetail()
        {
            try
            {
                ResetControlsValue("CUD");
                this.hdnYear.Value = string.Empty;
                this.hdnRecpNo.Value = string.Empty;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #endregion 메소드

    }
}