<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="asset_notes_popup.aspx.cs" Inherits="asset_notes_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="titleDiv">
<h1> 
    <asp:Label ID="titleLabel" runat="server" Text=""></asp:Label>   
</h1>
</div>
 <asp:ListView ID="AssetNotesListView" runat="server" DataKeyNames="id" 
        InsertItemPosition="FirstItem"
        OnItemInserting="asset_note_ItemInserting"
         OnItemInserted="asset_note_ItemInserted"
        DataSourceID="AssetNotesDataSource" 
           OnDataBound="page_load_finish">
        <ItemTemplate>
                
            <tr >
                 
                <td > <%# Eval("audit_note") %></td>
                <td > <%#Eval("date", "{0:ddd, d MMM, yyyy - H:mm}")%></td>
                <td > <%#Eval("logged_by") %></td>
  
                
            </tr>
            
        </ItemTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                <td colspan="3">
                    <asp:TextBox  Width="70%" ID="messageTextBox" runat="server" Text='<%# Bind("audit_note") %>' />
                 
                   
                
              
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Add Note" />
                    
                </td>
                
                
                
                
            </tr>
        </InsertItemTemplate>
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
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        
       
    </asp:ListView>
   
  

    <asp:LinqDataSource ID="AssetNotesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="asset_audit_notes"
        OnSelecting="AssetNotesDataSource_Selecting">
</asp:LinqDataSource>






</asp:Content>

