<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SendSMSMajor.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.SendSMSMajor" MasterPageFile="~/Page.Master" %>
<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="uc1" %>
<%@ Register Src="/COFF/CONTROL/COFF/StudSearchControl.ascx" TagPrefix="uc2" TagName="StudSearch" %>
<%@ Register Src="/COFF/CONTROL/COFF/SMSControl_ENTR.ascx" TagPrefix="uc" TagName="sms" %>
<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">

</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div id="divInput">
            <!-- 상단 조회 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt연도">연도  :</asp:Label>
                        <cc1:ExTextBox ID="txt연도" runat="server" CssClass="form-control" Width="55px" ToolTip="연도" Description="연도" MaxLength="4" FixLength="4"  Required="true" Group="ExToolBar1_Search" OnTextChanged="txt연도_TextChanged"></cc1:ExTextBox>
                    </div>
                    <!-- 시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl시기">시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl시기" runat="server" CssClass="form-control" Width="120px" ToolTip="시기" Description="시기" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar1_Search"></cc1:ExDropDownList>
                    </div>
                    <!-- (합격)구분 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl구분">구분 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl구분" runat="server" CssClass="form-control" Width="170px" ToolTip="구분" Description="구분" BindMode="All" CodeType="_공통" P1="SA04" Group="ExToolBar1_Search"></cc1:ExDropDownList>
                    </div>                
                    <!-- 계열 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl계열">계열 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl계열" runat="server" CssClass="form-control" Width="300px" ToolTip="계열" Description="계열" BindMode="All" CodeType="_일반" Group="ExToolBar1_Search"></cc1:ExDropDownList>
                    </div>
                    <!-- 전형 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl전형">전형 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl전형" runat="server" CssClass="form-control" Width="300px" ToolTip="전형" Description="전형" BindMode="All" CodeType="_일반" Group="ExToolBar1_Search"></cc1:ExDropDownList>
                    </div>
                    <!-- 수험번호 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="StudSearch">수험번호 :</asp:Label>
                        <uc2:StudSearch ID="StudSearch" runat="server" CssClass="form-control" ToolTip="수험번호" Description="수험번호" DisplayToolTip="수험번호" ValueToolTip="수험번호" MenuType="FreshMan" Group="ExToolBar1_Search"/>
                    </div>
                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    </div>                          
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->       
            
            <!--SMS 발송 리스트 시작 -->
            <uc:sms ID="ucSMS" runat="server" CompkeyEnum="입시"/>
            <!--SMS 발송 리스트 끝 -->
        </div>
    </div>
       
</asp:Content>
