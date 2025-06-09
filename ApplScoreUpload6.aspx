<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplScoreUpload6.aspx.cs" Inherits="KJC.IMS.ENTR.StaffMngr.ApplScoreUpload6" MasterPageFile="~/Modal.Master" %>

<%@ Register Assembly="IFW.WebUI" Namespace="IFW.WebUI" TagPrefix="cc1" %>
<%@ Register Src="/COFF/CONTROL/SCFF/YearTermControl.ascx" TagPrefix="uc2" TagName="yt" %>
<%@ Register Assembly="KJC.IMS.COFF.COMM.BIZ" Namespace="KJC.IMS.COFF.COMM.BIZ" TagPrefix="cc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="subcont">
                <div class="table-filter">
            <div class="form-inline">

                <div class="form-group form-group-sm">
            <asp:Label runat="server" CssClass=" control-label" AssociatedControlID="txt연도조회">연도 :</asp:Label>
            <cc1:ExTextBox ID="txt연도조회" runat="server" Width="55px" ValidationType="Numeric" MaxLength="4" FixLength="4" CssClass="form-control text-center" Group="ExToolBar1_Search" Description="연도" ToolTip="연도" Required="true" ReadOnly="True"></cc1:ExTextBox>
        </div>
        <!-- 수험번호 -->
        <div class="form-group form-group-sm">
            <asp:Label runat="server" CssClass="control-label" AssociatedControlID="txt수험번호조회">수험번호 :</asp:Label>
            <cc1:ExTextBox ID="txt수험번호조회" runat="server" Width="150px" CssClass="form-control" Group="ExToolBar1_Search" Description="수험번호" ToolTip="수험번호" MaxLength="8" IsNegative="false" ReadOnly="True"></cc1:ExTextBox>
        </div>
        </div>
        </div>

        <div class="table-filter">
            <div class="form-inline">
                <div class="form-group form-group-sm">
                    <asp:Label runat="server" CssClass="control-label m-r-xs" Text="파일 :" AssociatedControlID="upload_file"></asp:Label>
                    <input id="upload_file" type="file" name="upload_file" runat="server" title="첨부파일" class="hidden" />
                    <div class="input-group">
                        <input type="text" onclick="$('#<%=upload_file.ClientID %>    ').click();" id="subfile" class="form-control" readonly style="width: 250px;" />
                        <span class="input-group-addon btn" onclick="$('#<%=upload_file.ClientID %>').click();" style="height: 30px; width: 80px">찾아보기</span>
                    </div>
                </div>
                <div class="form-group form-group-sm">
                    <cc1:ExToolBar ID="ExToolBar1" runat="server" Etc1Visible="true" Etc1CSS="btn btn-sm btn-success" Etc1Text="엑셀 내용 확인" />
                </div>
            </div>
        </div>



        <strong>< 유의사항 ></strong><br />
        <ol>            
            <li>업로드 샘플 파일을 다운로드해서 데이터를 입력하시기 바랍니다. (<a href="학생부 업로드 샘플파일2.xlsx" target="_blank">학생부 업로드 샘플파일2.xlsx</a>)
            </li>
            <li>엑셀내용확인를 누르면 입력될 내역이 나타납니다. 확인 후 최종 저장 하세요.
            </li>
            <li>반드시 입력한 성적의 갯수를 확인하시기 바랍니다.
            </li>
            <li>성적을 저장하면 기존 성적을 모두 삭제하고 입력합니다.
            </li>
        </ol>

        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title pull-left grdList">성적 엑셀 리스트</h3>
                        <cc1:ExDataCounter ID="ExDataCounter" runat="server" />
                    </div>
                    <div class="panel-body p-n">
                        <div id="MainContent_ComDivScroll1" onscroll="document.getElementById('MainContent_ComDivScroll1_value').value = this.scrollTop" style="width: 2000px; height: 580px; overflow-y: visible; cursor: pointer;">
                            <cc1:ExGridView ID="grdList" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered " SelectedRowStyle-CssClass="active"
                                ShowHeaderWhenEmpty="true" ShowHeader="true" ShowRowNumber="true" TableSummary="장학생 엑셀 리스트" TableCaption="장학생 관리(모달)" ShowRowNumberWidth="60">
                                <Columns>
                                    <%--1--%><asp:BoundField HeaderText="연도" DataField="ApplYear" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                                    <%--2--%><asp:BoundField HeaderText="학년" DataField="Grade" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--3--%><asp:BoundField HeaderText="학기" DataField="Term" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--4--%><asp:BoundField HeaderText="편제코드" DataField="OrganizationCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--5--%><asp:BoundField HeaderText="편제명" DataField="OrganizationName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--6--%><asp:BoundField HeaderText="교과코드" DataField="CourceCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--7--%><asp:BoundField HeaderText="교과명" DataField="CourceName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--8--%><asp:BoundField HeaderText="과목코드" DataField="SubjectCode" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--9--%><asp:BoundField HeaderText="과목명" DataField="SubjectName" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--10--%><asp:BoundField HeaderText="단위" DataField="Unit" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--11--%><asp:BoundField HeaderText="석차" DataField="Rank" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--12--%><asp:BoundField HeaderText="학생수" DataField="StudentCount" HeaderStyle-Width="" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-left" />
                                    <%--15--%><asp:BoundField DataField="SeqNumber" HeaderStyle-CssClass="skip" ItemStyle-CssClass="skip" />
                                </Columns>
                            </cc1:ExGridView>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <div class="text-right">
                            <cc1:ExToolBar ID="ExToolBar2" runat="server" SaveVisible="true" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#<%=upload_file.ClientID%>").on("change", function ()
            {
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

                confirmMessage("파일 Upload를 수행 하시겠습니까?", $btnUpload);

                return rValue;

            });
        });
    </script>
</asp:Content>