<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="job_list_notes_popup_new.aspx.cs" Inherits="job_list_notes_popup_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
    <div style="background:white; color:black; padding:3px;">
        <br />
        <br />

     Notes for : <%= GetJobListInfo().Replace("\n", "<br/>")%>
  <hr border="5px white solid"/>
  <br />
<div style="background:white;">
     <asp:ListView ID="JobListNotesListView" runat="server" DataKeyNames="id" 
        DataSourceID="JobListNotesDataSource" 
         InsertItemPosition="FirstItem"
        OnItemInserting="job_list_notes_ItemInserting"
         OnItemInserted="job_list_notes_ItemInserted">
         <InsertItemTemplate>
            <tr class="insertrow" >
                <td colspan="3">
                
                
                    <asp:TextBox TextMode="MultiLine" Columns="100" Rows="3" Width="98%" ID="messageTextBox" runat="server" Text='<%# Bind("note_description") %>' CssClass="ui-corner-all" />
                <br />
                   <div style="margin-right:10px; text-align:right;"> <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Add Note" /></div>
                    
                </td>
                
                
                
                
            </tr>
        </InsertItemTemplate>
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
            <table id="Table1" runat="server"  >
                <tr>
                    <td>
                        There are no notes for this item.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                       
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
         

        
    </asp:ListView>

<asp:LinqDataSource ID="JobListNotesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="True" TableName="job_list_item_notes"
        OnSelecting="job_list_notes_DataSource_Selecting">
</asp:LinqDataSource>
</div>
</div>
</asp:Content>

