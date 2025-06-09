<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="enterReceiveAppl.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.enterReceiveAppl" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>
<%@ Register Src="/COFF/CONTROL/ENTR/HighschoolSearch.ascx" TagPrefix="uc2" TagName="Highschool" %>
<%@ Register Src="/COFF/CONTROL/ENTR/CompanySearch.ascx" TagPrefix="uc2" TagName="CompanySearch" %>
<%@ Register Src="~/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="IDINO" TagName="BootstrapModal" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>

<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function OpenModalZipCode() {

            var modalId = '#<%= ModalPop1.ModalId %>';

            var height = 530;
            var src = "/COFF/COMM/ZipCode.aspx";
            $(modalId)
                .find('.modal-body iframe')
                .css({ 'height': height + 'px' })
                .attr({ 'src': src });

            window.modalCallback = bindZipcode;

            $(modalId).modal('show');

            var parentScrollTop = parent.getTopPanelHeight();

            if (parentScrollTop != null) {
                $(document).find('.modal-content').css({ 'margin-top': parentScrollTop });
            }
        }

        function bindZipcode(addressObj) {

            if (addressObj) {
                var modalId = '#<%= ModalPop1.ModalId %>';

                var zipCode = addressObj['zipCode'];
                var addrLocal = addressObj['addressLocal'];
                var addrRoad = addressObj['addressRoad'];

                $('#<%= txtPostCode.ClientID %>').val(zipCode);
                $('#<%= txtAddress.ClientID %>').val(addrRoad);
                window.modalCallback = null;

                $(modalId).modal('hide');
            }
        }

        function SaveEventHandler() {
            if (ClientValidate('divInput')) {
                var result = ($('#<%= hdnResult.ClientID %>').val());
                //신규 저장 시
                <%--if ($('#<%= txt지원연도.ClientID %>').prop("disabled") == false)
                {--%>
                if (!$('#<%= txt지원연도.ClientID %>').prop('disabled')) {
                    if (result == "") {
                        alertMessage("주민등록번호 검사버튼을 클릭 해 주세요.");
                        return false;
                    }
                    else if (result.indexOf("등록불가") >= 0) {
                        alertMessage("3건 이상의 지원정보가 존재하여 등록 불가능 합니다. ");
                        return false;
                    }
                }
                //}
                var $1지망 = $('#<%= ddl1지망지원학과.ClientID %>').val();
                var $2지망 = $('#<%= ddl2지망지원학과.ClientID %>').val();
                if ($1지망 == $2지망) {
                    alertMessage("1지망 2지망 지원학과가 중복 되었습니다.");
                    return false;
                }
            }
            else {
                return false;
            }
        }

        function ResdChk() {
            var $주민번호앞자리 = $('#<%= txt주민등록번호앞자리.ClientID %>').val();
            var $주민번호뒷자리 = $('#<%= txt주민등록번호뒷자리.ClientID %>').val();
            if ($주민번호앞자리 == "" || $주민번호뒷자리 == "" || $주민번호앞자리.length != 6 || $주민번호뒷자리.length != 7) {
                alertMessage("주민등록번호를 확인 바랍니다.");
                return false;
            }

        }
    </script>
</asp:Content>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <IDINO:BootstrapModal runat="server" ID="ModalPop1" ModalId="ModalPopZipCode" ModalTitle="우편번호검색" ShowCloseButton="false">
            <ModalBodyTemplate>
                <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
            </ModalBodyTemplate>
        </IDINO:BootstrapModal>
        <div id="divInput">
            <!-- 상단 조회 영역 시작 -->
            <div class="table-filter">
                <div class="form-inline">
                    <!-- 지원연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txt지원연도조회">지원연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt지원연도조회" runat="server" Width="60px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar1_Search" Description="지원연도" ToolTip="지원연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl지원시기조회">지원시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl지원시기조회" runat="server" CssClass="form-control" Width="165px" Group="ExToolBar1_Search" Description="지원시기" ToolTip="지원시기" CodeType="_공통" BindMode="All" P1="SA02" Required="true"></cc1:ExDropDownList>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <!-- 전형구분 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl전형구분조회">전형구분 :</asp:Label>
                                <cc1:ExDropDownList ID="ddl전형구분조회" runat="server" CssClass="form-control" Width="310px" Group="ExToolBar1_Search" Description="전형구분" ToolTip="전형구분" CodeType="_일반" BindMode="All"></cc1:ExDropDownList>
                            </div>

                            <!-- 지원학과 -->
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl지원학과조회">지원학과 :</asp:Label>
                                <cc1:ExDropDownList ID="ddl지원학과조회" runat="server" CssClass="form-control" Width="390px" Group="ExToolBar1_Search" Description="지원학과" ToolTip="지원학과" CodeType="_일반" BindMode="All"></cc1:ExDropDownList>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindSearchDdl" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnReBindSearchDdl" runat="server" CssClass="hidden" Text="연도 변경시 전형구분, 지원학과 다시 바인딩" />

                    <!-- 주민번호뒷자리 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txt주민등록번호뒷자리조회">주민번호뒷자리 :</asp:Label>
                        <cc1:ExTextBox ID="txt주민등록번호뒷자리조회" runat="server" Width="150px" ValidationType="Numeric" MaxLength="7" CssClass="form-control" Group="ExToolBar1_Search" Description="주민등록번호뒷자리" ToolTip="주민등록번호뒷자리"></cc1:ExTextBox>
                    </div>

                    <!-- 성명/수험번호 recpNo -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txt성명수험번호조회">성명/수험번호 :</asp:Label>
                        <cc1:ExTextBox ID="txt성명수험번호조회" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar1_Search" Description="성명/수험번호" ToolTip="성명/수험번호"></cc1:ExTextBox>
                    </div>

                    <!-- 중복지원여부 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="chk중복지원여부조회">중복지원여부 :</asp:Label>
                        <cc1:ExCheckBox ID="chk중복지원여부조회" runat="server" CssClass="checkbox-inline" Group="ExToolBar1_Search" Text="중복지원" ToolTip="중복지원"></cc1:ExCheckBox>
                    </div>

                    <!-- 버튼영역 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true"></cc1:ExToolBar>
                    </div>

                    <!-- 히든 값 설정 -->
                    <asp:HiddenField ID="hdnRowNum" runat="server" />

                    <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:HiddenField ID="hdnResult" runat="server" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnResdChk" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!-- 입시지원자 리스트 시작 -->
            <div class="panel panel-default">
                <div class="panel-heading ">
                    <h3 class="panel-title pull-left grdList">입시지원자 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="400px" Style="overflow-y: hidden">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="입시 지원자 리스트" TableCaption="입시 지원자리스트"
                            OnRowCommand="grdList_RowCommand">
                            <Columns>
                                <%--1 순번--%>
                                <asp:BoundField HeaderText="순번" DataField="SEQ" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--2 지원시기--%>
                                <asp:BoundField HeaderText="지원시기" DataField="SeasonNM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--3-- 전형구분--%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsCodeNM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--4-- 1지망 지원학과--%>
                                <asp:BoundField HeaderText="1지망 지원학과" DataField="majorCode1NM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--5-- 2지망 지원학과--%>
                                <asp:BoundField HeaderText="2지망 지원학과" DataField="majorCode2NM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--6-- 수험번호--%>
                                <asp:TemplateField HeaderText="수험번호">
                                    <HeaderStyle CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkrecpNo" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.recpNo") %>' CommandName="SELECT"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--7-- 성명--%>
                                <asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--8-- 생년월일--%>
                                <asp:BoundField HeaderText="생년월일" DataField="birthday" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--9-- 고교졸업--%>
                                <asp:BoundField HeaderText="고교졸업" DataField="graduYM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--10-- 입력자--%>
                                <asp:BoundField HeaderText="입력자" DataField="StaffName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--11-- 접수일자--%>
                                <asp:BoundField HeaderText="접수일자" DataField="sppoDt" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--12 선택 체크박스--%>
                                <asp:TemplateField HeaderText="{chkRow:}">
                                    <HeaderStyle Width="10px" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--13-- 지원연도--%>
                                <asp:BoundField HeaderText="지원연도" DataField="year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--14-- 지원시기 코드--%>
                                <asp:BoundField HeaderText="지원시기" DataField="season" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--15-- 전형구분 코드--%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--16-- 1지망 지원학과 코드--%>
                                <asp:BoundField HeaderText="1지망 지원학과" DataField="majorCode1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--17-- 2지망 지원학과 코드--%>
                                <asp:BoundField HeaderText="2지망 지원학과" DataField="majorCode2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--18-- 주민등록번호 앞자리 --%>
                                <asp:BoundField HeaderText="주민등록번호 앞자리" DataField="resdNo1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--19-- 주민등록번호 뒷자리 --%>
                                <asp:BoundField HeaderText="주민등록번호 뒷자리" DataField="resdNo2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--20-- 주민등록번호 --%>
                                <asp:BoundField HeaderText="주민등록번호 뒷자리" DataField="resdNo" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--21-- 등록건수 --%>
                                <asp:BoundField HeaderText="등록건수" DataField="duplicateCnt" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--22-- 고등학교유형 --%>
                                <asp:BoundField HeaderText="고등학교 유형" DataField="LstGradu" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--23-- 고등학교 과 --%>
                                <asp:BoundField HeaderText="고등학교 과" DataField="graduLesson" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--24-- 고등학교 졸업여부--%>
                                <asp:BoundField HeaderText="고등학교 졸업여부" DataField="graduYN" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--25-- 고등학교 졸업년도--%>
                                <asp:BoundField HeaderText="고등학교 졸업년도" DataField="graduYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--26-- 고등학교 졸업월 --%>
                                <asp:BoundField HeaderText="고등학교 졸업월" DataField="graduMonth" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--27-- 검정고시점수 --%>
                                <asp:BoundField HeaderText="검정고시점수" DataField="qualificationScore" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--28-- 환불계좌 번호 --%>
                                <asp:BoundField HeaderText="환불계좌 번호" DataField="RefundAccountNo" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--29-- 환불계좌 명의 --%>
                                <asp:BoundField HeaderText="환불계좌 명의" DataField="RefundAccountName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--30-- 환불계좌 은행코드 --%>
                                <asp:BoundField HeaderText="환불계좌 은행코드" DataField="BankCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--31-- 대학명 --%>
                                <asp:BoundField HeaderText="대학명" DataField="UnivName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--32-- 대학과명 --%>
                                <asp:BoundField HeaderText="대학과명" DataField="UnivLesson" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--33-- 대학졸업여부 --%>
                                <asp:BoundField HeaderText="대학졸업여부" DataField="UnivYN" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--34-- 대학졸업년도 --%>
                                <asp:BoundField HeaderText="대학졸업년도" DataField="UnivYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--35-- 대학 기준평점 --%>
                                <asp:BoundField HeaderText="대학 기준평점" DataField="Score" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--36-- 대학 본인(평점평균) --%>
                                <asp:BoundField HeaderText="대학 본인(평점평균)" DataField="AvgScore" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--37-- 자격증 --%>
                                <asp:BoundField HeaderText="자격증" DataField="certificate" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--38-- 산업체명 --%>
                                <asp:BoundField HeaderText="산업체명" DataField="office" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--39-- 특기사항 --%>
                                <asp:BoundField HeaderText="" DataField="ReMark" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--40-- 생활관(기숙사) --%>
                                <asp:BoundField HeaderText="생활관(기숙사)" DataField="ListSelect" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--41--병역사항  --%>
                                <asp:BoundField HeaderText="병역사항" DataField="military" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--42-- 전형료 --%>
                                <asp:BoundField HeaderText="전형료" DataField="ApplyFee" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--43-- 우편번호 --%>
                                <asp:BoundField HeaderText="우편번호" DataField="zipCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--44-- 주소 --%>
                                <asp:BoundField HeaderText="주소" DataField="address" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--45-- 상세주소 --%>
                                <asp:BoundField HeaderText="상세주소" DataField="addressDetail" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--46-- 자택전화 --%>
                                <asp:BoundField HeaderText="자택전화" DataField="phone" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--47-- 휴대폰 --%>
                                <asp:BoundField HeaderText="휴대폰" DataField="celPhone" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--48-- 이메일 --%>
                                <asp:BoundField HeaderText="이메일" DataField="email" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--49-- 직장전화 --%>
                                <asp:BoundField HeaderText="직장전화1" DataField="guardOfficePhone" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--50-- 휴대폰 --%>
                                <asp:BoundField HeaderText="휴대폰1" DataField="guardCelPhone" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--51-- 직장전화2 --%>
                                <asp:BoundField HeaderText="직장전화2" DataField="guardOfficePhone2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--52-- 휴대폰2 --%>
                                <asp:BoundField HeaderText="휴대폰2" DataField="guardCelPhone2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--53-- 직장전화3 --%>
                                <asp:BoundField HeaderText="직장전화3" DataField="guardOfficePhone3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--54-- 휴대폰3--%>
                                <asp:BoundField HeaderText="휴대폰3" DataField="guardCelPhone3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--55-- 직장전화4  --%>
                                <asp:BoundField HeaderText="직장전화4" DataField="guardOfficePhone4" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--56-- 휴대폰4 --%>
                                <asp:BoundField HeaderText="휴대폰4" DataField="guardCelPhone4" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--57-- 동의여부1 --%>
                                <asp:BoundField HeaderText="동의여부1" DataField="UseScoreForPass" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--58-- 동의여부2 --%>
                                <asp:BoundField HeaderText="동의여부2" DataField="UseExamForPass" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--59-- 동의여부3 --%>
                                <asp:BoundField HeaderText="동의여부3" DataField="UseScoreForScholarShip" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--60-- 동의여부4 --%>
                                <asp:BoundField HeaderText="동의여부4" DataField="UseExamForScholarShip" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--61-- 동의여부5 --%>
                                <asp:BoundField HeaderText="동의여부5" DataField="UseApplicantData" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--62-- CS코드 --%>
                                <asp:BoundField HeaderText="CS코드" DataField="CSCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--63-- CS명 --%>
                                <asp:BoundField HeaderText="CS명" DataField="csName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--64-- NEIS코드 고등학교코드--%>
                                <asp:BoundField HeaderText="NEIS코드" DataField="neisCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--65-- NEIS명 고등학교명--%>
                                <asp:BoundField HeaderText="NEIS명" DataField="neisName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--66-- 고등학교 위치 --%>
                                <asp:BoundField HeaderText="고등학교 위치" DataField="state" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--67-- 편입학 학년 --%>
                                <asp:BoundField HeaderText="편입학 학년" DataField="transferGrade" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--68-- 산업체 코드 --%>
                                <asp:BoundField HeaderText="산업체 코드" DataField="CompanyCode" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--69-- 산업체 명 --%>
                                <asp:BoundField HeaderText="산업체 명" DataField="CompanyName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--70-- 산업체 부서 --%>
                                <asp:BoundField HeaderText="산업체 부서" DataField="CompanyDeptName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--71-- 산업체 직위 --%>
                                <asp:BoundField HeaderText="산업체 직위" DataField="CompanyGradeName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--72-- 산업체 근무개월수 --%>
                                <asp:BoundField HeaderText="산업체 근무개월수" DataField="CompanyWork" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--73-- 검정고시회차 --%>
                                <asp:BoundField HeaderText="검정고시회차" DataField="GEDCount" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--74-- 대학수료년수 --%>
                                <asp:BoundField HeaderText="대학수료년수" DataField="UnivCompletion" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--75-- 대학구분 --%>
                                <asp:BoundField HeaderText="대학구분" DataField="UnivDiv" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--76-- 파일경로1 --%>
                                <asp:BoundField HeaderText="파일경로1" DataField="FILE_PATH1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--77-- 파일명1 --%>
                                <asp:BoundField HeaderText="파일명1" DataField="FILE_NAME1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--78-- 파일경로2 --%>
                                <asp:BoundField HeaderText="파일경로2" DataField="FILE_PATH2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--79-- 파일명2 --%>
                                <asp:BoundField HeaderText="파일명2" DataField="FILE_NAME2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
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
                        <cc1:ExToolBar ID="ExToolBar2" runat="server" DeleteVisible="true" />
                    </div>
                </div>
            </div>
            <!-- 입시지원자 리스트 끝 -->

            <!-- 입시지원 입력항목 시작 -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title pencil">입시지원 입력항목</h3>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">
                        <!-- 1열 -->
                        <div class="form-group form-group-sm">
                            <!-- 지원연도 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="txt지원연도">지원연도 :</asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt지원연도" runat="server" Width="60px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar3_Save;ExToolBar5_Print" Description="지원연도" ToolTip="지원연도" Required="true"></cc1:ExTextBox>
                            </div>

                            <!-- 지원시기 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="ddl지원시기">지원시기 :</asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExDropDownList ID="ddl지원시기" runat="server" CssClass="form-control" Width="170px" Group="ExToolBar3_Save" Description="지원시기" ToolTip="지원시기" CodeType="_공통" BindMode="None" P1="SA02" Required="true" OnSelectedIndexChanged="ddl전형구분_SelectedIndexChanged" AutoPostBack="true"></cc1:ExDropDownList>
                            </div>

                            <!-- 수험번호 -->
                            <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txt수험번호">수험번호 : </asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt수험번호" runat="server" Width="120px" CssClass="form-control" Group="ExToolBar5_Print" Description="수험번호" ToolTip="수험번호" Required="true" ReadOnly="true"></cc1:ExTextBox>
                                <cc1:ExToolBar ID="ExToolBar5" runat="server" PrintVisible="true" PrintText="수험표출력" />
                            </div>
                        </div>
                        <!-- 2열 -->
                        <div class="form-group form-group-sm">
                            <!-- 성명 korName -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="txt성명">성명 :</asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt성명" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar3_Save" Description="성명" ToolTip="성명" Required="true" MaxLength="20"></cc1:ExTextBox>
                            </div>

                            <!-- 주민등록번호 resdNo-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="txt주민등록번호앞자리">주민등록번호 :</asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt주민등록번호앞자리" runat="server" CssClass="form-control" Description="주민등록번호(앞자리)" ToolTip="주민등록번호(앞자리)" Width="75px" FixLength="6" MaxLength="6" ValidationType="Numeric" Group="ExToolBar3_Save" Required="true"></cc1:ExTextBox>
                                &nbsp-&nbsp
                                <cc1:ExTextBox ID="txt주민등록번호뒷자리" runat="server" CssClass="form-control" Description="주민등록번호(뒷자리)" ToolTip="주민등록번호(뒷자리)" Width="75px" FixLength="7" MaxLength="7" ValidationType="Numeric" Group="ExToolBar3_Save" Required="true"></cc1:ExTextBox>
                                <%--<cc1:ExToolBar ID="ExToolBar6" runat="server" Etc2Visible="true" Etc2Text="검사" Etc2CSS="btn btn-sm btn-default" />--%>
                                <asp:Button runat="server" ID="btnResdChk" CssClass="btn btn-sm btn-default" Text="검사" OnClientClick="return ResdChk();" />
                            </div>

                            <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <!-- 결과 -->
                                    <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="lbl결과">결과 : </asp:Label>
                                    <asp:Label ID="lbl결과" runat="server" CssClass="control-label col-xs-3" Style="text-align: left" Description="결과" ToolTip="결과" ForeColor="Red"></asp:Label>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnResdChk" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <!-- 3열 -->
                        <div class="form-group form-group-sm">
                            <!-- 전형구분 sppoClsCode-->
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="ddl전형구분">전형구분 :</asp:Label>
                                    <div class="col-xs-3 form-inline">
                                        <cc1:ExDropDownList ID="ddl전형구분" runat="server" CssClass="form-control" Width="100%" Group="ExToolBar3_Save" Description="전형구분" ToolTip="전형구분" CodeType="_공통" BindMode="Select" Required="true" OnSelectedIndexChanged="ddl전형구분_SelectedIndexChanged" AutoPostBack="true"></cc1:ExDropDownList>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnReBindDdl" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:Button ID="btnReBindDdl" runat="server" CssClass="hidden" Text="연도 변경시 전형구분, 지원학과 다시 바인딩" />

                            <!-- 1지망 지원학과 majorCode1 -->
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="ddl1지망지원학과"><strong style="color:red">*</strong>1지망 지원학과 :</asp:Label>
                                    <div class="col-xs-3 form-inline">
                                        <cc1:ExDropDownList ID="ddl1지망지원학과" runat="server" CssClass="form-control" Width="100%" Group="ExToolBar3_Save" Description="1지망 지원학과" ToolTip="1지망 지원학과" CodeType="_공통" BindMode="Select" Required="true"></cc1:ExDropDownList>
                                    </div>

                                    <!-- 2지망 지원학과 majorCode2 -->
                                    <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="ddl2지망지원학과">2지망 지원학과 :</asp:Label>
                                    <div class="col-xs-3 form-inline">
                                        <cc1:ExDropDownList ID="ddl2지망지원학과" runat="server" CssClass="form-control" Width="100%" Group="ExToolBar3_Save" Description="2지망 지원학과" ToolTip="2지망 지원학과" CodeType="_공통" BindMode="Select" Required="false"></cc1:ExDropDownList>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddl전형구분" />
                                    <asp:AsyncPostBackTrigger ControlID="ddl지원시기" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 입시지원 입력항목 끝 -->

            <!-- 입시지원자 정보 입력항목 시작 -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title pencil">입시지원자 정보 입력항목</h3>
                </div>
                <div class="panel-body">
                    <div class="form-horizontal">

                        <h3 class="sTitle c05 mb_5">▶ 출신고교</h3>
                        <!-- 1열 -->
                        <div class="form-group form-group-sm">
                            <!-- 출신고교명 -->
                            <asp:Label CssClass="col-xs-1 control-label" runat="server" AssociatedControlID="txtNeisName" Text="출신고교명 :"></asp:Label>
                            <div class="col-xs-3 form-inline">
                                <uc2:Highschool ID="txtNeisName" runat="server" Group="ExToolBar3_Save" DisplayToolTip="출신고교명" Description="출신고교명" ValueToolTip="출신고교명" neisNameWidth="240px" />
                            </div>
                            <!-- 고교유형 LstGradu 1:일반고, 특목고, 종합고 / 2:마이스터고, 특성화고-->
                            <asp:Label CssClass="col-xs-1 control-label" runat="server" AssociatedControlID="rdo고교유형" Text="고교유형 :"></asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExRadioButtonList ID="rdo고교유형" runat="server" Group="ExToolBar3_Save" Description="고교유형" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="일반고, 특목고, 종합고" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="마이스터고, 특성화고" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <!-- 고교과 graduLesson -->
                            <asp:Label CssClass="col-xs-1 control-label" runat="server" AssociatedControlID="txt고교과" Text="고교과 :"></asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt고교과" runat="server" Width="80%" Description="고교과" ToolTip="고교과" Group="ExToolBar3_Save" IsNegative="false" MaxLength="30"></cc1:ExTextBox>
                                과
                            </div>
                        </div>
                        <!-- 2열 -->
                        <div class="form-group form-group-sm">
                            <!-- 고교졸업 graduYN 1:졸업/0:졸업예정 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="고교졸업 :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExRadioButtonList ID="rdo고교졸업" runat="server" Group="ExToolBar3_Save" Description="(고교)졸업/졸업예정" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="졸업예정" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="졸업" Value="1"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>

                            <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txt고교졸업년도">졸업(검정합격) :</asp:Label>
                            <div class="col-xs-3 form-inline">
                                <!-- 졸업(검정합격)년 graduYear -->
                                <cc1:ExTextBox ID="txt고교졸업년도" runat="server" Width="60px" CssClass="form-control text-center" Description="고교졸업년도" ToolTip="고교졸업년도" Group="ExToolBar3_Save" ValidationType="Numeric" IsNegative="false" MaxLength="4" FixLength="4"></cc1:ExTextBox>
                                년&nbsp;
                                <!-- 졸업(검정합격)월 graduMonth -->
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddl고교졸업월" Visible="false">월 :</asp:Label>
                                <cc1:ExDropDownList ID="ddl고교졸업월" runat="server" CssClass="form-control" Width="80px" Group="ExToolBar3_Save" Description="고교졸업월" ToolTip="고교졸업월">
                                    <asp:ListItem Value="">선택</asp:ListItem>
                                    <asp:ListItem Value="01">1월</asp:ListItem>
                                    <asp:ListItem Value="02" Selected="True">2월</asp:ListItem>
                                    <asp:ListItem Value="03">3월</asp:ListItem>
                                    <asp:ListItem Value="04">4월</asp:ListItem>
                                    <asp:ListItem Value="05">5월</asp:ListItem>
                                    <asp:ListItem Value="06">6월</asp:ListItem>
                                    <asp:ListItem Value="07">7월</asp:ListItem>
                                    <asp:ListItem Value="08">8월</asp:ListItem>
                                    <asp:ListItem Value="09">9월</asp:ListItem>
                                    <asp:ListItem Value="10">10월</asp:ListItem>
                                    <asp:ListItem Value="11">11월</asp:ListItem>
                                    <asp:ListItem Value="12">12월</asp:ListItem>
                                </cc1:ExDropDownList>
                                (검정회차)
                                <cc1:ExDropDownList ID="ddl검정고시회차" runat="server" CssClass="form-control" Width="80px" Group="ExToolBar3_Save" Description="검정고시회차" ToolTip="검정고시회차">
                                    <asp:ListItem Value=""></asp:ListItem>
                                    <asp:ListItem Value="1">1회차</asp:ListItem>
                                    <asp:ListItem Value="2">2회차</asp:ListItem>
                                    <asp:ListItem Value="3">3회차</asp:ListItem>
                                    <asp:ListItem Value="4">4회차</asp:ListItem>
                                </cc1:ExDropDownList>
                            </div>
                            <!-- 검정고시 점수 qualificationScore -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="검정고시점수 :" AssociatedControlID="txt검정고시점수"></asp:Label>
                            <div class="col-xs-1">
                                <cc1:ExTextBox ID="txt검정고시점수" runat="server" Width="70px" CssClass="form-control text-right" ValidationType="Numeric" Cipher="2" IsNegative="false" Group="ExToolBar3_Save" Description="검정고시점수" ToolTip="검정고시점수"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddl편입학년">편입학 학년 :</asp:Label>
                            <div class="col-xs-1">
                                <cc1:ExDropDownList ID="ddl편입학년" runat="server" CssClass="form-control" Width="80px" Group="ExToolBar3_Save" Description="편입학 학년" ToolTip="편입학 학년">
                                    <asp:ListItem Value=""></asp:ListItem>
                                    <asp:ListItem Value="1">1학년</asp:ListItem>
                                    <asp:ListItem Value="2">2학년</asp:ListItem>
                                    <asp:ListItem Value="3">3학년</asp:ListItem>
                                    <asp:ListItem Value="4">4학년</asp:ListItem>
                                </cc1:ExDropDownList>
                            </div>
                        </div>




                        <h3 class="sTitle c05 mb_5">▶ 전형료 환불계좌 (부모명의)</h3>
                        <!-- 3열 -->
                        <div class="form-group form-group-sm">
                            <!-- 계좌번호 ApplicantRefundAccount.RefundAccountNo-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="계좌번호 :" AssociatedControlID="txt계좌번호"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt계좌번호" runat="server" Width="100%" CssClass="form-control" MaxLength="100" Group="ExToolBar3_Save" Description="계좌번호" ToolTip="계좌번호"></cc1:ExTextBox>
                            </div>
                            <!-- 계좌명의 ApplicantRefundAccount.RefundAccountName-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="계좌명의 :" AssociatedControlID="txt계좌명의"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt계좌명의" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="계좌명의" ToolTip="계좌명의"></cc1:ExTextBox>
                            </div>
                            <!-- 은행 ApplicantRefundAccount.BankCode-->
                            <div class="col-xs-1">
                                <cc1:ExDropDownList ID="ddl은행" runat="server" CssClass="form-control" Width="150px" Group="ExToolBar3_Save" Description="은행" ToolTip="은행" CodeType="_공통" BindMode="None" P1="C101"></cc1:ExDropDownList>
                            </div>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 대학(교) 정보
                            <label style="color: red; font-size: small;">* 전문대학/대졸자 전형만 입력하세요 </label>
                        </h3>
                        <!-- 4열 -->
                        <div class="form-group form-group-sm">
                            <!-- 대학명 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="대학명 :" AssociatedControlID="txt대학명"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt대학명" runat="server" Width="100%" CssClass="form-control" MaxLength="50" Group="ExToolBar3_Save" Description="대학명" ToolTip="대학명"></cc1:ExTextBox>
                            </div>
                            <!-- 대학과명 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="대학과명 :" AssociatedControlID="txt대학과명"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt대학과명" runat="server" Width="100%" CssClass="form-control" MaxLength="100" Group="ExToolBar3_Save" Description="대학과명" ToolTip="대학과명"></cc1:ExTextBox>
                            </div>
                        </div>

                        <div class="form-group form-group-sm">
                            <!-- 대학수료년수 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="대학수료년수 :" AssociatedControlID="txt대학수료년수"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt대학수료년수" runat="server" Width="60px" CssClass="form-control text-right" Description="대학수료년수" ToolTip="대학수료년수" Group="ExToolBar3_Save" ValidationType="Numeric" IsNegative="false" MaxLength="4"></cc1:ExTextBox>
                            </div>
                            <!-- 대학구분 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="대학구분 :" AssociatedControlID="ddl대학구분"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExDropDownList ID="ddl대학구분" runat="server" CssClass="form-control" Width="70%" Group="ExToolBar3_Save" Description="대학구분" ToolTip="대학구분">
                                    <asp:ListItem Value=""></asp:ListItem>
                                    <asp:ListItem Value="2">2년제 전문대</asp:ListItem>
                                    <asp:ListItem Value="3">3년제 전문대</asp:ListItem>
                                    <asp:ListItem Value="4">4년제 대학교</asp:ListItem>
                                    <asp:ListItem Value="5">4년제 전문대</asp:ListItem>
                                </cc1:ExDropDownList>
                            </div>
                        </div>

                        <!-- 4-2열 -->
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="subfile1" Text="졸업증명서 :"></asp:Label>
                            <div class="col-xs-10">
                                <input id="upload_file1" type="file" name="upload_file1" runat="server" title="첨부파일" class="hidden" />
                                <div class="input-group" style="width: 525px">
                                    <cc1:extextbox runat="server" ID="subfile1" CssClass="form-control disabled" DataBindGroup="ProfileResult" DataField="RealFileName"></cc1:extextbox>
                                    <span id="spanFindFile1" runat="server" class="input-group-addon btn" style="height: 30px; width: 80px">파일찾기</span>
                                    <span id="btnDownLoadFile1" runat="server" class="input-group-addon btn" style="height: 30px; width: 40px" title="다운로드"><i class='glyphicon glyphicon-floppy-disk c06'></i></span>
                                    <asp:Button ID="btnDownFile1" runat="server" CssClass="hidden"/>
                                </div>
                                <span class="txt bg-primary small">첨부파일은 10MB이하 파일만 등록 가능합니다.</span>
                                <cc1:extextbox ID="txtServerFilePath1" runat="server" DataBindGroup="ProfileResult" DataField="ServerFilePath" CssClass="hidden"></cc1:extextbox>
                                <cc1:extextbox ID="txtServerFileName1" runat="server" DataBindGroup="ProfileResult" DataField="ServerFileName" CssClass="hidden"></cc1:extextbox>
                                <cc1:extextbox ID="txtRealFileName1" runat="server" DataBindGroup="ProfileResult" DataField="RealFileName" CssClass="hidden"></cc1:extextbox>
                            </div>
                        </div>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="subfile2" Text="성적증명서 :"></asp:Label>
                            <div class="col-xs-10">
                                <input id="upload_file2" type="file" name="upload_file1" runat="server" title="첨부파일" class="hidden" />
                                <div class="input-group" style="width: 525px">
                                    <cc1:extextbox runat="server" ID="subfile2" CssClass="form-control disabled" DataBindGroup="ProfileResult" DataField="RealFileName"></cc1:extextbox>
                                    <span id="spanFindFile2" runat="server" class="input-group-addon btn" style="height: 30px; width: 80px">파일찾기</span>
                                    <span id="btnDownLoadFile2" runat="server" class="input-group-addon btn" style="height: 30px; width: 40px" title="다운로드"><i class='glyphicon glyphicon-floppy-disk c06'></i></span>
                                    <asp:Button ID="btnDownFile2" runat="server" CssClass="hidden" />
                                </div>
                                <span class="txt bg-primary small">첨부파일은 10MB이하 파일만 등록 가능합니다.</span>
                                <cc1:extextbox ID="txtServerFilePath2" runat="server" DataBindGroup="ProfileResult" DataField="ServerFilePath" CssClass="hidden"></cc1:extextbox>
                                <cc1:extextbox ID="txtServerFileName2" runat="server" DataBindGroup="ProfileResult" DataField="ServerFileName" CssClass="hidden"></cc1:extextbox>
                                <cc1:extextbox ID="txtRealFileName2" runat="server" DataBindGroup="ProfileResult" DataField="RealFileName" CssClass="hidden"></cc1:extextbox>
                            </div>
                        </div>

                        <!-- 5열 -->
                        <div class="form-group form-group-sm form-inline">
                            <!-- 대학졸업 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="대학졸업 :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExRadioButtonList ID="rdo대학졸업" runat="server" Group="ExToolBar3_Save" Description="(대학)졸업/예정/수료" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="졸업" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="예정" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="수료" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                                <!-- 대학졸업년도 -->
                                <cc1:ExTextBox ID="txt대학졸업년도" runat="server" Width="60px" CssClass="form-control text-center" Description="연도" ToolTip="연도" Group="ExToolBar3_Save" ValidationType="Numeric" IsNegative="false" MaxLength="4" FixLength="4"></cc1:ExTextBox>
                                년
                            </div>
                            <!-- 기준평점 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="기준평점 :" AssociatedControlID="txt기준평점"></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExTextBox ID="txt기준평점" runat="server" Width="70px" CssClass="form-control text-right" MaxLength="15" Group="ExToolBar3_Save" ValidationGroup="Numeric" Cipher="2" IsNegative="false" Description="기준평점" ToolTip="기준평점"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Style="text-align: left" Text="(ex 4.5)"></asp:Label>
                            <!-- 본인(평점평균) -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="본인(평점평균) :" AssociatedControlID="txt본인평점평균"></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExTextBox ID="txt본인평점평균" runat="server" Width="70px" CssClass="form-control text-right" MaxLength="15" ValidationGroup="Numeric" Cipher="2" IsNegative="false" Group="ExToolBar3_Save" Description="본인(평점평균)" ToolTip="본인(평점평균)"></cc1:ExTextBox>
                            </div>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 자격증</h3>
                        <!-- 6열 -->
                        <div class="form-group form-group-sm">
                            <!-- 자격증 certificate-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="자격증 :" AssociatedControlID="txt자격증"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt자격증" runat="server" Width="100%" CssClass="form-control" MaxLength="80" Group="ExToolBar3_Save" Description="자격증" ToolTip="자격증"></cc1:ExTextBox>
                            </div>
                            <!-- 산업체명 office-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="산업체명 :" AssociatedControlID="txt산업체명"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt산업체명" runat="server" Width="100%" CssClass="form-control" MaxLength="80" Group="ExToolBar3_Save" Description="산업체명" ToolTip="산업체명"></cc1:ExTextBox>
                            </div>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 생활관 / 병역사항 / 전형료</h3>
                        <!-- 7열 -->
                        <div class="form-group form-group-sm">
                            <!-- 생활관(기숙사) boarding 0:미신청/1:신청  ListSelect-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="rdo생활관기숙사" Text="생활관(기숙사) :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExRadioButtonList ID="rdo생활관기숙사" runat="server" Group="ExToolBar3_Save" Description="생활관(기숙사)" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="미신청" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="1인실" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2인실" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3인실" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4인실" Value="4"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <!-- 병역사항 military-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="rdo병역사항" Text="병역사항 :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExRadioButtonList ID="rdo병역사항" runat="server" Group="ExToolBar3_Save" Description="병역사항" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="미필" Value="2" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="면제" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="군필" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="여학생" Value=""></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <!-- 전형료 ApplyFee -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="ddl전형료" Text="전형료 :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExDropDownList ID="ddl전형료" runat="server" Group="ExtoolBar3_Save" Description="전형료" CssClass="form-control" BindMode="Select" Width="70%"></cc1:ExDropDownList>
                            </div>
                            <%--                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="rdo전형료" Text="전형료 :"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExRadioButtonList ID="rdo전형료" runat="server" Group="ExToolBar3_Save" Description="전형료" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="30,000원" Value="30000" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="25,000원" Value="25000"></asp:ListItem>
                                    <asp:ListItem Text="5,000원" Value="5000"></asp:ListItem>
                                    <asp:ListItem Text="면제" Value="0"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>--%>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 주소 / 연락처 / 추가연락처</h3>
                        <!-- 8열 -->
                        <div class="form-group form-group-sm">
                            <!-- 우편번호 -->
                            <asp:Label CssClass="col-xs-1 control-label" runat="server" AssociatedControlID="txtPostCode" Text="우편번호 :"></asp:Label>
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txtPostCode" runat="server" CssClass="form-control" Width="100px" MaxLength="7" ReadOnly="true" Group="ExToolBar3_Save" Description="우편번호" ToolTip="우편번호"></cc1:ExTextBox>
                                <button id="btnPopup" class="btn btn-default btn-sm" type="button" runat="server" onclick="OpenModalZipCode();"><i class='glyphicon glyphicon-search'></i></button>
                            </div>
                            <!-- 주소 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="주소 :" AssociatedControlID="txtAddress"></asp:Label>
                            <div class="col-xs-7 form-inline">
                                <cc1:ExTextBox ID="txtAddress" runat="server" Width="322px" CssClass="form-control" MaxLength="100" ReadOnly="true" Group="ExToolBar3_Save" Description="주소" ToolTip="주소"></cc1:ExTextBox>
                                <asp:Label ID="lblDetailAddress" AssociatedControlID="txtDetailAddress" runat="server" CssClass="sr-only">상세주소</asp:Label>
                                <cc1:ExTextBox ID="txtDetailAddress" runat="server" Width="440px" CssClass="form-control" MaxLength="50" Group="ExToolBar3_Save" Description="상세주소" ToolTip="상세주소"></cc1:ExTextBox>
                            </div>
                        </div>
                        <!-- 9열 -->
                        <div class="form-group form-group-sm">
                            <!-- 자택전화 phone-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="자택전화 :" AssociatedControlID="txt자택전화"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt자택전화" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="자택전화" ToolTip="자택전화"></cc1:ExTextBox>
                            </div>
                            <!-- 휴대폰 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="휴대폰 :" AssociatedControlID="txt휴대폰"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt휴대폰" runat="server" Width="100%" CssClass="form-control" MaxLength="15" Group="ExToolBar3_Save" Description="휴대폰" ToolTip="휴대폰"></cc1:ExTextBox>
                            </div>
                            <!-- 이메일 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="이메일 :" AssociatedControlID="txt이메일"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt이메일" runat="server" Width="100%" CssClass="form-control" MaxLength="60" Group="ExToolBar3_Save" Description="이메일" ToolTip="이메일"></cc1:ExTextBox>
                            </div>
                        </div>
                        <!-- 10열 -->
                        <div class="form-group form-group-sm">
                            <!-- 직장전화1 guardOfficePhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="직장전화1 :" AssociatedControlID="txt직장전화1"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt직장전화1" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="직장전화1" ToolTip="직장전화1"></cc1:ExTextBox>
                            </div>
                            <!-- 휴대폰1 guardCelPhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="휴대폰1 :" AssociatedControlID="txt휴대폰1"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt휴대폰1" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="휴대폰1" ToolTip="휴대폰1"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="(추가 연락처 1)"></asp:Label>
                        </div>
                        <!-- 11열 -->
                        <div class="form-group form-group-sm">
                            <!-- 직장전화2 ApplicantAdditionalPhoneNo.guardOfficePhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="직장전화2 :" AssociatedControlID="txt직장전화2"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt직장전화2" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="직장전화2" ToolTip="직장전화2"></cc1:ExTextBox>
                            </div>
                            <!-- 휴대폰2 ApplicantAdditionalPhoneNo.guardCelPhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="휴대폰2 :" AssociatedControlID="txt휴대폰2"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt휴대폰2" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="휴대폰2" ToolTip="휴대폰2"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="(추가 연락처 2)"></asp:Label>
                        </div>
                        <!-- 12열 -->
                        <div class="form-group form-group-sm">
                            <!-- 직장전화3 ApplicantAdditionalPhoneNo.guardOfficePhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="직장전화3 :" AssociatedControlID="txt직장전화3"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt직장전화3" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="직장전화3" ToolTip="직장전화3"></cc1:ExTextBox>
                            </div>
                            <!-- 휴대폰3 ApplicantAdditionalPhoneNo.guardCelPhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="휴대폰3 :" AssociatedControlID="txt휴대폰3"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt휴대폰3" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="휴대폰3" ToolTip="휴대폰3"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="(추가 연락처 3)"></asp:Label>
                        </div>
                        <!-- 13열 -->
                        <div class="form-group form-group-sm">
                            <!-- 직장전화4 ApplicantAdditionalPhoneNo.guardOfficePhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="직장전화4 :" AssociatedControlID="txt직장전화4"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt직장전화4" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="직장전화4" ToolTip="직장전화4"></cc1:ExTextBox>
                            </div>
                            <!-- 휴대폰4 ApplicantAdditionalPhoneNo.guardCelPhone -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="휴대폰4 :" AssociatedControlID="txt휴대폰4"></asp:Label>
                            <div class="col-xs-3">
                                <cc1:ExTextBox ID="txt휴대폰4" runat="server" Width="100%" CssClass="form-control" MaxLength="20" Group="ExToolBar3_Save" Description="휴대폰4" ToolTip="휴대폰4"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="(추가 연락처 4)"></asp:Label>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 특기사항</h3>
                        <div class="form-group form-group-sm">
                            <!-- 특기사항 ReMark-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="특기사항 :" AssociatedControlID="txt특기사항"></asp:Label>
                            <div class="col-xs-7">
                                <cc1:ExTextBox ID="txt특기사항" runat="server" Width="100%" CssClass="form-control" MaxLength="200" Group="ExToolBar3_Save" Description="특기사항" ToolTip="특기사항"></cc1:ExTextBox>
                            </div>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 산업체 정보</h3>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="산업체 :" AssociatedControlID="CompanySearch1"></asp:Label>
                            <div class="col-xs-3 form-inline">
                                <uc2:CompanySearch ID="CompanySearch1" runat="server" Group="ExToolBar3_Save" DisplayToolTip="산업체명" Description="산업체명" ValueToolTip="산업체명" CompanyNameWidth="280px" />
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="부서 :" AssociatedControlID="txtCompanyDept"></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExTextBox ID="txtCompanyDept" runat="server" Width="100%" CssClass="form-control" MaxLength="80" Group="ExToolBar3_Save" Description="부서" ToolTip="부서"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="직위 :" AssociatedControlID="txtCompanyGrade"></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExTextBox ID="txtCompanyGrade" runat="server" Width="100%" CssClass="form-control" MaxLength="80" Group="ExToolBar3_Save" Description="직위" ToolTip="직위"></cc1:ExTextBox>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="근무개월수 :" AssociatedControlID="txt검정고시점수"></asp:Label>
                            <div class="col-xs-1">
                                <cc1:ExTextBox ID="txtCompanyWork" runat="server" Width="70px" CssClass="form-control text-right" ValidationType="Numeric" Cipher="0" IsNegative="false" Group="ExToolBar3_Save" Description="근무개월수" ToolTip="근무개월수"></cc1:ExTextBox>
                            </div>
                        </div>

                        <h3 class="sTitle c05 mb_5">▶ 확인 및 주의사항</h3>
                        <!-- 14열 -->
                        <div class="form-group form-group-sm">
                            <!-- 동의여부1 ApplicantUseScoreAgree.Pass-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text=""></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExRadioButtonList ID="rdo동의여부1" runat="server" Group="ExToolBar3_Save" Description="동의여부1" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="동의함" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="동의안함" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-4 control-label" Style="text-align: left" Text="교육부에서 제공하는 학교생활기록부 자료를 합격사정 활용"></asp:Label>
                        </div>
                        <!-- 15열 -->
                        <div class="form-group form-group-sm">
                            <!-- 동의여부2 ApplicantUseExamAgree.Pass-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text=""></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExRadioButtonList ID="rdo동의여부2" runat="server" Group="ExToolBar3_Save" Description="동의여부2" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="동의함" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="동의안함" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-4 control-label" Style="text-align: left" Text="교육부에서 제공하는 수능성적 자료를 합격사정 활용"></asp:Label>
                        </div>
                        <!-- 16열 -->
                        <div class="form-group form-group-sm">
                            <!-- 동의여부3 ApplicantUseScoreAgree.Scholarship-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text=""></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExRadioButtonList ID="rdo동의여부3" runat="server" Group="ExToolBar3_Save" Description="동의여부3" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="동의함" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="동의안함" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-4 control-label" Style="text-align: left" Text="교육부에서 제공하는 학교생활기록부 자료를 장학사정 활용"></asp:Label>
                        </div>
                        <!-- 17열 -->
                        <div class="form-group form-group-sm">
                            <!-- 동의여부4 ApplicantUseExamAgree.Scholarship-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text=""></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExRadioButtonList ID="rdo동의여부4" runat="server" Group="ExToolBar3_Save" Description="동의여부4" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="동의함" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="동의안함" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-4 control-label" Style="text-align: left" Text="교육부에서 제공하는 수능성적 자료를 장학사정 활용"></asp:Label>
                        </div>
                        <!-- 18열 -->
                        <div class="form-group form-group-sm">
                            <!-- 동의여부5 ApplicantUwayDataAgree.Agree-->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" Text=""></asp:Label>
                            <div class="col-xs-2">
                                <cc1:ExRadioButtonList ID="rdo동의여부5" runat="server" Group="ExToolBar3_Save" Description="동의여부5" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="동의함" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="동의안함" Value="2"></asp:ListItem>
                                </cc1:ExRadioButtonList>
                            </div>
                            <asp:Label runat="server" CssClass="col-xs-4 control-label" Style="text-align: left" Text="입학지원서 자료를 거제대학교 입학전형 활용"></asp:Label>
                        </div>
                    </div>
                </div>
                <!-- 버튼영역 -->
                <div class="panel-footer">
                    <div class="text-right">
                        <cc1:ExToolBar ID="ExToolBar3" runat="server" NewVisible="true" SaveVisible="true" />
                    </div>
                </div>
            </div>
            <!-- 입시지원자 정보 입력항목 끝 -->
        </div>
    </div>
</asp:Content>

<asp:Content runat="server" ID="Footer" ContentPlaceHolderID="FooterContent">
    <script type="text/javascript">
        $(document).ready(function () {

            var regExp1 = /^\d{2,3}-\d{3,4}-\d{4}$/;
            var regExp2 = /^\d{3}-\d{3,4}-\d{4}$/;

            $('#<%= txt자택전화.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp1.test($phone.val())) {
                        alertMessage('자택전화 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt직장전화1.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp1.test($phone.val())) {
                        alertMessage('직장전화1 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt직장전화2.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp1.test($phone.val())) {
                        alertMessage('직장전화2 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt직장전화3.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp1.test($phone.val())) {
                        alertMessage('직장전화3 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt직장전화4.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp1.test($phone.val())) {
                        alertMessage('직장전화4 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });

            $('#<%= txt휴대폰.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp2.test($phone.val())) {
                        alertMessage('휴대폰 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt휴대폰1.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp2.test($phone.val())) {
                        alertMessage('휴대폰1 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt휴대폰2.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp2.test($phone.val())) {
                        alertMessage('휴대폰2 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt휴대폰3.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp2.test($phone.val())) {
                        alertMessage('휴대폰3 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });
            $('#<%= txt휴대폰4.ClientID %>').on('blur', function () {
                var $phone = $(this);
                if ($phone.val() != '') {
                    if (!regExp2.test($phone.val())) {
                        alertMessage('휴대폰4 항목의 번호가 잘못된 형식입니다.');
                        $phone.val('');
                        return false;
                    }
                }
            });

            $('#<%= ExToolBar2.ClientID %>' + '_Delete').on('click', function (e) {
                var $button = $(this);
                if (ClickChkSelect('입지지원자 리스트에서 삭제', 'grdList', 'chkRow', 0)) {
                    confirmMessage("선택한 자료를 삭제 하시겠습니까?", $button);
                }
                return false;
            });

            $('#<%= txt주민등록번호앞자리.ClientID %>').on('keyup', function (e) {
                $("#<%=lbl결과.ClientID%>").text("");
                return false;
            });
            $('#<%= txt주민등록번호뒷자리.ClientID %>').on('keyup', function (e) {
                $("#<%=lbl결과.ClientID%>").text("");
                return false;
            });

            $('#<%= txt지원연도.ClientID %>').on('blur', function () {
                var $applyYear = $(this).val();
                if ($applyYear == '' || $applyYear.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindDdl.ClientID %>').click();
                }
            });

            $('#<%= txt지원연도조회.ClientID %>').on('blur', function () {
                var $applyYear = $(this).val();
                if ($applyYear == '' || $applyYear.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindSearchDdl.ClientID %>').click();
                }
            });

            $("#<%=spanFindFile1.ClientID%>").on("click", function () {
                $("#<%=upload_file1.ClientID%>").click();
            });

            $("#<%=spanFindFile2.ClientID%>").on("click", function () {
                $("#<%=upload_file2.ClientID%>").click();
            });

             $("#<%=upload_file1.ClientID%>").on("change", function () {

                var filesize = this.files[0].size / 1024 / 1024;
                var fileName = this.files[0].name;
                var dotPosition = fileName.lastIndexOf(".");
                var fileExt = fileName.substring(dotPosition);
                var maxsize = 10;

                if (filesize > maxsize) {
                    alertMessage("파일 용량은 10메가를 초과 할 수 없습니다.");
                    return false;
                }

                $("#<%=subfile1.ClientID%>").val($(this).val());
            });


             $("#<%=upload_file2.ClientID%>").on("change", function () {

                var filesize = this.files[0].size / 1024 / 1024;
                var fileName = this.files[0].name;
                var dotPosition = fileName.lastIndexOf(".");
                var fileExt = fileName.substring(dotPosition);
                var maxsize = 10;

                if (filesize > maxsize) {
                    alertMessage("파일 용량은 10메가를 초과 할 수 없습니다.");
                    return false;
                }

                $("#<%=subfile2.ClientID%>").val($(this).val());
             });

             $("#<%=btnDownLoadFile1.ClientID%>").on("click", function (e) {

                if ($("#<%=txtServerFilePath1.ClientID%>").val().length == 0) {
                    alertMessage("다운로드 할 파일이 없습니다.");
                    return false;
                }

                $("#<%=btnDownFile1.ClientID%>").click();
             });

             $("#<%=btnDownLoadFile2.ClientID%>").on("click", function (e) {

                if ($("#<%=txtServerFilePath2.ClientID%>").val().length == 0) {
                    alertMessage("다운로드 할 파일이 없습니다.");
                    return false;
                }

                $("#<%=btnDownFile2.ClientID%>").click();
            });

        });
    </script>
    <uc2:report ID="Report1" runat="server" />
</asp:Content>