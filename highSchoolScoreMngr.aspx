<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreMngr" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>
<%@ Register Src="~/COFF/CONTROL/COFF/StudSearchControl.ascx" TagPrefix="uc2" TagName="StudSearch" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div id="divSearch" class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplYear">지원연도 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplYear" runat="server" CssClass="form-control" Width="55px" Required="true" MaxLength="4" FixLength="4" ValidationType="Numeric" Group="ExToolBar1_Search;ExToolBar2_Save" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplSeason">지원시기 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplSeason" runat="server" CodeType="_공통" P1="SA02" Width="100px" BindMode="Select" Required="true" Group="ExToolBar1_Search;ExToolBar2_Save" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="StudSearch">수험번호 : </asp:Label>
                    <uc2:StudSearch ID="StudSearch" runat="server" MenuType="FreshMan" DisplayToolTip="성명" ValueToolTip="수험번호" Description="수험번호" Group="ExToolBar1_Search" />
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" SaveText="고교학생부 이관" />
                </div>
                <asp:HiddenField ID="hdnApplYear" runat="server" />
                <asp:HiddenField ID="hdnApplSeason" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">고교학생부 등록 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 373px">
                            <cc1:ExGridView ID="grdList1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="고교학생부 등록 리스트" TableCaption="고교학생부 등록 리스트" Width="100%"
                                OnRowCommand="grdList1_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="수험번호">
                                        <HeaderStyle Width="7%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="HyperLink1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.recpNo") %>' CommandName="SELECT"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--2--%><asp:BoundField HeaderText="성명" DataField="KorName" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--3--%><asp:BoundField HeaderText="고교명" DataField="neisName" HeaderStyle-Width="22%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--4--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--5--%><asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--6--%><asp:BoundField HeaderText="과목수" DataField="CNT" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--7--%><asp:BoundField HeaderText="성적반영여부" DataField="CalcScoreYN" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--8--%><asp:BoundField HeaderText="지원연도" DataField="ApplYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--9--%><asp:BoundField HeaderText="지원시기" DataField="ApplSeason" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--10--%><asp:BoundField HeaderText="주민번호" DataField="resdNo" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                            <div class="col-xs-12 m-b-n fixedbt">
                                <uc1:CommonPager ID="CommonPager1" runat="server" />
                            </div>
                        </cc2:ComDivScroll>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">교과학습 내역 리스트&nbsp;
                             [ 수험번호:
                                <asp:Label ID="lblrecpNo1" runat="server" CssClass="m-r-xs text-primary strong" Width="80px"></asp:Label>
                            성명:
                                <asp:Label ID="lblStudentName1" runat="server" CssClass="m-r-xs text-primary strong" Width="90px"></asp:Label>
                            ]
                        </h3>
                        <cc1:ExDataCounter ID="ExDataCounter2" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll2" runat="server" Style="height: 174px">
                            <cc1:ExGridView ID="grdList2" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="교과학습 내역 리스트" TableCaption="교과학습 내역 리스트" Width="100%">
                                <Columns>
                                    <asp:BoundField HeaderText="학년도" DataField="Year" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="학년" DataField="Grade" HeaderStyle-Width="3.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="학기" DataField="Term" HeaderStyle-Width="3.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="편제명" DataField="OrganizationName" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <asp:BoundField HeaderText="교과명" DataField="CourceName" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <asp:BoundField HeaderText="과목명" DataField="SubjectName" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <asp:BoundField HeaderText="이수단위" DataField="Unit" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="성취도" DataField="Assessment" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="석차" DataField="Rank" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="동석차" DataField="SameRank" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="재적수" DataField="StudentCount" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="원점수" DataField="OriginalScore" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="평균" DataField="AvgScore" HeaderStyle-Width="4.5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="표준편차" DataField="StandardDeviation" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                                    <asp:BoundField HeaderText="석차등급" DataField="RankingGrade" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="등급코드" DataField="RankingGradeCode" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="성취평가" DataField="Achievement" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HtmlEncode="false" />
                                    <asp:BoundField HeaderText="평가코드" DataField="AchievementCode" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HtmlEncode="false" />
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                        </cc2:ComDivScroll>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">출결 내역 리스트&nbsp;
                             [ 수험번호:
                                <asp:Label ID="lblrecpNo2" runat="server" CssClass="m-r-xs text-primary strong" Width="80px"></asp:Label>
                            성명:
                                <asp:Label ID="lblStudentName2" runat="server" CssClass="m-r-xs text-primary strong" Width="90px"></asp:Label>
                            ]
                        </h3>
                        <cc1:ExDataCounter ID="ExDataCounter3" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll3" runat="server" Style="height: 120px">
                            <cc1:ExGridView ID="grdList3" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="교과학습 내역 리스트" TableCaption="교과학습 내역 리스트" Width="100%">
                                <Columns>
                                    <asp:BoundField HeaderText="학년도" DataField="Year" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="학년" DataField="Grade" HeaderStyle-Width="4%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="수업일수" DataField="StudyDayCount" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결석질병" DataField="Absence_Disease" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결석사고" DataField="Absence_Accident" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결석기타" DataField="Absence_Etc" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="지각질병" DataField="Lateness_Disease" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="지각사고" DataField="Lateness_Accident" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="지각기타" DataField="Lateness_Etc" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="조퇴질병" DataField="EarlyLeaving_Disease" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="조퇴사고" DataField="EarlyLeaving_Accident" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="조퇴기타" DataField="EarlyLeaving_Etc" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결과질병" DataField="Result_Disease" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결과사고" DataField="Result_Accident" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="결과기타" DataField="Result_Etc" HeaderStyle-Width="5%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="특기사항" DataField="Specials" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                        </cc2:ComDivScroll>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <uc1:Modal ID="modalFileUpload" runat="server" ModalId="FileUpload" ModalTitle="고교학생부 이관" ShowCloseButton="true">
        <ModalBodyTemplate>
            <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
        </ModalBodyTemplate>
    </uc1:Modal>

    <script type="text/javascript">

        function StudentFileUpload() {

            // 필수항목 체크
            if (!ClientValidate('divSearch')) return false;

            var applyear = $("#<%=txtSearchApplYear.ClientID%>").val();
            var applseason = $("#<%=ddlSearchApplSeason.ClientID%>").val();

            var modalId = '#<%= modalFileUpload.ModalId %>';
            var height = 430;
            var src = "/ENTR/StaffMngr/highSchoolScoreUpload.aspx?ApplYear=" + applyear + "&ApplSeason=" + applseason;
            $(modalId)
                .find('.modal-body iframe')
                .css({ 'height': height + 'px' })
                .attr({ 'src': src });

            window.modalCallback = CompleteUpload;

            $(modalId).modal('show');

            return false;
        }

        function CompleteUpload() {

            var modalId = '#<%= modalFileUpload.ModalId %>';
            $(modalId).modal('hide');
            window.modalCallback = null;

            stopSpin();

            alertMessage('고교학생부 이관 작업이 완료 되었습니다.');
                <%--$('#<%= ExToolBar1.ClientID %>' + '_Search').click();--%>
        }

        $(document).ready(function () {
            $('#<%= txtSearchApplYear.ClientID%>').on('blur', function () {

                var $Year = $('#<%= txtSearchApplYear.ClientID%>_txtYear');

                var $StudSearchYear = $('#<%= StudSearch.ClientID%>_hidYear');
                var $StudSearchSeason = $('#<%= StudSearch.ClientID%>_hidSeason');

                $StudSearchYear.val($Year.val());
                $StudSearchSeason.val('');

            });
        });
    </script>
</asp:Content>