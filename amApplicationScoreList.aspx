<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amApplicationScoreList.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amApplicationScoreList" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportInvoker.ascx" TagPrefix="uc1" TagName="reportInvoker" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc" %>

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
                    <!-- 지원연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt지원연도조회">지원연도  :</asp:Label>
                        <cc1:ExTextBox ID="txt지원연도조회" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar2_Print" Description="지원연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl지원시기조회">지원시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl지원시기조회" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="None" CodeType="_공통" P1="SA02" Group="ExToolBar1_Search;ExToolBar2_Print" AutoPostBack="true"></cc1:ExDropDownList>
                    </div>
                    &nbsp
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>

                            <!-- 전형구분 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl전형구분조회">전형구분 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl전형구분조회" runat="server" Width="320px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="전형구분" Description="전형구분" BindMode="All"></cc1:ExDropDownList>
                            </div>
                            <!-- 지원학과 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl지원학과조회">지원학과 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl지원학과조회" runat="server" Width="320px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="지원학과" Description="지원학과" BindMode="All"></cc1:ExDropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    </div>
                    <!-- 인쇄버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar2" runat="server" PrintVisible="true" />
                    </div>
                    <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!--성적사정표 리스트 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pull-left grdList">성적사정표 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="ibox-content p-n">
                    <%--                    <div class="table-responsive">--%>
                    <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="600px">
                        <%--<div id="MainContent_ComDivScroll1" onscroll="document.getElementById('MainContent_ComDivScroll1_value').value = this.scrollTop" style="width: 3300px; height: 450px; overflow-y: visible; cursor: pointer;">--%>
                        <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active" ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="70">
                            <Columns>
                                <%--1--%><asp:BoundField HeaderText="지원학과(계열)" DataField="LessonName" HeaderStyle-Width="15%" ItemStyle-CssClass="textWrap text-left" />
                                <%--2--%><asp:BoundField HeaderText="전공" DataField="majorname" HeaderStyle-Width="15%" ItemStyle-CssClass="textWrap text-left" />
                                <%--3--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="15%" ItemStyle-CssClass="textWrap text-left" />
                                <%--4--%><asp:BoundField HeaderText="석차" DataField="Rank" HeaderStyle-Width="4%" ItemStyle-CssClass="textWrap text-rignt" />
                                <%--5--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="7%" ItemStyle-CssClass="textWrap text-center" />
                                <%--6--%><asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-center" />
                                <%--7--%><asp:BoundField HeaderText="출신고" DataField="neisName" HeaderStyle-Width="12%" ItemStyle-CssClass="textWrap text-left" />
                                <%--8--%><asp:BoundField HeaderText="총점" DataField="totalScore" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-rignt" DataFormatString="{0:0.00}" />
                                <%--9--%><asp:BoundField HeaderText="교과성적" DataField="highSchoolScore" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-rignt" DataFormatString="{0:0.00}" />
                                <%--10--%><asp:BoundField HeaderText="출석" DataField="absenceScore" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-rignt" />
                                <%--11--%><asp:BoundField HeaderText="수능" DataField="examScoreSum" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-rignt" DataFormatString="{0:0.00}" />
                                <%--12--%><asp:BoundField HeaderText="면접" DataField="interview" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-rignt" DataFormatString="{0:0.00}" />
                                <%--13--%><asp:BoundField HeaderText="지원연도" DataField="Year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--14--%><asp:BoundField HeaderText="지원시기" DataField="season" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                        <%-- </div>--%>
                        <div class="col-xs-12 m-b-n fixedbt">
                            <uc:CommonPager ID="CommonPager1" runat="server" />
                        </div>
                    </cc2:ComDivScroll>
                    <%--</div>--%>
                </div>
            </div>
            <!--성적사정표 리스트 끝 -->
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txt지원연도조회.ClientID %>').on('blur', function () {
                var $applyYear = $('#<%= txt지원연도조회.ClientID %>').val();

                if ($applyYear == '' || $applyYear.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });

        });
    </script>
    <%--<uc2:report ID="Report1" runat="server" />--%>
    <uc1:reportInvoker ID="rv1" runat="server" />
</asp:Content>