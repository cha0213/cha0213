<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolList.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolList" MasterPageFile="~/Page.Master"%>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/ENTR/HighschoolSearch.ascx" TagPrefix="uc2" TagName="Highschool" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportInvoker.ascx" TagPrefix="uc2" TagName="reportInvoker" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportPDFAlert.ascx" TagPrefix="uc1" TagName="pdf" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Etc1" Description="연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="180px" ToolTip="지원시기" Description="지원시기" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar1_Etc1"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlGbn">구분 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlGbn" runat="server" CssClass="form-control" Width="210px" Group="ExToolBar1_Print" ToolTip="구분" Description="구분" CodeType="_공통" P1="SA04" BindMode="All" ></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtNeisName">고등학교 :</asp:Label>
                    <uc2:Highschool ID="txtNeisName" runat="server" Group="ExToolBar3_Save" DisplayToolTip="고등학교" Description="고등학교" ValueToolTip="고등학교" neisNameWidth="250px" />
                </div>

                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtGraduYear">졸업년도 : </asp:Label>
                    <cc1:ExTextBox ID="txtGraduYear" runat="server" CssClass="form-control" Width="50px" Group="ExToolBar1_Search" ToolTip="졸업년도" Description="졸업년도" MaxLength="4"></cc1:ExTextBox>
                </div>

                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="인쇄" Etc1CSS="btn btn-default btn-sm" />
                </div>
            </div>
        </div>
        <uc1:pdf ID="PDFAlert" runat="server" />
        <uc2:reportInvoker ID="ReportInvoker" runat="server" />
        <uc2:report ID="Report1" runat="server" />
    </div>
    <%--<uc2:report ID="Report1" runat="server" />--%>
</asp:Content>