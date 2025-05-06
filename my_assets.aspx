<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="my_assets.aspx.cs" Inherits="my_assets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    $(function () {



        $('.bookinButton').click(function () {

            if (confirm('Are you sure the asset has been returned?') == true) {

                var $this = $(this), // the button clicked
             $thisRow = $this.closest('tr'), // the buttons row
             $thisAssetBookoutId = $thisRow.find('.assetBookoutIdHolder');
                $thisAssetUser = $thisRow.find('.assetUser');
                $thisAssetOwner = $thisRow.find('.assetAssetOwner');
                $thisAssetBorrower = $thisRow.find('.assetAssetBorrower');



                $.ajax({
                    type: "POST",
                    url: "my_assets.aspx/bookIn",
                    data: '{pAssetBookoutId: ' + $thisAssetBookoutId.val() + ',pUser: "' + $thisAssetUser.val() + '",pAssetOwner:" ' + $thisAssetOwner.val() + '",pAssetBorrower: "' + $thisAssetBorrower.val() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            } else {
                return;

            }

        });



        $('.team_DropDownList').change(function () {


            var $this = $(this), // dropdown that changed
             $thisRow = $this.closest('tr'), // the dropdowns row
             $thisAssetId = $thisRow.find('.assetIdHolder');
            $thisAssetUser = $thisRow.find('.assetUser');
            $thisAssetOwner = $thisRow.find('.assetAssetOwner');
            $thisAssetDescription = $thisRow.find('.assetDescription');
            $thisAssetBorrower = $this.val();


            if (confirm('Are you sure you want to book item out to ' + $thisAssetBorrower + '?') == true) {




                $.ajax({
                    type: "POST",
                    url: "my_assets.aspx/bookOut",
                    data: '{pAssetId: ' + $thisAssetId.val() + ',pUser: "' + $thisAssetUser.val() + '",pAssetOwner:" ' + $thisAssetOwner.val() + '",pAssetBorrower: "' + $thisAssetBorrower + '",pAssetDescription: "' + $thisAssetDescription.val() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: OnSuccess,
                    failure: function (response) {
                        alert(response.d);
                    }
                });

            } else {
                return;

            }


        });
    });

    function OnSuccess(response) {
        saveScroll();
        location.reload();
    }
 
 </script>


<h1>Assets I've borrowed</h1>
 <asp:ListView ID="BorrowedAssetListView" runat="server" DataKeyNames="id" 
        DataSourceID="BorrowedAssetDataSource" >
        <ItemTemplate>
                
            <tr >
                
                
                <td > <%# Eval("asset_item.id") %></td>
                <td > <%# Eval("asset_item.description") %></td>
                <td > <%#Eval("asset_item.notes") %></td>
                <td > <%# Eval("asset_item.asset_group.description")%></td>
                <td > <%#Eval("date_out","{0:ddd, d MMM, yyyy}") %></td>
                <td > <%#Eval("asset_item.current_status")%></td>
                
                
                
                <td class="TDwithButtons">
                     <a  href="asset_notes_popup.aspx?pItemId=<%# Eval("asset_item.id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                     </a> &nbsp&nbsp  <a  href="asset_damages_popup.aspx?pItemId=<%# Eval("asset_item.id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/responses.png" title="damages"/>
                     </a> &nbsp&nbsp

                     <asp:TextBox Width="1%" style="display:none;"  ID="assetBookoutIdHolder" class="assetBookoutIdHolder" runat="server" Text='<%# Eval("id")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetUser" class="assetUser" runat="server" Text='<%# Page.User.Identity.Name%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetAssetOwner" class="assetAssetOwner" runat="server" Text='<%# Eval("asset_item.asset_group.description")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetAssetBorrower" class="assetAssetBorrower" runat="server" Text='<%# Eval("booked_to")%>' />
                    <asp:Button ID="bookinButton" class="bookinButton" OnClientClick="return false;" runat="server" CommandName="Bookin" Text="Book In" />
                  
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        There are no assets that you have borrowed.</td>
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
                                <th>Notes</th>
                                <th>Borrowed From</th>
                                <th>Date Borrowed</th>
                                
                                <th>Status</th>
                                
                                <th>&nbsp</th>
                            
                                
                                
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
    
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="BorrowedAssetDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="asset_bookouts"
        OnSelecting="BorrowedAssetDataSource_Selecting">
</asp:LinqDataSource>
<br />
<h1>Assets I've leant out</h1>
 <asp:ListView ID="LeantAssetListView" runat="server" DataKeyNames="id" 
        DataSourceID="LeantAssetDataSource" >
        <ItemTemplate>
                
            <tr >
                
                
                <td > <%# Eval("asset_item.id") %></td>
                <td > <%# Eval("asset_item.description") %></td>
                <td > <%#Eval("asset_item.notes") %></td>
                <td > <%# Eval("booked_to")%></td>
                <td > <%#Eval("date_out","{0:ddd, d MMM, yyyy}") %></td>
                <td > <%#Eval("asset_item.current_status")%></td>
                
                
                
                <td class="TDwithButtons">
                     <a  href="asset_notes_popup.aspx?pItemId=<%# Eval("asset_item.id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                     </a>
                     &nbsp&nbsp  <a  href="asset_damages_popup.aspx?pItemId=<%# Eval("asset_item.id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/responses.png" title="damages"/>
                     </a> &nbsp&nbsp

                     <asp:TextBox Width="1%" style="display:none;"  ID="assetBookoutIdHolder" class="assetBookoutIdHolder" runat="server" Text='<%# Eval("id")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetUser" class="assetUser" runat="server" Text='<%# Page.User.Identity.Name%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetAssetOwner" class="assetAssetOwner" runat="server" Text='<%# Eval("asset_item.asset_group.description")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetAssetBorrower" class="assetAssetBorrower" runat="server" Text='<%# Eval("booked_to")%>' />
                    <asp:Button ID="bookinButton" class="bookinButton" OnClientClick="return false;" runat="server" CommandName="Bookin" Text="Book In" />
                  
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        There are no assets that you have leant out.</td>
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
                                <th>Notes</th>
                                <th>Leant To</th>
                                <th>Date Leant Out</th>
                                
                                <th>Status</th>
                                
                                <th>&nbsp</th>
                            
                                
                                
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
    
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="LeantAssetDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="asset_bookouts"
        OnSelecting="LeantAssetDataSource_Selecting">
</asp:LinqDataSource>

<br />
<h1>Assets I am responsisble for</h1>
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
               
                <td > <%#Eval("current_status") %></td>
                <td > <%#Eval("notes") %></td>
                
                
                <td class="TDwithButtons">
                     <a  href="asset_notes_popup.aspx?pItemId=<%# Eval("id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                     </a>
                     &nbsp&nbsp  <a  href="asset_damages_popup.aspx?pItemId=<%# Eval("id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/responses.png" title="damages"/>
                     </a> &nbsp&nbsp
                     
                   <a href="javascript:void(0)" class="linkButton" onclick="toggle_visibility(<%# Eval("id")%>)">
                        Book Out
                     </a>
                    
                    
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetIdHolder" class="assetIdHolder" runat="server" Text='<%# Eval("id")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetUser" class="assetUser" runat="server" Text='<%# Page.User.Identity.Name%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetAssetOwner" class="assetAssetOwner" runat="server" Text='<%# Eval("asset_group.description")%>' />
                     <asp:TextBox Width="1%" style="display:none;"  ID="assetDescription" class="assetDescription" runat="server" Text='<%# Eval("description")%>' />
                     
               
               
                     <div id="<%# Eval("id")%>"   style="display:none;">
                       
                        
                         <asp:DropDownList ID="team_DropDownList" class="team_DropDownList" Width="100%" 
                                                     DataSourceID = "teamLinqDataSource" 
                                                      DataValueField = "UserName"  
                                                      DataTextField="UserName"   
                                                      runat="server">
                            
                        </asp:DropDownList>
                            
                         
                       
                        
                    
                     </div>








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
        
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="AssetItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="asset_items"
        OnSelecting="AssetItemsDataSource_Selecting">
</asp:LinqDataSource>
 <asp:LinqDataSource ID="teamLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="aspnet_Users"
         OnSelecting ="team_info_selecting">
    </asp:LinqDataSource>


   







</asp:Content>

