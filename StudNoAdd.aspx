<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudNoAdd.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.StudNoAdd" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>

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
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt연도">연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt연도" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Group="ExToolBar1_Etc1;ExToolBar2_Etc2;ExToolBar3_Etc3;ExToolBar6_Print" Description="연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 계열구분 (정규)-->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl계열구분">계열구분 :</asp:Label>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                    <cc1:ExDropDownList ID="ddl계열구분" runat="server" CssClass="form-control" Width="400px" CodeType="_일반" BindMode="Select" Group="ExToolBar1_Etc1" ToolTip="계열구분" Description="계열구분" Required="true">
                                        <%--<asp:ListItem Value="00" Selected="True">선택</asp:ListItem>
                                        <asp:ListItem Value="11">기계공학과</asp:ListItem>
                                        <asp:ListItem Value="13">선박전기과</asp:ListItem>
                                        <asp:ListItem Value="12">조선해양공학과</asp:ListItem>
                                        <asp:ListItem Value="14">조선기술과</asp:ListItem>
                                        <asp:ListItem Value="15">사회계열</asp:ListItem>
                                        <asp:ListItem Value="16">유아교육과</asp:ListItem>
                                        <asp:ListItem Value="17">간호학과</asp:ListItem>
                                        <asp:ListItem Value="41">전공심화(기계)</asp:ListItem>
                                        <asp:ListItem Value="46">전공심화(유아)</asp:ListItem>
                                        <asp:ListItem Value="47">전공심화(간호)</asp:ListItem>
                                        <asp:ListItem Value="45">전공심화(사회계열)</asp:ListItem>--%>
                                    </cc1:ExDropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnReBindDdlOrgID" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <!-- 학과구분코드 (정규)-->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt학과구분코드정규">학과구분코드 : </asp:Label>
                            <cc1:ExTextBox ID="txt학과구분코드정규" runat="server" CssClass="form-control text-center" Width="50px" Group="ExToolBar1_Etc1" ToolTip="정규학과구분" Description="정규학과구분" ReadOnly="true"></cc1:ExTextBox>
                        </div>
                        <!-- 입학일 (정규)-->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="edp입학일정규">입학일 : </asp:Label>
                            <cc1:ExDatePicker ID="edp입학일정규" runat="server" ToolTip="정규입학일" Description="정규입학일"></cc1:ExDatePicker>
                        </div>
                        <!-- 일괄처리 버튼 (정규)-->
                        <div class="form-group form-group-sm">
                            <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1CSS="btn btn-sm btn-primary" Etc1Text="일괄처리" />
                        </div>
                        <br />
                        <!-- 2열 -->
                        <!-- 위탁 -->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" Style="margin-left: 133px" AssociatedControlID="ddl위탁">위탁 :</asp:Label>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <cc1:ExDropDownList ID="ddl위탁" runat="server" CssClass="form-control" Width="400px" CodeType="_일반" BindMode="Select" Group="ExToolBar2_Etc2" ToolTip="위탁" Description="위탁" Required="true">
                                        <%--<asp:ListItem Value="00" Selected="True">선택</asp:ListItem>
                                    <asp:ListItem Value="34">조선과</asp:ListItem>
                                    <asp:ListItem Value="35">사회계열</asp:ListItem>--%>
                                </cc1:ExDropDownList>
                            </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnReBindDdlOrgID" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <!-- 학과구분코드 (위탁)-->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt학과구분코드위탁">학과구분코드 : </asp:Label>
                            <cc1:ExTextBox ID="txt학과구분코드위탁" runat="server" CssClass="form-control text-center" Width="50px" Group="ExToolBar2_Etc2" ToolTip="위탁학과구분" Description="위탁학과구분" ReadOnly="true"></cc1:ExTextBox>
                        </div>
                        <!-- 입학일 (위탁)-->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="edp입학일위탁">입학일 : </asp:Label>
                            <cc1:ExDatePicker ID="edp입학일위탁" runat="server" ToolTip="위탁입학일" Description="위탁입학일" Group="ExToolBar2_Etc2"></cc1:ExDatePicker>
                        </div>
                        <!-- 일괄처리 버튼 (위탁)-->
                        <div class="form-group form-group-sm">
                            <cc1:ExToolBar ID="ExToolBar2" runat="server" Etc2Visible="true" Etc2CSS="btn btn-sm btn-primary" Etc2Text="일괄처리" />
                        </div>
                    <br />
                    <!-- 3열 -->
                    <!-- 수험번호-->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 5px" AssociatedControlID="txt수험번호">수험번호 : </asp:Label>
                        <cc1:ExTextBox ID="txt수험번호" runat="server" CssClass="form-control" Width="130px" Group="ExToolBar3_Etc3" ToolTip="수험번호" Description="수험번호" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 학번-->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="txt학번">학번 : </asp:Label>
                        <cc1:ExTextBox ID="txt학번" runat="server" CssClass="form-control" Width="130px" Group="ExToolBar3_Etc3" ToolTip="학번" Description="학번" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 개별처리 버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar3" runat="server" Etc3Visible="true" Etc3CSS="btn btn-sm btn-primary" Etc3Text="개별처리" />
                    </div>
                    <!-- 인쇄 버튼 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="ExToolBar4">신입생 전공 선택 양식 출력 : </asp:Label>
                        <cc1:ExToolBar ID="ExToolBar6" runat="server" PrintVisible="true" />
                        <asp:Button ID="btnReBindDdlOrgID" runat="server" CssClass="hidden" />
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!-- 알림 메세지 시작 -->
            <div class="alert alert-info">
                <strong class="c03">계열 선택해서 일괄처리 후 밑에 일괄처리 함
                </strong>
            </div>
            <!-- 알림 메세지 끝 -->

            <!-- 학과별 일괄처리 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 학과 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="ddl학과">학과 : </asp:Label>
                        <cc1:ExDropDownList ID="ddl학과" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar4_Ect4;ExToolBar5_Ect5" ToolTip="학과" Description="학과" BindMode="All" OnSelectedIndexChanged="ddl학과_SelectedIndexChanged" AutoPostBack="true"></cc1:ExDropDownList>
                    </div>
                    <!-- 일괄처리 버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar4" runat="server" Etc4Visible="true" Etc4CSS="btn btn-sm btn-primary" Etc4Text="일괄처리" />
                    </div>
                    <!-- 일괄취소 버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar5" runat="server" Etc5Visible="true" Etc5CSS="btn btn-sm btn-danger" Etc5Text="일괄취소" />
                    </div>
                </div>
            </div>
            <!-- 학과별 일괄처리 영역 끝 -->

            <!--합격자 학번부여 현황 리스트 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pull-left grdList">합격자 학번부여 현황 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 400px">
                        <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="합격자 학번부여 현황 리스트" TableCaption="합격자 학번부여 현황 리스트" Width="100%"
                            OnRowDataBound="grdList_RowDataBound" OnRowCommand="grdList_RowCommand">
                            <Columns>
                                <%--1--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="15%" ItemStyle-CssClass="textWrap text-center" SortExpression="recpNo" />
                                <%--2--%><asp:BoundField HeaderText="학생명" DataField="korName" HeaderStyle-Width="10%" ItemStyle-CssClass="textWrap text-center" />
                                <%--3--%><asp:BoundField HeaderText="주민등록번호" DataField="resdNo" HeaderStyle-Width="15%" ItemStyle-CssClass="textWrap text-center" />
                                <%--4--%><asp:BoundField HeaderText="학과" DataField="majorName" HeaderStyle-Width="20%" ItemStyle-CssClass="textWrap text-left" />
                                <%--5--%><asp:BoundField HeaderText="부여학번" DataField="StudentNo" HeaderStyle-Width="20%" ItemStyle-CssClass="textWrap text-center" SortExpression="StudentNo" />
                                <%--6--%><asp:BoundField HeaderText="자료이관유무" DataField="PYD" HeaderStyle-Width="10%" ItemStyle-CssClass="textWrap text-center" />
                                <%--7--%><asp:TemplateField HeaderText="개별이관">
                                    <HeaderStyle Width="10%" CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk개별이관" runat="server" Width="100%" Text="선택" CausesValidation="false" CommandName="SELECT">이관</asp:LinkButton>
                                        <%-- <asp:Button ID="btn개별이관" runat="server" Text='일괄처리' CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="SELECT"></asp:Button>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                    </cc2:ComDivScroll>
                </div>
                <!-- 버튼영역 -->
                <div class="panel-footer">
                </div>
            </div>
            <!--합격자 학번부여 현황 리스트 끝 -->
        </div>
    </div>
    <script type="text/javascript">

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            initializeComponent();
        });

        function initializeComponent() {
            
            if ($("#<%=ddl계열구분.ClientID%>").val() == "")
            {
                $("#<%=txt학과구분코드정규.ClientID%>").val("");
            }

            if ($("#<%=ddl위탁.ClientID%>").val() == "")
            {
                $("#<%=txt학과구분코드위탁.ClientID%>").val("");
            }

            $('#<%= txt연도.ClientID %>').on('blur', function () {
                var $Year = $('#<%= txt연도.ClientID %>').val();

                if ($Year == '' || $Year.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdlOrgID.ClientID %>').click();
                }
            });

            $("#<%=ddl계열구분.ClientID%>").on('change', function (e) {
                if ($(this).val() == "") {
                    $("#<%=txt학과구분코드정규.ClientID%>").val("");
                }
                else {
                    $("#<%=txt학과구분코드정규.ClientID%>").val($(this).val());
                }
            });

            $("#<%=ddl위탁.ClientID%>").on('change', function (e) {
                if ($(this).val() == "") {
                    $("#<%=txt학과구분코드위탁.ClientID%>").val("");
                }
                else {
                    $("#<%=txt학과구분코드위탁.ClientID%>").val($(this).val());
                }
            });

            $('#<%= ExToolBar1.ClientID %>_Etc1').on('click', function () {
                var $ddl계열구분 = $('#<%= ddl계열구분.ClientID %>').val();

                if ($ddl계열구분 == '') {
                    alertMessage('먼저 계열구분을 선택하셔야 합니다.');
                    return false;
                }
                else {
                    return true;
                }
                return false;
            });

            $('#<%= ExToolBar2.ClientID %>_Etc2').on('click', function () {
                var $ddl위탁 = $('#<%= ddl위탁.ClientID %>').val();

                if ($ddl위탁 == '') {
                    alertMessage('먼저 위탁구분을 선택하셔야 합니다.');
                    return false;
                }
                else {
                    return true;
                }
                return false;
            });
        }

        $(document).ready(function () {
            initializeComponent();
        });
    </script>
    <uc2:report ID="Report1" runat="server" />
</asp:Content>