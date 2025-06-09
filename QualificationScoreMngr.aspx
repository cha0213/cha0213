<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QualificationScoreMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.QualificationScoreMngr" MasterPageFile="/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div id="divSearch" class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplYear">지원연도 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplYear" runat="server" CssClass="form-control" Width="55px" Required="true" MaxLength="4" FixLength="4" ValidationType="Numeric" Group="ExToolBar1_Search;ExToolBar2_Save" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplSeason">지원시기 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplSeason" runat="server" CodeType="_공통" P1="SA02" Width="100px" BindMode="Select" Required="true" Group="ExToolBar1_Search;ExToolBar2_Save" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" SaveText="검정고시 성적 이관" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">검정고시 성적 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 286px">
                            <cc1:ExGridView ID="grdList1" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="검정고시 성적 리스트" TableCaption="검정고시 성적 리스트" Width="100%"
                                OnRowCommand="grdList1_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="수험번호">
                                        <HeaderStyle Width="10%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="HyperLink1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.recpNo") %>' CommandName="SELECT"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--2--%><asp:BoundField HeaderText="성명" DataField="KorName" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--3--%><asp:BoundField HeaderText="고교명" DataField="neisName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--4--%><asp:BoundField HeaderText="전형구분" DataField="sppoClsName" HeaderStyle-Width="12%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--5--%><asp:BoundField HeaderText="지원학과" DataField="lessonName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--6--%><asp:BoundField HeaderText="합격일자" DataField="AcceptedDate" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" DataFormatString="{0:yyyy-MM-dd}" />
                                    <%--7--%><asp:BoundField HeaderText="과목수" DataField="CNT" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--8--%><asp:BoundField HeaderText="성적반영여부" DataField="CalcScoreYN" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--9--%><asp:BoundField HeaderText="지원연도" DataField="ApplYear" HeaderStyle-Width="10%" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--10--%><asp:BoundField HeaderText="지원시기" DataField="ApplSeason" HeaderStyle-Width="10%" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--11--%><asp:BoundField HeaderText="주민번호" DataField="resdNo" HeaderStyle-Width="10%" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                        </cc2:ComDivScroll>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">검정고시 과목 리스트&nbsp;
                             [ 수험번호:
                                <asp:Label ID="lblrecpNo1" runat="server" CssClass="m-r-xs text-primary strong" Width="80px"></asp:Label>
                            성명:
                                <asp:Label ID="lblStudentName1" runat="server" CssClass="m-r-xs text-primary strong" Width="70px"></asp:Label>
                            ]
                        </h3>
                        <cc1:ExDataCounter ID="ExDataCounter2" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll2" runat="server" Style="height: 286px">
                            <cc1:ExGridView ID="grdList2" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="검정고시 과목 리스트" TableCaption="검정고시 과목 리스트" Width="100%">
                                <Columns>
                                    <asp:BoundField HeaderText="필수구분" DataField="SubjectReqName" HeaderStyle-Width="25%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="과목명" DataField="SubjectName" HeaderStyle-Width="30%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <asp:BoundField HeaderText="점수" DataField="SubjectScore" HeaderStyle-Width="30%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                </Columns>
                                <EmptyDataRowStyle CssClass="dataTables_empty" />
                                <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                            </cc1:ExGridView>
                        </cc2:ComDivScroll>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <uc1:Modal ID="modalFileUpload" runat="server" ModalId="FileUpload" ModalTitle="검정고시 성적 이관" ShowCloseButton="true">
        <ModalBodyTemplate>
            <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
        </ModalBodyTemplate>
    </uc1:Modal>

    <script type="text/javascript">

        function StudentFileUpload() {

            // 필수항목 체크
            if (!ClientValidate('divSearch')) return false;

            var applyear = $("#<%=txtSearchApplYear.ClientID%>").val();
            var applseason = $("#<%=ddlSearchApplSeason.ClientID%>").val();

            var modalId = '#<%= modalFileUpload.ModalId %>';
            var height = 230;
            var src = "/ENTR/StaffMngr/QualificationScoreUpload.aspx?ApplYear=" + applyear + "&ApplSeason=" + applseason;
            $(modalId)
                .find('.modal-body iframe')
                .css({ 'height': height + 'px' })
                .attr({ 'src': src });

            window.modalCallback = CompleteUpload;

            $(modalId).modal('show');

            return false;
        }

        function CompleteUpload() {

            var modalId = '#<%= modalFileUpload.ModalId %>';
            $(modalId).modal('hide');
            window.modalCallback = null;

            stopSpin();

            alertMessage('검정고시 성적 이관 작업이 완료 되었습니다.');
                <%--$('#<%= ExToolBar1.ClientID %>' + '_Search').click();--%>
        }

        $(document).ready(function () {

        });
    </script>
</asp:Content>