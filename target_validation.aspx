<%@ Page Language="C#" AutoEventWireup="true" CodeFile="target_validation.aspx.cs" Inherits="target_validation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head id="Head1" runat="server">
    <title></title>
    <link href="page.css" rel="stylesheet" type="text/css" />
     <link href="Scripts/jquery-ui-1.8.7.custom/css/smoothness/jquery-ui-1.8.7.custom.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    

    <script src="Scripts/jquery-ui-1.8.7.custom/js/jquery-ui-1.8.7.custom.min.js" type="text/javascript"></script>
    
     <script type="text/javascript">

     $(function () {
         $("input[id$='datepicker']").datepicker({ dateFormat: 'MM, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="container">

<div id="one_column" >
     
     <a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.location.reload();parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>
  <div style=" padding-left:20px;">

     <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
               

<h1>Target Management</h1>
<br />
               <asp:LinqDataSource ID="TargetsDataSource" runat="server" 
                ContextTypeName="IntranetDataDataContext" 
                TableName="monthly_targets"
                OnSelecting="TargetsDataSource_Selecting" EnableDelete="True" 
                EnableInsert="True" EnableUpdate="True">
            </asp:LinqDataSource>
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            InsertItemPosition="FirstItem"
            DataSourceID="TargetsDataSource">
        <ItemTemplate>
            <tr >
                        
                <td>
                    <%#Eval("target_date","{0:MMM yy}") %>
                </td>
               
                <td>
                    R<%# Eval("target_amount","{0:N2}") %>
                </td>
                <td>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete"  />
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
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                                
                                
                                
                                
                                <th id="Th3" runat="server">
                                    Month</th>
                                
                                   <th id="Th1" runat="server">
                                    Target Amount
                                </th>   
                                 <th id="Th5" runat="server">
                                   </th> 
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr >
                
                
                
                
                <td>
                   <asp:TextBox  placeholder="Click for Date..." ID="datepicker"  runat="server" Text='<%# Bind("target_date","{0:MMM yy}") %>' />
                </td>
                
                <td>
                    <asp:TextBox  ID="amount" runat="server" 
                        Text='<%# Bind("target_amount") %>' />        
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
                
            </tr>
        </EditItemTemplate>
          <InsertItemTemplate>
            <tr >
                
              <td>
                   <asp:TextBox   placeholder="Click for Date..." ID="datepicker"  runat="server" Text='<%# Bind("target_date") %>' />
                </td>
                
                <td>
                    <asp:TextBox  ID="amount" runat="server" 
                        Text='<%# Bind("target_amount") %>' />        
                </td>  
                <td>
                   
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
       
    </asp:ListView>









            </LoggedInTemplate>
            <AnonymousTemplate>
                <p>Not Logged in</p>
            </AnonymousTemplate>
            </asp:LoginView>



     </div>

 </div>
 </div>
    </div>
    </form>
</body>
</html>
