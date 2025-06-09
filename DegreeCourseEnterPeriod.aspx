<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DegreeCourseEnterPeriod.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.DegreeCourseEnterPeriod" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchYear">연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Etc1" Description="연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplyOrgID">지원학과 : </asp:Label>
                                <cc1:ExDropDownList ID="ddlSearchApplyOrgID" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar1_Etc1" ToolTip="지원학과" Description="지원학과" BindMode="All"></cc1:ExDropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                 </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="엑셀" Etc1CSS="btn btn-default btn-sm" />
                </div>
                <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtSearchYear.ClientID %>').on('blur', function () {
                var $applyYear = $('#<%= txtSearchYear.ClientID %>').val();

                if ($applyYear == '' || $applyYear.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });
        });
    </script>
</asp:Content>