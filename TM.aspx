<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TM.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.TM" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div id="divInput">
            <!-- 상단 조회 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 1열 -->
                    <!-- 연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 32px" AssociatedControlID="txt연도">연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt연도" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Group="ExToolBar1_Print" Description="연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl시기">시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl시기" runat="server" CssClass="form-control" Width="150px" Group="ExToolBar1_Print" Description="시기" ToolTip="시기" CodeType="_공통" BindMode="None" P1="SA02" Required="true"></cc1:ExDropDownList>
                    </div>
                    &nbsp
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <!-- 전형구분 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl전형구분">전형구분 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl전형구분" runat="server" CssClass="form-control" Width="320px" Group="ExToolBar1_Print" ToolTip="전형구분" Description="전형구분" CodeType="_일반" BindMode="All"></cc1:ExDropDownList>
                            </div>
                            <!-- 학과계열 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl학과계열"><strong style="color:red">*</strong>학과계열 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl학과계열" runat="server" CssClass="form-control" Width="400px" Group="ExToolBar1_Print" ToolTip="학과계열" Description="학과계열" CodeType="_일반" BindMode="Select" Required="true"></cc1:ExDropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
                    <!-- 합격구분 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl합격구분">합격구분 : </asp:Label>
                        <cc1:ExDropDownList ID="ddl합격구분" runat="server" CssClass="form-control" Width="210px" Group="ExToolBar1_Print" ToolTip="합격구분" Description="합격구분" CodeType="_공통" P1="SA04" BindMode="None" Required="true"></cc1:ExDropDownList>
                    </div>
                    <!-- 버튼 영역 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" PrintVisible="true" />
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->
        </div>
        <div class="panel panel-default">
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ExScrollBar" runat="server" ReportViewer="true">
                    <uc1:rv ID="rv2" runat="server"></uc1:rv>
                </cc2:ComDivScroll>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $('#<%= txt연도.ClientID %>').on('blur', function () {
                var $Year = $(this).val();

                if ($Year == '' || $Year.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });
        });
    </script>
    <!-- Report -->
    <%--<uc2:report ID="Report1" runat="server" />--%>
</asp:Content>