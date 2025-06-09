<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreInput5.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreInput5" MasterPageFile="/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/CommonPager.ascx" TagName="CommonPager" TagPrefix="uc1" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>


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

        
        function OpenModal() {

            var year = ($('#<%= hdnYear.ClientID %>').val());
            var recpNo = ($('#<%= hdnRecpNo.ClientID %>').val());

            var modalId = '#<%= modalPlan.ModalId%>';
            var height = 950;
            var src = 'ApplScoreUpload.aspx?year=' + year + '&recpNo=' + recpNo;

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

    </script>

</asp:Content>

<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:Modal ID="modalPlan" runat="server" ModalId="modalPlan" ModalTitle="학생부 엑셀 업로드" ShowCloseButton="true">
        <ModalBodyTemplate>
            <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
        </ModalBodyTemplate>
    </uc1:Modal>
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
                    <!-- 지원시기 -->
                    <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplSeason">지원시기 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplSeason" runat="server" CodeType="_공통" P1="SA02" Width="100px" BindMode="Select" Required="true" Group="ExToolBar1_Search;ExToolBar2_Save" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
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
                                <asp:BoundField HeaderText="고교명" DataField="neisName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--3 전형구분--%>
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--4 1지망 학과(계열)--%>
                                <asp:BoundField HeaderText="1지망 학과(계열)" DataField="majorCode1NM" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--5 2지망 학과(계열)--%>
                                <asp:BoundField HeaderText="2지망 학과(계열)" DataField="majorCode2NM" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--6 상태--%>
                                <asp:BoundField HeaderText="상태" DataField="passName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--7 최종합격--%>
                                <asp:BoundField HeaderText="최종합격" DataField="majorFinalName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%--8 지원연도 --%>
                                <asp:BoundField HeaderText="" DataField="year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--9 수험번호 --%>
                                <asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <%-- 성명 고교 정보 --%>
                                <asp:BoundField HeaderText="" DataField="korName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="graduYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="neisName" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%-- 춮결성적 정보 --%>
                                <asp:BoundField HeaderText="" DataField="Absence_Disease_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Accident_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Etc_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Disease_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Accident_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Etc_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Disease_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Accident_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Etc_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Disease_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Accident_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Etc_1" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />

                                <asp:BoundField HeaderText="" DataField="Absence_Disease_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Accident_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Etc_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Disease_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Accident_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Etc_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Disease_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Accident_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Etc_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Disease_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Accident_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Etc_2" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />

                                <asp:BoundField HeaderText="" DataField="Absence_Disease_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Accident_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Absence_Etc_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Disease_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Accident_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Lateness_Etc_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Disease_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Accident_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="EarlyLeaving_Etc_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Disease_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Accident_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="Result_Etc_3" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />

                                <%--10. 생년월일 --%>
                                <asp:BoundField HeaderText="생년월일" DataField="birth" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />

                                <%--11. 생년월일 --%>
                                <asp:BoundField HeaderText="성적입력여부" DataField="Score" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />

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

                <!-- 상단 버튼 영역 시작 -->
                <div class="panel panel-default">
                    <div class="panel-footer">
                        <div class="row">
                            <div class="text-right">
                                <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 상단 버튼 영역 끝 -->

                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <table class="table table-striped table-bordered table-sm" summary="출결성적 입력항목 테이블 입니다.">
                        <caption>
                            <%--출결성적 입력항목--%>
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col">구분</th>
                                <th scope="col">결석(질병)</th>
                                <th scope="col">결석(무단)</th>
                                <th scope="col">결석(기타)</th>
                                <th scope="col">지각(질병)</th>
                                <th scope="col">지각(무단)</th>
                                <th scope="col">지각(기타)</th>
                                <th scope="col">조퇴(질병)</th>
                                <th scope="col">조퇴(무단)</th>
                                <th scope="col">조퇴(기타)</th>
                                <th scope="col">결과(질병)</th>
                                <th scope="col">결과(무단)</th>
                                <th scope="col">결과(기타)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>1학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Disease_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Disease_1" Group="ExToolBar2_Save" Description="1학년결석" ToolTip="1학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Accident_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Accident_1" Group="ExToolBar2_Save" Description="1학년결석" ToolTip="1학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Etc_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Etc_1" Group="ExToolBar2_Save" Description="1학년결석" ToolTip="1학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Disease_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Disease_1" Group="ExToolBar2_Save" Description="1학년지각" ToolTip="1학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Accident_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Accident_1" Group="ExToolBar2_Save" Description="1학년지각" ToolTip="1학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Etc_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Etc_1" Group="ExToolBar2_Save" Description="1학년지각" ToolTip="1학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Disease_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Disease_1" Group="ExToolBar2_Save" Description="1학년조퇴" ToolTip="1학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Accident_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Accident_1" Group="ExToolBar2_Save" Description="1학년조퇴" ToolTip="1학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Etc_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Etc_1" Group="ExToolBar2_Save" Description="1학년조퇴" ToolTip="1학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Disease_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Disease_1" Group="ExToolBar2_Save" Description="1학년결과" ToolTip="1학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Accident_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Accident_1" Group="ExToolBar2_Save" Description="1학년결과" ToolTip="1학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Etc_1" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Etc_1" Group="ExToolBar2_Save" Description="1학년결과" ToolTip="1학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>2학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Disease_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Disease_2" Group="ExToolBar2_Save" Description="2학년결석" ToolTip="2학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Accident_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Accident_2" Group="ExToolBar2_Save" Description="2학년결석" ToolTip="2학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Etc_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Etc_2" Group="ExToolBar2_Save" Description="2학년결석" ToolTip="2학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Disease_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Disease_2" Group="ExToolBar2_Save" Description="2학년지각" ToolTip="2학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Accident_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Accident_2" Group="ExToolBar2_Save" Description="2학년지각" ToolTip="2학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Etc_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Etc_2" Group="ExToolBar2_Save" Description="2학년지각" ToolTip="2학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Disease_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Disease_2" Group="ExToolBar2_Save" Description="2학년조퇴" ToolTip="2학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Accident_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Accident_2" Group="ExToolBar2_Save" Description="2학년조퇴" ToolTip="2학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Etc_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Etc_2" Group="ExToolBar2_Save" Description="2학년조퇴" ToolTip="2학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Disease_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Disease_2" Group="ExToolBar2_Save" Description="2학년결과" ToolTip="2학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Accident_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Accident_2" Group="ExToolBar2_Save" Description="2학년결과" ToolTip="2학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Etc_2" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Etc_2" Group="ExToolBar2_Save" Description="2학년결과" ToolTip="2학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                            <tr>
                                <th>3학년</th>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Disease_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Disease_3" Group="ExToolBar2_Save" Description="3학년결석" ToolTip="3학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Accident_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Accident_3" Group="ExToolBar2_Save" Description="3학년결석" ToolTip="3학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtAbsence_Etc_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Absence_Etc_3" Group="ExToolBar2_Save" Description="3학년결석" ToolTip="3학년결석" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Disease_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Disease_3" Group="ExToolBar2_Save" Description="3학년지각" ToolTip="3학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Accident_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Accident_3" Group="ExToolBar2_Save" Description="3학년지각" ToolTip="3학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtLateness_Etc_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Lateness_Etc_3" Group="ExToolBar2_Save" Description="3학년지각" ToolTip="3학년지각" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Disease_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Disease_3" Group="ExToolBar2_Save" Description="3학년조퇴" ToolTip="3학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Accident_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Accident_3" Group="ExToolBar2_Save" Description="3학년조퇴" ToolTip="3학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtEarlyLeaving_Etc_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="EarlyLeaving_Etc_3" Group="ExToolBar2_Save" Description="3학년조퇴" ToolTip="3학년조퇴" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Disease_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Disease_3" Group="ExToolBar2_Save" Description="3학년결과" ToolTip="3학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Accident_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Accident_3" Group="ExToolBar2_Save" Description="3학년결과" ToolTip="3학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                                <td>
                                    <cc1:ExTextBox ID="txtResult_Etc_3" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="Result_Etc_3" Group="ExToolBar2_Save" Description="3학년결과" ToolTip="3학년결과" ValidationType="Numeric" Cipher="0" IsNegative="false"></cc1:ExTextBox></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 출결성적 입력항목 끝 -->



            <!-- 교과성적 입력항목 끝 -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title pull-left pencil">교과성적 입력항목</h3>
                    <%--<div class="ibox-tools">
                        <a title="패널 숨기기" id="cLink4" class="collapse-link" style="margin-right: 20px;"><i class="glyphicon glyphicon-chevron-up"></i><span class="skip">패널 숨기기</span></a>--%>
                    <cc1:ExDataCounter ID="ExDataCounter3" runat="server"></cc1:ExDataCounter>
                    <input id="hidcLink4State" type="hidden" runat="server" />
                    <%--</div>--%>
                </div>
                <div class="panel-body  p-n">
                    <div class="table-filter m-n">
                        <div class="form-inline" style="display:none">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtScoreYear">연도 :</asp:Label>
                                <cc1:ExTextBox ID="txtScoreYear" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="Year" Width="60px" MaxLength="4" Description="연도" ToolTip="연도" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="자동입력" Required="False" ReadOnly="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtGrade">학년 :</asp:Label>
                                <cc1:ExTextBox ID="txtGrade" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="Grade" Width="60px" MaxLength="1" Description="학년" ToolTip="학년" Group="ExToolBar6_Save" ValidationType="Numeric" IsNegative="false" Text="0" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtTerm">학기 :</asp:Label>
                                <cc1:ExTextBox ID="txtTerm" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="Term" Width="60px" MaxLength="1" Description="학기" ToolTip="학기" Group="ExToolBar6_Save" ValidationType="Numeric" IsNegative="false" Text="0" Required="false"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtOrganizationCode">편제코드 :</asp:Label>
                                <cc1:ExTextBox ID="txtOrganizationCode" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="OrganizationCode" Width="60px" Description="편제코드" ToolTip="편제코드" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="미입력" Required="false" ReadOnly="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtOrganizationName">편제명 :</asp:Label>
                                <cc1:ExTextBox ID="txtOrganizationName" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="OrganizationName" Width="100px" Description="편제명" ToolTip="편제명" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="미입력" Required="false" ReadOnly="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtCourceCode">교과코드 :</asp:Label>
                                <cc1:ExTextBox ID="txtCourceCode" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="CourceCode" Width="60px" Description="교과코드" ToolTip="교과코드" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="미입력" Required="false" ReadOnly="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtCourceName">교과명 :</asp:Label>
                                <cc1:ExTextBox ID="txtCourceName" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="CourceName" Width="60px" Description="교과명" ToolTip="교과명" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="" Required="True" ReadOnly="False"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSubjectCode">과목코드 :</asp:Label>
                                <cc1:ExTextBox ID="txtSubjectCode" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="SubjectCode" Width="60px" Description="과목코드" ToolTip="과목코드" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Text="" Required="True" ReadOnly="False"></cc1:ExTextBox>
                            </div>
                        </div>
                        <div class="form-inline" style="display:none">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSubjectName">과목명 :</asp:Label>
                                <cc1:ExTextBox ID="txtSubjectName" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="SubjectName" Width="100px" Description="과목명" ToolTip="과목명" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtUnit">단위 :</asp:Label>
                                <cc1:ExTextBox ID="txtUnit" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="Unit" Width="60px" MaxLength="2" Description="단위" ToolTip="단위" Group="ExToolBar6_Save" ValidationType="Numeric" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtOriginalScore">원점수 :</asp:Label>
                                <cc1:ExTextBox ID="txtOriginalScore" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="OriginalScore" Width="60px" Description="원점수" ToolTip="원점수" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtAvgScore">평균 :</asp:Label>
                                <cc1:ExTextBox ID="txtAvgScore" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="AvgScore" Width="60px" Description="평균" ToolTip="평균" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtStandardDeviation">표준편차 :</asp:Label>
                                <cc1:ExTextBox ID="txtStandardDeviation" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="StandardDeviation" Width="60px" Description="표준편차" ToolTip="표준편차" Group="ExToolBar6_Save" ValidationType="None" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtRankingGrade">등급 :</asp:Label>
                                <cc1:ExTextBox ID="txtRankingGrade" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="RankingGrade" Width="60px" MaxLength="1" Description="등급" ToolTip="등급" Group="ExToolBar6_Save" ValidationType="Numeric" IsNegative="false" Required="True"></cc1:ExTextBox>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtRankingGrade">순번 :</asp:Label>
                                <cc1:ExTextBox ID="txtSeqNumber" runat="server" CssClass="form-control text-center" DataBindGroup="CUDscore" DataField="RankingGrade" Width="60px" MaxLength="1" Description="순번" ToolTip="순번" Group="ExToolBar6_Save" ValidationType="Numeric" IsNegative="false" Required="False" ReadOnly="true"></cc1:ExTextBox>
                            </div>
                        </div>
                    </div>

                    <!-- 하단 버튼 영역 시작 -->
                    <div class="panel panel-default">
                        <div class="panel-footer">
                                <div class="row">
                                    <!--
                                    <div class="text-right">
                                        <cc1:ExToolBar ID="ExToolBar6" runat="server" SaveVisible="true" DeleteVisible="True" SaveText="추가" Visible="False" />
                                    </div>
                                    -->
                                    <div class="text-right">
                                            <asp:Button ID="btnUpload" runat="server" CssClass="btn btn-sm btn-default" Text="업로드" />
                                     </div>
                                </div>
                        </div>
                        
                        <!-- 하단 버튼 영역 끝 -->

                        <cc2:ComDivScroll ID="ComDivScroll3" runat="server" Style="height: 228px">
                            <cc1:ExGridView ID="grdList3" runat="server"
                                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                                SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="교과성적 리스트" TableCaption="교과성적 등록" OnSelectedIndexChanged="grdList3_SelectedIndexChanged">
                                <Columns>
                                    <%--1--%><asp:BoundField HeaderText="연도" DataField="year" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--2--%><asp:BoundField HeaderText="학년" DataField="Grade" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--3--%><asp:BoundField HeaderText="학기" DataField="Term" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--4--%><asp:BoundField HeaderText="편제코드" DataField="OrganizationCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--5--%><asp:BoundField HeaderText="편제명" DataField="OrganizationName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--6--%><asp:BoundField HeaderText="교과코드" DataField="CourceCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--7--%><asp:BoundField HeaderText="교과명" DataField="CourceName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--8--%><asp:BoundField HeaderText="과목코드" DataField="SubjectCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--9--%><asp:BoundField HeaderText="과목명" DataField="SubjectName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--10--%><asp:BoundField HeaderText="단위" DataField="Unit" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--11--%><asp:BoundField HeaderText="원점수" DataField="OriginalScore" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--12--%><asp:BoundField HeaderText="평균" DataField="AvgScore" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--13--%><asp:BoundField HeaderText="표준편차" DataField="StandardDeviation" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--14--%><asp:BoundField HeaderText="등급" DataField="RankingGrade" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--15--%><asp:BoundField DataField="SeqNumber" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--16--%><asp:TemplateField HeaderText="선택" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" Visible="False">
                                        <HeaderStyle Width="5%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                        </cc2:ComDivScroll>
                    </div>
                </div>
                <!-- 교과성적 입력항목 끝 -->



            </div>
        </div>
        </div>

</asp:Content>

<%--푸터--%>
<asp:Content runat="server" ID="Footer" ContentPlaceHolderID="FooterContent">
    <script type="text/javascript">
    
    </script>
</asp:Content>
