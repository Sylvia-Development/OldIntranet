<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="asset_damages_popup.aspx.cs" Inherits="asset_damages_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="titleDiv">
<h1> 
    <asp:Label ID="titleLabel" runat="server" Text=""></asp:Label>   
</h1>
</div>
 <asp:ListView ID="AssetDamagesListView" runat="server" DataKeyNames="id" 
        InsertItemPosition="FirstItem"
        OnItemInserting="asset_damages_ItemInserting"
         OnItemInserted="asset_damages_ItemInserted"
        DataSourceID="AssetDamagesDataSource" 
           OnDataBound="page_load_finish">
        <ItemTemplate>
                
            <tr >
                 
                <td > <%# GetOpenTag(Eval("still_applicable"))%> <%# Eval("description") %><%# GetCloseTag(Eval("still_applicable"))%></td>
                <td > <%#Eval("date_logged", "{0:ddd, d MMM, yyyy - H:mm}")%></td>
                <td > <%#Eval("user_logged") %></td>
                <td><asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" /></td>
                
            </tr>
            
        </ItemTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                <td colspan="4">
                    <asp:TextBox  Width="70%" ID="messageTextBox" runat="server" Text='<%# Bind("description") %>' />
                 
                   
                
              
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Add Note" />
                    
                </td>
                
                
                
                
            </tr>
        </InsertItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server"  class="themeContent">
                <tr>
                    <td>
                        No damage reported.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EditItemTemplate>





            <tr class="editrow">
 

                <td >
                    <asp:TextBox    ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' />
                     
                </td>
                <td > <%#Eval("date_logged", "{0:ddd, d MMM, yyyy - H:mm}")%></td>
                <td > <%#Eval("user_logged") %></td>
 
                <td class="TDwithButtons"   align="center" >
                
                  <div style=" float:right;">
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                        <asp:CheckBox ID="CheckBox4"  runat="server" Text="Still Valid" Checked='<%# Bind("still_applicable") %>'  />

                        

                    </div>    
                </td>
                
            </tr>






        </EditItemTemplate>
        
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="AssetDamagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="True" TableName="asset_damages"
        OnSelecting="AssetDamagesDataSource_Selecting">
</asp:LinqDataSource>








</asp:Content>

