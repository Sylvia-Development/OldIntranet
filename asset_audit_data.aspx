<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="asset_audit_data.aspx.cs" Inherits="asset_audit_data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<script type="text/javascript">
    $(function () {
        $('.StatusDropDownList').change(function () {


            var $this = $(this), // the drop down that changed
             $thisRow = $this.closest('tr'), // the drop down's row

             $assetId = $thisRow.find('.assetIdHolder');
            $auditItemId = $thisRow.find('.auditItemIdHolder');
            $auditUser = $thisRow.find('.auditUserHolder');
            $currentStatus = $thisRow.find('.currentStatusHolder');
            $auditStatus = $this.val();


            $.ajax({
                type: "POST",
                url: "asset_audit_data.aspx/auditItem",
                data: '{pAssetId: ' + $assetId.val() + ',pAuditItemId:' + $auditItemId.val() + ',pAuditUser:"' + $auditUser.val() + '",pCurrentStatus:"' + $currentStatus.val() + '",pAuditStatus:"' + $auditStatus + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                }
            });



        });
    });
    function OnSuccess(response) {

        saveScroll();
        location.reload();
    }
 </script>


 <h1> 
    Asset Audit of <asp:Label ID="titleLabel" runat="server" Text=""></asp:Label>   
</h1>
<br />

  <asp:ListView ID="AssetAuditListView" runat="server" DataKeyNames="id" 
        DataSourceID="AssetAuditDataSource" 
        OnDataBound="page_load_finish">
        <ItemTemplate>
                
            <tr >
                
                
                <td > <%# Eval("item_id") %></td>
                <td > <%# Eval("asset_item.description") %></td>
                <td > <%#Eval("asset_item.current_status")%></td>
                <td>
                 <asp:DropDownList ID="StatusDropDownList" class="StatusDropDownList" Width="100%" runat="server">
                            <asp:ListItem Value="" Text="<< Select Status >>"></asp:ListItem>
                            <asp:ListItem Value="Confirmed" Text="Confirmed"></asp:ListItem>
                            <asp:ListItem Value="To Be Repaired" Text="To Be Repaired"></asp:ListItem>
                            <asp:ListItem Value="To Be Replaced" Text="To Be Replaced"></asp:ListItem>
                            <asp:ListItem Value="Archived" Text="Archived"></asp:ListItem>
                        </asp:DropDownList>
                     <asp:TextBox Width="1%" style="display:none;"  ID="TextBox1" class="assetIdHolder" runat="server" Text='<%# Eval("item_id")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="TextBox4" class="auditItemIdHolder" runat="server" Text='<%# Eval("id")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="TextBox2" class="auditUserHolder" runat="server" Text='<%# Page.User.Identity.Name%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="TextBox3" class="currentStatusHolder" runat="server" Text='<%# Eval("asset_item.current_status")%>' />
                  </td>   
               
                
                
                
                <td class="TDwithButtons">
                     <a  href="asset_notes_popup.aspx?pItemId=<%# Eval("item_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                     </a>
                      &nbsp&nbsp  <a  href="asset_damages_popup.aspx?pItemId=<%# Eval("item_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/responses.png" title="damages"/>
                     </a> &nbsp&nbsp

                    
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        There are no more assets in this group to audit.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                                
                                <th >Asset Id</th>
                                <th >Description</th>
                                <th>Current Status</th>
                                
                                <th colspan="2">&nbsp</th>
                                
                                
                            
                                
                                
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
    
       
    </asp:ListView>
     <asp:LinqDataSource ID="AssetAuditDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="asset_audit_items"
        OnSelecting="AssetAuditDataSource_Selecting">
</asp:LinqDataSource>

</asp:Content>

