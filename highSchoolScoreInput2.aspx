<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreInput2.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreInput2" MasterPageFile="/Page.Master" %>

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
                                <asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--4 1지망 학과(계열)--%>
                                <asp:BoundField HeaderText="1지망 학과(계열)" DataField="majorCode1NM" HeaderStyle-Width="17%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--5 2지망 학과(계열)--%>
                                <asp:BoundField HeaderText="2지망 학과(계열)" DataField="majorCode2NM" HeaderStyle-Width="17%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--6 상태--%>
                                <asp:BoundField HeaderText="상태" DataField="passName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--7 최종합격--%>
                                <asp:BoundField HeaderText="최종합격" DataField="majorFinalName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                <%--8 지원연도 --%>
                                <asp:BoundField HeaderText="" DataField="year" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <%--9 수험번호 --%>
                                <asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
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
                                <asp:BoundField HeaderText="" DataField="11_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_01_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_01_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_01_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_02_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_02_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_02_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_03_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_03_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_03_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_04_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_04_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_04_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_05_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_05_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_05_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_06_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_06_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_06_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_07_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_07_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_07_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_08_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_08_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_08_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_09_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_09_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_09_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_10_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_10_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_10_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_11_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_11_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_11_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_12_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_12_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_12_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_13_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_13_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_13_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_14_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_14_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_14_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_15_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_15_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_15_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_16_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_16_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_16_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_17_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_17_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_17_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_18_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_18_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_18_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_19_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_19_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_19_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="11_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="12_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="21_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="22_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="31_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_20_ISU" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_20_SEK" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="" DataField="32_20_JAE" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />

                                <%--10. 생년월일 --%>
                                <asp:BoundField HeaderText="생년월일" DataField="birth" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
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
                <!-- 교과성적 테이블 -->
                <div class="panel-body p-n">
                    <div id="MainContent_ComDivScroll1" class="ComDivScroll" style="overflow-y: hidden">
                        <div class="form-group-sm">
                            <table class="table table-bordered t_style01 m-n" summary="내신성적 산출표 입니다.">
                                <!-- t_style01 클래스 추가 -->
                                <caption>
                                    내신성적 산출표
                                </caption>
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col" colspan="3">1학년(1학기)</th>
                                        <th scope="col" colspan="3">1학년(2학기)</th>
                                        <th scope="col" colspan="3" class="bg01">2학년(1학기)</th>
                                        <!-- 학년별 bg01 ,bg02 클래스 추가 -->
                                        <th scope="col" colspan="3" class="bg01">2학년(2학기)</th>
                                        <th scope="col" colspan="3" class="bg02">3학년(1학기)</th>
                                        <th scope="col" colspan="3" class="bg02">3학년(2학기)</th>
                                    </tr>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">단위</th>
                                        <th scope="col">석차</th>
                                        <th scope="col">인원</th>
                                        <th scope="col">단위</th>
                                        <th scope="col">석차</th>
                                        <th scope="col">인원</th>
                                        <th scope="col" class="bg01">단위</th>
                                        <th scope="col" class="bg01">석차</th>
                                        <th scope="col" class="bg01">인원</th>
                                        <th scope="col" class="bg01">단위</th>
                                        <th scope="col" class="bg01">석차</th>
                                        <th scope="col" class="bg01">인원</th>
                                        <th scope="col" class="bg02">단위</th>
                                        <th scope="col" class="bg02">석차</th>
                                        <th scope="col" class="bg02">인원</th>
                                        <th scope="col" class="bg02">단위</th>
                                        <th scope="col" class="bg02">석차</th>
                                        <th scope="col" class="bg02">인원</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>1</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_01_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_1" ToolTip="1학년(1학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <!-- input박스 form-control 추가 -->
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_01_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_1" ToolTip="1학년(1학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_01_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_1" ToolTip="1학년(1학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_01_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_1" ToolTip="1학년(2학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_01_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_1" ToolTip="1학년(2학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_01_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_1" ToolTip="1학년(2학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_01_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_1" ToolTip="2학년(1학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_01_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_1" ToolTip="2학년(1학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_01_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_1" ToolTip="2학년(1학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_01_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_1" ToolTip="2학년(2학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_01_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_1" ToolTip="2학년(2학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_01_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_1" ToolTip="2학년(2학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_01_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_1" ToolTip="3학년(1학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_01_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_1" ToolTip="3학년(1학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_01_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_1" ToolTip="3학년(1학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_01_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_1" ToolTip="3학년(2학기)단위_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_01_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_1" ToolTip="3학년(2학기)석차_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_01_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_1" ToolTip="3학년(2학기)인원_1" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>2</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_02_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_2" ToolTip="1학년(1학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_02_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_2" ToolTip="1학년(1학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_02_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_2" ToolTip="1학년(1학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_02_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_2" ToolTip="1학년(2학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_02_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_2" ToolTip="1학년(2학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_02_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_2" ToolTip="1학년(2학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_02_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_2" ToolTip="2학년(1학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_02_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_2" ToolTip="2학년(1학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_02_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_2" ToolTip="2학년(1학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_02_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_2" ToolTip="2학년(2학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_02_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_2" ToolTip="2학년(2학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_02_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_2" ToolTip="2학년(2학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_02_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_2" ToolTip="3학년(1학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_02_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차ㅍ" ToolTip="3학년(1학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_02_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_2" ToolTip="3학년(1학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_02_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_2" ToolTip="3학년(2학기)단위_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_02_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_2" ToolTip="3학년(2학기)석차_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_02_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_2" ToolTip="3학년(2학기)인원_2" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>3</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_03_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_3" ToolTip="1학년(1학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_03_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_3" ToolTip="1학년(1학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_03_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_3" ToolTip="1학년(1학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_03_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_3" ToolTip="1학년(2학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_03_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_3" ToolTip="1학년(2학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_03_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_3" ToolTip="1학년(2학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_03_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_3" ToolTip="2학년(1학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_03_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_3" ToolTip="2학년(1학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_03_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_3" ToolTip="2학년(1학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_03_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_3" ToolTip="2학년(2학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_03_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_3" ToolTip="2학년(2학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_03_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_3" ToolTip="2학년(2학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_03_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_3" ToolTip="3학년(1학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_03_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_3" ToolTip="3학년(1학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_03_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_3" ToolTip="3학년(1학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_03_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_3" ToolTip="3학년(2학기)단위_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_03_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_3" ToolTip="3학년(2학기)석차_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_03_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_3" ToolTip="3학년(2학기)인원_3" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>4</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_04_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_4" ToolTip="1학년(1학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_04_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_4" ToolTip="1학년(1학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_04_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_4" ToolTip="1학년(1학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_04_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_4" ToolTip="1학년(2학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_04_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_4" ToolTip="1학년(2학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_04_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_4" ToolTip="1학년(2학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_04_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_4" ToolTip="2학년(1학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_04_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_4" ToolTip="2학년(1학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_04_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_4" ToolTip="2학년(1학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_04_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_4" ToolTip="2학년(2학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_04_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_4" ToolTip="2학년(2학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_04_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_4" ToolTip="2학년(2학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_04_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_4" ToolTip="3학년(1학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_04_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_4" ToolTip="3학년(1학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_04_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_4" ToolTip="3학년(1학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_04_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_4" ToolTip="3학년(2학기)단위_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_04_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_4" ToolTip="3학년(2학기)석차_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_04_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_4" ToolTip="3학년(2학기)인원_4" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>5</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_05_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_5" ToolTip="1학년(1학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_05_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_5" ToolTip="1학년(1학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_05_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_5" ToolTip="1학년(1학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_05_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_5" ToolTip="1학년(2학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_05_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_5" ToolTip="1학년(2학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_05_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_5" ToolTip="1학년(2학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_05_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_5" ToolTip="2학년(1학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_05_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_5" ToolTip="2학년(1학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_05_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_5" ToolTip="2학년(1학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_05_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_5" ToolTip="2학년(2학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_05_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_5" ToolTip="2학년(2학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_05_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_5" ToolTip="2학년(2학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_05_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_5" ToolTip="3학년(1학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_05_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_5" ToolTip="3학년(1학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_05_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_5" ToolTip="3학년(1학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_05_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_5" ToolTip="3학년(2학기)단위_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_05_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_5" ToolTip="3학년(2학기)석차_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_05_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_5" ToolTip="3학년(2학기)인원_5" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>6</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_06_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_6" ToolTip="1학년(1학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_06_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_6" ToolTip="1학년(1학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_06_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_6" ToolTip="1학년(1학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_06_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_6" ToolTip="1학년(2학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_06_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_6" ToolTip="1학년(2학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_06_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_6" ToolTip="1학년(2학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_06_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_6" ToolTip="2학년(1학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_06_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_6" ToolTip="2학년(1학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_06_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_6" ToolTip="2학년(1학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_06_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_6" ToolTip="2학년(2학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_06_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_6" ToolTip="2학년(2학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_06_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_6" ToolTip="2학년(2학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_06_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_6" ToolTip="3학년(1학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_06_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_6" ToolTip="3학년(1학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_06_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_6" ToolTip="3학년(1학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_06_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_6" ToolTip="3학년(2학기)단위_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_06_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_6" ToolTip="3학년(2학기)석차_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_06_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_6" ToolTip="3학년(2학기)인원_6" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>7</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_07_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_7" ToolTip="1학년(1학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_07_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_7" ToolTip="1학년(1학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_07_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_7" ToolTip="1학년(1학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_07_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_7" ToolTip="1학년(2학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_07_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_7" ToolTip="1학년(2학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_07_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_7" ToolTip="1학년(2학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_07_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_7" ToolTip="2학년(1학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_07_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_7" ToolTip="2학년(1학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_07_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_7" ToolTip="2학년(1학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_07_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_7" ToolTip="2학년(2학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_07_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_7" ToolTip="2학년(2학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_07_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_7" ToolTip="2학년(2학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_07_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_7" ToolTip="3학년(1학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_07_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_7" ToolTip="3학년(1학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_07_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_7" ToolTip="3학년(1학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_07_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_7" ToolTip="3학년(2학기)단위_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_07_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_7" ToolTip="3학년(2학기)석차_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_07_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_7" ToolTip="3학년(2학기)인원_7" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>8</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_08_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_8" ToolTip="1학년(1학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_08_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_8" ToolTip="1학년(1학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_08_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_8" ToolTip="1학년(1학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_08_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_8" ToolTip="1학년(2학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_08_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_8" ToolTip="1학년(2학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_08_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_8" ToolTip="1학년(2학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_08_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_8" ToolTip="2학년(1학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_08_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_8" ToolTip="2학년(1학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_08_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_8" ToolTip="2학년(1학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_08_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_8" ToolTip="2학년(2학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_08_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_8" ToolTip="2학년(2학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_08_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_8" ToolTip="2학년(2학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_08_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_8" ToolTip="3학년(1학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_08_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_8" ToolTip="3학년(1학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_08_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_8" ToolTip="3학년(1학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_08_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_8" ToolTip="3학년(2학기)단위_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_08_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_8" ToolTip="3학년(2학기)석차_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_08_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_8" ToolTip="3학년(2학기)인원_8" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>9</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_09_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_9" ToolTip="1학년(1학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_09_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_9" ToolTip="1학년(1학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_09_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_9" ToolTip="1학년(1학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_09_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_9" ToolTip="1학년(2학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_09_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_9" ToolTip="1학년(2학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_09_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_9" ToolTip="1학년(2학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_09_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_9" ToolTip="2학년(1학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_09_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_9" ToolTip="2학년(1학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_09_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_9" ToolTip="2학년(1학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_09_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_9" ToolTip="2학년(2학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_09_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_9" ToolTip="2학년(2학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_09_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_9" ToolTip="2학년(2학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_09_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_9" ToolTip="3학년(1학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_09_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_9" ToolTip="3학년(1학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_09_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_9" ToolTip="3학년(1학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_09_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_9" ToolTip="3학년(2학기)단위_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_09_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_9" ToolTip="3학년(2학기)석차_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_09_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_9" ToolTip="3학년(2학기)인원_9" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>10</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_10_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_10" ToolTip="1학년(1학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_10_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_10" ToolTip="1학년(1학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_10_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_10" ToolTip="1학년(1학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_10_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_10" ToolTip="1학년(2학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_10_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_10" ToolTip="1학년(2학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_10_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_10" ToolTip="1학년(2학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_10_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_10" ToolTip="2학년(1학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_10_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_10" ToolTip="2학년(1학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_10_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_10" ToolTip="2학년(1학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_10_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_10" ToolTip="2학년(2학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_10_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_10" ToolTip="2학년(2학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_10_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_10" ToolTip="2학년(2학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_10_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_10" ToolTip="3학년(1학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_10_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_10" ToolTip="3학년(1학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_10_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_10" ToolTip="3학년(1학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_10_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_10" ToolTip="3학년(2학기)단위_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_10_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_10" ToolTip="3학년(2학기)석차_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_10_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_10" ToolTip="3학년(2학기)인원_10" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>11</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_11_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_11" ToolTip="1학년(1학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_11_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_11" ToolTip="1학년(1학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_11_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_11" ToolTip="1학년(1학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_11_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_11" ToolTip="1학년(2학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_11_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_11" ToolTip="1학년(2학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_11_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_11" ToolTip="1학년(2학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_11_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_11" ToolTip="2학년(1학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_11_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_11" ToolTip="2학년(1학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_11_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_11" ToolTip="2학년(1학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_11_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_11" ToolTip="2학년(2학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_11_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_11" ToolTip="2학년(2학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_11_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_11" ToolTip="2학년(2학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_11_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_11" ToolTip="3학년(1학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_11_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_11" ToolTip="3학년(1학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_11_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_11" ToolTip="3학년(1학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_11_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_11" ToolTip="3학년(2학기)단위_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_11_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_11" ToolTip="3학년(2학기)석차_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_11_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_11" ToolTip="3학년(2학기)인원_11" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>12</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_12_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_12" ToolTip="1학년(1학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_12_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_12" ToolTip="1학년(1학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_12_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_12" ToolTip="1학년(1학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_12_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_12" ToolTip="1학년(2학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_12_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_12" ToolTip="1학년(2학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_12_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_12" ToolTip="1학년(2학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_12_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_12" ToolTip="2학년(1학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_12_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_12" ToolTip="2학년(1학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_12_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_12" ToolTip="2학년(1학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_12_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_12" ToolTip="2학년(2학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_12_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_12" ToolTip="2학년(2학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_12_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_12" ToolTip="2학년(2학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_12_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_12" ToolTip="3학년(1학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_12_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_12" ToolTip="3학년(1학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_12_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_12" ToolTip="3학년(1학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_12_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_12" ToolTip="3학년(2학기)단위_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_12_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_12" ToolTip="3학년(2학기)석차_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_12_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_12" ToolTip="3학년(2학기)인원_12" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>13</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_13_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_13" ToolTip="1학년(1학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_13_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_13" ToolTip="1학년(1학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_13_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_13" ToolTip="1학년(1학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_13_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_13" ToolTip="1학년(2학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_13_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_13" ToolTip="1학년(2학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_13_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_13" ToolTip="1학년(2학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_13_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_13" ToolTip="2학년(1학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_13_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_13" ToolTip="2학년(1학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_13_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_13" ToolTip="2학년(1학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_13_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_13" ToolTip="2학년(2학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_13_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_13" ToolTip="2학년(2학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_13_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_13" ToolTip="2학년(2학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_13_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_13" ToolTip="3학년(1학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_13_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_13" ToolTip="3학년(1학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_13_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_13" ToolTip="3학년(1학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_13_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_13" ToolTip="3학년(2학기)단위_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_13_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_13" ToolTip="3학년(2학기)석차_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_13_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_13" ToolTip="3학년(2학기)인원_13" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>14</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_14_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_14" ToolTip="1학년(1학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_14_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_14" ToolTip="1학년(1학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_14_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_14" ToolTip="1학년(1학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_14_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_14" ToolTip="1학년(2학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_14_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_14" ToolTip="1학년(2학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_14_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_14" ToolTip="1학년(2학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_14_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_14" ToolTip="2학년(1학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_14_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_14" ToolTip="2학년(1학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_14_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_14" ToolTip="2학년(1학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_14_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_14" ToolTip="2학년(2학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_14_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_14" ToolTip="2학년(2학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_14_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_14" ToolTip="2학년(2학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_14_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_14" ToolTip="3학년(1학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_14_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_14" ToolTip="3학년(1학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_14_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_14" ToolTip="3학년(1학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_14_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_14" ToolTip="3학년(2학기)단위_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_14_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_14" ToolTip="3학년(2학기)석차_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_14_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_14" ToolTip="3학년(2학기)인원_14" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>15</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_15_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_15" ToolTip="1학년(1학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_15_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_15" ToolTip="1학년(1학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_15_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_15" ToolTip="1학년(1학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_15_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_15" ToolTip="1학년(2학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_15_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_15" ToolTip="1학년(2학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_15_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_15" ToolTip="1학년(2학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_15_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_15" ToolTip="2학년(1학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_15_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_15" ToolTip="2학년(1학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_15_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_15" ToolTip="2학년(1학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_15_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_15" ToolTip="2학년(2학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_15_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_15" ToolTip="2학년(2학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_15_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_15" ToolTip="2학년(2학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_15_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_15" ToolTip="3학년(1학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_15_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_15" ToolTip="3학년(1학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_15_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_15" ToolTip="3학년(1학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_15_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_15" ToolTip="3학년(2학기)단위_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_15_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_15" ToolTip="3학년(2학기)석차_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_15_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_15" ToolTip="3학년(2학기)인원_15" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>16</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_16_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_16" ToolTip="1학년(1학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_16_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_16" ToolTip="1학년(1학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_16_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_16" ToolTip="1학년(1학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_16_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_16" ToolTip="1학년(2학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_16_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_16" ToolTip="1학년(2학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_16_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_16" ToolTip="1학년(2학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_16_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_16" ToolTip="2학년(1학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_16_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_16" ToolTip="2학년(1학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_16_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_16" ToolTip="2학년(1학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_16_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_16" ToolTip="2학년(2학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_16_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_16" ToolTip="2학년(2학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_16_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_16" ToolTip="2학년(2학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_16_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_16" ToolTip="3학년(1학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_16_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_16" ToolTip="3학년(1학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_16_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_16" ToolTip="3학년(1학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_16_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_16" ToolTip="3학년(2학기)단위_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_16_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_16" ToolTip="3학년(2학기)석차_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_16_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_16" ToolTip="3학년(2학기)인원_16" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>17</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_17_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_17" ToolTip="1학년(1학기)단위_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_17_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_17" ToolTip="1학년(1학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_17_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_17" ToolTip="1학년(1학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_17_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_17" ToolTip="1학년(2학기)단위_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_17_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_17" ToolTip="1학년(2학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_17_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_17" ToolTip="1학년(2학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_17_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_17" ToolTip="2학년(1학기)단위_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_17_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_17" ToolTip="2학년(1학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_17_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_17" ToolTip="2학년(1학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_17_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_17" ToolTip="2학년(2학기)단위_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_17_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_17" ToolTip="2학년(2학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_17_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_17" ToolTip="2학년(2학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_17_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_17" ToolTip="3학년(1학기)원점_17수" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_17_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_17" ToolTip="3학년(1학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_17_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_17" ToolTip="3학년(1학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_17_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_17" ToolTip="3학년(2학기)단위_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_17_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_17" ToolTip="3학년(2학기)석차_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_17_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_17" ToolTip="3학년(2학기)인원_17" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>18</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_18_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_18" ToolTip="1학년(1학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_18_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_18" ToolTip="1학년(1학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_18_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_18" ToolTip="1학년(1학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_18_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_18" ToolTip="1학년(2학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_18_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_18" ToolTip="1학년(2학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_18_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_18" ToolTip="1학년(2학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_18_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_18" ToolTip="2학년(1학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_18_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_18" ToolTip="2학년(1학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_18_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_18" ToolTip="2학년(1학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_18_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_18" ToolTip="2학년(2학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_18_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_18" ToolTip="2학년(2학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_18_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_18" ToolTip="2학년(2학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_18_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_18" ToolTip="3학년(1학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_18_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_18" ToolTip="3학년(1학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_18_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_18" ToolTip="3학년(1학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_18_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_18" ToolTip="3학년(2학기)단위_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_18_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_18" ToolTip="3학년(2학기)석차_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_18_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_18" ToolTip="3학년(2학기)인원_18" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>19</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_19_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_19" ToolTip="1학년(1학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_19_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_19" ToolTip="1학년(1학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_19_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_19" ToolTip="1학년(1학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_19_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_19" ToolTip="1학년(2학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_19_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_19" ToolTip="1학년(2학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_19_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_19" ToolTip="1학년(2학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_19_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_19" ToolTip="2학년(1학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_19_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_19" ToolTip="2학년(1학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_19_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_19" ToolTip="2학년(1학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_19_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_19" ToolTip="2학년(2학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_19_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_19" ToolTip="2학년(2학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_19_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_19" ToolTip="2학년(2학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_19_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_19" ToolTip="3학년(1학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_19_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_19" ToolTip="3학년(1학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_19_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_19" ToolTip="3학년(1학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_19_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_19" ToolTip="3학년(2학기)단위_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_19_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_19" ToolTip="3학년(2학기)석차_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_19_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_19" ToolTip="3학년(2학기)인원_19" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                    <tr>
                                        <th>20</th>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_20_ISU" Group="ExToolBar2_Save" Description="1학년(1학기)단위_20" ToolTip="1학년(1학기)단위_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_20_SEK" Group="ExToolBar2_Save" Description="1학년(1학기)석차_20" ToolTip="1학년(1학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_11_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="11_20_JAE" Group="ExToolBar2_Save" Description="1학년(1학기)인원_20" ToolTip="1학년(1학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_20_ISU" Group="ExToolBar2_Save" Description="1학년(2학기)단위_20" ToolTip="1학년(2학기)원점_20수" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_20_SEK" Group="ExToolBar2_Save" Description="1학년(2학기)석차_20" ToolTip="1학년(2학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td>
                                            <cc1:ExTextBox ID="txt_12_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="12_20_JAE" Group="ExToolBar2_Save" Description="1학년(2학기)인원_20" ToolTip="1학년(2학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_20_ISU" Group="ExToolBar2_Save" Description="2학년(1학기)단위_20" ToolTip="2학년(1학기)단위_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_20_SEK" Group="ExToolBar2_Save" Description="2학년(1학기)석차_20" ToolTip="2학년(1학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_21_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="21_20_JAE" Group="ExToolBar2_Save" Description="2학년(1학기)인원_20" ToolTip="2학년(1학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_20_ISU" Group="ExToolBar2_Save" Description="2학년(2학기)단위_20" ToolTip="2학년(2학기)단위_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_20_SEK" Group="ExToolBar2_Save" Description="2학년(2학기)석차_20" ToolTip="2학년(2학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg01">
                                            <cc1:ExTextBox ID="txt_22_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="22_20_JAE" Group="ExToolBar2_Save" Description="2학년(2학기)인원_20" ToolTip="2학년(2학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_20_ISU" Group="ExToolBar2_Save" Description="3학년(1학기)단위_20" ToolTip="3학년(1학기)단위_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_20_SEK" Group="ExToolBar2_Save" Description="3학년(1학기)석차_20" ToolTip="3학년(1학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_31_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="31_20_JAE" Group="ExToolBar2_Save" Description="3학년(1학기)인원_20" ToolTip="3학년(1학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_20_ISU" Group="ExToolBar2_Save" Description="3학년(2학기)단위_20" ToolTip="3학년(2학기)단위_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_20_SEK" Group="ExToolBar2_Save" Description="3학년(2학기)석차_20" ToolTip="3학년(2학기)석차_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                        <td class="bg02">
                                            <cc1:ExTextBox ID="txt_32_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" DataBindGroup="CUD" DataField="32_20_JAE" Group="ExToolBar2_Save" Description="3학년(2학기)인원_20" ToolTip="3학년(2학기)인원_20" ValidationType="Numeric" Cipher="2" IsNegative="false"></cc1:ExTextBox></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <input name="ctl00$MainContent$ComDivScroll1_value" type="hidden" id="MainContent_ComDivScroll1_value" value="0">
                    </div>
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