<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="amPassSMSMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.amPassSMSMngr" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Src="/COFF/CONTROL/SCFF/YearTermControl.ascx" TagPrefix="uc2" TagName="yt" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddl합격코드조회">합격코드 : </asp:Label>
                    <cc1:ExDropDownList ID="ddl합격코드조회" runat="server" Width="252px" ToolTip="합격코드" Description="합격코드" BindMode="All" CodeType="_공통" P1="SA04" Group="ExToolBar2_Print"></cc1:ExDropDownList>
                </div>                       
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">지원자 SMS 문장 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll" runat="server" class="ComDivScroll" Height="200px">
                        <cc1:ExGridView ID="grdList" runat="server"
                            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-sm"
                            SelectedRowStyle-CssClass="active"
                            ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="false" TableSummary="지원자 SMS 리스트" TableCaption="지원자 SMS 리스트"
                            OnRowCommand="grdList_RowCommand">
                            <Columns>                                
                                <asp:TemplateField HeaderText="합격코드">
                                    <HeaderStyle Width="15%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="passName" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.passName") %>' CommandName="SELECT"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>   
                                <%--<asp:TemplateField HeaderText="SMS 문장">
                                    <HeaderStyle Width="20%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-left" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="Smscontent" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.Smscontent") %>' CommandName="SELECT"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>  --%>                             
                                <asp:BoundField HeaderText="SMS 예시 문장" DataField="Preview" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" HtmlEncode="false"/>                             
                                <asp:BoundField HeaderText="자동발송여부" DataField="AutoSendName" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                <asp:TemplateField HeaderText="{chkRow:}">
                                    <HeaderStyle Width="5%" CssClass="text-center" />
                                    <ItemStyle CssClass="text-center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>                                
                                <asp:BoundField HeaderText="합격코드코드값" DataField="pass" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="자동발송여부" DataField="AutoSend" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                <asp:BoundField HeaderText="SMS 문장" DataField="Smscontent" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
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
                        <h3 class="panel-title pencil">장학생 입력항목</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddl합격코드입력">합격코드 : </asp:Label>
                                <div class="col-xs-4 form-inline">
                                    <cc1:ExDropDownList ID="ddl합격코드입력" runat="server" Width="252px" ToolTip="합격코드" Description="합격코드" BindMode="Select" CodeType="_공통" P1="SA04" Required="true" Group="ExToolBar3_Save"></cc1:ExDropDownList>
                                </div>  
                                <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="rbl자동발송">자동발송여부 :</asp:Label>
                                <div class="col-xs-4 form-inline">
                                    <cc1:ExRadioButtonList ID="rbl자동발송" runat="server" Required="true" Group="ExToolBar3_Save" Description="자동발송여부" ToolTip="자동발송여부" RepeatDirection="Horizontal" CssClass="RadioButtonList" RepeatLayout="Flow">
                                        <asp:ListItem Value="Y">자동발송</asp:ListItem>
                                        <asp:ListItem Value="N">수동발송</asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>                              
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtSMS문장">SMS문장 : </asp:Label>
                                <div class="col-xs-4">
                                    <cc1:ExTextBox ID="txtSMS문장" runat="server" CssClass="form-control" Width="252px" TextMode="MultiLine" Height="150px" ToolTip="SMS문장" Description="SMS문장" Required="true" Group="ExToolBar3_Save"></cc1:ExTextBox>
                                </div>  
                                <div class="col-xs-4 form-inline">
                                    <p class="txt bg-primary small">
                                        * 문장 내 유동적으로 삽입 할 내용은 아래 버튼을 이용하세요.
                                        <br>
                                        * 예:) {@버튼이름} 은 유동적인 텍스트를 삽입하게 됩니다.
                                    </p>
                                    <%--<div class="btn-group mt_5" role="group" aria-label="btngroup2">--%>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원연도</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원시기</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">전형구분</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원학과</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">석차</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">예비석차</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">현재일자</button>
                                        <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">수험번호</button>
                                    <%--</div>--%>
                                </div>        
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">                           
                            <div class="col-lg-6 text-right">
                                <cc1:ExToolBar ID="ExToolBar3" runat="server" SaveVisible="true" NewVisible="true" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
                    
             $('#<%= ExToolBar2.ClientID %>_Delete').on('click', function () {
                var rValue = false;
                var $btn = $(this);

                if (ClickChkSelect('지원자 SMS 문장 리스트에서 삭제', 'grdList', 'chkRow', 0)) {
                    confirmMessage("해당내역을 삭제 하시겠습니까?", $btn);
                }
                else {
                    return false;
                }

                return rValue;
             });


            $(document).find("[name~=btnGroup]").each(function () {
                $(this).on('click', function (e) {
                    var $button = $(this);
                    var obj = document.getElementById("[name~=btnGroup]");
                    var $SMSText = $('#<%= txtSMS문장.ClientID%>');

                    var cursorPos = $SMSText.prop('selectionStart');
                    var v = $SMSText.val();
                    var textBefore = v.substring(0, cursorPos) + '{@' + $button.text() + '}';
                    var textAfter = v.substring(cursorPos, v.length);

                    $SMSText.val(textBefore + textAfter);
                    $SMSText.selectRange(textBefore.length, textBefore.length);
                    $SMSText.focus();
                });
            });

            $.fn.selectRange = function (start, end) {
                return this.each(function () {
                    if (this.setSelectionRange) {
                        this.focus();
                        this.setSelectionRange(start, end);
                    } else if (this.createTextRange) {
                        var range = this.createTextRange();
                        range.collapse(true);
                        range.moveEnd('character', end);
                        range.moveStart('character', start);
                        range.select();
                    }
                });
            };


        });
    </script>
</asp:Content>