<!DOCTYPE html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplSearchReportPeriodCheck.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplSearchReportPeriodCheck" %>

<html>
<head>
    <title>출력물</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding: 10px; margin-bottom: 5px !important; color: #31708f; background-color: #d9edf7; border-color: #bce8f1; border: 1px solid transparent; border-radius: 4px; box-sizing: border-box;">
            <strong style="color: #153166 !important; width: 60%">※
                <asp:Label ID="lblInfo" runat="server"></asp:Label>
            </strong>
        </div>
    </form>

    <input type="hidden" id="hidGubun" runat="server" />
    <input type="hidden" id="hidYear" runat="server" />
    <input type="hidden" id="hidSeason" runat="server" />
    <input type="hidden" id="hidRecpNo" runat="server" />
</body>
</html>