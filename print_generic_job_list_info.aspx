<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print_generic_job_list_info.aspx.cs" Inherits="print_generic_job_list_info" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(setTimeout(function () { window.print() }, 1000));      


        setTimeout(function () { window.close() }, 1000);
       

    </script>
    <title>..</title>
</head>
<body>
    <form id="form1" runat="server">
     <div>

     <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
        <div style="float:right"><img src="Images/OCD_Logo.jpg" /></div>
        <br /><br /><br />

    <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="Larger" ID="back0"  OnLoad="getClientSectionName" ></asp:Label> 
    <br />
    <br />
    <asp:ListView ID="PrintListView" runat="server" DataKeyNames="id" 
        DataSourceID="PrintDataSource">
        <ItemTemplate>
                
            <tr style="background-color:white;color: #000000;">

                
                <td style="width:80%;">
                    <b>Internal Order No: <%# Eval("id")%></b><br /><br />
                      <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <%#Eval("order_no")%><br /><br />
                    <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %>  </font><br />
                    <font size="1" color="grey"> Authorised by:<%# Eval("manager_processed_name")%> - <%#Eval("manager_processed_date", "{0:ddd, d MMM, yyyy}")%></font>

     

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
                                <th id="Th1"    align="left"  runat="server"><font size="1">&nbsp</font></th>
                                
                               
                                
                                    
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
