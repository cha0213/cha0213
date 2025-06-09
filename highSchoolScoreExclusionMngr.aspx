<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreExclusionMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreExclusionMngr" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>
<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
    </script>
</asp:Content>

<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div id="divInput">
            <!-- 상단 조회 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 지원연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass=" control-label" AssociatedControlID="txt지원연도조회">연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt지원연도조회" runat="server" Width="55px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar1_Search" Description="연도" ToolTip="연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl지원시기조회">지원시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl지원시기조회" runat="server" CssClass="form-control" Width="180px" Group="ExToolBar1_Search" Description="지원시기" ToolTip="지원시기" CodeType="_공통" BindMode="None" P1="SA02" Required="true"></cc1:ExDropDownList>
                    </div>
                    <!-- 제외여부 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl제외여부조회">제외여부 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl제외여부조회" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search" Description="제외여부" ToolTip="제외여부" CodeType="_일반" BindMode="All">
                            <asp:ListItem Value="%">전체</asp:ListItem>
                            <asp:ListItem Value="1">제외</asp:ListItem>
                            <asp:ListItem Value="2">일부제외</asp:ListItem>
                            <asp:ListItem Value="3">미제외</asp:ListItem>
                        </cc1:ExDropDownList>
                    </div>
                    <!-- 점수미존재 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs sr-only" AssociatedControlID="chk점수미존재조회">점수미존재 :</asp:Label>
                        <cc1:ExCheckBox ID="chk점수미존재조회" runat="server" CssClass="checkbox-inline" Group="ExToolBar1_Search" Text="점수미존재" ToolTip="점수미존재"></cc1:ExCheckBox>
                        <cc1:ExCheckBox ID="chk평균0인과목만조회" runat="server" CssClass="checkbox-inline" Group="ExToolBar1_Search" Text="평균0인 과목만" ToolTip="평균0인 과목만"></cc1:ExCheckBox>
                    </div>
                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true"></cc1:ExToolBar>
                        <cc1:ExToolBar ID="ExToolBar4" runat="server" Etc3Visible="true" Etc3CSS="btn btn-sm btn-default" Etc3Text="엑셀" />
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <div class="row">
                <!-- 좌측 리스트 시작 -->
                <div class="col-xs-6">
                    <!-- 학생부 성적 교과 리스트 시작 -->
                    <div class="panel panel-default">
                        <!-- 타이틀 영역 -->
                        <div class="panel-heading">
                            <h3 class="panel-title pull-left grdList">학생부 성적 교과 리스트</h3>
                            <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                        </div>
                        <!-- 목록 영역 -->
                        <div class="panel-body p-n">
                            <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="470px">
                                <cc1:ExGridView ID="grdList" runat="server"
                                    AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                                    SelectedRowStyle-CssClass="active"
                                    ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="학생부 성적 교과 리스트" TableCaption="학생부 성적 교과 리스트"
                                    OnRowCommand="grdList_RowCommand">
                                    <Columns>
                                        <%--1 편제코드--%>
                                        <asp:TemplateField HeaderText="편제코드">
                                            <HeaderStyle CssClass="text-center" Width="20%" />
                                            <ItemStyle CssClass="text-center" />
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkOrganizationCode" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.OrganizationCode") %>' CommandName="SELECT"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--2 편제명--%>
                                        <asp:BoundField HeaderText="편제명" DataField="OrganizationName" HeaderStyle-Width="24%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--3 교과코드--%>
                                        <asp:BoundField HeaderText="교과코드" DataField="CourceCode" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--4 교과명--%>
                                        <asp:BoundField HeaderText="교과명" DataField="CourceName" HeaderStyle-Width="24%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--5 제외여부--%>
                                        <asp:BoundField HeaderText="제외여부" DataField="ExclusionName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--6 선택 체크박스--%>
                                        <asp:TemplateField HeaderText="{chkRow:}">
                                            <HeaderStyle Width="10px" CssClass="text-center" />
                                            <ItemStyle CssClass="text-center" />
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--7-- 지원연도--%>
                                        <asp:BoundField HeaderText="지원연도" DataField="ApplYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                        <%--8-- 지원시기 코드--%>
                                        <asp:BoundField HeaderText="지원시기" DataField="ApplSeason" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    </Columns>
                                    <EmptyDataRowStyle CssClass="dataTables_empty" />
                                    <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                                </cc1:ExGridView>
                                <div class="col-xs-12 m-b-n fixedbt">
                                    <uc1:CommonPager ID="CommonPager1" runat="server" />
                                </div>
                            </cc2:ComDivScroll>
                        </div>
                        <!-- 버튼영역 -->
                        <div class="panel-footer">
                            <div class="text-right">
                                <cc1:ExToolBar ID="ExToolBar2" runat="server" Etc1Visible="true" Etc1Text="제외등록"></cc1:ExToolBar>
                            </div>
                        </div>
                    </div>
                    <!-- 학생부 성적 교과 리스트 끝 -->
                </div>
                <!-- 좌측 리스트 끝 -->

                <!-- 우측 리스트 시작 -->
                <div class="col-xs-6">
                    <!-- 편제코드 교과코드 시작 -->
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <div class="form-horizontal">
                                <!-- 1열 -->
                                <div class="form-group form-group-sm">
                                    <!-- 편제코드 -->
                                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="txt편제코드" Style="width: 90px">편제코드 :</asp:Label>
                                    <div class="col-xs-4 form-inline">
                                        <cc1:ExTextBox ID="txt편제코드" runat="server" Width="100%" CssClass="form-control" Group="ExToolBar3_Save" Description="편제코드" ToolTip="편제코드" Required="true" ReadOnly="true"></cc1:ExTextBox>
                                    </div>

                                    <!-- 교과코드 -->
                                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="txt교과코드">교과코드 :</asp:Label>
                                    <div class="col-xs-4 form-inline">
                                        <cc1:ExTextBox ID="txt교과코드" runat="server" Width="100%" CssClass="form-control" Group="ExToolBar3_Save" Description="교과코드" ToolTip="교과코드" Required="true" ReadOnly="true"></cc1:ExTextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 편제코드 교과코드 시작 -->

                    <!-- 학생부 성적 과목 리스트 시작 -->
                    <div class="panel panel-default">
                        <!-- 타이틀 영역 -->
                        <div class="panel-heading">
                            <h3 class="panel-title pull-left grdList">학생부 성적 과목 리스트</h3>
                            <cc1:ExDataCounter ID="ExDataCounter2" runat="server"></cc1:ExDataCounter>
                        </div>
                        <!-- 목록 영역 -->
                        <div class="panel-body p-n">
                            <cc2:ComDivScroll ID="ComDivScroll1" runat="server" class="ComDivScroll" Height="400px">
                                <cc1:ExGridView ID="grdList2" runat="server"
                                    AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                                    SelectedRowStyle-CssClass="active"
                                    ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="학생부 성적 과목 리스트" TableCaption="학생부 성적 과목 리스트">
                                    <Columns>
                                        <%--1 과목코드--%>
                                        <asp:BoundField HeaderText="과목코드" DataField="SubjectCode" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--2 과목명--%>
                                        <asp:BoundField HeaderText="과목명" DataField="SubjectName" HeaderStyle-Width="60%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--3 제외여부--%>
                                        <asp:BoundField HeaderText="제외여부" DataField="Exclusion" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                        <%--4 선택 체크박스--%>
                                        <asp:TemplateField HeaderText="{chkRow:}">
                                            <HeaderStyle Width="10px" CssClass="text-center" />
                                            <ItemStyle CssClass="text-center" />
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkRow2" runat="server"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <%--5-- 지원연도--%>
                                        <asp:BoundField HeaderText="지원연도" DataField="ApplYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                        <%--6-- 지원시기 코드--%>
                                        <asp:BoundField HeaderText="지원시기" DataField="ApplSeason" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                        <%--7-- 편제코드--%>
                                        <asp:BoundField HeaderText="편제코드" DataField="OrganizationCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                        <%--8-- 교과코드--%>
                                        <asp:BoundField HeaderText="교과코드" DataField="CourceCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    </Columns>
                                    <EmptyDataRowStyle CssClass="dataTables_empty" />
                                    <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                                </cc1:ExGridView>
                            </cc2:ComDivScroll>
                        </div>
                        <!-- 버튼영역 -->
                        <div class="panel-footer">
                            <div class="text-right">
                                <cc1:ExToolBar ID="ExToolBar3" runat="server" Etc2Visible="true" Etc2Text="제외등록"></cc1:ExToolBar>
                            </div>
                        </div>
                    </div>
                    <!-- 학생부 성적 과목 리스트 끝 -->
                </div>
                <!-- 우측 리스트 끝 -->
            </div>
        </div>
    </div>
</asp:Content>

<%--푸터--%>
<asp:Content runat="server" ID="Footer" ContentPlaceHolderID="FooterContent">
    <script type="text/javascript">
        $(document).ready(function () {

            //좌측 리스트 제외등록
            $('#<%= ExToolBar2.ClientID %>' + '_Etc1').on('click', function (e) {
                if (ClickChkSelect('좌측 학생부 성적 교과 리스트에서 제외등록', 'grdList', 'chkRow', 0)) { //할 항목을 선택 하셔야 합니다.
                    confirmMessage("해당 교과에 해당하는 과목 전체에 대하여 제외 과목으로 등록 합니다. 제외등록을 수행 하시겠습니까?", $(this));
                }
                else {
                    return false;
                }
                return false;
            });

            //우측 리스트 제외등록
            $('#<%= ExToolBar3.ClientID %>' + '_Etc2').on('click', function (e) {
                if (ClickChkSelect('우측 학생부 성적 과목 리스트에서 제외등록', 'grdList2', 'chkRow2', 0)) { //할 항목을 선택 하셔야 합니다.
                    confirmMessage("선택한 과목에 대하여 제외 과목으로 등록 합니다. 제외등록을 수행 하시겠습니까?", $(this));
                }
                else {
                    return false;
                }
                return false;
            });
        });
    </script>
</asp:Content>