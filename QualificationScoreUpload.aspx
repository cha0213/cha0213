<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QualificationScoreUpload.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.QualificationScoreUpload" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- 파일 업로드 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title pull-left"><span class="glyphicon glyphicon-upload c06" aria-hidden="true"></span>검정고시 성적 이관</h3>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="txtApplyYear">지원연도 :</asp:Label>
                    <div class="col-xs-10 form-inline">
                        <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control" ReadOnly="true" Width="55px" FixLength="4" ToolTip="지원연도" Description="지원연도" Required="true" Group="ExToolBar1_Save"></cc1:ExTextBox>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="ddlApplSeason">지원시기 :</asp:Label>
                    <div class="col-xs-10 form-inline">
                        <cc1:ExDropDownList ID="ddlApplSeason" runat="server" CssClass="form-control" Enabled="false" CodeType="_공통" P1="SA02" Width="100px" BindMode="Select" Required="true" Group="ExToolBar1_Save" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" Text="파일 :" AssociatedControlID="upload_file"></asp:Label>
                    <div class="col-xs-10">
                        <input id="upload_file" type="file" name="upload_file" runat="server" title="첨부파일" class="hidden" />
                        <div class="input-group" style="width:600px">
                            <input type="text" onclick="$('#<%=upload_file.ClientID %>').click();" id="subfile" class="form-control" readonly/>
                            <span class="input-group-addon btn" onclick="$('#<%=upload_file.ClientID %>').click();">찾아보기</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">  
            <div class="text-right">                           
                <cc1:ExToolBar id="ExToolBar1" runat="server" SaveVisible="True" SaveText="검정고시 성적 이관"></cc1:ExToolBar>                                
            </div>
        </div>
    </div>

    <script type="text/javascript">  
  
        // 시간이 오래 걸리는 관계로 Spiner 를 사용하기 위해..
        function confirmMessage2(msg, $obj) {
           
            var agent = navigator.userAgent.toLowerCase();

            if (typeof (window.parent.getTopPanelHeight) == "function") {
                var TabPanelScrollHeight = window.parent.getTopPanelHeight();

                
                var box = bootbox.confirm({
                    title: confirmTitle,
                    message: msg,
                    callback: function (confirmed) {
                        if (confirmed) {
                            $obj.off('click');
                            $obj.trigger('click');
                        }  
                        else
                        {
                            parent.stopSpin();
                        }
                    }
                , show: false
                });

                box.on("shown.bs.modal", function (e) {
                    if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) || agent.search("edge/") > -1) {
                        window.parent.setTopPanelHeight(0);
                    }
                    else {
                        // IE 가 아닐경우..
                        TabPanelScrollHeight = window.parent.getTopPanelHeight();
                        $(document).find('.modal-content').css({ 'margin-top': TabPanelScrollHeight })
                    }
                });

                box.on("hide.bs.modal", function () {
                    window.parent.setTopPanelHeight(TabPanelScrollHeight);                    
                });

                box.modal('show');
            }
            else {
                var box = bootbox.confirm({
                    title: confirmTitle,
                    message: msg,
                    callback: function (confirmed) {
                        if (confirmed) {
                            $obj.off('click');
                            $obj.trigger('click');
                        }
                        else
                        {
                            parent.stopSpin();
                        }
                    }
                });
            }
        }

        $(document).ready(function () {  

             $("#<%=upload_file.ClientID%>").on("change", function ()
             {
                 // 파일 확장자 체크
                 var ext = $(this).val().split('.').pop().toLowerCase();
                 if(ext != 'db3')
                 {
                     alertMessage('검정고시 성적 업로드 파일을 확인하세요. [.db3] 확장자 파일만 업로드 가능합니다.');
                     $(this).val('');
                     return false;
                 }
                 
                $("#subfile").val($(this).val());
            });

            $('#<%= ExToolBar1.ClientID %>' + '_Save').on('click', function (e) {
                var rValue = false;
                var $btnUpload = $(this);

                var $upload_file = $("#<%=upload_file.ClientID%>");

                if($upload_file.val() == "")
                {
                    alertMessage("파일을 선택 하세요.");
                    return false;
                }
                
                parent.startSpin();
                confirmMessage2("이관 하려는 데이터의 용량에 따라 다소 시간이 소요 될 수 있습니다.<br/>검정고시 성적 이관 작업을 수행 하시겠습니까?", $btnUpload);
                
                return rValue;

            });
        });
    </script>
        
    <input type="hidden" id="hdnFilePath" runat="server" />
    <input type="hidden" id="hdnFileName" runat="server" />
</asp:Content>
