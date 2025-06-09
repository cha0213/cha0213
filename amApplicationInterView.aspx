<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amApplicationInterView.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amApplicationInterView" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc" %>
<%@ Register Src="/COFF/CONTROL/COFF/StudSearchControl.ascx" TagPrefix="uc1" TagName="StudSearch" %>
<%@ Register Src="/COFF/CONTROL/ENTR/HighschoolSearch.ascx" TagPrefix="uc2" TagName="Highschool" %>

<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function SaveEventHandler() {
            if (ClientValidate('divInput')) {
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div id="divInput">
            <!-- 상단 조회 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 지원연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txt지원연도조회">지원연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt지원연도조회" runat="server" Width="55px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar1_Search;ExToolBar3_Print" Description="지원연도" ToolTip="지원연도" Required="true"></cc1:ExTextBox>
                    </div>

                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl지원시기조회">지원시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl지원시기조회" runat="server" CssClass="form-control" Width="150px" Group="ExToolBar1_Search;ExToolBar3_Print" Description="지원시기" ToolTip="지원시기" CodeType="_공통" BindMode="None" P1="SA02" Required="true"></cc1:ExDropDownList>
                    </div>
                    &nbsp
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>

                            <!-- 전형구분 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl전형구분조회">전형구분 :</asp:Label>
                                <cc1:ExDropDownList ID="ddl전형구분조회" runat="server" CssClass="form-control" Width="300px" Group="ExToolBar1_Search;ExToolBar3_Print" Description="전형구분" ToolTip="전형구분" CodeType="_일반" BindMode="All"></cc1:ExDropDownList>
                            </div>

                            <!-- 지원학과 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl지원학과조회">지원학과 :</asp:Label>
                                <cc1:ExDropDownList ID="ddl지원학과조회" runat="server" CssClass="form-control" Width="380px" Group="ExToolBar1_Search;ExToolBar3_Print" Description="지원학과" ToolTip="지원학과" CodeType="_일반" BindMode="All"></cc1:ExDropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
                    <br />
                    <!-- 출신고교 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtNeisName">출신고교 :</asp:Label>
                        <%--<cc1:ExDropDownList ID="ddl출신고교" runat="server" CssClass="form-control" Width="200px" Group="ExToolBar1_Search;ExToolBar3_Print" Description="출신고교" ToolTip="출신고교" CodeType="_일반" BindMode="All">
                            <asp:ListItem Value="%">전체</asp:ListItem>
                            <asp:ListItem Value="S100000464">거제고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000465">거제공업고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000469">경남산업고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000467">거제여자고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000470">거제중앙고등학교</asp:ListItem>
                            <asp:ListItem Value="S100003299">거제옥포고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000468">거제제일고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000741">해성고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000714">통영고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000716">통영여자고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000708">충무고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000717">통영제일고등학교</asp:ListItem>
                            <asp:ListItem Value="S100000706">충렬여자고등학교</asp:ListItem>
                        </cc1:ExDropDownList>--%>
                        <uc2:Highschool ID="txtNeisName" runat="server" Group="ExToolBar3_Save" DisplayToolTip="출신고교명" Description="출신고교명" ValueToolTip="출신고교명" neisNameWidth="280px" ReadOnly="false" />
                    </div>

                    <!-- 성명/수험번호 recpNo -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="StudNoSearch">수험번호 :</asp:Label>
                        <%--<cc1:ExTextBox ID="txt성명수험번호조회" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar3_Print" Description="성명/수험번호" ToolTip="성명/수험번호"></cc1:ExTextBox>--%>
                        <uc1:StudSearch ID="StudNoSearch" runat="server" DisplayControlWidth="150px" Group="ExToolBar1_Search;ExToolBar3_Print" Description="수험번호" DisplayToolTip="수험번호" ValueToolTip="수험번호" MenuType="FreshMan" />
                    </div>

                    <!-- 구분 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rbl구분조회">구분 :</asp:Label>
                        <cc1:ExRadioButtonList ID="rbl구분조회" runat="server" Group="ExToolBar1_Search" Description="구분" ToolTip="구분" RepeatDirection="Horizontal" CssClass="form-control" RepeatLayout="Flow">
                            <asp:ListItem Text="면접대상만 조회" Value="30" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="전체조회" Value="%"></asp:ListItem>
                        </cc1:ExRadioButtonList>
                    </div>

                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true"></cc1:ExToolBar>
                    </div>

                    <!-- 인쇄구분 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rbl인쇄구분">인쇄구분 :</asp:Label>
                        <cc1:ExRadioButtonList ID="rbl인쇄구분" runat="server" Group="ExToolBar1_Search;ExToolBar3_Print" Description="인쇄구분" ToolTip="인쇄구분" RepeatDirection="Horizontal" CssClass="form-control" RepeatLayout="Flow">
                            <asp:ListItem Text="전체" Value="%" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="개인" Value="1"></asp:ListItem>
                            <asp:ListItem Text="개인(20%)" Value="4"></asp:ListItem>
                            <asp:ListItem Text="개인(100%)" Value="5"></asp:ListItem>
                            <asp:ListItem Text="수험표" Value="3"></asp:ListItem>
                        </cc1:ExRadioButtonList>
                    </div>

                    <!-- 인쇄버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar3" runat="server" PrintVisible="true" />
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!-- 면접점수 입력 리스트 시작 -->
            <div class="panel panel-default">
                <div class="panel-heading ">
                    <h3 class="panel-title pull-left grdList" id="headtitle" runat="server">면접점수 입력 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="800px">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="15" TableSummary="면접점수 입력 리스트" TableCaption="면접점수 입력 리스트">
                            <Columns>
                                <%--1 지원학과--%>
                                <asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" HeaderStyle-Width="19%" />
                                <%--2 수험번호--%>
                                <asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HeaderStyle-Width="5%" />
                                <%--3 연락처--%>
                                <asp:BoundField HeaderText="연락처" DataField="celPhone" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HeaderStyle-Width="9%" />
                                <%--4 성명--%>
                                <asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HeaderStyle-Width="8%" />
                                <%--5 출신고교--%>
                                <asp:BoundField HeaderText="출신고교" DataField="neisName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" HeaderStyle-Width="9%" />
                                <%--6 내신등급--%>
                                <asp:BoundField HeaderText="내신등급" DataField="highSchoolGrade" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" HeaderStyle-Width="6%" />
                                <%--7 전형구분--%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsCodeName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" HeaderStyle-Width="20%" />
                                <%--8 부가점수--%>
                                <asp:TemplateField HeaderText="부가점수">
                                    <HeaderStyle Width="6%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <cc1:ExTextBox ID="txt부가점수" CssClass="form-control text-right" runat="server" Width="60px" Description="부가점수" ToolTip="부가점수" Text='<%# DataBinder.Eval(Container.DataItem, "AdditionalScore") %>' Enabled='<%# DataBinder.Eval(Container, "DataItem.pass").ToString() == "30" && DataBinder.Eval(Container, "DataItem.PosibleInput").ToString() == "Y" %>' Group="ExToolBar2_Save" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--9 면접점수--%>
                                <asp:TemplateField HeaderText="면접점수">
                                    <HeaderStyle Width="6%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <cc1:ExTextBox ID="txt면접점수" CssClass="form-control text-right" runat="server" Width="60px" Description="면접점수" ToolTip="면접점수" Text='<%# DataBinder.Eval(Container.DataItem, "interview") %>' Enabled='<%# DataBinder.Eval(Container, "DataItem.pass").ToString() == "30" && DataBinder.Eval(Container, "DataItem.PosibleInput").ToString() == "Y" %>' Group="ExToolBar2_Save" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--10 면접일자--%>
                                <asp:TemplateField HeaderText="면접일자">
                                    <HeaderStyle Width="13%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center form-inline" />
                                    <ItemTemplate>
                                        <div class="form-group form-group-sm ">
                                            <cc1:ExDatePicker ID="edp면접일자" runat="server" onkeydown=""
                                                SelectedDate='<%# DataBinder.Eval(Container.DataItem,"interViewDate") %>' Enabled='<%# DataBinder.Eval(Container, "DataItem.pass").ToString() == "30" && DataBinder.Eval(Container, "DataItem.PosibleInput").ToString() == "Y" %>'
                                                Group="ExToolBar2_Save" ValidationType="Date" Description="면접일자" ToolTip="면접일자" Width="160px">
                                            </cc1:ExDatePicker>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--11 면접대상 구분 --%>
                                <asp:BoundField HeaderText="구분" DataField="pass" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--12 지원연도 --%>
                                <asp:BoundField HeaderText="지원연도" DataField="year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--13 지원시기 --%>
                                <asp:BoundField HeaderText="지원시기" DataField="season" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--14 전형구분코드 --%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--15 지원학과코드 --%>
                                <asp:BoundField HeaderText="지원학과" DataField="majorCode1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--16 출신고교코드 --%>
                                <asp:BoundField HeaderText="출신고교" DataField="neisCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                        <div class="col-xs-12 m-b-n fixedbt">
                            <uc:CommonPager ID="CommonPager1" runat="server" />
                        </div>
                    </cc2:ComDivScroll>
                </div>
                <!-- 버튼영역 -->
                <div class="panel-footer">
                    <div class="row">
                        <div class="col-xs-6 text-left">
                            <asp:Label ID="lblInterviewInfo" runat="server" Style="color: red;"></asp:Label>
                        </div>
                        <div class="col-xs-6 text-right">
                            <div class="form-group form-group-sm">
                                <div class="form-inline">
                                    <asp:Label runat="server" CssClass="control-label" Style="width: 80px" AssociatedControlID="edp일괄면접일자">면접일자 : </asp:Label>
                                    <cc1:ExDatePicker ID="edp일괄면접일자" runat="server" Description="면접일자" ToolTip="면접일자" Width="160px" ValidationType="Date"></cc1:ExDatePicker>
                                    <cc1:ExToolBar ID="ExToolBar4" runat="server" Etc2Visible="true" Etc2Text="일괄입력" Etc2CSS="btn btn-sm btn-default" />
                                    <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 면접점수 입력 리스트 끝 -->
        </div>
    </div>
    <asp:HiddenField ID="hdnPageNo" runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {
            changePrintGubun();

            $('#<%= ExToolBar3.ClientID %>_Print').on('click', function () {
                var $Stud = $('#<%= StudNoSearch.ClientID %>_txtStudNo').val();
                var $Year = $('#<%= txt지원연도조회.ClientID %>').val();
                if ($('#<%= rbl인쇄구분.ClientID %>_5').is(':checked')) {
                    if ($Year == '') {
                        alertMessage('지원연도은(는) 필수항목 입니다.');
                        return false;
                    }
                    else if ($Stud == '') {
                        alertMessage('성명/수험번호은(는) 필수항목 입니다.');
                        return false;
                    }
                    else {
                        return true;
                    }
                }
                else {
                    return true;
                }
                return false;
            });

            $('#<%= txt지원연도조회.ClientID %>').on('blur', function () {
                var $Year = $(this).val();

                if ($Year == '' || $Year.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });

            $('#<%= ddl지원시기조회.ClientID %>').on('change', function () {
                $('#<%= rbl인쇄구분.ClientID %>_0').prop('checked', true);
                changePrintGubun();
            });
        });

        function changePrintGubun() {
            var $season = $('#<%= ddl지원시기조회.ClientID %>').val();
            if ($season == "1" || $season == "2" || $season == "4" || $season == "5") { // 수시1차, 수시2차, 정시, 추가모집 일 경우 인쇄구분에서 [개인] 사용안함, [개인(20%), 개인(100%)] 사용
                $('#<%= rbl인쇄구분.ClientID %>_1').attr('disabled', true); // 개인
                $('#<%= rbl인쇄구분.ClientID %>_2').attr('disabled', false);  // 개인(20%)
                $('#<%= rbl인쇄구분.ClientID %>_3').attr('disabled', false);  // 개인(100%)
            }
            else {
                $('#<%= rbl인쇄구분.ClientID %>_1').attr('disabled', false); // 개인
                $('#<%= rbl인쇄구분.ClientID %>_2').attr('disabled', true);  // 개인(20%)
                $('#<%= rbl인쇄구분.ClientID %>_3').attr('disabled', true);  // 개인(100%)
            }
        }
    </script>
    <uc2:report ID="Report1" runat="server" />
</asp:Content>