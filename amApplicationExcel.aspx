<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amApplicationExcel.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amApplicationExcel" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchYear">연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Etc1" Description="연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchGubun">구분 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchGubun" runat="server" Width="600px" ToolTip="구분" Description="구분" Required="true" Group="ExToolBar1_Etc1">
                        <asp:ListItem Value="">선택</asp:ListItem>
						<asp:ListItem Value="1">1. 지원자/합격자/불합격자/합격후포기자/등록자 인원 수</asp:ListItem>
						<asp:ListItem Value="2">2. 지원학과/전형시기/수험번호/이름/전형/지원상태/고등학교종류/고등학교명/대학명/성적및인적사항</asp:ListItem>
						<asp:ListItem Value="3">3. 수능등급/성명/고등학교명/고등학교 종류/전형구분/전형시기/전형성적/면접점수/합격여부/학과/순위등급</asp:ListItem>
						<asp:ListItem Value="4">4. 정보공시 자료(대학 지원자 및 입학자 수)</asp:ListItem>
						<asp:ListItem Value="5">5. 대졸자 전형 상세정보(전형시기/지원학과/전형구분/성명/등수/후보순위/대학명/학과명/졸업년도/..)</asp:ListItem>
						<asp:ListItem Value="6">6. 중복지원자 확인</asp:ListItem>
                        <asp:ListItem Value="7">7. 전형시기별 인원 현황</asp:ListItem>
                        <asp:ListItem Value="8">8. 기숙사 신청 현황</asp:ListItem>
                        <asp:ListItem Value="9">9. 지역별 입학자 현황(정규과정)</asp:ListItem>
                    </cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="엑셀" Etc1CSS="btn btn-default btn-sm" />
                </div>
            </div>
        </div>
        <div class="alert alert-info">
            <strong style="color: red;">※ 2013학년도 입시부터 정확한 내용이 출력됩니다.</strong><br /><br />
            <strong class="c03">1. 지원자/ 합격자/ 불합격자/ 합격후포기자/ 등록자 인원 수</strong><br />
            <strong class="c03">2. 지원학과/ 전형시기/ 수험번호/ 이름/ 전형/ 지원상태/ 고등학교종류/ 고등학교명/ 대학명/ 편입학년/ 등수/ 후보순위</strong><br />
            <strong class="c03">&nbsp;&nbsp;&nbsp;&nbsp;/ 내신등급/ 언어영역등급/ 수리영역등급/ 외국어영역등급/ 탐구1영역등급/ 탐구2영역등급/ 탐구3영역등급/총점</strong><br />
            <strong class="c03">3. 수능등급/ 성명/ 고등학교명/ 고등학교 종류/ 전형구분/ 전형시기/ 전형성적/ 면접점수/ 합격여부/ 소속학과</strong><br />
            <strong class="c03">&nbsp;&nbsp;&nbsp;&nbsp;/ 등수/ 후보순위/ 언어영역등급/ 수리영역등급/ 외국어영역등급/ 탐구1영역등급/ 탐구2영역등급/ 탐구3영역등급/ 내신등급</strong><br />
            <strong class="c03">4. 정보공시 자료( 대학 지원자 및 입학자 수 )</strong><br />
            <strong class="c03">5. 대졸자 전형 상세정보( 전형시기/ 지원학과/ 전형구분/ 성명/ 등수/ 후보순위/ 대학명/ 학과명/ 졸업년도/ 수료년수/ 대학구분</strong><br />
            <strong class="c03">&nbsp;&nbsp;&nbsp;&nbsp;/ 대학성적/ 면접점수/ 총점/ 합격여부/ 고등학교명/ 고등학교종류/ 고등학교졸업년도 )</strong><br />
            <strong class="c03">6. 중복지원자 확인</strong><br />
            <strong class="c03">7. 전형시기별 인원 현황</strong><br />
            <strong class="c03">8. 기숙사 신청 현황</strong><br />
            <strong class="c03">9. 지역별 입학자 현황(정규과정)</strong>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

        });
    </script>
</asp:Content>