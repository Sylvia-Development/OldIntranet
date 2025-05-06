<%@ Page Language="C#" AutoEventWireup="true" CodeFile="production_control_notes_popup.aspx.cs" Inherits="production_control_notes_popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="page.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <div id="container">

<div id="one_column" >

  <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
   

<a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>
  
  Notes for : <%= GetJobInfo().Replace("\n", "<br/>")%>
  
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
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                       
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
         <InsertItemTemplate>
            <tr class="insertrow" >
                <td colspan="3">
                
                
                    <asp:TextBox TextMode="MultiLine" Columns="100" Rows="3" Width="95%" ID="messageTextBox" runat="server" Text='<%# Bind("note_description") %>' />
                <br />
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Add Note" />
                    
                </td>
                
                
                
                
            </tr>
        </InsertItemTemplate>

        
    </asp:ListView>

<asp:LinqDataSource ID="ProductionNotesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="True" TableName="production_control_notes"
        OnSelecting="production_notes_DataSource_Selecting">
</asp:LinqDataSource>
 </LoggedInTemplate>
    
    <AnonymousTemplate>
    
    
    <div align="center">
    <br /><br />
       You are not Logged in anymore!
        
     </div>  
    
    
    </AnonymousTemplate>
    
 </asp:LoginView>




 </div>






 </div>
    </div>
    </form>
</body>
</html>
