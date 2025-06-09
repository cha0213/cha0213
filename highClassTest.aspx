<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highClassTest.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highClassTest" MasterPageFile="/Page.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>
<%@ Register Src="/COFF/CONTROL/COFF/BootstrapModalControl.ascx" TagPrefix="uc1" TagName="Modal" %>

<%--헤더--%>
<asp:Content ID="header" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<%--바디--%>
<asp:Content ID="Contents" ContentPlaceHolderID="MainContent" runat="server">
    <%--내용시작--%>
    <div class="subcont">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title pull-left"><span class="glyphicon glyphicon-upload c06" aria-hidden="true"></span>수능자료 업데이트</h3>
                <div class="clearfix"></div>
            </div>
            <div class="panel-body">
                <div class="form-horizontal">
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="txtApplyYear">지원연도 :</asp:Label>
                        <div class="col-xs-10 form-inline">
                            <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control text-center" Width="60px" FixLength="4" ValidationType="Numeric" ToolTip="지원연도" Description="지원연도" Required="true" Group="ExToolBar1_Save"></cc1:ExTextBox>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="ddlApplSeason">지원시기 :</asp:Label>
                        <div class="col-xs-10 form-inline">
                            <cc1:ExDropDownList ID="ddlApplSeason" runat="server" CssClass="form-control"  CodeType="_공통" P1="SA02" Width="200px" BindMode="Select" Required="true" Group="ExToolBar1_Save" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                        </div>
                    </div>
                    <div class="form-group form-group-sm">
                        <asp:Label runat="server" CssClass="col-xs-2 control-label" Text="파일 :" AssociatedControlID="upload_file"></asp:Label>
                        <div class="col-xs-10">
                            <input id="upload_file" type="file" name="upload_file" runat="server" title="첨부파일" class="hidden" />
                            <div class="input-group" style="width:600px">
                                <input type="text" onclick="$('#<%=upload_file.ClientID %>      ').click();" id="subfile" class="form-control" readonly/>
                                <span class="input-group-addon btn" onclick="$('#<%=upload_file.ClientID %>').click();">찾아보기</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-footer">  
                <div class="text-right">                           
                    <cc1:ExToolBar id="ExToolBar1" runat="server" SaveVisible="True" SaveText="수능자료 업데이트"></cc1:ExToolBar>                                
                </div>
            </div>
        </div>
        <div class="alert alert-info">
            <strong class="c03">* 정시 모집시 수시합격자도 같이 수능자료 업데이트해야 함. Pass IN ('09','01','02')</strong>
        </div>

    </div>
   

    <script type="text/javascript">
        
        $(document).ready(function () {
            $("#<%=upload_file.ClientID%>").on("change", function () {
                $("#subfile").val($(this).val());
            });

            $('#<%= ExToolBar1.ClientID %>_Save').on('click', function () {
                var rValue = false;
                var $btnUpload = $(this);

                var $upload_file = $("#<%=upload_file.ClientID%>");

                if($upload_file.val() == "")
                {
                    alertMessage("파일을 선택 하세요.");
                    return false;
                }

                confirmMessage("수능자료 업데이트를 수행 하시겠습니까?", $btnUpload);

                return rValue;
            });
        });
    </script>
</asp:Content>