<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="asset_lookup.aspx.cs" Inherits="asset_lookup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script runat="server">
void CommandBtn_Click(Object sender, CommandEventArgs e) 
      {

          
          Response.Redirect("asset_lookup.aspx?pAssetId=" + pAssetId.Text);
    
         

              

        

      }

</script>

    Asset Id :
    
    <asp:TextBox  name="pAssetId" ID="pAssetId" runat="server"/>
    
     
    <asp:Button ID="LookupButton" runat="server" OnCommand="CommandBtn_Click"  CommandName="Lookup" 
                        Text="Lookup" />

<br />
<br />
 <asp:ListView ID="AssetItemsListView" runat="server" DataKeyNames="id" 
        DataSourceID="AssetItemsDataSource" 
        
         OnItemUpdating = "asset_items_ItemUpdating"
          OnItemUpdated="asset_items_ItemUpdated">
        <ItemTemplate>
                
            <tr >
                
                
                <td > <%# Eval("id") %></td>
                <td > <%# Eval("description") %></td>
                <td > <%# Eval("purchase_price") %></td>
                <td > <%#Eval("purchase_date","{0:ddd, d MMM, yyyy}") %></td>
                <td > <%#Eval("asset_class.description") %></td>
                <td > <%#Eval("asset_group.description") %></td>
                <td > <%#Eval("current_status") %></td>
                <td > <%#Eval("notes") %></td>
                
                
                <td class="TDwithButtons">
                     <a  href="asset_notes_popup.aspx?pItemId=<%# Eval("id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                     </a>
                      &nbsp&nbsp  <a  href="asset_damages_popup.aspx?pItemId=<%# Eval("id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/responses.png" title="damages"/>
                     </a> &nbsp&nbsp
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
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
                                <th>Purchase Price</th>
                                <th>Purchase Date</th>
                                <th>Asset Class</th>
                                <th>Asset Group</th>
                                <th>Status</th>
                                <th>Notes</th>
                                <th>&nbsp</th>
                            
                                
                                
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
               
                     <td ><asp:TextBox ID="TextBox1" runat="server" 
                            Text='<%# Bind("id") %>' 
                             
                             Enabled="false"/> 
                            
                            </td>
                     <td >
                        <asp:TextBox ID="descriptionTextBox" runat="server" 
                            Text='<%# Bind("description") %>' 
                             
                            Width="100%"/>
                    </td>  
                    <td >
                        <asp:TextBox ID="priceTextBox" runat="server" 
                            Text='<%# Bind("purchase_price") %>' 
                             
                            Width="100%"/>
                    </td>  
                     <td>
                       <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("purchase_date","{0:ddd, d MMM, yyyy}") %>'  Width="100%"/> 
                    </td>     
                   
                    <td>
                        <asp:DropDownList ID="class_DropDownList" Width="100%" 
                                                      DataSourceID = "AssetClassesLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      SelectedValue='<%# Bind("class_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                        
                    </td>   
                
                    <td>
                        <asp:DropDownList ID="Group_DropDownList" Width="100%" 
                                                      DataSourceID = "AssetGroupsLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      SelectedValue='<%# Bind("group_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                        
                    </td>   
                    <td >
                       <asp:DropDownList ID="DropDownList1" Width="100%"  
                                               
                                                      SelectedValue='<%# Bind("current_status") %>'
                                                      
                                                      runat="server">
                            <asp:ListItem Value="Confirmed" Text="Confirmed"></asp:ListItem>
                            <asp:ListItem Value="To Be Repaired" Text="To Be Repaired"></asp:ListItem>
                            <asp:ListItem Value="To Be Replaced" Text="To Be Replaced"></asp:ListItem>
                            <asp:ListItem Value="Archived" Text="Archived"></asp:ListItem>
                        </asp:DropDownList>


                       
                    </td>  
                

                    <td>
                        <asp:TextBox ID="notes_TextBox" runat="server" 
                            Text='<%# Bind("notes") %>' 
                             
                            Width="100%"/>
                    </td>
                    
               
                
               
                
                <td class="TDwithButtons">
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                        
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="AssetItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="asset_items"
        OnSelecting="AssetItemsDataSource_Selecting">
</asp:LinqDataSource>

 <asp:LinqDataSource ID="AssetClassesLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" Select="new (id, description)" 
        TableName="asset_classes">
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="AssetGroupsLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" OrderBy="description" 
        Select="new (id, description)" 
        TableName="asset_groups">
    </asp:LinqDataSource>


</asp:Content>

