<!DOCTYPE html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplSearchReportView.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplSearchReportView" %>

<html>
<head>
    <title>보고서출력</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link href="/Common/Styles/report/crownix-viewer.min.css" rel="stylesheet" />
    <script src="/Scripts/jquery-3.1.1.min.js"></script>
    <script src="/Scripts/report/crownix-viewer.min.js"></script>
    <script src="/Scripts/report/crownix-invoker.min.js"></script>
</head>
<body>
    <form id="Form1" runat="server">
        <div id="crownix-viewer" style="position: absolute; width: 100%; height: 100%"></div>
    </form>

    <input type="hidden" id="hidGubun" runat="server" />
    <input type="hidden" id="hidYear" runat="server" />
    <input type="hidden" id="hidSeason" runat="server" />
    <input type="hidden" id="hidRecpNo" runat="server" />
    <input type="hidden" id="hidMrdUrl" runat="server" />
    <input type="hidden" id="hidReportServiceUrl" runat="server" />
    <input type="hidden" id="hiNeisCode" runat="server" />

    <script type="text/javascript">
        $(document).ready(function () {
            var gubun = $('#<%= hidGubun.ClientID %>').val();
            var year = $("#<%=hidYear.ClientID%>").val();
            var season = $("#<%=hidSeason.ClientID%>").val();
            var recpNo = $('#<%= hidRecpNo.ClientID %>').val();
            var mrdUrl = $("#<%=hidMrdUrl.ClientID%>").val();
            var serviceUrl = $("#<%=hidReportServiceUrl.ClientID%>").val();
            var neisCode = $("#<%=hiNeisCode.ClientID%>").val();

            $.ajax({
                url: '/ENTR/StaffMngr/ApplSearchReportViewXml.aspx',
                data: {
                    'gubun': gubun,
                    'year': year,
                    'season': season,
                    'recpNo': recpNo,
                    'neisCode': neisCode,
                },
                method: 'GET',
                dataType: 'xml',
                cache: false
            }).done(function (data, textStatus, jqXHR) {
                var xmlString = '';
                if (data) {
                    if (typeof data === 'object') {
                        xmlString = new XMLSerializer().serializeToString(data);
                    }
                    else {
                        xmlString = data;
                    }
                    var viewer = new m2soft.crownix.Viewer(serviceUrl, 'crownix-viewer');
                    viewer.openFile(mrdUrl, '/rdata [' + xmlString + ']', { timeout: 180 });
                }
                console.log('done.');
            }).fail(function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
                console.log(errorThrown);
            }).always(function () { console.log('always.'); });
        });
    </script>
</body>
</html>