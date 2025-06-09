<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplSearch.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplSearch" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="uc1" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportInvoker.ascx" TagPrefix="uc1" TagName="ReportInvoker" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>

<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function SearchEventHandler() {
            var msg = "은(는) 필수항목 입니다.";

            if (base.MainContent_txtYear.value == "") {
                //alert(base.MainContent_txtYear.val());
                alertMessage("모집연도" + msg);
                base.MainContent_txtYear.focus();
                return false;
            }

            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">지원연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar2_Print;ExToolBar1_Etc1" Description="지원연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="150px" ToolTip="지원시기" Description="지원시기" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar2_Save;ExToolBar2_Print"></cc1:ExDropDownList>
                </div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchGubun">전형구분 : </asp:Label>
                            <cc1:ExDropDownList ID="ddlSearchGubun" runat="server" Width="320px" CodeType="_일반" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="전형구분" Description="전형구분" BindMode="All"></cc1:ExDropDownList>
                        </div>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplyOrgID">지원학과 : </asp:Label>
                            <cc1:ExDropDownList ID="ddlSearchApplyOrgID" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="지원학과" Description="지원학과" BindMode="All"></cc1:ExDropDownList>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchStud">성명/수험번호 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchStud" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="성명/수험번호" Description="성명/수험번호"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlHostelYN">기숙사 신청여부 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlHostelYN" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="기숙사 신청여부" Description="기숙사 신청여부" AutoPostBack="true">
                        <asp:ListItem Value="%" Selected="True">전체</asp:ListItem>
                        <asp:ListItem Value="Y">신청</asp:ListItem>
                        <asp:ListItem Value="N">미신청</asp:ListItem>
                    </cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlListSelect">인실 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlListSelect" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="인실" Description="인실">
                        <asp:ListItem Value="%" Selected="True">전체</asp:ListItem>
                        <asp:ListItem Value="2">2인실</asp:ListItem>
                        <asp:ListItem Value="3">3인실</asp:ListItem>
                        <asp:ListItem Value="4">4인실</asp:ListItem>
                    </cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchStud">고교명 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchSchool" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search;ExToolBar1_Etc1" ToolTip="고교명" Description="고교명"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar3" runat="server" Etc1Visible="true" Etc1CSS="btn btn-sm btn-default" Etc1Text="엑셀" />
                </div>
                <br />
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlPass">입시 지원자 상태 구분 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlPass" runat="server" Width="180px" ToolTip="입시 지원자 상태 구분" Description="입시 지원자 상태 구분" BindMode="All" Required="true" CodeType="_공통" P1="SA04" Group="ExToolBar2_Print"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rblPrintGubun">인쇄구분 : </asp:Label>
                    <cc1:ExRadioButtonList ID="rblPrintGubun" runat="server" CssClass="radio" RepeatLayout="Flow" RepeatDirection="Horizontal" ToolTip="인쇄구분" Description="인쇄구분" Group="ExToolBar1_Search;ExToolBar1_Etc1">
                        <asp:ListItem Value="1" Text="합격통지서" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="장학증서"></asp:ListItem>
                        <asp:ListItem Value="3" Text="등록금고지서(주소○)"></asp:ListItem>
                        <asp:ListItem Value="6" Text="등록금고지서(주소X)"></asp:ListItem>
                        <asp:ListItem Value="4" Text="입학원서"></asp:ListItem>
                        <asp:ListItem Value="5" Text="예치금고지서(주소○)"></asp:ListItem>
                        <asp:ListItem Value="7" Text="예치금고지서(주소X)"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" PrintVisible="true" />
                </div>
                <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left grdList">입시지원자 리스트</h3>
                <h6 class="color-point pull-left panel-title">( ※ 모집인원 :<asp:Label ID="lblInwon" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    ① 지원자 : &nbsp<asp:Label ID="lblApplyCnt" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    ② 최초합격자 :&nbsp<asp:Label ID="lblPassFirst" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    ③ 충원합격자 :&nbsp<asp:Label ID="lblPassPlus" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    ④ 최초합격 최종등록 :&nbsp<asp:Label ID="lblPassFirstJoin" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    ⑤ 충원합격 최종등록 :&nbsp<asp:Label ID="lblPassPlusJoin" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                    )
                </h6>
                <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
            </div>
            <div class="ibox-content p-n">
                <div class="table-responsive">
                    <div id="]MainContent_ComDivScroll1" onscroll="document.getElementById('MainContent_ComDivScroll1_value').value = this.scrollTop" style="width: 3740px; height: 570px; overflow-y: visible; cursor: pointer;">
                        <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active" ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="50">
                            <Columns>
                                <%--1--%><asp:BoundField HeaderText="수험번호" DataField="수험번호" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                <%--2--%><asp:BoundField HeaderText="성명" DataField="이름" HeaderStyle-Width="120px" ItemStyle-CssClass="textWrap text-center" />
                                <%--3--%><asp:BoundField HeaderText="주민등록번호" DataField="주민등록번호" HeaderStyle-Width="160px" ItemStyle-CssClass="textWrap text-center" />
                                
                                <%--4--%><asp:BoundField HeaderText="합격코드" DataField="합격코드" HeaderStyle-Width="240px" ItemStyle-CssClass="textWrap text-left" />

                                <%--4--%><asp:BoundField HeaderText="성적순위" DataField="성적순위" HeaderStyle-Width="140px" ItemStyle-CssClass="textWrap text-center" />
                                <%--4--%><asp:BoundField HeaderText="예비합격순위" DataField="예비합격순위" HeaderStyle-Width="140px" ItemStyle-CssClass="textWrap text-center" />

                                <%--5--%><asp:BoundField HeaderText="전형구분" DataField="전형구분" HeaderStyle-Width="300px" ItemStyle-CssClass="textWrap text-left" />
                                <%--6--%><asp:BoundField HeaderText="1지망" DataField="1지망" HeaderStyle-Width="260px" ItemStyle-CssClass="textWrap text-left" />
                                <%--7--%><asp:BoundField HeaderText="2지망" DataField="2지망" HeaderStyle-Width="260px" ItemStyle-CssClass="textWrap text-left" />
                                <%--8--%><asp:BoundField HeaderText="최종지망" DataField="최종지망" HeaderStyle-Width="260px" ItemStyle-CssClass="textWrap text-left" />
                                <%--9--%><asp:BoundField HeaderText="최종전공" DataField="최종전공" HeaderStyle-Width="260px" ItemStyle-CssClass="textWrap text-left" />
                                <%--10--%><asp:BoundField HeaderText="기숙사" DataField="기숙사" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                <%--10--%><asp:BoundField HeaderText="인실" DataField="인실" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />

                                <%--11--%><asp:BoundField HeaderText="졸업연도" DataField="졸업연도" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                <%--12--%><asp:BoundField HeaderText="출신고교(검정고시)" DataField="출신고교(검정고시)" HeaderStyle-Width="220px" ItemStyle-CssClass="textWrap text-left" />
                                <%--13--%><asp:BoundField HeaderText="고교과" DataField="고교과" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                <%--14--%><asp:BoundField HeaderText="졸업" DataField="졸업" HeaderStyle-Width="50px" ItemStyle-CssClass="textWrap text-center" />
                                <%--15--%><asp:BoundField HeaderText="이메일" DataField="이메일" HeaderStyle-Width="180px" ItemStyle-CssClass="textWrap text-left" />
                                <%--16--%><asp:BoundField HeaderText="보호자" DataField="보호자" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-left" />
                                <%--17--%><asp:BoundField HeaderText="관계" DataField="관계" HeaderStyle-Width="50px" ItemStyle-CssClass="textWrap text-center" />
                                <%--18--%><asp:BoundField HeaderText="보호자 휴대전화" DataField="보호자휴대전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                <%--19--%><asp:BoundField HeaderText="보호자 전화" DataField="보호자전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                <%--20--%><asp:BoundField HeaderText="우편번호" DataField="우편번호" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                <%--21--%><asp:BoundField HeaderText="주소" DataField="주소" HeaderStyle-Width="550px" ItemStyle-CssClass="textWrap text-left" />
                                <%--22--%><asp:BoundField HeaderText="전화" DataField="전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                <%--23--%><asp:BoundField HeaderText="휴대전화" DataField="휴대전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                <%--24--%><asp:BoundField HeaderText="자격증" DataField="자격증" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                <%--25--%><asp:BoundField HeaderText="산업체" DataField="산업체" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                <%--26--%><asp:BoundField HeaderText="접수자" DataField="접수자" HeaderStyle-Width="120px" ItemStyle-CssClass="textWrap text-center" />
                                <%--27--%><asp:BoundField HeaderText="접수일" DataField="접수일" HeaderStyle-Width="130px" ItemStyle-CssClass="textWrap text-center" DataFormatString="{0:yyyy-MM-dd}" />
                                <%--28--%><asp:BoundField HeaderText="address" DataField="address" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                        <div class="col-xs-12  fixedbt">
                            <uc1:CommonPager ID="CommonPager1" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <uc1:ReportInvoker ID="ReportInvoker1" runat="server" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtSearchApplyYear.ClientID %>').on('blur', function () {
                var $applyYear = $('#<%= txtSearchApplyYear.ClientID %>').val();

                if ($applyYear == '' || $applyYear.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });

            $('#<%= ExToolBar2.ClientID %>_Print').on('click', function () {
                var $pass = $('#<%= ddlPass.ClientID %>').val();
                var $org = $('#<%= ddlSearchApplyOrgID.ClientID %>').val();

                if ($('#<%= rblPrintGubun.ClientID %>_2').is(':checked') || $('#<%= rblPrintGubun.ClientID %>_3').is(':checked')) {
                    if ($pass == '%') {
                        alertMessage('합격코드은(는) 필수항목 입니다.');
                        return false;
                    }
                    //else if ($org == '%') {
                    //    //2019-01-29 김동균 지원학과 필수항목 제외
                    //    //alertMessage('지원학과은(는) 필수항목 입니다.');
                    //    //return false;
                    //    return true;
                    //}
                    else {
                        return true;
                    }
                }
                else if ($('#<%= rblPrintGubun.ClientID %>_5').is(':checked') || $('#<%= rblPrintGubun.ClientID %>_6').is(':checked')) {
                    if ($pass == '%') {
                        alertMessage('합격코드은(는) 필수항목 입니다.');
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
        });
    </script>
    <uc2:report ID="Report1" runat="server" />
</asp:Content>