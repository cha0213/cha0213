<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplGuideMsgPopUP.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplGuideMsgPopUP"  MasterPageFile="~/Modal.Master" %>


<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
        <div class="panel-body" style="height: 550px">
            <asp:Label ID="lblInfoMessage" runat="server" CssClass="form-control-static"></asp:Label>
        </div>
    </div>
</asp:Content>