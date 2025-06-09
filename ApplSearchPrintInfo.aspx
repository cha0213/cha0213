<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplSearchPrintInfo.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplSearchPrintInfo" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">지원연도 : </asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Required="true" Group="ExToolBar1_Search" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="Select" CodeType="_공통" P1="SA02" Group="ExToolBar1_Search"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rblSearchPrintGubun">인쇄구분 : </asp:Label>
                    <cc1:ExRadioButtonList ID="rblSearchPrintGubun" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" ToolTip="인쇄구분" Description="인쇄구분" Group="ExToolBar1_Search">
                        <asp:ListItem Value="1" Text="합격통지서" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="장학증서"></asp:ListItem>
                        <asp:ListItem Value="3" Text="등록금고지서"></asp:ListItem>
                        <asp:ListItem Value="4" Text="예치금고지서"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rblSearchPassGubun">합격구분 : </asp:Label>
                    <cc1:ExRadioButtonList ID="rblSearchPassGubun" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" ToolTip="합격구분" Description="합격구분" Group="ExToolBar1_Search">
                        <asp:ListItem Value="08" Text="충원합격자" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="09" Text="최초합격자"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SearchVisible="true" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pencil">출력 정보 입력항목</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-horizontal">
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtApplyYear">지원연도 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control" Width="55px" MaxLength="4" FixLength="4" Required="true" Group="ExToolBar2_Save" ToolTip="지원연도" Description="지원연도"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="ddlApplySeason">지원시기 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExDropDownList ID="ddlApplySeason" runat="server" Width="100px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="Select" CodeType="_공통" P1="SA02" Group="ExToolBar2_Save"></cc1:ExDropDownList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblPrintGubun">인쇄구분 :</asp:Label>
                                <div class="col-xs-4">
                                    <cc1:ExRadioButtonList ID="rblPrintGubun" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" ToolTip="인쇄구분" Description="인쇄구분" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="1" Text="합격통지서" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="2" Text="장학증서"></asp:ListItem>
                                        <asp:ListItem Value="3" Text="등록금고지서"></asp:ListItem>
                                        <asp:ListItem Value="4" Text="예치금고지서"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblPassGubun">합격구분 : </asp:Label>
                                <div class="col-xs-2">
                                    <cc1:ExRadioButtonList ID="rblPassGubun" runat="server"  CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow"  ToolTip="합격구분" Description="합격구분" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="08" Text="충원합격자" Selected="True"></asp:ListItem>
                                        <asp:ListItem Value="09" Text="최초합격자"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtPrintDate">날짜 : </asp:Label>
                                <div class="col-xs-3 form-inline">
                                    <cc1:ExDatePicker ID="txtPrintDate" runat="server" ToolTip="날짜" Description="날짜" Group="ExToolBar2_Save"></cc1:ExDatePicker>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText1">[1] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText1" runat="server" CssClass="form-control" Width="98%" ToolTip="[1] 내용" Description="[1] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport1">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport1" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[1] 중요여부" Description="[1] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText2">[2] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText2" runat="server" CssClass="form-control" Width="98%" ToolTip="[2] 내용" Description="[2] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport2">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport2" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[2] 중요여부" Description="[2] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText3">[3] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText3" runat="server" CssClass="form-control" Width="98%" ToolTip="[3] 내용" Description="[3] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport3">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport3" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[3] 중요여부" Description="[3] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText4">[4] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText4" runat="server" CssClass="form-control" Width="98%" ToolTip="[4] 내용" Description="[4] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport4">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport4" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[4] 중요여부" Description="[4] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText5">[5] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText5" runat="server" CssClass="form-control" Width="98%" ToolTip="[5] 내용" Description="[5] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport5">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport5" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[5] 중요여부" Description="[5] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText6">[6]  내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText6" runat="server" CssClass="form-control" Width="98%" ToolTip="[6] 내용" Description="[6] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport6">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport6" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[6] 중요여부" Description="[6] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText7">[7] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText7" runat="server" CssClass="form-control" Width="98%" ToolTip="[7] 내용" Description="[7] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport7">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport7" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[7] 중요여부" Description="[7] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText8">[8] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText8" runat="server" CssClass="form-control" Width="98%" ToolTip="[8] 내용" Description="[8] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport8">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport8" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[8] 중요여부" Description="[8] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText9">[9] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText9" runat="server" CssClass="form-control" Width="98%" ToolTip="[9] 내용" Description="[9] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport9">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport9" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[9] 중요여부" Description="[9] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText10">[10] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText10" runat="server" CssClass="form-control" Width="98%" ToolTip="[10] 내용" Description="[10] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport10">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport10" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[10] 중요여부" Description="[10] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText11">[11] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText11" runat="server" CssClass="form-control" Width="98%" ToolTip="[11] 내용" Description="[11] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport11">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport11" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[11] 중요여부" Description="[11] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText12">[12] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText12" runat="server" CssClass="form-control" Width="98%" ToolTip="[12] 내용" Description="[12] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport12">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport12" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[12] 중요여부" Description="[12] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText13">[13] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText13" runat="server" CssClass="form-control" Width="98%" ToolTip="[13] 내용" Description="[13] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport13">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport13" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[13] 중요여부" Description="[13] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText14">[14] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText14" runat="server" CssClass="form-control" Width="98%" ToolTip="[14] 내용" Description="[14] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport14">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport14" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[14] 중요여부" Description="[14] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText15">[15] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText15" runat="server" CssClass="form-control" Width="98%" ToolTip="[15] 내용" Description="[15] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport15">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport15" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[15] 중요여부" Description="[15] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText16">[16] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText16" runat="server" CssClass="form-control" Width="98%" ToolTip="[16] 내용" Description="[16] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport16">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport16" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[16] 중요여부" Description="[16] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText17">[17] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText17" runat="server" CssClass="form-control" Width="98%" ToolTip="[17] 내용" Description="[17] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport17">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport17" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[17] 중요여부" Description="[17] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText18">[18] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText18" runat="server" CssClass="form-control" Width="98%" ToolTip="[18] 내용" Description="[18] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport18">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport18" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[18] 중요여부" Description="[18] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText19">[19] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText19" runat="server" CssClass="form-control" Width="98%" ToolTip="[19] 내용" Description="[19] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport19">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport19" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[19] 중요여부" Description="[19] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText20">[20] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText20" runat="server" CssClass="form-control" Width="98%" ToolTip="[20] 내용" Description="[20] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport20">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport20" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[20] 중요여부" Description="[20] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                            <div class="form-group form-group-sm m-b-n">
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText21">[21] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText21" runat="server" CssClass="form-control" Width="98%" ToolTip="[21] 내용" Description="[21] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport21">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport21" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[21] 중요여부" Description="[21] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="txtText22">[22] 내용 :</asp:Label>
                                <div class="col-xs-3">
                                    <cc1:ExTextBox ID="txtText22" runat="server" CssClass="form-control" Width="98%" ToolTip="[22] 내용" Description="[22] 내용" Group="ExToolBar2_Save"></cc1:ExTextBox>
                                </div>
                                <asp:Label runat="server" CssClass="control-label col-xs-1" AssociatedControlID="rblImport22">중요여부 : </asp:Label>
                                <div class="col-xs-1">
                                    <cc1:ExRadioButtonList ID="rblImport22" runat="server" CssClass="radio" RepeatDirection="Horizontal" RepeatLayout="Flow" Enabled="false" ToolTip="[22] 중요여부" Description="[22] 중요여부" Group="ExToolBar2_Save">
                                        <asp:ListItem Value="Y" Text="Y"></asp:ListItem>
                                        <asp:ListItem Value="N" Text="N" Selected="True"></asp:ListItem>
                                    </cc1:ExRadioButtonList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="text-right">
                            <cc1:ExToolBar ID="ExToolBar2" runat="server" NewVisible="true" SaveVisible="true" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="form-group form-group-sm m-b-n">
                            <div class="col-xs-4">
                                <p class="txt bg-primary small">
                                    * 문장 내 유동적으로 삽입 할 내용은 아래 버튼을 이용하세요.
                                    <br>
                                    * 예:) {@버튼이름} 은 유동적인 텍스트를 삽입하게 됩니다.
                                </p>
                            </div>
                            <div class="col-xs-12">
                                <button type="button" name="btnGroup" class="btn btn-default btn-sm mb_5" style="width: 70px">등록계좌</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            
            if ($('#<%= rblSearchPrintGubun.ClientID %>_2').is(':checked') || $('#<%= rblSearchPrintGubun.ClientID %>_3').is(':checked')) {
                $('#MainContent_rblSearchPassGubun_0').prop('disabled', '');
                $('#MainContent_rblSearchPassGubun_1').prop('disabled', '');
            }
            else {
                $('#MainContent_rblSearchPassGubun_0').prop('disabled', 'disabled');
                $('#MainContent_rblSearchPassGubun_1').prop('disabled', 'disabled');
            }


            if ($('#<%= rblPrintGubun.ClientID %>_2').is(':checked') || $('#<%= rblPrintGubun.ClientID %>_3').is(':checked')) {

                if ($('#<%= txtApplyYear.ClientID %>').prop('readonly') == true) {
                    $('#MainContent_rblPassGubun_0').prop('disabled', 'disabled');
                    $('#MainContent_rblPassGubun_1').prop('disabled', 'disabled');
                }
                else {
                    $('#MainContent_rblPassGubun_0').prop('disabled', '');
                    $('#MainContent_rblPassGubun_1').prop('disabled', '');
                }

                $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').attr('readonly', true);
                $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').removeClass('hasDatepicker');
                $('#<%= txtPrintDate.ClientID %>').find('.ui-datepicker-trigger').addClass('hidden');

                $('#<%= txtText1.ClientID %>').prop('readonly', false);
                $('#<%= txtText2.ClientID %>').prop('readonly', false);
                $('#<%= txtText3.ClientID %>').prop('readonly', false);
                $('#<%= txtText4.ClientID %>').prop('readonly', false);
                $('#<%= txtText5.ClientID %>').prop('readonly', false);
                $('#<%= txtText6.ClientID %>').prop('readonly', false);
                $('#<%= txtText7.ClientID %>').prop('readonly', false);
                $('#<%= txtText8.ClientID %>').prop('readonly', false);
                $('#<%= txtText9.ClientID %>').prop('readonly', false);
                $('#<%= txtText10.ClientID %>').prop('readonly', false);
                $('#<%= txtText11.ClientID %>').prop('readonly', false);
                $('#<%= txtText12.ClientID %>').prop('readonly', false);
                $('#<%= txtText13.ClientID %>').prop('readonly', false);
                $('#<%= txtText14.ClientID %>').prop('readonly', false);
                $('#<%= txtText15.ClientID %>').prop('readonly', false);
                $('#<%= txtText16.ClientID %>').prop('readonly', false);
                $('#<%= txtText17.ClientID %>').prop('readonly', false);
                $('#<%= txtText18.ClientID %>').prop('readonly', false);
                $('#<%= txtText19.ClientID %>').prop('readonly', false);
                $('#<%= txtText20.ClientID %>').prop('readonly', false);
                $('#<%= txtText21.ClientID %>').prop('readonly', false);
                $('#<%= txtText22.ClientID %>').prop('readonly', false);

                $('#MainContent_rblImport1_0').prop('disabled', '');
                $('#MainContent_rblImport1_1').prop('disabled', '');
                $('#MainContent_rblImport2_0').prop('disabled', '');
                $('#MainContent_rblImport2_1').prop('disabled', '');
                $('#MainContent_rblImport3_0').prop('disabled', '');
                $('#MainContent_rblImport3_1').prop('disabled', '');
                $('#MainContent_rblImport4_0').prop('disabled', '');
                $('#MainContent_rblImport4_1').prop('disabled', '');
                $('#MainContent_rblImport5_0').prop('disabled', '');
                $('#MainContent_rblImport5_1').prop('disabled', '');
                $('#MainContent_rblImport6_0').prop('disabled', '');
                $('#MainContent_rblImport6_1').prop('disabled', '');
                $('#MainContent_rblImport7_0').prop('disabled', '');
                $('#MainContent_rblImport7_1').prop('disabled', '');
                $('#MainContent_rblImport8_0').prop('disabled', '');
                $('#MainContent_rblImport8_1').prop('disabled', '');
                $('#MainContent_rblImport9_0').prop('disabled', '');
                $('#MainContent_rblImport9_1').prop('disabled', '');
                $('#MainContent_rblImport10_0').prop('disabled', '');
                $('#MainContent_rblImport10_1').prop('disabled', '');
                $('#MainContent_rblImport11_0').prop('disabled', '');
                $('#MainContent_rblImport11_1').prop('disabled', '');
                $('#MainContent_rblImport12_0').prop('disabled', '');
                $('#MainContent_rblImport12_1').prop('disabled', '');
                $('#MainContent_rblImport13_0').prop('disabled', '');
                $('#MainContent_rblImport13_1').prop('disabled', '');
                $('#MainContent_rblImport14_0').prop('disabled', '');
                $('#MainContent_rblImport14_1').prop('disabled', '');
                $('#MainContent_rblImport15_0').prop('disabled', '');
                $('#MainContent_rblImport15_1').prop('disabled', '');
                $('#MainContent_rblImport16_0').prop('disabled', '');
                $('#MainContent_rblImport16_1').prop('disabled', '');
                $('#MainContent_rblImport17_0').prop('disabled', '');
                $('#MainContent_rblImport17_1').prop('disabled', '');
                $('#MainContent_rblImport18_0').prop('disabled', '');
                $('#MainContent_rblImport18_1').prop('disabled', '');
                $('#MainContent_rblImport19_0').prop('disabled', '');
                $('#MainContent_rblImport19_1').prop('disabled', '');
                $('#MainContent_rblImport20_0').prop('disabled', '');
                $('#MainContent_rblImport20_1').prop('disabled', '');
                $('#MainContent_rblImport21_0').prop('disabled', '');
                $('#MainContent_rblImport21_1').prop('disabled', '');
                $('#MainContent_rblImport22_0').prop('disabled', '');
                $('#MainContent_rblImport22_1').prop('disabled', '');
            }
            else {
                $('#MainContent_rblPassGubun_0').prop('disabled', 'disabled');
                $('#MainContent_rblPassGubun_1').prop('disabled', 'disabled');

                $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').attr('readonly', false);
                $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').addClass('hasDatepicker');
                $('#<%= txtPrintDate.ClientID %>').find('.ui-datepicker-trigger').removeClass('hidden');

                $('#<%= txtText1.ClientID %>').prop('readonly', true);
                $('#<%= txtText2.ClientID %>').prop('readonly', true);
                $('#<%= txtText3.ClientID %>').prop('readonly', true);
                $('#<%= txtText4.ClientID %>').prop('readonly', true);
                $('#<%= txtText5.ClientID %>').prop('readonly', true);
                $('#<%= txtText6.ClientID %>').prop('readonly', true);
                $('#<%= txtText7.ClientID %>').prop('readonly', true);
                $('#<%= txtText8.ClientID %>').prop('readonly', true);
                $('#<%= txtText9.ClientID %>').prop('readonly', true);
                $('#<%= txtText10.ClientID %>').prop('readonly', true);
                $('#<%= txtText11.ClientID %>').prop('readonly', true);
                $('#<%= txtText12.ClientID %>').prop('readonly', true);
                $('#<%= txtText13.ClientID %>').prop('readonly', true);
                $('#<%= txtText14.ClientID %>').prop('readonly', true);
                $('#<%= txtText15.ClientID %>').prop('readonly', true);
                $('#<%= txtText16.ClientID %>').prop('readonly', true);
                $('#<%= txtText17.ClientID %>').prop('readonly', true);
                $('#<%= txtText18.ClientID %>').prop('readonly', true);
                $('#<%= txtText19.ClientID %>').prop('readonly', true);
                $('#<%= txtText20.ClientID %>').prop('readonly', true);
                $('#<%= txtText21.ClientID %>').prop('readonly', true);
                $('#<%= txtText22.ClientID %>').prop('readonly', true);

                $('#MainContent_rblImport1_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport1_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport2_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport2_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport3_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport3_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport4_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport4_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport5_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport5_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport6_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport6_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport7_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport7_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport8_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport8_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport9_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport9_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport10_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport10_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport11_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport11_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport12_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport12_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport13_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport13_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport14_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport14_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport15_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport15_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport16_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport16_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport17_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport17_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport18_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport18_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport19_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport19_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport20_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport20_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport21_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport21_1').prop('disabled', 'disabled');
                $('#MainContent_rblImport22_0').prop('disabled', 'disabled');
                $('#MainContent_rblImport22_1').prop('disabled', 'disabled');
            }


            var $temp = '';
            $("input").focus(function () {
                $temp = $(this);
            });

             $(document).find("[name~=btnGroup]").each(function () {
                 $(this).on('click', function (e) {
                     if ($temp != '') {
                         if ($temp.prop('readonly') == false) {
                             var $button = $(this);
                             var obj = document.getElementById("[name~=btnGroup]");

                             var cursorPos = $temp.prop('selectionStart');
                             var v = $temp.val();
                             var textBefore = v.substring(0, cursorPos) + '{@' + $button.text() + '}';
                             var textAfter = v.substring(cursorPos, v.length);

                             $temp.val(textBefore + textAfter);
                             $temp.selectRange(textBefore.length, textBefore.length);
                             $temp.focus();
                         }
                         else {
                             alertMessage('텍스트를 입력할 수 없습니다.');
                         }
                     }
                     else {
                         alertMessage('텍스트 박스를 선택 해주세요.');
                     }
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


            $('#<%= rblSearchPrintGubun.ClientID %>').on('change', function () {
                if ($('#<%= rblSearchPrintGubun.ClientID %>_2').is(':checked') || $('#<%= rblSearchPrintGubun.ClientID %>_3').is(':checked')) {
                    $('#MainContent_rblSearchPassGubun_0').prop('disabled', '');
                    $('#MainContent_rblSearchPassGubun_1').prop('disabled', '');
                }
                else {
                    $('#MainContent_rblSearchPassGubun_0').prop('disabled', 'disabled');
                    $('#MainContent_rblSearchPassGubun_1').prop('disabled', 'disabled');
                }
            });

            $('#<%= rblPrintGubun.ClientID %>').on('change', function () {
                if ($('#<%= rblPrintGubun.ClientID %>_2').is(':checked') || $('#<%= rblPrintGubun.ClientID %>_3').is(':checked')) {

                    $('#MainContent_rblPassGubun_0').prop('disabled', '');
                    $('#MainContent_rblPassGubun_1').prop('disabled', '');

                    $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').attr('readonly', true);
                    $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').removeClass('hasDatepicker');
                    $('#<%= txtPrintDate.ClientID %>').find('.ui-datepicker-trigger').addClass('hidden');

                    $('#<%= txtText1.ClientID %>').prop('readonly', false);
                    $('#<%= txtText2.ClientID %>').prop('readonly', false);
                    $('#<%= txtText3.ClientID %>').prop('readonly', false);
                    $('#<%= txtText4.ClientID %>').prop('readonly', false);
                    $('#<%= txtText5.ClientID %>').prop('readonly', false);
                    $('#<%= txtText6.ClientID %>').prop('readonly', false);
                    $('#<%= txtText7.ClientID %>').prop('readonly', false);
                    $('#<%= txtText8.ClientID %>').prop('readonly', false);
                    $('#<%= txtText9.ClientID %>').prop('readonly', false);
                    $('#<%= txtText10.ClientID %>').prop('readonly', false);
                    $('#<%= txtText11.ClientID %>').prop('readonly', false);
                    $('#<%= txtText12.ClientID %>').prop('readonly', false);
                    $('#<%= txtText13.ClientID %>').prop('readonly', false);
                    $('#<%= txtText14.ClientID %>').prop('readonly', false);
                    $('#<%= txtText15.ClientID %>').prop('readonly', false);
                    $('#<%= txtText16.ClientID %>').prop('readonly', false);
                    $('#<%= txtText17.ClientID %>').prop('readonly', false);
                    $('#<%= txtText18.ClientID %>').prop('readonly', false);
                    $('#<%= txtText19.ClientID %>').prop('readonly', false);
                    $('#<%= txtText20.ClientID %>').prop('readonly', false);
                    $('#<%= txtText21.ClientID %>').prop('readonly', false);
                    $('#<%= txtText22.ClientID %>').prop('readonly', false);

                    $('#MainContent_rblImport1_0').prop('disabled', '');
                    $('#MainContent_rblImport1_1').prop('disabled', '');
                    $('#MainContent_rblImport2_0').prop('disabled', '');
                    $('#MainContent_rblImport2_1').prop('disabled', '');
                    $('#MainContent_rblImport3_0').prop('disabled', '');
                    $('#MainContent_rblImport3_1').prop('disabled', '');
                    $('#MainContent_rblImport4_0').prop('disabled', '');
                    $('#MainContent_rblImport4_1').prop('disabled', '');
                    $('#MainContent_rblImport5_0').prop('disabled', '');
                    $('#MainContent_rblImport5_1').prop('disabled', '');
                    $('#MainContent_rblImport6_0').prop('disabled', '');
                    $('#MainContent_rblImport6_1').prop('disabled', '');
                    $('#MainContent_rblImport7_0').prop('disabled', '');
                    $('#MainContent_rblImport7_1').prop('disabled', '');
                    $('#MainContent_rblImport8_0').prop('disabled', '');
                    $('#MainContent_rblImport8_1').prop('disabled', '');
                    $('#MainContent_rblImport9_0').prop('disabled', '');
                    $('#MainContent_rblImport9_1').prop('disabled', '');
                    $('#MainContent_rblImport10_0').prop('disabled', '');
                    $('#MainContent_rblImport10_1').prop('disabled', '');
                    $('#MainContent_rblImport11_0').prop('disabled', '');
                    $('#MainContent_rblImport11_1').prop('disabled', '');
                    $('#MainContent_rblImport12_0').prop('disabled', '');
                    $('#MainContent_rblImport12_1').prop('disabled', '');
                    $('#MainContent_rblImport13_0').prop('disabled', '');
                    $('#MainContent_rblImport13_1').prop('disabled', '');
                    $('#MainContent_rblImport14_0').prop('disabled', '');
                    $('#MainContent_rblImport14_1').prop('disabled', '');
                    $('#MainContent_rblImport15_0').prop('disabled', '');
                    $('#MainContent_rblImport15_1').prop('disabled', '');
                    $('#MainContent_rblImport16_0').prop('disabled', '');
                    $('#MainContent_rblImport16_1').prop('disabled', '');
                    $('#MainContent_rblImport17_0').prop('disabled', '');
                    $('#MainContent_rblImport17_1').prop('disabled', '');
                    $('#MainContent_rblImport18_0').prop('disabled', '');
                    $('#MainContent_rblImport18_1').prop('disabled', '');
                    $('#MainContent_rblImport19_0').prop('disabled', '');
                    $('#MainContent_rblImport19_1').prop('disabled', '');
                    $('#MainContent_rblImport20_0').prop('disabled', '');
                    $('#MainContent_rblImport20_1').prop('disabled', '');
                    $('#MainContent_rblImport21_0').prop('disabled', '');
                    $('#MainContent_rblImport21_1').prop('disabled', '');
                    $('#MainContent_rblImport22_0').prop('disabled', '');
                    $('#MainContent_rblImport22_1').prop('disabled', '');
                }
                else {
                    $('#MainContent_rblPassGubun_0').prop('disabled', 'disabled');
                    $('#MainContent_rblPassGubun_1').prop('disabled', 'disabled');

                    $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').attr('readonly', false);
                    $('#<%= txtPrintDate.ClientID %>' + '_dateTextBox').addClass('hasDatepicker');
                    $('#<%= txtPrintDate.ClientID %>').find('.ui-datepicker-trigger').removeClass('hidden');

                    $('#<%= txtText1.ClientID %>').prop('readonly', true);
                    $('#<%= txtText2.ClientID %>').prop('readonly', true);
                    $('#<%= txtText3.ClientID %>').prop('readonly', true);
                    $('#<%= txtText4.ClientID %>').prop('readonly', true);
                    $('#<%= txtText5.ClientID %>').prop('readonly', true);
                    $('#<%= txtText6.ClientID %>').prop('readonly', true);
                    $('#<%= txtText7.ClientID %>').prop('readonly', true);
                    $('#<%= txtText8.ClientID %>').prop('readonly', true);
                    $('#<%= txtText9.ClientID %>').prop('readonly', true);
                    $('#<%= txtText10.ClientID %>').prop('readonly', true);
                    $('#<%= txtText11.ClientID %>').prop('readonly', true);
                    $('#<%= txtText12.ClientID %>').prop('readonly', true);
                    $('#<%= txtText13.ClientID %>').prop('readonly', true);
                    $('#<%= txtText14.ClientID %>').prop('readonly', true);
                    $('#<%= txtText15.ClientID %>').prop('readonly', true);
                    $('#<%= txtText16.ClientID %>').prop('readonly', true);
                    $('#<%= txtText17.ClientID %>').prop('readonly', true);
                    $('#<%= txtText18.ClientID %>').prop('readonly', true);
                    $('#<%= txtText19.ClientID %>').prop('readonly', true);
                    $('#<%= txtText20.ClientID %>').prop('readonly', true);
                    $('#<%= txtText21.ClientID %>').prop('readonly', true);
                    $('#<%= txtText22.ClientID %>').prop('readonly', true);

                    $('#MainContent_rblImport1_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport1_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport2_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport2_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport3_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport3_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport4_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport4_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport5_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport5_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport6_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport6_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport7_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport7_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport8_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport8_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport9_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport9_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport10_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport10_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport11_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport11_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport12_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport12_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport13_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport13_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport14_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport14_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport15_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport15_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport16_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport16_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport17_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport17_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport18_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport18_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport19_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport19_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport20_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport20_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport21_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport21_1').prop('disabled', 'disabled');
                    $('#MainContent_rblImport22_0').prop('disabled', 'disabled');
                    $('#MainContent_rblImport22_1').prop('disabled', 'disabled');
                }
            });
        });
    </script>
</asp:Content>