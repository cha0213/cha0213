<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="ApplMajorGuideMsgMngr.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplMajorGuideMsgMngr" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>
<asp:Content ID="Script" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        function infoMessagePop(year, season, majorCd, passCd) {
            var modalId = '#<%= modalInfoMessage.ModalId %>';
            var height = 600;
            var src = '/ENTR/StaffMngr/ApplMajorGuideMsgPopUP.aspx?Year=' + year + '&Season=' + season + '&MajorCd=' + majorCd + '&PassCd=' + passCd;
            $(modalId)
                .find('.modal-body iframe')
                .css({ 'height': height + 'px' })
                .attr({ 'src': src });

            window.modalCallback = null;

            $(modalId).modal('show');

            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script type="text/javascript" src="/CrossEditor/js/namo_scripteditor.js">
    </script>
    <uc1:Modal ID="modalInfoMessage" runat="server" ModalId="InfoMessage" ModalTitle="지원자 안내 메시지" ShowCloseButton="false">
        <ModalBodyTemplate>
            <iframe runat="server" style="border: 0 none; width: 100%;"></iframe>
        </ModalBodyTemplate>
    </uc1:Modal>
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">지원연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Search;ExToolBar2_Print" Description="지원연도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="Select" CodeType="_공통" P1="SA02" Group="ExToolBar2_Save;ExToolBar2_Print" AutoPostBack="true"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplyOrgID">지원학과 : </asp:Label>
                            <cc1:ExDropDownList ID="ddlSearchApplyOrgID" runat="server" Width="400px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="지원학과" Description="지원학과" BindMode="All"></cc1:ExDropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReBindSearchYear" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchPassCode">합격코드 : </asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchPassCode" runat="server" Width="210px" CodeType="_일반" Group="ExToolBar1_Search" ToolTip="합격코드" Description="합격코드" BindMode="All"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar4" runat="server" Etc1Visible="true" Etc1Text="이전연도복사" Etc1CSS="btn btn-sm btn-danger" />
                </div>
                <asp:Button ID="btnReBindSearchYear" runat="server" CssClass="hidden" />
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">지원자 안내 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter1" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <cc2:ComDivScroll ID="ComDivScroll1" runat="server" Style="height: 273px">
                            <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-sm" SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="지원자 안내 리스트" TableCaption="지원자 안내 관리" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="지원학과">
                                        <HeaderStyle Width="6%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="HyperLink1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MajorCode") %>' CommandName="SELECT"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--2--%><asp:BoundField HeaderText="전공명" DataField="majorName" HeaderStyle-Width="13%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--3--%><asp:BoundField HeaderText="실제학과(계열)" DataField="OrgName" HeaderStyle-Width="13%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--4--%><asp:BoundField HeaderText="합격코드" DataField="PassNM" HeaderStyle-Width="10%" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <asp:TemplateField HeaderText="안내메시지">
                                        <HeaderStyle Width="5%" CssClass="text-center" />
                                        <ItemStyle CssClass="text-center" />
                                        <ItemTemplate>
                                            <asp:Button ID="btnInfoMessage" runat="server" CssClass="btn btn-sm btn-default" Text="보기" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="{chkRow:}">
                                        <HeaderStyle Width="5%" />
                                        <ItemStyle CssClass="inputWrap" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkRow" runat="server"></asp:CheckBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--7--%><asp:BoundField HeaderText="지원연도" DataField="ApplYear" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--8--%><asp:BoundField HeaderText="지원시기" DataField="Season" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--9--%><asp:BoundField HeaderText="합격코드(코드)" DataField="Pass" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                    <%--10--%><asp:BoundField HeaderText="안내메시지" DataField="GuideMsg" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                </Columns>
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
                        <h3 class="panel-title pencil">지원자 안내 입력항목</h3>
                    </div>
                    <div class="panel-body" style="height: 490px">
                        <div class="form-horizontal">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtApplyYear">지원연도 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Group="ExToolBar3_Save" Required="true" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddlApplySeason">지원시기 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExDropDownList ID="ddlApplySeason" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="Select" CodeType="_공통" P1="SA02" Group="ExToolBar3_Save" AutoPostBack="true"></cc1:ExDropDownList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddlApplyOrgID">지원학과 : </asp:Label>
                                <div class="col-xs-4">
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                        <ContentTemplate>
                                            <cc1:ExDropDownList ID="ddlApplyOrgID" runat="server" Width="95%" CodeType="_일반" Group="ExToolBar3_Save" Required="true" ToolTip="지원학과" Description="지원학과" BindMode="Select"></cc1:ExDropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="btnReBindYear" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddlPassCode">합격코드 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExDropDownList ID="ddlPassCode" runat="server" Width="210px" CodeType="_일반" Group="ExToolBar3_Save" Required="true" ToolTip="합격코드" Description="합격코드" BindMode="Select"></cc1:ExDropDownList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm m-b-n">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtInfoMessage">안내메세지 : </asp:Label>
                                <div class="col-xs-8 form-inline">
                                    <script type="text/javascript">
                                        var CrossEditor = new NamoSE("MsgMngr");
                                        CrossEditor.params.UserToolbar = true;
                                        CrossEditor.params.CreateToolbar = "print|spacebar|undo|redo|spacebar|cut|copy|pastetext|spacebar|hyperlink|spacebar|image|insertfile|spacebar|specialchars|emoticon|blockquote|spacebar|tableinsert|tabledraginsert|enter|formatblock|space|fontname|space|fontsize|space|word_style|word_color|spacebar|word_justify|spacebar|word_listset|spacebar|pagebreak";
                                        CrossEditor.params.Width = 865;
                                        CrossEditor.params.Height = 420;
                                        CrossEditor.EditorStart();

                                        function setEditorValue() {
                                            CrossEditor.SetValue($('#<%= txtInfoMessage.ClientID %>').val());
                                        }

                                        $(document).ready(function () {
                                            $('#<%= ExToolBar3.ClientID %>_Save').on('click', function () {
                                                if (CrossEditor.GetTextValue() == "") {
                                                    alertMessage('프로그램메모를 입력하시기 바랍니다.');
                                                    return;
                                                }
                                                else
                                                    $('#<%= txtInfoMessage.ClientID %>').val(CrossEditor.GetValue());
                                            });
                                        });
                                    </script>
                                    <cc1:ExTextBox ID="txtInfoMessage" runat="server" TextMode="MultiLine" Required="true" Height="357px" CssClass="form-control" Style="display: none;"></cc1:ExTextBox>
                                </div>
                                <div class="col-xs-3 form-inline" style="margin-top: 285px;">
                                    <p class="txt bg-primary small">
                                        * 문장 내 유동적으로 삽입 할 내용은 아래 버튼을 이용하세요.
                                        <br>
                                        * 예:) {@버튼이름} 은 유동적인 텍스트를 삽입하게 됩니다.
                                    </p>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원연도</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원시기</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">전형구분</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">지원학과</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">석차</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">예비석차</button>
                                    <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">현재일자</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="row">
                            <div class="text-right">
                                <cc1:ExToolBar ID="ExToolBar3" runat="server" SaveVisible="true" NewVisible="true" />
                            </div>
                        </div>
                    </div>
                    <asp:Button ID="btnReBindYear" runat="server" CssClass="hidden" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#<%= ExToolBar2.ClientID %>_Delete').on('click', function () {
                var rValue = false;
                var $btnSave = $(this);

                if (ClickChkSelect('지원자 안내 리스트에서 삭제', 'grdList', 'chkRow', 0)) {
                    confirmMessage("삭제하시겠습니까?", $btnSave);
                }
                else {
                    return false;
                }
                return rValue;
            });

            $('#<%= txtSearchApplyYear.ClientID %>').on('blur', function () {
                var $Year = $('#<%= txtSearchApplyYear.ClientID %>').val();

                if ($Year == '') {
                    alertMessage('지원연도은(는) 필수항목 입니다.');
                    return false;
                }
                else if ($Year.length < 4) {
                    alertMessage('지원연도은(는) 반드시 4자리 이어야 합니다.');
                    return false;
                }
                else {
                    $('#<%= btnReBindSearchYear.ClientID %>').click();
                }
                return false;
            });

            $('#<%= txtApplyYear.ClientID %>').on('blur', function () {
                var $Year = $('#<%= txtApplyYear.ClientID %>').val();

                if ($Year == '') {
                    alertMessage('지원연도은(는) 필수항목 입니다.');
                    return false;
                }
                else if ($Year.length < 4) {
                    alertMessage('지원연도은(는) 반드시 4자리 이어야 합니다.');
                    return false;
                }
                else {
                    $('#<%= btnReBindYear.ClientID %>').click();
                }
                return false;
            });

            $('#<%= ExToolBar4.ClientID %>_Etc1').on('click', function () {
                var rValue = false;
                var $btnSave = $(this);
                var $Year = $('#<%= txtSearchApplyYear.ClientID %>').val();

                if ($Year == '') {
                    alertMessage('지원연도은(는) 필수항목 입니다.');
                    return false;
                }
                else if ($Year.length < 4) {
                    alertMessage('지원연도은(는) 반드시 4자리 이어야 합니다.');
                    return false;
                }
                else {
                    confirmMessage("이전연도 복사 시 " + $Year + "도의 등록된 데이터는 삭제 됩니다.<br />" + (Number($Year) - 1) + "도 데이터를 복사 하시겠습니까?", $btnSave);
                }

                return rValue;
            });

            $(document).find("[name~=btnGroup]").each(function () {
                $(this).on('click', function (e) {
                    var $button = $(this);
                    CrossEditor.InsertValue(CrossEditor.GetCaretPos(), '{@' + $button.text() + '}');
                    CrossEditor.SetFocusEditor();
                });
            });

        });
    </script>
</asp:Content>