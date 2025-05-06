<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print_delivery_note.aspx.cs" Inherits="print_delivery_note" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="Scripts/jquery-1.4.4.min.js" type="text/javascript"></script>
    <script type="text/javascript">

       $(document).ready(  setTimeout(function () { window.print() },1000) );


       setTimeout(function(){window.close()},1000);
        


       

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>

     <asp:LoginView ID="LoginView2" runat="server">
    <LoggedInTemplate>
    <br />
    <table width="98%">
        <tr>    
            <td align="right"> 
                <img  src="Images/Blu-line_Logo.jpg" />   
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Label runat="server" Font-Names="Arial" Font-Bold="true" Font-Size="X-Large" ID="Label3">Delivery Note & Packing List</asp:Label><br />
            </td>
        </tr>
        <tr><td>&nbsp</td></tr>
        <tr>
            <td align="center">
               <table ID="table1" cellpadding="3"  border="1" 
                            style=" background-color:transparent; width:98%; border-collapse: collapse;border-color: #999999;border-style:outset;border-width:2px;font-size:medium; font-family: Verdana, Arial, Helvetica, sans-serif;">
                    <tr>
                        <td style="width:49%;">
                            <font style="font-family:Arial;" size="3"><u>Dispatched From :</u></font><br />
                            <font style="font-family:Arial;" size="2">
                            blu_line kitchens (Pty)Ltd<br />
                            7 Mastiff Rd<br />
                            Linbro Business Park<br />
                            Sandton 2090<br />
                            Johannesburg<br />
                            South Africa<br /> 
                                </font>

                        </td>
                        <td style="width:49%; vertical-align:top">
                            <font style="font-family:Arial;" size="3"><u>Delivery Address :</u></font><br />
                             <font style="font-family:Arial;" size="2">
                             <%Response.Write(GetDeliveryAddress(Page.Request.QueryString["pSectionId"]));%>


                                

                                 </font>
                        </td>

                    </tr>
                    <tr>
                     <td align="left"  >
                       <font style="font-family:Arial;" size="3"> Client Reference :</font><font style="font-family:Arial;" size="2">  <%Response.Write(GetClientRef(Page.Request.QueryString["pSectionId"]));%>  </font>
                        
                     </td>
                        <td>

                            &nbsp
                        </td>
                    </tr>
                    <tr>
                     <td align="left"  >
                         
                        <font style="font-family:Arial;" size="3">Dispatch Event : </font><font style="font-family:Arial;" size="2"> <%Response.Write(GetDispatchEvent(Page.Request.QueryString["pEvent"]));%></font>

        
                    </td>
                         <td align="left"  >
                       <font style="font-family:Arial;" size="3"> Total Packages :</font><font style="font-family:Arial;" size="2">  <%Response.Write(GetPackageCount());%>  </font>
                        
                     </td>
                </tr>
                <tr>
                    <td colspan="2">

                        <asp:ListView ID="WallsListView" runat="server" DataKeyNames="id" 
            DataSourceID="WallsDataSource" >
        <ItemTemplate>
                
                
            <asp:Label ID="hiddenWallIdLabel" Visible="false" runat="server" Text='<%# Eval("wall_id") %>' />


                <li >
                   
                    <asp:Label ID="wallLabel" runat="server" Font-Size="Medium" Text='<%# Eval("wall.wall_label") %>' />  
                    
                  
                   
                 </li>

           <asp:ListView ID="PackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="packagesDataSource">
        <ItemTemplate>
            <tr >
                
                <td style="width:10%">1</td>
                <td style="width:20%">
                    <asp:Label ID="packageID" runat="server" Text='<%# Eval("id") %>' />
                </td>
                
                <td style="width:50%">
                    <asp:Label ID="packageDescription" runat="server" Text='<%# Eval("description") %>' />

                </td>
                <td style="width:10%">
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("job_list_item.id") %>' />

                </td>
                <td style="width:10%">
                    &nbsp

                </td>
                         
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Data</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            <table  cellpadding="3"  border="1" id="itemPlaceholderContainer" runat="server"
                            style=" background-color:transparent; width:98%; border-collapse: collapse;border-color: #999999;border-style:outset;border-width:2px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                 
                       <tr><th>Qty</th>
                           <th>Code</th>
                           <th>Package Description</th>
                           <th>Order</th>
                           <th>&nbsp</th>

                       </tr>
                           
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
       
       
    </asp:ListView>
<asp:LinqDataSource ID="packagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="packageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
        <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenWallIdLabel" Name="wallId" PropertyName="Text" Type="Int32" />
        </SelectParameters>      
</asp:LinqDataSource>

            <br />
               
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <br />
            <br />
            No Wall Data
                  <br />
            <br />      
                
        </EmptyDataTemplate>
       
        <LayoutTemplate>
           
                        <ul style="margin-left:00px" ID="itemPlaceholderContainer" runat="server" >   
                            <li ID="itemPlaceholder" runat="server"></li>
                        </ul>
                    
        </LayoutTemplate>
       
       
    </asp:ListView>

<asp:LinqDataSource ID="WallsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="WallsDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">

</asp:LinqDataSource>

                    </td>



                </tr>
                     
                    <tr>
                     <td align="left"  >
                         
                        <font style="font-family:Arial;" size="3">Delivered By Name : &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp </font><font style="font-family:Arial;" size="1">Date:</font>

        
                    </td>
                         <td>

                            Signature :
                        </td>
                </tr>
                   <tr>
                     <td align="left"  >
                         
                        <font style="font-family:Arial;" size="3">Received By Name : &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp </font><font style="font-family:Arial;" size="1">Date:</font>

        
                    </td>
                         <td>

                            Signature :
                        </td>
                </tr>




                </table>     
            </td>
        </tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>&nbsp</td></tr>
        <tr><td>&nbsp</td></tr>
       
        <tr>
            <td align="center">

                <font style="font-family:Arial;" size="3">**************************  BELOW FOR INFORMATION PURPOSES ONLY **************************</font>

            </td>

        </tr>
       
        <tr><td>&nbsp</td></tr>

        <tr>
            <td align="center">

       <asp:ListView ID="OrdersListView" runat="server" DataKeyNames="id" 
            DataSourceID="ordersDataSource">
        <ItemTemplate>
            <tr >
                
                <td style="width:20%"> <asp:Label ID="Label1" runat="server" Text='<%# Eval("job_list_item.id") %>' /></td>
                <td style="width:80%">
                  

                     <asp:Image ID="high_pri_image" Visible='<%# Eval("job_list_item.is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                        <%#Eval("job_list_item.description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("job_list_item.user_logged") %> - <%#Eval("job_list_item.date_logged","{0:ddd, d MMM, yyyy}") %> </font>
                </td>
                
               
                         
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Data</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            <table  cellpadding="3"  border="1" id="itemPlaceholderContainer" runat="server"
                            style=" background-color:transparent; width:98%; border-collapse: collapse;border-color: #999999;border-style:outset;border-width:2px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                 
                      
                           
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
       
       
    </asp:ListView>
<asp:LinqDataSource ID="ordersDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="ordersDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">   
</asp:LinqDataSource>

            </td>

        </tr>
       
   
</table>

   




       



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
