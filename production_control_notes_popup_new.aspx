<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="production_control_notes_popup_new.aspx.cs" Inherits="production_control_notes_popup_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--    a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>--%>
 <div style="background:white; color:black">
 <span style="color:black"> Notes for : <%= GetJobInfo().Replace("\n", "<br/>")%></span>
  
  <br />
  <br />
    <asp:ListView ID="ProductionNotesListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProductionNotesDataSource" 
         InsertItemPosition="FirstItem"
        OnItemInserting="production_notes_ItemInserting"
         OnItemInserted="production_notes_ItemInserted">
        <ItemTemplate>
                
             <tr >

               
               <td>
                   <asp:Label Width="80%" ID="messageLabel" runat="server" Text='<%# Eval("note_description") %>' />
                </td>
                <td>
                    <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("date_logged") %>' />
                </td>
                
                <td>
                    <asp:Label ID="user_nameLabel" runat="server" Text='<%# Eval("user_logged") %>' />
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        There are no notes for this item.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="themeContent" >
                       
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
         <InsertItemTemplate>
            <tr class="insertrow" >
                <td colspan="3">
                
                
                    <asp:TextBox TextMode="MultiLine" Columns="100" Rows="3" Width="98%" CssClass="ui-corner-all ui-widget" ID="messageTextBox" runat="server" Text='<%# Bind("note_description") %>' />
                <br />
                    <div style="text-align:right;">
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Add Note" />
                    </div>
                </td>
                
                
                
                
            </tr>
        </InsertItemTemplate>

        
    </asp:ListView>

<asp:LinqDataSource ID="ProductionNotesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="True" TableName="production_control_notes"
        OnSelecting="production_notes_DataSource_Selecting">
</asp:LinqDataSource>
</div>
</asp:Content>

