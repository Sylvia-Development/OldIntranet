<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print_single_package_barcode.aspx.cs" Inherits="print_single_package_barcode" %>

<!DOCTYPE html>

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
        
    
    <asp:ListView ID="PrintListView" runat="server" DataKeyNames="id" 
        DataSourceID="PrintDataSource">
        <ItemTemplate>
            
        
         
            
            <div style="float:left; padding-left:80px;"><img src="<%# GetBarcodeLogo(Eval("wall.section.client.client_id")) %>" /></div>
       
         <div>
            <font size="4px" face="Arial" color="black">    
            <br />
           <br />
            
            <b><%# Eval("wall.section.client.job_name")%>-<%# Eval("wall.section.section_name")%></b>
            
            <br />

            <b><%# Eval("wall.wall_label")%></b>
            
          <br />
            

            <b><%# Eval("description")%></b>

            
            <br />
            </font>
             </div>  
       <div style="padding-left:57px;">
        <font size="2px" face="Arial" color="black">
           <b> <%Response.Write(Page.Request.QueryString["pType"]);%> - <%# Eval("job_list_order_id")%></b>
            
        </font>
                </div>
            
    <div style="padding-left:1px;">
            
        <img src="/ASPBarcodeGenerator.aspx?text=<%# Eval("id")%>& 
            bt=11&talign=4&fsize=14&fbold=0&w=250&h=100&ccheck=no&stext=yes" width="350" height="40">       
    </div>
        
                     
                    

     

                
                
                
                
              
               
                
            
            
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
         <div ID="itemPlaceholder" runat="server">


         </div>
                       
                   
        </LayoutTemplate>
      
        
    </asp:ListView>

<asp:LinqDataSource ID="PrintDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="section_dispatch_items"
        OnSelecting="print_DataSource_Selecting">
</asp:LinqDataSource>

    </LoggedInTemplate>
    
    <AnonymousTemplate>
    
    
    <div align="center">
    <br /><br />
       You are not Logged In anymore!
        
     </div>  
    
    
    </AnonymousTemplate>
    
 </asp:LoginView>



    
    </div>
    </form>
</body>
</html>
