<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreStatistics2.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreStatistics2" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>

<%--<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>--%>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Print" Description="연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="180px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="Select" CodeType="_공통" P1="SA02" Group="ExToolBar1_Print"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rdApplySeasonGbn">구분 :</asp:Label>
                    <cc1:ExRadioButtonList ID="rdApplySeasonGbn" runat="server" CssClass="form-control" Group="ExToolBar1_Print" Description="구분" ToolTip="구분" RepeatDirection="Horizontal" Required="true">
                        <asp:ListItem Value="1" Text="지원자" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="합격자"></asp:ListItem>
                        <asp:ListItem Value="3" Text="등록자"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" PrintVisible="true" />
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