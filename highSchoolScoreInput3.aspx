<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreInput3.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreInput3" MasterPageFile="/Page.Master" %>
<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">

    </script>

</asp:Content>

<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont" id="divInput">
        <!-- 상단 산출방법 선택 영역 시작 -->
        <div class="table-filter m-b-xs tf_style01 tf_bg01"> <!-- tf_style01 tf_bg01 클래스 추가 -->
            <h3>산출방법을 선택하세요.</h3>
                <cc1:ExRadioButtonList ID="rblType" runat="server" Group="ExToolBar1_Search" Description="구분" ToolTip="구분" RepeatDirection="Vertical" CssClass="form-control" RepeatLayout="Flow">
                <asp:ListItem Text="일반전형, 특별전형(일반고/자율고/특목고) - 3단위 이상 과목 입력" Value="1" Selected="True"></asp:ListItem>
                <asp:ListItem Text="특별전형(특성화고), 정원외전형 - 전과목 입력" Value="2" ></asp:ListItem>                           
                </cc1:ExRadioButtonList>
        </div>
        <!-- 상단 산출방법 선택 영역 끝 -->
        
        <!-- 내신성적 산출표 입력항목 시작 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pencil">내신성적 산출표</h3>
                </div>
            </div>
            <div class="panel-body p-n">
                <!-- 내신 성적 산출 테이블 -->
                <div id="MainContent_ComDivScroll1" class="ComDivScroll" style="overflow-y:hidden">
                <div class="form-group-sm">
                    <table class="table table-bordered t_style01 m-n" summary="내신성적 산출표 입니다.">  <!-- t_style01 클래스 추가 -->
                    <caption>
                    내신성적 산출표
                    </caption>
                    <thead>
                        <tr>
                        <th></th>
                        <th scope="col" colspan="3">1학년(1학기)</th>
                        <th scope="col" colspan="3">1학년(2학기)</th>
                        <th scope="col" colspan="3" class="bg01">2학년(1학기)</th>  <!-- 학년별 bg01 ,bg02 클래스 추가 -->
                        <th scope="col" colspan="3" class="bg01">2학년(2학기)</th>
                        <th scope="col" colspan="3" class="bg02">3학년(1학기)</th>
                        <th scope="col" colspan="3" class="bg02">3학년(2학기)</th>
                        </tr>
                        <tr>
                        <th scope="col">과목</th>
                        <th scope="col">원<br>
                            점수</th>
                        <th scope="col">과목<br>
                            평균</th>
                        <th scope="col">표준<br>
                            편차</th>
                        <th scope="col">원<br>
                            점수</th>
                        <th scope="col">과목<br>
                            평균</th>
                        <th scope="col">표준<br>
                            편차</th>
                        <th scope="col" class="bg01">원<br>
                            점수</th>
                        <th scope="col" class="bg01">과목<br>
                            평균</th>
                        <th scope="col" class="bg01">표준<br>
                            편차</th>
                        <th scope="col" class="bg01">원<br>
                            점수</th>
                        <th scope="col" class="bg01">과목<br>
                            평균</th>
                        <th scope="col" class="bg01">표준<br>
                            편차</th>
                        <th scope="col" class="bg02">원<br>
                            점수</th>
                        <th scope="col" class="bg02">과목<br>
                            평균</th>
                        <th scope="col" class="bg02">표준<br>
                            편차</th>
                        <th scope="col" class="bg02">원<br>
                            점수</th>
                        <th scope="col" class="bg02">과목<br>
                            평균</th>
                        <th scope="col" class="bg02">표준<br>
                            편차</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        <th>1</th>
                        <td><cc1:ExTextBox ID="txt_11_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_1" ToolTip="1학년(1학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>  <!-- input박스 form-control 추가 -->
                        <td><cc1:ExTextBox ID="txt_11_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_1" ToolTip="1학년(1학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_1" ToolTip="1학년(1학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_1" ToolTip="1학년(2학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_1" ToolTip="1학년(2학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_1" ToolTip="1학년(2학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_1" ToolTip="2학년(1학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_1" ToolTip="2학년(1학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_1" ToolTip="2학년(1학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_1" ToolTip="2학년(2학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_1" ToolTip="2학년(2학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_1" ToolTip="2학년(2학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_1" ToolTip="3학년(1학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_1" ToolTip="3학년(1학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_1" ToolTip="3학년(1학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_01_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_1" ToolTip="3학년(2학기)원점수_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_01_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_1" ToolTip="3학년(2학기)과목평균_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_01_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_1" ToolTip="3학년(2학기)표준편차_1" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>2</th>
                        <td><cc1:ExTextBox ID="txt_11_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_2" ToolTip="1학년(1학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_2" ToolTip="1학년(1학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_2" ToolTip="1학년(1학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_2" ToolTip="1학년(2학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_2" ToolTip="1학년(2학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_2" ToolTip="1학년(2학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_2" ToolTip="2학년(1학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_2" ToolTip="2학년(1학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_2" ToolTip="2학년(1학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_2" ToolTip="2학년(2학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_2" ToolTip="2학년(2학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_2" ToolTip="2학년(2학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_2" ToolTip="3학년(1학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균ㅍ" ToolTip="3학년(1학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_2" ToolTip="3학년(1학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_02_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_2" ToolTip="3학년(2학기)원점수_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_02_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_2" ToolTip="3학년(2학기)과목평균_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_02_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_2" ToolTip="3학년(2학기)표준편차_2" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>3</th>
                        <td><cc1:ExTextBox ID="txt_11_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_3" ToolTip="1학년(1학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_3" ToolTip="1학년(1학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_3" ToolTip="1학년(1학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_3" ToolTip="1학년(2학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_3" ToolTip="1학년(2학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_3" ToolTip="1학년(2학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_3" ToolTip="2학년(1학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_3" ToolTip="2학년(1학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_3" ToolTip="2학년(1학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_3" ToolTip="2학년(2학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_3" ToolTip="2학년(2학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_3" ToolTip="2학년(2학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_3" ToolTip="3학년(1학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_3" ToolTip="3학년(1학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_3" ToolTip="3학년(1학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_03_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_3" ToolTip="3학년(2학기)원점수_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_03_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_3" ToolTip="3학년(2학기)과목평균_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_03_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_3" ToolTip="3학년(2학기)표준편차_3" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>4</th>
                        <td><cc1:ExTextBox ID="txt_11_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_4" ToolTip="1학년(1학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_4" ToolTip="1학년(1학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_4" ToolTip="1학년(1학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_4" ToolTip="1학년(2학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_4" ToolTip="1학년(2학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_4" ToolTip="1학년(2학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_4" ToolTip="2학년(1학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_4" ToolTip="2학년(1학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_4" ToolTip="2학년(1학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_4" ToolTip="2학년(2학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_4" ToolTip="2학년(2학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_4" ToolTip="2학년(2학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_4" ToolTip="3학년(1학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_4" ToolTip="3학년(1학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_4" ToolTip="3학년(1학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_04_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_4" ToolTip="3학년(2학기)원점수_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_04_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_4" ToolTip="3학년(2학기)과목평균_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_04_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_4" ToolTip="3학년(2학기)표준편차_4" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>5</th>
                        <td><cc1:ExTextBox ID="txt_11_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_5" ToolTip="1학년(1학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_5" ToolTip="1학년(1학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_5" ToolTip="1학년(1학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_5" ToolTip="1학년(2학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_5" ToolTip="1학년(2학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_5" ToolTip="1학년(2학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_5" ToolTip="2학년(1학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_5" ToolTip="2학년(1학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_5" ToolTip="2학년(1학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_5" ToolTip="2학년(2학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_5" ToolTip="2학년(2학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_5" ToolTip="2학년(2학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_5" ToolTip="3학년(1학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_5" ToolTip="3학년(1학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_5" ToolTip="3학년(1학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_05_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_5" ToolTip="3학년(2학기)원점수_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_05_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_5" ToolTip="3학년(2학기)과목평균_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_05_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_5" ToolTip="3학년(2학기)표준편차_5" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>6</th>
                        <td><cc1:ExTextBox ID="txt_11_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_6" ToolTip="1학년(1학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_6" ToolTip="1학년(1학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_6" ToolTip="1학년(1학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_6" ToolTip="1학년(2학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_6" ToolTip="1학년(2학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_6" ToolTip="1학년(2학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_6" ToolTip="2학년(1학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_6" ToolTip="2학년(1학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_6" ToolTip="2학년(1학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_6" ToolTip="2학년(2학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_6" ToolTip="2학년(2학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_6" ToolTip="2학년(2학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_6" ToolTip="3학년(1학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_6" ToolTip="3학년(1학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_6" ToolTip="3학년(1학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_06_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_6" ToolTip="3학년(2학기)원점수_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_06_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_6" ToolTip="3학년(2학기)과목평균_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_06_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_6" ToolTip="3학년(2학기)표준편차_6" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>7</th>
                        <td><cc1:ExTextBox ID="txt_11_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_7" ToolTip="1학년(1학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_7" ToolTip="1학년(1학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_7" ToolTip="1학년(1학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_7" ToolTip="1학년(2학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_7" ToolTip="1학년(2학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_7" ToolTip="1학년(2학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_7" ToolTip="2학년(1학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_7" ToolTip="2학년(1학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_7" ToolTip="2학년(1학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_7" ToolTip="2학년(2학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_7" ToolTip="2학년(2학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_7" ToolTip="2학년(2학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_7" ToolTip="3학년(1학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_7" ToolTip="3학년(1학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_7" ToolTip="3학년(1학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_07_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_7" ToolTip="3학년(2학기)원점수_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_07_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_7" ToolTip="3학년(2학기)과목평균_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_07_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_7" ToolTip="3학년(2학기)표준편차_7" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>8</th>
                        <td><cc1:ExTextBox ID="txt_11_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_8" ToolTip="1학년(1학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_8" ToolTip="1학년(1학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_8" ToolTip="1학년(1학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_8" ToolTip="1학년(2학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_8" ToolTip="1학년(2학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_8" ToolTip="1학년(2학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_8" ToolTip="2학년(1학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_8" ToolTip="2학년(1학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_8" ToolTip="2학년(1학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_8" ToolTip="2학년(2학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_8" ToolTip="2학년(2학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_8" ToolTip="2학년(2학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_8" ToolTip="3학년(1학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_8" ToolTip="3학년(1학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_8" ToolTip="3학년(1학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_08_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_8" ToolTip="3학년(2학기)원점수_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_08_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_8" ToolTip="3학년(2학기)과목평균_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_08_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_8" ToolTip="3학년(2학기)표준편차_8" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>9</th>
                        <td><cc1:ExTextBox ID="txt_11_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_9" ToolTip="1학년(1학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_9" ToolTip="1학년(1학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_9" ToolTip="1학년(1학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_9" ToolTip="1학년(2학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_9" ToolTip="1학년(2학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_9" ToolTip="1학년(2학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_9" ToolTip="2학년(1학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_9" ToolTip="2학년(1학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_9" ToolTip="2학년(1학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_9" ToolTip="2학년(2학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_9" ToolTip="2학년(2학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_9" ToolTip="2학년(2학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_9" ToolTip="3학년(1학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_9" ToolTip="3학년(1학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_9" ToolTip="3학년(1학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_09_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_9" ToolTip="3학년(2학기)원점수_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_09_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_9" ToolTip="3학년(2학기)과목평균_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_09_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_9" ToolTip="3학년(2학기)표준편차_9" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>10</th>
                        <td><cc1:ExTextBox ID="txt_11_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_10" ToolTip="1학년(1학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_10" ToolTip="1학년(1학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_10" ToolTip="1학년(1학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_10" ToolTip="1학년(2학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_10" ToolTip="1학년(2학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_10" ToolTip="1학년(2학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_10" ToolTip="2학년(1학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_10" ToolTip="2학년(1학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_10" ToolTip="2학년(1학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_10" ToolTip="2학년(2학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_10" ToolTip="2학년(2학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_10" ToolTip="2학년(2학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_10" ToolTip="3학년(1학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_10" ToolTip="3학년(1학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_10" ToolTip="3학년(1학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_10_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_10" ToolTip="3학년(2학기)원점수_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_10_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_10" ToolTip="3학년(2학기)과목평균_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_10_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_10" ToolTip="3학년(2학기)표준편차_10" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>11</th>
                        <td><cc1:ExTextBox ID="txt_11_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_11" ToolTip="1학년(1학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_11" ToolTip="1학년(1학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_11" ToolTip="1학년(1학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_11" ToolTip="1학년(2학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_11" ToolTip="1학년(2학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_11" ToolTip="1학년(2학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_11" ToolTip="2학년(1학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_11" ToolTip="2학년(1학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_11" ToolTip="2학년(1학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_11" ToolTip="2학년(2학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_11" ToolTip="2학년(2학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_11" ToolTip="2학년(2학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_11" ToolTip="3학년(1학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_11" ToolTip="3학년(1학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_11" ToolTip="3학년(1학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_11_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_11" ToolTip="3학년(2학기)원점수_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_11_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_11" ToolTip="3학년(2학기)과목평균_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_11_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_11" ToolTip="3학년(2학기)표준편차_11" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>12</th>
                        <td><cc1:ExTextBox ID="txt_11_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_12" ToolTip="1학년(1학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_12" ToolTip="1학년(1학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_12" ToolTip="1학년(1학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_12" ToolTip="1학년(2학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_12" ToolTip="1학년(2학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_12" ToolTip="1학년(2학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_12" ToolTip="2학년(1학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_12" ToolTip="2학년(1학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_12" ToolTip="2학년(1학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_12" ToolTip="2학년(2학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_12" ToolTip="2학년(2학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_12" ToolTip="2학년(2학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_12" ToolTip="3학년(1학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_12" ToolTip="3학년(1학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_12" ToolTip="3학년(1학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_12_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_12" ToolTip="3학년(2학기)원점수_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_12_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_12" ToolTip="3학년(2학기)과목평균_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_12_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_12" ToolTip="3학년(2학기)표준편차_12" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>13</th>
                        <td><cc1:ExTextBox ID="txt_11_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_13" ToolTip="1학년(1학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_13" ToolTip="1학년(1학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_13" ToolTip="1학년(1학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_13" ToolTip="1학년(2학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_13" ToolTip="1학년(2학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_13" ToolTip="1학년(2학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_13" ToolTip="2학년(1학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_13" ToolTip="2학년(1학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_13" ToolTip="2학년(1학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_13" ToolTip="2학년(2학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_13" ToolTip="2학년(2학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_13" ToolTip="2학년(2학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_13" ToolTip="3학년(1학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_13" ToolTip="3학년(1학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_13" ToolTip="3학년(1학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_13_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_13" ToolTip="3학년(2학기)원점수_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_13_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_13" ToolTip="3학년(2학기)과목평균_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_13_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_13" ToolTip="3학년(2학기)표준편차_13" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>14</th>
                        <td><cc1:ExTextBox ID="txt_11_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_14" ToolTip="1학년(1학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_14" ToolTip="1학년(1학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_14" ToolTip="1학년(1학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_14" ToolTip="1학년(2학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_14" ToolTip="1학년(2학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_14" ToolTip="1학년(2학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_14" ToolTip="2학년(1학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_14" ToolTip="2학년(1학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_14" ToolTip="2학년(1학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_14" ToolTip="2학년(2학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_14" ToolTip="2학년(2학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_14" ToolTip="2학년(2학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_14" ToolTip="3학년(1학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_14" ToolTip="3학년(1학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_14" ToolTip="3학년(1학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_14_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_14" ToolTip="3학년(2학기)원점수_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_14_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_14" ToolTip="3학년(2학기)과목평균_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_14_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_14" ToolTip="3학년(2학기)표준편차_14" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>15</th>
                        <td><cc1:ExTextBox ID="txt_11_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_15" ToolTip="1학년(1학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_15" ToolTip="1학년(1학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_15" ToolTip="1학년(1학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_15" ToolTip="1학년(2학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_15" ToolTip="1학년(2학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_15" ToolTip="1학년(2학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_15" ToolTip="2학년(1학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_15" ToolTip="2학년(1학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_15" ToolTip="2학년(1학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_15" ToolTip="2학년(2학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_15" ToolTip="2학년(2학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_15" ToolTip="2학년(2학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_15" ToolTip="3학년(1학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_15" ToolTip="3학년(1학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_15" ToolTip="3학년(1학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_15_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_15" ToolTip="3학년(2학기)원점수_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_15_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_15" ToolTip="3학년(2학기)과목평균_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_15_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_15" ToolTip="3학년(2학기)표준편차_15" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>16</th>
                        <td><cc1:ExTextBox ID="txt_11_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_16" ToolTip="1학년(1학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_16" ToolTip="1학년(1학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_16" ToolTip="1학년(1학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_16" ToolTip="1학년(2학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_16" ToolTip="1학년(2학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_16" ToolTip="1학년(2학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_16" ToolTip="2학년(1학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_16" ToolTip="2학년(1학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_16" ToolTip="2학년(1학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_16" ToolTip="2학년(2학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_16" ToolTip="2학년(2학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_16" ToolTip="2학년(2학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_16" ToolTip="3학년(1학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_16" ToolTip="3학년(1학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_16" ToolTip="3학년(1학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_16_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_16" ToolTip="3학년(2학기)원점수_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_16_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_16" ToolTip="3학년(2학기)과목평균_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_16_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_16" ToolTip="3학년(2학기)표준편차_16" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>17</th>
                        <td><cc1:ExTextBox ID="txt_11_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_17" ToolTip="1학년(1학기)원점수_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_17" ToolTip="1학년(1학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_17" ToolTip="1학년(1학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_17" ToolTip="1학년(2학기)원점수_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_17" ToolTip="1학년(2학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_17" ToolTip="1학년(2학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_17" ToolTip="2학년(1학기)원점수_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_17" ToolTip="2학년(1학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_17" ToolTip="2학년(1학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_17" ToolTip="2학년(2학기)원점수_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_17" ToolTip="2학년(2학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_17" ToolTip="2학년(2학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_17" ToolTip="3학년(1학기)원점_17수" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_17" ToolTip="3학년(1학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_17" ToolTip="3학년(1학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_17_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_17" ToolTip="3학년(2학기)원점수_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_17_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_17" ToolTip="3학년(2학기)과목평균_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_17_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_17" ToolTip="3학년(2학기)표준편차_17" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>18</th>
                        <td><cc1:ExTextBox ID="txt_11_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_18" ToolTip="1학년(1학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_18" ToolTip="1학년(1학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_18" ToolTip="1학년(1학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_18" ToolTip="1학년(2학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_18" ToolTip="1학년(2학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_18" ToolTip="1학년(2학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_18" ToolTip="2학년(1학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_18" ToolTip="2학년(1학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_18" ToolTip="2학년(1학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_18" ToolTip="2학년(2학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_18" ToolTip="2학년(2학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_18" ToolTip="2학년(2학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_18" ToolTip="3학년(1학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_18" ToolTip="3학년(1학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_18" ToolTip="3학년(1학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_18_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_18" ToolTip="3학년(2학기)원점수_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_18_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_18" ToolTip="3학년(2학기)과목평균_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_18_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_18" ToolTip="3학년(2학기)표준편차_18" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>19</th>
                        <td><cc1:ExTextBox ID="txt_11_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_19" ToolTip="1학년(1학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_19" ToolTip="1학년(1학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_19" ToolTip="1학년(1학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_19" ToolTip="1학년(2학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_19" ToolTip="1학년(2학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_19" ToolTip="1학년(2학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_19" ToolTip="2학년(1학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_19" ToolTip="2학년(1학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_19" ToolTip="2학년(1학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_19" ToolTip="2학년(2학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_19" ToolTip="2학년(2학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_19" ToolTip="2학년(2학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_19" ToolTip="3학년(1학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_19" ToolTip="3학년(1학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_19" ToolTip="3학년(1학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_19_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_19" ToolTip="3학년(2학기)원점수_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_19_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_19" ToolTip="3학년(2학기)과목평균_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_19_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_19" ToolTip="3학년(2학기)표준편차_19" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                        <th>20</th>
                        <td><cc1:ExTextBox ID="txt_11_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)원점수_20" ToolTip="1학년(1학기)원점수_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)과목평균_20" ToolTip="1학년(1학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_11_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(1학기)표준편차_20" ToolTip="1학년(1학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)원점수_20" ToolTip="1학년(2학기)원점_20수" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)과목평균_20" ToolTip="1학년(2학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td><cc1:ExTextBox ID="txt_12_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="1학년(2학기)표준편차_20" ToolTip="1학년(2학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)원점수_20" ToolTip="2학년(1학기)원점수_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)과목평균_20" ToolTip="2학년(1학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_21_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(1학기)표준편차_20" ToolTip="2학년(1학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)원점수_20" ToolTip="2학년(2학기)원점수_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)과목평균_20" ToolTip="2학년(2학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg01"><cc1:ExTextBox ID="txt_22_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="2학년(2학기)표준편차_20" ToolTip="2학년(2학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)원점수_20" ToolTip="3학년(1학기)원점수_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)과목평균_20" ToolTip="3학년(1학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_31_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(1학기)표준편차_20" ToolTip="3학년(1학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_20_ISU" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)원점수_20" ToolTip="3학년(2학기)원점수_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_20_SEK" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)과목평균_20" ToolTip="3학년(2학기)과목평균_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        <td class="bg02"><cc1:ExTextBox ID="txt_32_20_JAE" runat="server" Width="100%" CssClass="form-control text-right" Group="btnComfirm" Description="3학년(2학기)표준편차_20" ToolTip="3학년(2학기)표준편차_20" ValidationType="Numeric" Cipher="2" IsNegative="false" ></cc1:ExTextBox></td>
                        </tr>
                    </tbody>
                    </table>
                    <cc1:ExTextBox ID="txtabsence_3_D" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_3_C" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_3_B" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_3_A" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_2_D" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_2_A" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_2_B" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_1_D" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_2_C" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_1_C" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_1_B" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>
                    <cc1:ExTextBox ID="txtabsence_1_A" runat="server" Width="50px" Visible="False"></cc1:ExTextBox>

                </div>
                <input name="ctl00$MainContent$ComDivScroll1_value" type="hidden" id="MainContent_ComDivScroll1_value" value="0">
                </div>
                
                <!-- 확인하기 버튼 -->
                <div class="mt_20 mb_20 text-center">
                    <asp:Button runat="server" ID="btnComfirm" Text="확인하기" CssClass="btnstyle02" OnClick="btnComfirm_Click"  />
                </div>
            </div>  
        </div>
        <!-- 내신성적 산출표 입력항목 끝 -->

        <!-- 성적결과 시작 -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pencil">성적결과</h3>
                </div>
            </div>
            <div class="panel-body p-n">
                 <table class="table t_style01 t-grade">
                    <colgroup>
                        <col style="width:20%;">
                        <col style="width:;">   
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="bg01">내신등급</th>
                            <td><cc1:ExTextBox ID="txtGrade" runat="server" Width="200px" CssClass="form-control text-right" Group="btnComfirm" Description="내신등급" ToolTip="내신등급" ></cc1:ExTextBox></td>
                        </tr>
                        <tr>
                            <th class="bg01">교과백분위</th>
                            <td><cc1:ExTextBox ID="txtTot" runat="server" Width="200px" CssClass="form-control text-right" Group="btnComfirm" Description="교과백분위" ToolTip="교과백분위" ></cc1:ExTextBox></td>
                        </tr>
                    </tbody>
                </table>
            </div> 
        </div>
        <!-- 성적결과 끝 -->
    </div>
</asp:Content>

<%--푸터--%>
<asp:Content runat="server" ID="Footer" ContentPlaceHolderID="FooterContent">
    <script type="text/javascript">
    
    </script>
</asp:Content>