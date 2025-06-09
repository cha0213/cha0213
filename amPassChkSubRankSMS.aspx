<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amPassChkSubRankSMS.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amPassChkSubRankSMS"  MasterPageFile="/Page.Master"%>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">지원연도 : </asp:Label>
                    <cc1:extextbox id="txtSearchApplyYear" runat="server" cssclass="form-control" width="55px" maxlength="4" fixlength="4" validationtype="Numeric" required="true" group="ExToolBar1_Search" tooltip="지원연도" description="지원연도"></cc1:extextbox>
                </div>

                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 : </asp:Label>
                    <cc1:exdropdownlist id="ddlSearchApplySeason" runat="server" codetype="_공통" p1="SA02" width="180px" bindmode="Select" required="true" group="ExToolBar1_Search" tooltip="지원시기" description="지원시기"></cc1:exdropdownlist>
                </div>
                &nbsp
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchGubun"><strong style="color:red">*</strong>전형구분 : </asp:Label>
                            <cc1:exdropdownlist id="ddlSearchGubun" runat="server" width="300px" codetype="_일반" bindmode="Select" required="true" group="ExToolBar1_Search" tooltip="전형구분" description="전형구분"></cc1:exdropdownlist>
                        </div>
                        <%--<div class="form-group form-group-sm">
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplyOrgID">지원학과 : </asp:Label>
                            <cc1:exdropdownlist id="ddlSearchApplyOrgID" runat="server" width="380px" codetype="_일반" bindmode="All" group="ExToolBar1_Search" tooltip="지원학과" description="지원학과"></cc1:exdropdownlist>
                        </div>--%>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnReBindSearchDdl" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:Button ID="btnReBindSearchDdl" runat="server" CssClass="hidden" />
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                </div>
            </div>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left grdList">예비후보 SMS 인원 관리 리스트</h3>
                <h6 class="color-point pull-left panel-title">( ※ ① 지원연도 : &nbsp<asp:Label ID="lbl지원연도" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                         ② 지원시기 : &nbsp<asp:Label ID="lbl지원시기" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                         ③ 전형구분 : &nbsp<asp:Label ID="lbl전형구분" CssClass="control-label m-r-xs" runat="server"></asp:Label>
                        )
                    </h6>
                <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
            </div>
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 500px">
                    <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                        ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="예비후보 SMS 인원 관리 리스트" TableCaption="예비후보 SMS 인원 관리 리스트" Width="100%">
                        <Columns>
                            <%--1--%><asp:BoundField HeaderText="코드" DataField="majorCode" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                            <%--2--%><asp:BoundField HeaderText="표시학과(계열)" DataField="LessonName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />                         
                            <%--3--%><asp:BoundField HeaderText="전공명" DataField="majorName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--4--%><asp:BoundField HeaderText="실제학과(계열)" DataField="OrgName" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                            <%--5--%><asp:BoundField HeaderText="입학정원" DataField="EnterCount" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-right" />
                            <asp:TemplateField HeaderText="예비후보 SMS 발송 순위">
                                <HeaderStyle Width="12%" />
                                <ItemTemplate>
                                    <cc1:ExTextBox ID="txtSubRankCount" runat="server" CssClass="form-control text-right" MaxLength="4" Description="SMS발송순위" ValidationType="Numeric" MaskType="CurrencyMask" Cipher="0" IsNegative="false" Group="toolBarCUD" Text='<%# DataBinder.Eval(Container.DataItem, "SubRankCount") %>'></cc1:ExTextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle CssClass="dataTables_empty" />
                        <EmptyDataTemplate>데이터가 존재하지 않습니다.</EmptyDataTemplate>
                    </cc1:ExGridView>
                </cc2:ComDivScroll>
            </div>
            <div class="panel-footer">
                <div class="text-right">
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" />
                    <asp:HiddenField ID="hidApplyYear" runat="server" />
                    <asp:HiddenField ID="hidApplySeason" runat="server" />
                    <asp:HiddenField ID="hidGubun" runat="server" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= txtSearchApplyYear.ClientID %>').on('blur', function () {
                var $Year = $(this).val();

                if ($Year == '' || $Year.length < 4) {
                    return;
                }
                else {
                    $('#<%= btnReBindSearchDdl.ClientID %>').click();
                }
            });
        });
    </script>
</asp:Content>
