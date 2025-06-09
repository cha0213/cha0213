<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplDuplicationStatistics.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplDuplicationStatistics" MasterPageFile="~/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>

<%--<%@ Register Src="/COFF/CONTROL/COFF/ReportControl.ascx" TagPrefix="uc2" TagName="report" %>--%>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="~/COFF/CONTROL/COFF/ReportEmbeddedViewer.ascx" TagPrefix="uc1" TagName="rv" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
        <div class="table-filter">
            <div class="form-inline" id="divPrint">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="txtSearchApplyYear">연도  :</asp:Label>
                    <cc1:ExTextBox ID="txtSearchApplyYear" runat="server" Width="55px" MaxLength="4" FixLength="4" CssClass="form-control" Group="ExToolBar1_Etc1" Description="년도" Required="true"></cc1:ExTextBox>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="ddlSearchApplySeason">지원시기 :</asp:Label>
                    <cc1:ExDropDownList ID="ddlSearchApplySeason" runat="server" Width="180px" ToolTip="지원시기" Description="지원시기" Required="true" BindMode="All" CodeType="_공통" P1="SA02" Group="ExToolBar1_Etc1"></cc1:ExDropDownList>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" AssociatedControlID="rblPrintGubun">출력 구분 : </asp:Label>
                    <cc1:ExRadioButtonList ID="rblPrintGubun" runat="server" CssClass="radio-inline" ToolTip="출력 구분" Description="출력 구분" Group="ExToolBar1_Etc1" RepeatDirection="Horizontal" RepeatLayout="Flow">
                        <asp:ListItem Value="1" Text="현황" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="2" Text="지원자 리스트"></asp:ListItem>
                    </cc1:ExRadioButtonList>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1Text="인쇄" Etc1CSS="btn btn-default btn-sm" />
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" Etc2Visible="true" Etc2Text="엑셀" Etc2CSS="btn btn-sm btn-default" />
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-body p-n">
                <cc2:ComDivScroll ID="ExScrollBar" runat="server" ReportViewer="true">
                    <uc1:rv ID="rv1" runat="server"></uc1:rv>
                </cc2:ComDivScroll>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {

        });
    </script>

    <%--<uc2:report ID="Report1" runat="server" />--%>
</asp:Content>