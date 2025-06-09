<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplSearchInfoMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplSearchInfoMngr" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="content" runat="server" ContentPlaceHolderID="MainContent">
    <div class="subcont">
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-title">
                        <h3 class="panel-title pull-left grdList">지원자 조회 출력 정보 문장 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="200px">
                            <cc1:ExGridView ID="grdList" runat="server"
                                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                                SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="지원자 SMS 리스트" TableCaption="지원자 SMS 리스트"
                                OnRowCommand="grdList_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="문장">
                                        <HeaderStyle Width="15%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-left" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="passName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.passName") %>' CommandName="SELECT"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderText="설명" DataField="" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <asp:TemplateField HeaderText="{chkRow:}">
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
                    <div class="panel-footer">
                        <div class="text-right">
                            <cc1:ExToolBar ID="ExToolBar2" runat="server" DeleteVisible="true" />
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">문장 입력항목</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group form-group-sm">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>