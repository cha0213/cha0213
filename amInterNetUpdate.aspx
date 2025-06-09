<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amInterNetUpdate.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amInterNetUpdate" MasterPageFile="/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pencil">인터넷 접수 업로드</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtApplyYear">지원연도 : </asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Required="true" Group="ExToolBar1_Save" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddlApplySeason">지원시기 : </asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExDropDownList ID="ddlApplySeason" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" BindMode="Select" CodeType="_공통" P1="SA02" Required="true" Group="ExToolBar1_Save"></cc1:ExDropDownList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rbInfoType">구분 : </asp:Label>
                                <div class="col-xs-3">
                                    <asp:RadioButtonList ID="rbInfoType" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="radio">
                                        <asp:ListItem Value="0" Text="접수정보" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="1" Text="민감정보"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm m-b-n">
                                <asp:Label runat="server" CssClass="col-xs-1 control-label" Text="파일 :" AssociatedControlID="upload_file"></asp:Label>
                                <div class="col-xs-11">
                                    <input id="upload_file" type="file" name="upload_file" runat="server" title="첨부파일" class="hidden" />
                                    <div class="input-group" style="width: 600px">
                                        <input type="text" onclick="$('#<%=upload_file.ClientID %>    ').click();" id="subfile" class="form-control" readonly />
                                        <span class="input-group-addon btn" onclick="$('#<%=upload_file.ClientID %>').click();">찾아보기</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="text-right">
                            <cc1:ExToolBar ID="ExToolBar1" runat="server" SaveVisible="true" SaveText="인터넷 접수 업로드" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 히든 값 설정 -->
        <asp:HiddenField ID="hdnRowNum" runat="server" />
        <div class="row">
            <div class="col-xs-12">

           <!-- 입시지원자 리스트 시작 -->
            <div class="panel panel-default">
                <div class="panel-heading ">
                    <h3 class="panel-title pull-left grdList">3회이상 & 타행접수 중복 지원자 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="400px" Style="overflow-y: hidden">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="입시 지원자 리스트" TableCaption="입시 지원자리스트">
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
                                <asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--7-- 성명--%>
                                <asp:BoundField HeaderText="성명" DataField="korName" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--8-- 생년월일--%>
                                <asp:BoundField HeaderText="생년월일" DataField="birthday" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--9-- 고교졸업--%>
                                <asp:BoundField HeaderText="고교졸업" DataField="graduYM" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--10-- 입력자--%>
                                <asp:BoundField HeaderText="접수구분" DataField="applyDiv" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
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
                                <%--80-- 중복숫자 --%>
                                <asp:BoundField HeaderText="중복지원" DataField="Duplication_CNT" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
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
                        <cc1:ExToolBar ID="ExToolBar2" runat="server" SearchVisible ="true" DeleteVisible="true" Etc1Text="3회이상 중복자" Etc1Visible="True" SearchText="타행접수 중복자" />
                    </div>
                </div>
            </div>
            <!-- 입시지원자 리스트 끝 -->
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=upload_file.ClientID%>").on("change", function () {
                $("#subfile").val($(this).val());
            });

            $('#<%= ExToolBar1.ClientID %>_Save').on('click', function () {
                var rValue = false;
                var $btnUpload = $(this);

                var $upload_file = $("#<%=upload_file.ClientID%>");

                if($upload_file.val() == "")
                {
                    alertMessage("파일을 선택 하세요.");
                    return false;
                }

                confirmMessage("인터넷 접수 업로드를 수행 하시겠습니까?", $btnUpload);

                return rValue;
            });
        });
    </script>
    </div>
</asp:Content>