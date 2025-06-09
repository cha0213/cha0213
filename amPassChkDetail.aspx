<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amPassChkDetail.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amPassChkDetail" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="uc1" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="/COFF/CONTROL/COFF/SMSControl.ascx" TagPrefix="uc" TagName="sms" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportInvoker.ascx" TagPrefix="uc1" TagName="ReportInvoker" %>

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
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 10px" AssociatedControlID="txt지원연도조회">지원연도  :</asp:Label>
                        <cc1:ExTextBox ID="txt지원연도조회" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar2_Print" Description="지원연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="ddl지원시기조회">지원시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl지원시기조회" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar2_Save;ExToolBar2_Print" AutoPostBack="true"></cc1:ExDropDownList>
                    </div>
                    &nbsp
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <!-- 전형구분 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" Style="margin-left: 50px" AssociatedControlID="ddl전형구분조회">전형구분 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl전형구분조회" runat="server" Width="320px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="전형구분" Description="전형구분" BindMode="All"></cc1:ExDropDownList>
                            </div>
                            <!-- 지원학과 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="ddl지원학과조회">지원학과 : </asp:Label>
                                <cc1:ExDropDownList ID="ddl지원학과조회" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="지원학과" Description="지원학과" BindMode="All"></cc1:ExDropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <br />
                    <!-- 합격코드 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 18px" AssociatedControlID="ddl합격코드조회">합격코드 : </asp:Label>
                        <cc1:ExDropDownList ID="ddl합격코드조회" runat="server" Width="252px" ToolTip="합격코드" Description="합격코드" BindMode="All" CodeType="_공통" P1="SA04" Group="ExToolBar2_Print"></cc1:ExDropDownList>
                    </div>
                    <!-- 성명/수험번호 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="txt성명수험번호조회">성명/수험번호 : </asp:Label>
                        <cc1:ExTextBox ID="txt성명수험번호조회" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search" ToolTip="성명/수험번호" Description="성명/수험번호"></cc1:ExTextBox>
                    </div>

                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txtStartRankS">석차 : </asp:Label>
                        <cc1:ExTextBox ID="txtStartRankS" runat="server" CssClass="form-control text-center" Width="60px" Group="ExToolBar6_Delete" ToolTip="석차_시작" Description="석차_시작" TextMode="Number"></cc1:ExTextBox>
                        ~
                        <cc1:ExTextBox ID="txtEndRankS" runat="server" CssClass="form-control text-center" Width="60px" Group="ExToolBar6_Delete" ToolTip="석차_종료" Description="석차_종료" TextMode="Number"></cc1:ExTextBox>
                    </div>
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txtSearchSchool">고교명 : </asp:Label>
                        <cc1:ExTextBox ID="txtSearchSchool" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search" ToolTip="고교명" Description="고교명"></cc1:ExTextBox>
                    </div>

                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txtPhone">휴대폰번호 : </asp:Label>
                        <cc1:ExTextBox ID="txtPhone" runat="server" CssClass="form-control" Width="150px" Group="ExToolBar1_Search" ToolTip="휴대폰번호" Description="휴대폰번호"></cc1:ExTextBox>
                    </div>

                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    </div>
               </div>
                    <div class="form-inline">
                    <!-- 인쇄구분 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" Style="margin-left: 30px" AssociatedControlID="rbl인쇄구분조회">인쇄구분 : </asp:Label>
                        <cc1:ExRadioButtonList ID="rbl인쇄구분조회" runat="server" CssClass="radio" RepeatLayout="Flow" RepeatDirection="Horizontal" ToolTip="인쇄구분" Description="인쇄구분" Group="ExToolBar1_Search">
                            <asp:ListItem Value="1" Text="합격통지서" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="2" Text="장학증서"></asp:ListItem>
                            <asp:ListItem Value="3" Text="등록금고지서(주소있음)"></asp:ListItem>
                            <asp:ListItem Value="6" Text="등록금고지서(주소없음)"></asp:ListItem>
                            <asp:ListItem Value="4" Text="입학원서"></asp:ListItem>
                            <asp:ListItem Value="5" Text="예치금고지서(주소있음)"></asp:ListItem>
                            <asp:ListItem Value="7" Text="예치금고지서(주소없음)"></asp:ListItem>
                        </cc1:ExRadioButtonList>
                    </div>
                    <!-- 인쇄버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar2" runat="server" PrintVisible="true" />
                    </div>
                    <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" />
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!--입시지원자 리스트 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pull-left grdList">입시지원자 리스트</h3>
                    <h6 class="color-point pull-left panel-title">( ※ 모집인원 :<asp:Label ID="lbl모집인원" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        ① 지원자 : &nbsp<asp:Label ID="lbl지원자수" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        ② 최초합격자 :&nbsp<asp:Label ID="lbl최초합격자수" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        ③ 충원합격자 :&nbsp<asp:Label ID="lbl충원합격자수" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        ④ 최초합격 최종등록 :&nbsp<asp:Label ID="lbl최초합격최종등록수" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        ⑤ 충원합격 최종등록 :&nbsp<asp:Label ID="lbl충원합격최종등록수" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        )
                    </h6>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="ibox-content p-n">
                    <div class="table-responsive">
                        <div id="MainContent_ComDivScroll1" onscroll="document.getElementById('MainContent_ComDivScroll1_value').value = this.scrollTop" style="width: 3500px; height: 850px; overflow-y: visible; cursor: pointer;">
                            <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                                SelectedRowStyle-CssClass="active" ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" ShowRowNumberWidth="50"
                                OnRowDataBound="grdList_RowDataBound">
                                <Columns>
                                    <%--1--%><asp:BoundField HeaderText="수험번호" DataField="수험번호" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--2--%><asp:BoundField HeaderText="성명" DataField="이름" HeaderStyle-Width="120px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--3--%><asp:BoundField HeaderText="주민등록번호" DataField="주민등록번호" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--4--%><asp:TemplateField HeaderText="합격코드">
                                        <HeaderStyle Width="200px" CssClass="text-center" />
                                        <ItemStyle CssClass="inputWrap" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <cc1:ExDropDownList ID="ddl합격코드" runat="server" CssClass="form-control" Width="100%" ToolTip="합격코드" Description="합격코드" CodeType="_공통" BindMode="Empty" Group="ExToolBar2_Print"></cc1:ExDropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--5--%><asp:TemplateField HeaderText="SMS">
                                        <HeaderStyle Width="10px" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--6--%><asp:BoundField HeaderText="석차" DataField="성적순위" HeaderStyle-Width="70px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--7--%><asp:BoundField HeaderText="예비석차" DataField="예비합격순위" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--8--%><asp:BoundField HeaderText="최종지망" DataField="최종지망" HeaderStyle-CssClass="skip" ItemStyle-CssClass="textWrap text-left skip" />
                                    <%--9--%><asp:BoundField HeaderText="최종전공" DataField="최종전공" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--10--%><asp:BoundField HeaderText="전형구분" DataField="전형구분" HeaderStyle-Width="180px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--11--%><asp:BoundField HeaderText="휴대전화" DataField="휴대전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--12--%><asp:BoundField HeaderText="졸업연도" DataField="졸업연도" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--13--%><asp:BoundField HeaderText="출신고교(검정고시)" DataField="출신고교(검정고시)" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--14--%><asp:BoundField HeaderText="1지망" DataField="1지망" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--15--%><asp:BoundField HeaderText="2지망" DataField="2지망" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--16--%><asp:BoundField HeaderText="기숙사" DataField="기숙사" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--17--%><asp:BoundField HeaderText="고교과" DataField="고교과" HeaderStyle-Width="200px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--18--%><asp:BoundField HeaderText="졸업" DataField="졸업" HeaderStyle-Width="50px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--19--%><asp:BoundField HeaderText="이메일" DataField="이메일" HeaderStyle-Width="180px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--20--%><asp:BoundField HeaderText="보호자" DataField="보호자" HeaderStyle-CssClass="skip" ItemStyle-CssClass="textWrap text-left skip" />
                                    <%--21--%><asp:BoundField HeaderText="관계" DataField="관계" HeaderStyle-CssClass="skip" ItemStyle-CssClass="textWrap text-center skip" />
                                    <%--22--%><asp:BoundField HeaderText="보호자 휴대전화" DataField="보호자휴대전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--23--%><asp:BoundField HeaderText="보호자 전화" DataField="보호자전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--24--%><asp:BoundField HeaderText="우편번호" DataField="우편번호" HeaderStyle-Width="80px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--25--%><asp:BoundField HeaderText="주소" DataField="address" HeaderStyle-Width="700px" ItemStyle-CssClass="textWrap text-left" />
                                    <%--26--%><asp:BoundField HeaderText="전화" DataField="전화" HeaderStyle-Width="150px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--27--%><asp:BoundField HeaderText="자격증" DataField="자격증" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--28--%><asp:BoundField HeaderText="산업체" DataField="산업체" HeaderStyle-Width="100px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--29--%><asp:BoundField HeaderText="접수자" DataField="접수자" HeaderStyle-Width="120px" ItemStyle-CssClass="textWrap text-center" />
                                    <%--30--%><asp:BoundField HeaderText="접수일" DataField="접수일" HeaderStyle-Width="130px" ItemStyle-CssClass="textWrap text-center" DataFormatString="{0:yyyy-MM-dd}" />
                                    <%--31--%><asp:BoundField HeaderText="address" DataField="address" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--32--%><asp:BoundField HeaderText="지원연도" DataField="Year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--33--%><asp:BoundField HeaderText="지원시기" DataField="season" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />        
                                    <%-- 34 변경여부 --%>
                                    <asp:TemplateField HeaderText="합격코드변경여부">
                                        <HeaderStyle Width="7%" CssClass="skip" />
                                        <ItemStyle CssClass="skip" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtChangeYN" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <%--35--%>
                                    <asp:TemplateField HeaderText="합격코드값">
                                        <HeaderStyle Width="7%" CssClass="skip" />
                                        <ItemStyle CssClass="skip" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPassCode" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.합격") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                            <div class="col-xs-12 fixedbt">
                                <uc:CommonPager ID="CommonPager1" runat="server" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 버튼영역 -->
                <div class="panel-footer">
                    <div class="text-left pull-left">
                        <cc1:ExToolBar ID="ExToolBar5" runat="server" SaveVisible="true" SaveText="SMS문장관리" />
                        <cc1:ExToolBar ID="ExToolBar3" runat="server" Etc1Visible="true" Etc1Text="SMS 발송" Etc1CSS="btn btn-sm btn-default" />
                    </div>
                    <div class="pull-left mt_5" style="color: #31708f;">&nbsp;&nbsp;※ 메시지를 전송 할 학생의 'SMS' 를 체크 후 [SMS 발송] 버튼을 클릭 하세요.</div>
                    <div class="text-right">
                        <cc1:ExToolBar ID="ExToolBar4" runat="server" SaveVisible="true" />
                        <asp:Button ID="btnFinalSave" runat="server" CssClass="btn btn-default btn-xs hidden" Text="최종저장"></asp:Button>
                    </div>
                </div>
            </div>
            <!--입시지원자 리스트 끝 -->

            <!--SMS 발송 리스트 시작 -->
            <uc:sms ID="ucSMS" runat="server" CompkeyEnum="입시" />
            <!--SMS 발송 리스트 끝 -->

            <uc1:Modal ID="modalSMS" runat="server" ModalId="IDmodalSMS" ModalTitle="SMS문장관리" ShowCloseButton="true">
                <ModalBodyTemplate>
                    <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
                </ModalBodyTemplate>
            </uc1:Modal>

            <uc1:Modal ID="modalPreviewSMS" runat="server" ModalId="IDmodalPreviewSMS" ModalTitle="SMS 미리보기" ShowCloseButton="true">
                <ModalBodyTemplate>
                    <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
                </ModalBodyTemplate>
            </uc1:Modal>

            <%-- SMS 미리보기를 출력하기 위한 현재 저장 되는 합격코드 스트링을 구분자(|:파이프라인)을 이용해서 만들어 놓는다.(그리드의 합격코드가 변경 될때마다.) --%>
            <asp:TextBox ID="txtPassCodeString" runat="server" CssClass="hidden"></asp:TextBox>
        </div>
    </div>
    <div runat="server" class="alert alert-info ">
        <strong class="c03">※ 지원자 중 합격코드를 일괄로 변경 하시려면 아래 정보 선택/입력 후 [일괄변경] 버튼을 클릭 하세요.
        </strong>
        <br />
        <br />
        <div class="table-filter">
            <div class="form-inline">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl일괄처리_전형구분"><strong style="color:red">*</strong>전형구분 : </asp:Label>
                            <cc1:ExDropDownList ID="ddl일괄처리_전형구분" runat="server" Width="300px" CodeType="_일반" Group="ExToolBar6_Delete" ToolTip="일괄처리_전형구분" Description="일괄처리_전형구분" BindMode="Select" Required="true"></cc1:ExDropDownList>
                        </div>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl일괄처리_지원학과"><strong style="color:red">*</strong>지원학과 : </asp:Label>
                            <cc1:ExDropDownList ID="ddl일괄처리_지원학과" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar6_Delete" ToolTip="일괄처리_지원학과" Description="일괄처리_지원학과" BindMode="Select" Required="true"></cc1:ExDropDownList>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                    </Triggers>
                </asp:UpdatePanel>
                <div id="divBatch">
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="ddl일괄처리_합격코드">합격코드 : </asp:Label>
                        <cc1:ExDropDownList ID="ddl일괄처리_합격코드" runat="server" Width="300px" ToolTip="일괄변경_합격코드" Description="일괄변경_합격코드" BindMode="Select" CodeType="_공통" P1="SA04" Group="ExToolBar6_Delete" Required="true"></cc1:ExDropDownList>
                    </div>

                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txtRankStart">대상석차 : </asp:Label>
                        <cc1:ExTextBox ID="txtRankStart" runat="server" CssClass="form-control text-center" Width="60px" Group="ExToolBar6_Delete" ToolTip="대상석차_시작" Description="대상석차_시작" Required="true" TextMode="Number"></cc1:ExTextBox>
                        ~
                        <cc1:ExTextBox ID="txtRankEnd" runat="server" CssClass="form-control text-center" Width="60px" Group="ExToolBar6_Delete" ToolTip="대상석차_종료" Description="대상석차_종료" Required="true" TextMode="Number"></cc1:ExTextBox>
                    </div>
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar6" runat="server" DeleteVisible="true" DeleteText="일괄변경" />
                        <asp:Button ID="btnBatchFinalSave" runat="server" CssClass="btn btn-default btn-xs hidden" Text="일괄변경최종저장"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdnSaveGubun" runat="server" />
    </div>
    <uc1:ReportInvoker ID="ReportInvoker1" runat="server" />
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

            $('#<%= ExToolBar2.ClientID %>_Print').on('click', function () {
                var $pass = $('#<%= ddl합격코드조회.ClientID %>').val();
                var $org = $('#<%= ddl지원학과조회.ClientID %>').val();

                if ($('#<%= rbl인쇄구분조회.ClientID %>_2').is(':checked') || $('#<%= rbl인쇄구분조회.ClientID %>_3').is(':checked')) {
                    if ($pass == '%') {
                        alertMessage('합격코드은(는) 필수항목 입니다.');
                        return false;
                    }
                    //else if ($org == '%') {
                    //    alertMessage('지원학과은(는) 필수항목 입니다.');
                    //    return false;
                    //}
                    else {
                        return true;
                    }
                }
                else if ($('#<%= rbl인쇄구분조회.ClientID %>_5').is(':checked') || $('#<%= rbl인쇄구분조회.ClientID %>_6').is(':checked')) {
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

            $('#<%= ExToolBar4.ClientID %>_Save').on('click', function () {

                // 변경 된 내역이 있는지 갯수를 확인 한다.
                var $txtPassCodeString = $('#<%= txtPassCodeString.ClientID%>');

                if ($txtPassCodeString.val().length == 0) {
                    alertMessage('저장 할 내역(변경 된) 내역이 없습니다.');
                    return false;
                }
                $('#<%= hdnSaveGubun.ClientID%>').val('1');
                return OpenPreviewModal();
            });

            $('#<%= ExToolBar6.ClientID %>_Delete').on('click', function () {
                var rValue = false;
                var $btnSave = $(this);

                var $ddl일괄처리_전형구분 = $('#<%= ddl일괄처리_전형구분.ClientID%>');
                var $ddl일괄처리_지원학과 = $('#<%= ddl일괄처리_지원학과.ClientID%>');
                var $ddl일괄처리_합격코드 = $('#<%= ddl일괄처리_합격코드.ClientID%>');

                if ($ddl일괄처리_전형구분.val() == "") {
                    alertMessage("일괄변경 전형구분은(는) 필수항목 입니다.");
                    return false;
                }

                if ($ddl일괄처리_지원학과.val() == "") {
                    alertMessage("일괄변경 지원학과은(는) 필수항목 입니다.");
                    return false;
                }

                if (ClientValidate('divBatch')) {
                    var confirmTitle = '<span class="glyphicon glyphicon-question-sign c06" aria-hidden="true"></span> 확인';
                    bootbox.confirm({
                        title: confirmTitle,
                        message: '일괄변경을 수행 하시겠습니까?',
                        callback: function (confirmed) {
                            if (confirmed) {
                                $('#<%= hdnSaveGubun.ClientID%>').val('2');

                                var $txtPassCodeString = $('#<%= txtPassCodeString.ClientID%>');
                                var strPassCode = $ddl일괄처리_합격코드.val();

                                //$txtPassCodeString.val(strPassCode + '|ZZ');  // 예비후보는 무조건 나타나게 한다.

                                //OpenPreviewModal();

                                $('#<%= btnBatchFinalSave.ClientID %>').click();

                            }
                        }
                    });
                }

                return false;

            });

        });

        function OpenModal() {
            var modalId = '#<%= modalSMS.ModalId%>';
            var height = 670;
            var src = 'amPassSMSMngr.aspx?';

            $(modalId)
               .find('.modal-body iframe')
               .css({ 'height': height + 'px' })
               .attr({ 'src': src });

            $(modalId)
                .find('.modal-content')
                .css('width', '1000px');

            window.modalCallback = null;

            $(modalId).modal('show');

            return false;
        }

        function OpenPreviewModal() {
            var modalId = '#<%= modalPreviewSMS.ModalId%>';
            var height = 670;

            var PassCodeString = $('#<%= txtPassCodeString.ClientID%>').val();

            var src = 'amPassPreviewSMS.aspx?PassCodeString=' + PassCodeString;

            $(modalId)
               .find('.modal-body iframe')
               .css({ 'height': height + 'px' })
               .attr({ 'src': src });

            $(modalId)
                .find('.modal-content')
                .css('width', '1000px');

            window.modalCallback = null;

            $(modalId).modal('show');

            return false;
        }

        function ClosePreviewModal(strPassCode) {
            $('#<%= txtPassCodeString.ClientID%>').val(strPassCode);

            var modalId = '#<%= modalPreviewSMS.ModalId%>';
            $(modalId).modal('hide');

            if ($('#<%= hdnSaveGubun.ClientID%>').val() == "1") {
                $('#<%= btnFinalSave.ClientID%>').click();
            }
            else {
                // 일괄변경
                $('#<%= btnBatchFinalSave.ClientID %>').click();
            }

        }

        // 그리드 합격코드 변경 시 변경 여부 표시, 저장 시 해당 데이터만 저장하기 위해.
        function SetChangePassCode(rowindex) {
            var f = document.forms[0];

            var beforeCode = f.elements["MainContent_grdList_txtPassCode_" + rowindex].value;
            var afterCode = $('#MainContent_grdList_ddl합격코드_' + rowindex + ' option:selected').val();

            if (rowindex >= 0) {
                if (beforeCode == afterCode) {
                    f.elements["MainContent_grdList_txtChangeYN_" + rowindex].value = "N";
                }
                else {
                    f.elements["MainContent_grdList_txtChangeYN_" + rowindex].value = "Y";
                }

                SetPassCodeString();
            }
        }

        // 변경 된 합격코드의 중복을 제거하고 문자열로 생성한다.
        function SetPassCodeString() {
            var f = document.forms[0];
            var grid = document.getElementById("MainContent_grdList");
            var gridCount = grid.rows.length;
            var $txtPassCodeString = $('#<%= txtPassCodeString.ClientID%>');

            var strPassCode = "";

            // 그리드의 내용 중 txtChangeYN 의 값이 "Y" 인 합격코드를 중복제거하고 (|:파이프라인)으로 구분하여 문자열을 생성한다.
            for (var i = 0; i < gridCount - 1; i++) {

                var passCode = $('#MainContent_grdList_ddl합격코드_' + i + ' option:selected').val();
                var ChangeYN = f.elements["MainContent_grdList_txtChangeYN_" + i].value;

                if (ChangeYN == "Y") {
                    if (strPassCode.length == 0) {
                        strPassCode += passCode
                    }
                    else {
                        if (strPassCode.indexOf(passCode) < 0) {
                            strPassCode += '|' + passCode
                        }
                    }
                }
            }

            $txtPassCodeString.val(strPassCode + '|ZZ');  // 예비후보는 무조건 나타나게 한다.

        }
    </script>
    <uc2:report ID="Report1" runat="server" />
</asp:Content>