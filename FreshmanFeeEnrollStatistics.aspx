<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FreshmanFeeEnrollStatistics.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.FreshmanFeeEnrollStatistics" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%--<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>--%>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>
<%@ Register Src="/COFF/CONTROL/COFF/StudSearchControl.ascx" TagPrefix="uc1" TagName="StudSearch" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">지원연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Etc1" Description="지원연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="180px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar1_Etc1"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rdGbn">교장추천자/공학인재 :</asp:Label>
                    <cc1:ExRadioButtonList ID="rdGbn" runat="server" RepeatDirection="Horizontal" CssClass="radio">
                        <asp:ListItem Value="1" Text="포함" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="제외"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="인쇄" Etc1CSS="btn btn-default btn-sm" />
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ExScrollBar" runat="server" ReportViewer="true">
                    <uc1:rv ID="rv1" runat="server"></uc1:rv>
                </cc2:ComDivScroll>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

        });
    </script>

    <%--<uc2:report ID="Report1" runat="server" />--%>
</asp:Content>