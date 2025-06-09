<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreInput.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreInput" MasterPageFile="/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>
<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

        function SaveEventHandler() {
            var year = ($('#<%= hdnYear.ClientID %>').val());
        var recpNo = ($('#<%= hdnRecpNo.ClientID %>').val());
        if (year == "" || recpNo == "") {
            alertMessage("리스트에서 지원자를 선택하여 입력 한 후 저장 해 주세요.");
            return false;
        }
    }
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
                        <asp:Label runat="server" CssClass=" control-label" AssociatedControlID="txt연도조회">연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt연도조회" runat="server" Width="55px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar1_Search" Description="연도" ToolTip="연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 수험번호 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt수험번호조회">수험번호 :</asp:Label>
                        <cc1:ExTextBox ID="txt수험번호조회" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar1_Search" Description="수험번호" ToolTip="수험번호" MaxLength="8" IsNegative="false"></cc1:ExTextBox>
                    </div>
                    <!-- 성명 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt성명조회">성명 :</asp:Label>
                        <cc1:ExTextBox ID="txt성명조회" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar1_Search" Description="성명" ToolTip="성명" MaxLength="20" IsNegative="false"></cc1:ExTextBox>
                    </div>
                    <!-- 조회버튼 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true"></cc1:ExToolBar>
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->

            <!-- 지원자 리스트 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pull-left grdList">지원자 리스트</h3>
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="400px" Style="overflow-y: hidden">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="지원자 리스트" TableCaption="지원자 리스트" DataKeyNames="year,recpNo"
                            OnRowCommand="grdList_RowCommand" OnSelectedIndexChanged="grdList_SelectedIndexChanged">
                            <Columns>
                                <%--0 순번--%>
                                <asp:BoundField HeaderText="순번" DataField="SEQ" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--1 성명--%>
                                <asp:TemplateField HeaderText="성명">
                                    <HeaderStyle CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkkorName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.korName") %>' CommandName="SELECT"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--2 고교명--%>
                                <asp:BoundField HeaderText="고교명" DataField="neisName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--3 전형구분--%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--4 1지망 학과(계열)--%>
                                <asp:BoundField HeaderText="1지망 학과(계열)" DataField="majorCode1NM" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--5 2지망 학과(계열)--%>
                                <asp:BoundField HeaderText="2지망 학과(계열)" DataField="majorCode2NM" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--6 상태--%>
                                <asp:BoundField HeaderText="상태" DataField="passName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--7 최종합격--%>
                                <asp:BoundField HeaderText="최종합격" DataField="majorFinalName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--8 지원연도 --%>
                                <asp:BoundField HeaderText="" DataField="year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--9 수험번호 --%>
                                <asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"  />
                                <%-- 성명 고교 정보 --%>
                                <asp:BoundField HeaderText="" DataField="korName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="graduYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="neisName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%-- 춮결성적 정보 --%>
                                <asp:BoundField HeaderText="" DataField="absence_1_A" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_1_B" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_1_C" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_1_D" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_2_A" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_2_B" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_2_C" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_2_D" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_3_A" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_3_B" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_3_C" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="absence_3_D" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%-- 교과성적 정보 --%>
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_1_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_1_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_1_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_1_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_2_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_2_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_2_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_2_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_3_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_3_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolRank_3_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="highSchoolPerson_3_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />

                                <%--10. 생년월일 --%>
                                <asp:BoundField HeaderText="생년월일" DataField="birth" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center"  />
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                        <div class="col-xs-12 m-b-n fixedbt">
                            <uc1:CommonPager ID="CommonPager1" runat="server" />
                        </div>
                    </cc2:ComDivScroll>
                </div>
                <!-- hidden 값 설정 -->
                <input id="hdnYear" type="hidden" runat="server" />
                <input id="hdnRecpNo" type="hidden" runat="server" />
            </div>
            <!-- 지원자 리스트 끝 -->

            <!-- 성명,고교 정보 표시 시작 -->
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="form-horizontal">
                        <div class="form-group form-group-sm">
                            <!-- 성명 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="txt성명">성명 :</asp:Label>
                            <div class="col-xs-1 form-inline">
                                <cc1:ExTextBox ID="txt성명" runat="server" Width="150px" CssClass="form-control" DataBindGroup="CUD" DataField="korName" Group="ExToolBar2_Save" Description="성명" ToolTip="성명" ReadOnly="true"></cc1:ExTextBox>
                            </div>
                            <!-- 고교정보 -->
                            <asp:Label runat="server" CssClass="col-xs-1 control-label" AssociatedControlID="txt고교졸업년">고교명 :</asp:Label>
                            <!-- 고교졸업년 -->
                            <div class="col-xs-1 form-inline">
                                <cc1:ExTextBox ID="txt고교졸업년" runat="server" Width="60px" CssClass="form-control" DataBindGroup="CUD" DataField="graduYear" Group="ExToolBar2_Save" Description="고교졸업년" ToolTip="고교졸업년" ReadOnly="true"></cc1:ExTextBox>&nbsp;&nbsp;년
                            </div>
                            <!-- 고교명 -->
                            <div class="col-xs-3 form-inline">
                                <cc1:ExTextBox ID="txt고교명" runat="server" Width="250px" CssClass="form-control" DataBindGroup="CUD" DataField="neisName" Group="ExToolBar2_Save" Description="txt고교명" ToolTip="txt고교명" ReadOnly="true"></cc1:ExTextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 성명,고교 정보 표시 끝 -->

            <!-- 출결성적 입력항목 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pencil pull-left">출결성적 입력항목</h3>
                    <div style="color: #31708f;">&nbsp;&nbsp;※3학년 1학기까지 학생부가 반영되는 전형인지 확인 후 입력 바랍니다.</div>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <table class="table table-striped table-bordered table-sm" summary="출결성적 입력항목 테이블 입니다.">
                        <caption>
                            <%--출결성적 입력항목--%>
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col">구분</th>
                                <th scope="col">결석</th>
                                <th scope="col">지각</th>
                                <th scope="col">조퇴</th>
                                <th scope="col">결과</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>1학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_1_A" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_1_A" Group="ExToolBar2_Save" Description="1학년결석" ToolTip="1학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_1_B" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_1_B" Group="ExToolBar2_Save" Description="1학년지각" ToolTip="1학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_1_C" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_1_C" Group="ExToolBar2_Save" Description="1학년조퇴" ToolTip="1학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_1_D" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_1_D" Group="ExToolBar2_Save" Description="1학년결과" ToolTip="1학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>2학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_2_A" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_2_A" Group="ExToolBar2_Save" Description="2학년결석" ToolTip="2학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_2_B" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_2_B" Group="ExToolBar2_Save" Description="2학년지각" ToolTip="2학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_2_C" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_2_C" Group="ExToolBar2_Save" Description="2학년조퇴" ToolTip="2학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_2_D" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_2_D" Group="ExToolBar2_Save" Description="2학년결과" ToolTip="2학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>3학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_3_A" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_3_A" Group="ExToolBar2_Save" Description="3학년결석" ToolTip="3학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_3_B" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_3_B" Group="ExToolBar2_Save" Description="3학년지각" ToolTip="3학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_3_C" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_3_C" Group="ExToolBar2_Save" Description="3학년조퇴" ToolTip="3학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtabsence_3_D" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="absence_3_D" Group="ExToolBar2_Save" Description="3학년결과" ToolTip="3학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 출결성적 입력항목 끝 -->

            <!-- 교과성적 입력항목 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pencil">교과성적 입력항목</h3>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <table class="table table-striped table-bordered table-sm" summary="교과성적 입력항목 테이블 입니다.">
                        <caption>
                            <%--교과성적 입력항목--%>
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col">구분</th>
                                <th scope="col">1학기 석차</th>
                                <th scope="col">1학기 인원</th>
                                <th scope="col">2학기 석차</th>
                                <th scope="col">2학기 인원</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>1학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_1_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_1_1" Group="ExToolBar2_Save" Description="1학년1학기석차" ToolTip="1학년1학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_1_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_1_1" Group="ExToolBar2_Save" Description="1학년1학기인원" ToolTip="1학년1학기인원" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_1_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_1_2" Group="ExToolBar2_Save" Description="1학년2학기석차" ToolTip="1학년2학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_1_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_1_2" Group="ExToolBar2_Save" Description="1학년2학기인원" ToolTip="1학년2학기인원" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>2학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_2_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_2_1" Group="ExToolBar2_Save" Description="2학년1학기석차" ToolTip="2학년1학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_2_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_2_1" Group="ExToolBar2_Save" Description="2학년1학기인원" ToolTip="2학년1학기인원" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_2_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_2_2" Group="ExToolBar2_Save" Description="2학년2학기석차" ToolTip="2학년2학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_2_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_2_2" Group="ExToolBar2_Save" Description="2학년2학기인원" ToolTip="2학년2학기인원" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>3학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_3_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_3_1" Group="ExToolBar2_Save" Description="3학년1학기석차" ToolTip="3학년1학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_3_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_3_1" Group="ExToolBar2_Save" Description="3학년1학기인원" ToolTip="3학년1학기인원" ValidationType="Numeric" CIsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolRank_3_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolRank_3_2" Group="ExToolBar2_Save" Description="3학년2학기석차" ToolTip="3학년2학기석차" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txthighSchoolPerson_3_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="highSchoolPerson_3_2" Group="ExToolBar2_Save" Description="3학년2학기인원" ToolTip="3학년2학기인원" ValidationType="Numeric" IsNegative="false" Cipher="2"></cc1:ExTextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 교과성적 입력항목 끝 -->

            <!-- 하단 버튼 영역 시작 -->
            <div class="panel panel-default">
                <div class="panel-footer">
                    <div class="text-right">
                        <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" />
                    </div>
                </div>
                <!-- 하단 버튼 영역 끝 -->
            </div>
        </div>
    </div>
</asp:Content>

<%--푸터--%>
<asp:Content runat="server" ID="Footer" ContentPlaceHolderID="FooterContent">
    <script type="text/javascript">
    </script>
</asp:Content>