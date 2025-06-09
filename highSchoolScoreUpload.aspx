<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="highSchoolScoreUpload.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.highSchoolScoreUpload" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- 파일 업로드 -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title pull-left"><span class="glyphicon glyphicon-upload c06" aria-hidden="true"></span>고교학생부 이관</h3>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div class="form-horizontal">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="txtApplyYear">지원연도 :</asp:Label>
                    <div class="col-xs-10 form-inline">
                        <cc1:ExTextBox ID="txtApplyYear" runat="server" CssClass="form-control" ReadOnly="true" Width="55px" FixLength="4" ToolTip="지원연도" Description="지원연도" Required="true" Group="ExToolBar1_Save;ExToolBar2_Delete"></cc1:ExTextBox>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="ddlApplSeason">지원시기 :</asp:Label>
                    <div class="col-xs-10 form-inline">
                        <cc1:ExDropDownList ID="ddlApplSeason" runat="server" CssClass="form-control" Enabled="false" CodeType="_공통" P1="SA02" Width="100px" BindMode="Select" Required="true" Group="ExToolBar1_Save;ExToolBar2_Delete" ToolTip="지원시기" Description="지원시기"></cc1:ExDropDownList>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="col-xs-2 control-label" AssociatedControlID="upload_file"><strong style="color:red;">*</strong>파일 : </asp:Label>
                    <div class="col-xs-10">
                        <input id="upload_file" type="file" name="upload_file" runat="server" title="첨부파일" class="hidden" />
                        <div class="input-group" style="width: 600px">
                            <input type="text" onclick="$('#<%=upload_file.ClientID %>    ').click();" id="subfile" class="form-control" readonly />
                            <span class="input-group-addon btn" onclick="$('#<%=upload_file.ClientID %>').click();">찾아보기</span>
                        </div>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label col-xs-2" AssociatedControlID="chkGubun1">항목 : </asp:Label>
                    <div class="col-xs-10">
                        <cc1:ExCheckBox ID="chkGubun1" runat="server" CssClass="checkbox" Text="학생기본정보" Checked="true" />
                        <cc1:ExCheckBox ID="chkGubun2" runat="server" CssClass="checkbox" Text="인적사항" Checked="true" />
                        <cc1:ExCheckBox ID="chkGubun3" runat="server" CssClass="checkbox" Text="출결사항" Checked="true" />
                        <cc1:ExCheckBox ID="chkGubun4" runat="server" CssClass="checkbox" Text="교과학습발달상황" Checked="true" />
                        <cc1:ExCheckBox ID="chkGubun5" runat="server" CssClass="checkbox" Text="학적사항" />
                        <cc1:ExCheckBox ID="chkGubun6" runat="server" CssClass="checkbox" Text="수상경력" />
                        <cc1:ExCheckBox ID="chkGubun7" runat="server" CssClass="checkbox" Text="자격증" />
                        <cc1:ExCheckBox ID="chkGubun8" runat="server" CssClass="checkbox" Text="진로지도상황" />
                        <cc1:ExCheckBox ID="chkGubun9" runat="server" CssClass="checkbox" Text="창의적재량활동상황" />
                        <cc1:ExCheckBox ID="chkGubun10" runat="server" CssClass="checkbox" Text="특별활동상황" />
                        <cc1:ExCheckBox ID="chkGubun11" runat="server" CssClass="checkbox" Text="창의적체험활동상황" />
                        <cc1:ExCheckBox ID="chkGubun12" runat="server" CssClass="checkbox" Text="봉사활동실적" />
                        <cc1:ExCheckBox ID="chkGubun13" runat="server" CssClass="checkbox" Text="교외체험학습상황" />
                        <cc1:ExCheckBox ID="chkGubun14" runat="server" CssClass="checkbox" Text="과년도성적" />
                        <cc1:ExCheckBox ID="chkGubun15" runat="server" CssClass="checkbox" Text="세부능력" />
                        <cc1:ExCheckBox ID="chkGubun16" runat="server" CssClass="checkbox" Text="독서활동상황" />
                        <cc1:ExCheckBox ID="chkGubun17" runat="server" CssClass="checkbox" Text="행동특성" />
                        <cc1:ExCheckBox ID="chkGubun18" runat="server" CssClass="checkbox" Text="정정대장" />
                    </div>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <div class="row">
                <div class="col-xs-6 text-left">
                    <cc1:ExToolBar ID="ExToolBar2" runat="server" DeleteVisible="true" />
                    <cc1:ExToolBar ID="ExToolBar3" runat="server" Etc1Visible="true" Etc1CSS="btn btn-sm btn-primary" Etc1Text="성적산출로 이관" />
                </div>
                <div class="col-xs-6 text-right">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" SaveVisible="True" SaveText="고교학생부 이관"></cc1:ExToolBar>
                </div>
            </div>
        </div>
    </div>
    <div class="alert alert-info">
        <strong class="c03">※ 고교학생부 이관 처리에는 많은 시간이 소요 됩니다.
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;이관 항목별로 나뉘어서 처리하길 권장 합니다. (특히 '교과학습발달상황')<br />
            &nbsp;&nbsp;&nbsp;&nbsp;처리 속도 문제로 인하여, 중복에 대한 체크를 수행 하지 않습니다.<br />
            &nbsp;&nbsp;&nbsp;&nbsp;데이터가 잘 못 입력 되었을 경우, [삭제] 버튼을 통해 모두 삭제 후 다시 수행 하세요.<br />
        </strong>
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
                    alertMessage('고교학생부 업로드 파일을 확인하세요. [.db3] 확장자 파일만 업로드 가능합니다.');
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
                confirmMessage2("이관 하려는 데이터의 용량에 따라 다소 시간이 소요 될 수 있습니다.<br />고교학생부 이관 작업을 수행 하시겠습니까?", $btnUpload);

                return rValue;

            });

            $('#<%= ExToolBar2.ClientID %>_Delete').on('click', function(){
                confirmMessage('삭제 하시겠습니까?', $(this));
                return false;
            });

            $('#<%= ExToolBar3.ClientID %>_Etc1').on('click', function(){
                confirmMessage('이관한 고교학생부 데이터를 성적산출을 위해 이관 하시겠니까?<br />기존 데이터가 존재시 삭제 후 이관 됩니다.', $(this));
                return false;
            });
        });
    </script>

    <input type="hidden" id="hdnFilePath" runat="server" />
    <input type="hidden" id="hdnFileName" runat="server" />
</asp:Content>