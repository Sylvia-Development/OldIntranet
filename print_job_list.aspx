<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print_job_list.aspx.cs" Inherits="print_job_list" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>..</title>
    <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () { window.print(); });


        setTimeout(function () { window.close() }, 1);
       

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

     <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
    <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="back0"  OnLoad="getClientSectionName" ></asp:Label> 
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
                            <tr id="Tr2" runat="server" style="background-color:Gray;  font-size:11pt; color:White;">  
                                <th id="Th1"    align="left"  runat="server"><font size="1">Description of task</font></th>
                                <th  align="center" ><font size="1">Completed</font></th>
                                
                               
                                
                                    
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
