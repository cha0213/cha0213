<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amPassList.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amPassList" MasterPageFile="~/Page.Master" %>
<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>
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
                    <!-- 1열 -->
                    <!-- 연도 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt연도">연도 :</asp:Label>
                        <cc1:ExTextBox ID="txt연도" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Group="ExToolBar1_Search;ExToolBar1_Print" Description="연도" Required="true"></cc1:ExTextBox>
                    </div>
                    <!-- 시기 -->
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl시기">시기 :</asp:Label>
                        <cc1:ExDropDownList ID="ddl시기" runat="server" CssClass="form-control" Width="100px" Group="ExToolBar1_Search;ExToolBar1_Print" Description="시기" ToolTip="시기" CodeType="_공통" BindMode="None" P1="SA02" Required="true"></cc1:ExDropDownList>
                    </div>
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="control-label" AssociatedControlID="rdo구분">구분 :</asp:Label>
                        <cc1:ExRadioButtonList ID="rdo구분" runat="server" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar1_Print" Description="구분" ToolTip="구분" RepeatDirection="Horizontal" Required="true">
							<asp:ListItem Value="30">지원/면접대상자</asp:ListItem>
                            <asp:ListItem Value="09" Selected="True">합격자</asp:ListItem>
							<asp:ListItem Value="06">후보자</asp:ListItem>
							<asp:ListItem Value="04">불합격자</asp:ListItem>
                        </cc1:ExRadioButtonList>
                    </div>
                    <!-- 버튼 영역 -->
                    <div class="form-group form-group-sm">
                        <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" PrintVisible="true"/>
                    </div>
                </div>
            </div>
            <!-- 상단 조회 영역 끝 -->
            
            <!--면접대상자/합격자/후보자/불합격자 조회 리스트 시작 -->
            <div class="panel panel-default">
                <!-- 타이틀 영역 -->
                <div class="panel-heading">
                    <h3 class="panel-title pull-left grdList">면접대상자/합격자/후보자/불합격자 조회 리스트</h3>                   
                    <cc1:ExDataCounter ID="ExDataCounter1" runat="server"></cc1:ExDataCounter>
                </div>
                <!-- 목록 영역 -->
                <div class="panel-body p-n">
                    <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 400px"> 
                        <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="면접대상자/합격자/후보자/불합격자 조회 리스트" TableCaption="면접대상자/합격자/후보자/불합격자 조회 리스트" Width="100%"  >
                            <Columns>
                                <%--1--%><asp:BoundField HeaderText="석차" DataField="Rank" HeaderStyle-Width="5%" ItemStyle-CssClass="textWrap text-center"/>
                                <%--2--%><asp:BoundField HeaderText="수험번호" DataField="recpNo" HeaderStyle-Width="10%" ItemStyle-CssClass="textWrap text-center"  />
                                <%--3--%><asp:BoundField HeaderText="이름" DataField="korName" HeaderStyle-Width="10%" ItemStyle-CssClass="textWrap text-center" />
                                <%--4--%><asp:BoundField HeaderText="주민번호" DataField="resdNo" HeaderStyle-Width="10%" ItemStyle-CssClass="textWrap text-center" />
                                <%--5--%><asp:BoundField HeaderText="전형" DataField="sppoClsName" HeaderStyle-Width="20%" ItemStyle-CssClass="textWrap text-left" />
                                <%--6--%><asp:BoundField HeaderText="출신고" DataField="neisName" HeaderStyle-Width="20%" ItemStyle-CssClass="textWrap text-left" />
                                <%--7--%><asp:BoundField HeaderText="최종계열" DataField="LessonName" HeaderStyle-Width="18%" ItemStyle-CssClass="textWrap text-left" />
                                <%--8--%><asp:BoundField HeaderText="후보석차" DataField="SubRank" HeaderStyle-Width="7%" ItemStyle-CssClass="textWrap text-center" />
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataTables_empty" />
                            <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                        </cc1:ExGridView>
                    </cc2:ComDivScroll>    
                </div>

            </div>
            <!--면접대상자/합격자/후보자/불합격자 조회 리스트 끝 -->
            
        </div>
    </div>
    <!-- Report -->
    <uc2:report ID="Report1" runat="server" />
    <uc1:ReportInvoker ID="ReportInvoker1" runat="server" />
    <script type="text/javascript">

    </script>

</asp:Content>