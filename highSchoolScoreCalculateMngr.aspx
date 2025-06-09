<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreCalculateMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreCalculateMngr" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/SCFF/BaseLectureSearch.ascx" TagPrefix="uc1" TagName="BaseLectureSearch" %>
<%@ Register Src="~/COFF/CONTROL/SCFF/YearTermControl.ascx" TagPrefix="uc2" TagName="yt" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc" %>
<%@ Register Src="~/COFF/CONTROL/COFF/StudSearchControl.ascx" TagPrefix="uc2" TagName="StudSearch" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplYear">지원연도 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplYear" runat="server" CssClass="form-control" Width="55px" Required="true" MaxLength="4" FixLength="4" ValidationType="Numeric" Group="ExToolBar1_Search" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplSeason">지원시기 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplSeason" runat="server" CodeType="_공통" P1="SA02" Width="100px" BindMode="All" Required="true" Group="ExToolBar1_Search" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                </div>
                &nbsp
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchGubun">전형구분 : </asp:Label>
                            <cc1:ExDropDownList ID="ddlSearchGubun" runat="server" Width="300px" CodeType="_일반" BindMode="All" Group="ExToolBar1_Search" ToolTip="전형구분" Description="전형구분"></cc1:ExDropDownList>
                        </div>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplOrgID">지원학과 : </asp:Label>
                            <cc1:ExDropDownList ID="ddlSearchApplOrgID" runat="server" Width="380px" CodeType="_일반" BindMode="All" Group="ExToolBar1_Search" ToolTip="지원학과" Description="지원학과"></cc1:ExDropDownList>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label" AssociatedControlID="StudSearch">수험번호 :</asp:Label>
                    <uc2:StudSearch ID="StudSearch" runat="server" CssClass="form-control" ToolTip="수험번호" Description="수험번호" DisplayToolTip="수험번호" ValueToolTip="수험번호" MenuType="FreshMan" Group="ExToolBar1_Search" />
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" SaveText="성적산출" />
                    <%--<cc1:ExToolBar ID="ExToolBar3" runat="server" SaveVisible="true" SaveText="순위산출" />--%>
                </div>
            </div>
        </div>
        <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left grdList">성적산출 리스트</h3>
                <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
            </div>
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ComDivScroll1" class="ComDivScroll" runat="server" Style="height: 500px">
                    <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                        ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="성적산출 리스트" TableCaption="성적산출 리스트" Width="100%">
                        <Columns>
                            <%--1--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--1--%><asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--2--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--3--%><asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--4--%><asp:BoundField HeaderText="총점" DataField="totalScore" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" DataFormatString="{0:n2}" />
                            <%--5--%><asp:BoundField HeaderText="교과성적" DataField="highSchoolScore" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" DataFormatString="{0:n2}" />
                            <%--6--%><asp:BoundField HeaderText="교과등급" DataField="highSchoolGrade" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--7--%><asp:BoundField HeaderText="출석" DataField="absenceScore" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--8--%><asp:BoundField HeaderText="수능" DataField="examScoreSum" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--9--%><asp:BoundField HeaderText="면접" DataField="InterView" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--10--%><asp:BoundField HeaderText="석차" DataField="Rank" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--11--%><asp:BoundField HeaderText="예비석차" DataField="SubRank" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <%--12--%><asp:BoundField HeaderText="합격코드" DataField="PassName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                        </Columns>
                        <EmptyDataRowStyle CssClass="dataTables_empty" />
                        <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                    </cc1:ExGridView>
                    <div class="col-xs-12 m-b-n fixedbt">
                        <uc:CommonPager ID="CommonPager1" runat="server" />
                    </div>
                </cc2:ComDivScroll>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left grdList">3단위 이상 3과목 미달 학생 리스트</h3>
                <cc1:ExDataCounter ID="ExDataCounter2" runat="server" />
            </div>
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ComDivScroll2" runat="server" Style="height: 175px">
                    <cc1:ExGridView ID="grdList_verifi1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                        ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="5" TableSummary="학생부 검증 리스트" TableCaption="학생부 검증 리스트" Width="100%">
                        <Columns>
                            <%--1--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--2--%><asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--3--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--4--%><asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-Width="25%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--5--%><asp:BoundField HeaderText="고등학교" DataField="NeisName" HeaderStyle-Width="35%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                        </Columns>
                        <EmptyDataRowStyle CssClass="dataTables_empty" />
                        <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                    </cc1:ExGridView>
                </cc2:ComDivScroll>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left grdList">1,2,3학년 성적 미존재 학생 리스트</h3>
                <cc1:ExCheckBox ID="chkScoreExceptYN" runat="server" CssClass="checkbox" Text="3학년 2학기 성적 제외" Checked="true" Style="margin-left: 30px" />
                <cc1:ExCheckBox ID="chkCollegeExceptYN" runat="server" CssClass="checkbox" Text="대학(전문대)졸업자 전형 제외" Checked="true" Style="margin-left: 10px" />
                <cc1:ExDataCounter ID="ExDataCounter3" runat="server" />
            </div>
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ComDivScroll3" runat="server" Style="height: 175px">
                    <cc1:ExGridView ID="grdList_verifi2" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                        ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="5" TableSummary="학생부 검증 리스트" TableCaption="학생부 검증 리스트" Width="100%">
                        <Columns>
                            <%--1--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--2--%><asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--3--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--4--%><asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-Width="25%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--5--%><asp:BoundField HeaderText="고등학교" DataField="NeisName" HeaderStyle-Width="35%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                        </Columns>
                        <EmptyDataRowStyle CssClass="dataTables_empty" />
                        <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                    </cc1:ExGridView>
                </cc2:ComDivScroll>
            </div>
        </div>
    </div>
    <asp:Button ID="btnReSearch" runat="server" CssClass="hidden" />
    <asp:HiddenField ID="hdnPageNo" runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {

            $('#<%= ExToolBar2.ClientID %>' + '_Save').on('click', function (e) {
                var rValue = false;
                var $btnUpload = $(this);

                parent.startSpin();
                confirmMessage2("성적산출 수행은 다소 시간이 소요 될 수 있습니다.<br />성적산출 작업을 수행 하시겠습니까?", $btnUpload);

                return rValue;

            });

            $('#<%= txtSearchApplYear.ClientID %>').on('blur', function () {
                var $applyYear = $('#<%= txtSearchApplYear.ClientID %>').val();
                if ($applyYear == '' || $applyYear.length < 4) {
                    return false;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });

            $('#<%= chkCollegeExceptYN.ClientID %>').on('change', function () {
                $('#<%= btnReSearch.ClientID %>').click();
            });

            $('#<%= chkScoreExceptYN.ClientID %>').on('change', function () {
                $('#<%= btnReSearch.ClientID %>').click();
            });
        });

        // 시간이 오래 걸리는 관계로 Spiner 를 사용하기 위해..
        function confirmMessage2(msg, $obj) {

            var agent = navigator.userAgent.toLowerCase();

            if (typeof (window.parent.getTopPanelHeight) == "function") {
                var TabPanelScrollHeight = window.parent.getTopPanelHeight();

                var box = bootbox.confirm({
                    title: confirmTitle,
                    message: msg,
                    callback: function (confirmed) {
                        if (confirmed) {
                            $obj.off('click');
                            $obj.trigger('click');
                        }
                        else {
                            parent.stopSpin();
                        }
                    }
                , show: false
                });

                box.on("shown.bs.modal", function (e) {
                    if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) || agent.search("edge/") > -1) {
                        window.parent.setTopPanelHeight(0);
                    }
                    else {
                        // IE 가 아닐경우..
                        TabPanelScrollHeight = window.parent.getTopPanelHeight();
                        $(document).find('.modal-content').css({ 'margin-top': TabPanelScrollHeight })
                    }
                });

                box.on("hide.bs.modal", function () {
                    window.parent.setTopPanelHeight(TabPanelScrollHeight);
                });

                box.modal('show');
            }
            else {
                var box = bootbox.confirm({
                    title: confirmTitle,
                    message: msg,
                    callback: function (confirmed) {
                        if (confirmed) {
                            $obj.off('click');
                            $obj.trigger('click');
                        }
                        else {
                            parent.stopSpin();
                        }
                    }
                });
            }
        }
    </script>
</asp:Content>