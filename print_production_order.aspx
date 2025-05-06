<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print_production_order.aspx.cs" Inherits="print_production_order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>..</title>
    <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">

       $(document).ready(  setTimeout(function () { window.print() },1000) );


     setTimeout(function(){window.close()},1000);
        


       

    </script>
</head>
<body >
    <form id="form1" runat="server">
    <div>

     <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
    <br />
    <table width="95%">
    <tr>    
      <td   align="right"> 
       

            <asp:Label runat="server" Font-Names="Arial" ForeColor="#999999" Font-Bold="true" Font-Size="Large" ID="Label4">OCDsystems</asp:Label><br />
      
      
      
      </td>
    </tr>
        <tr>
<td align="center">
        <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="Label3">Production Order</asp:Label><br />
    </td>

        </tr>
    <tr>
    <td align="left">
        <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="Label2"   >Order No : <%Response.Write(Page.Request.QueryString["itemId"]); %></asp:Label><br />
    </td>
    </tr>
    <tr>
    <td align="left">
    <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="Label1"  Text="Client Name :" ></asp:Label> <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="back0"  OnLoad="getClientSectionName" ></asp:Label> 
    </td>
    </tr>
    </table>
    <br />
    <br />
    <asp:ListView ID="PrintListView" runat="server" DataKeyNames="id" 
        DataSourceID="PrintDataSource">
        <ItemTemplate>
                
            <tr style="background-color:white;color: #000000;">

                
                <td style="width:90%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>

                </td>
                
                
                
              
                <td   align="center">
                
                   &nbsp
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td colspan="2">
                       No Items to Print</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="1" 
                            style=" background-color: #FFFFFF; width:95%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"    align="left"  runat="server"><font size="3">Description</font></th>
                                <th  align="center" ><font size="3"></font></th>
                                
                               
                                
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
      
        
    </asp:ListView>

<asp:LinqDataSource ID="PrintDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="job_list_items"
        OnSelecting="print_DataSource_Selecting">
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
    </form>
</body>
</html>
