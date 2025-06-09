<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highClassGradeList22.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highClassGradeList22" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>

<%--<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>--%>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
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
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="180px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar1_Etc1"></cc1:ExDropDownList>
                </div>
                <%--<div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplyArea">지역 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplyArea" runat="server" Width="100px" ToolTip="지역" Description="지역" Required="true" BindMode="All" CodeType="_공통" Group="ExToolBar1_Etc1">
						<asp:ListItem Value="전체">전체</asp:ListItem>
						<asp:ListItem Value="강원">강원</asp:ListItem>
						<asp:ListItem Value="경기">경기</asp:ListItem>
						<asp:ListItem Value="경남">경남</asp:ListItem>
						<asp:ListItem Value="경북">경북</asp:ListItem>
						<asp:ListItem Value="광주">광주</asp:ListItem>
						<asp:ListItem Value="대구">대구</asp:ListItem>
						<asp:ListItem Value="대전">대전</asp:ListItem>
						<asp:ListItem Value="부산">부산</asp:ListItem>
						<asp:ListItem Value="서울">서울</asp:ListItem>
						<asp:ListItem Value="울산">울산</asp:ListItem>
						<asp:ListItem Value="인천">인천</asp:ListItem>
						<asp:ListItem Value="전남">전남</asp:ListItem>
						<asp:ListItem Value="전북">전북</asp:ListItem>
						<asp:ListItem Value="제주">제주</asp:ListItem>
						<asp:ListItem Value="중국">중국</asp:ListItem>
						<asp:ListItem Value="충남">충남</asp:ListItem>
						<asp:ListItem Value="충북">충북</asp:ListItem>
                </cc1:ExDropDownList>
                </div>--%>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="인쇄" Etc1CSS="btn btn-default btn-sm" />
                </div>
            </div>
        </div>

        <%--<div class="panel panel-default">
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ExScrollBar" runat="server" ReportViewer="true">
                    <uc1:rv ID="rv1" runat="server"></uc1:rv>
                </cc2:ComDivScroll>
            </div>
        </div>--%>
        <uc1:pdf ID="PDFAlert" runat="server" />
        <uc2:reportInvoker ID="ReportInvoker" runat="server" />
        <uc2:report ID="Report1" runat="server" />
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

        });
    </script>    
</asp:Content>