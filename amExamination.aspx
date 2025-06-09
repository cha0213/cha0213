<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amExamination.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amExamination" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtYear">지원연도 : </asp:Label>
                    <cc1:ExTextBox ID="txtYear" runat="server" CssClass="form-control" Width="55px" ValidationType="Numeric" FixLength="4" MaxLength="4" Required="true" Group="ExToolBar1_Print"
                        ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSeason">지원시기 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSeason" runat="server" CssClass="form-control" Width="100px" BindMode="All" Required="true" Group="ExToolBar1_Print" ToolTip="지원시기" Description="지원시기">
                        <%--CodeType="_공통" P1="SA02"--%>
                        <asp:ListItem Value="" Text="선택" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="7" Text="전공심화"></asp:ListItem>
                        <asp:ListItem Value="8" Text="편입학"></asp:ListItem>
                        <asp:ListItem Value="9" Text="산업체위탁"></asp:ListItem>
                        <asp:ListItem Value="A" Text="특별편입학"></asp:ListItem>
                    </cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlOrgID">지원학과 : </asp:Label>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <cc1:ExDropDownList ID="ddlOrgID" runat="server" CssClass="form-control" Width="400px" CodeType="_일반" BindMode="All" Group="ExToolBar1_Print" ToolTip="지원학과" Description="지원학과"></cc1:ExDropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBind" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnReBind" runat="server" CssClass="hidden" />
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
        $(document).ready(function (e) {
            $('#<%= txtYear.ClientID %>').on('blur', function (e) {
                var $Year = $(this).val();

                if ($Year.length < 4 || $Year == '') {
                    return;
                }
                else {
                    $('#<%= btnReBind.ClientID %>').click();
                }
            });
        });
    </script>
</asp:Content>