<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amPassPreviewSMS.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amPassPreviewSMS" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Src="/COFF/CONTROL/SCFF/YearTermControl.ascx" TagPrefix="uc2" TagName="yt" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">        
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">SMS 미리보기</h3>
                        <cc1:ExDataCounter ID="ExDataCounter" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="500px">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="SMS 미리보기" TableCaption="SMS 미리보기"
                            OnRowCommand="grdList_RowCommand">
                            <Columns>   
                                <asp:BoundField HeaderText="합격코드" DataField="passName" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />                             
                               <%-- <asp:TemplateField HeaderText="합격코드">
                                    <HeaderStyle Width="15%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-left" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="passName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.passName") %>' ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>   --%>
                                <asp:BoundField HeaderText="SMS 예시 문장" DataField="Preview" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" HtmlEncode="false"/>                             
                                <%--<asp:TemplateField HeaderText="SMS 문장">
                                    <HeaderStyle Width="20%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-left" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="Smscontent" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Smscontent") %>' ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>  --%>
                                <asp:TemplateField HeaderText="발송여부">
                                    <HeaderStyle Width="5%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkRowSmsSendYN" runat="server" Checked="false"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>       
                                
                                <asp:TemplateField HeaderText="합격코드값">
                                    <HeaderStyle Width="7%" CssClass="skip" />
                                    <ItemStyle CssClass="skip" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPassCode" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.pass") %>'></asp:TextBox>
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
                            <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" SaveText="발송여부 확인 완료" />
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
                    
             $('#<%= ExToolBar2.ClientID %>_Save').on('click', function () {
                 var f = document.forms[0];
                 var grid = document.getElementById("MainContent_grdList");
                 var gridCount = grid.rows.length;
                 
                 var strPassCode = "";

                 for (var i = 0; i < gridCount - 1; i++) {

                     var PassCode = f.elements["MainContent_grdList_txtPassCode_" + i].value;
                     var RowSmsSendYN = f.elements["MainContent_grdList_chkRowSmsSendYN_" + i].checked ? "Y" : "N";

                     if (strPassCode.length == 0) {
                         strPassCode += PassCode + "@" + RowSmsSendYN
                     }
                     else {
                         strPassCode += '|' + PassCode + "@" + RowSmsSendYN
                     }
                 }
                 //alert(strPassCode);
                 window.parent.ClosePreviewModal(strPassCode);
                 
             });

        });
    </script>
</asp:Content>