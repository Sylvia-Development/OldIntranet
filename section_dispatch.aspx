<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_dispatch.aspx.cs" Inherits="section_dispatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
    <script type="text/javascript">

    
   



    function ConfirmCloseEvent()
    {
      var x = confirm("Are you sure you want to close this Dispatch Event?");
      if (x) {

          document.getElementById('sectionLink').click();
          return true;
          
      }
      else {
          return false;
      }
    }

</script>


        <div class="titleDiv">
         <h1>Dispatch Packages for :  <%Response.Write(GetClientNameSection(Page.Request.QueryString["pSectionId"]));%></h1>
            <br />
            <br />
    <a id="sectionLink" href="section_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > << Back To Section Page</a>
    </div>
    <div>
    <br />
        <br />
        <p>
            <asp:Label runat="server" ID="scanResult"></asp:Label>
        </p>
        <asp:Label runat="server" ForeColor="White" ID="Label1">Scan Barcode to Disaptch Package : </asp:Label>
            <asp:TextBox ID="barcode" ClientIDMode="Static" TabIndex="-1" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="Dispatch" OnClick="Dispatch_Click" />
        
    <br />
    <br />
        </div>
    <div>
        
            <table ID="table1" cellpadding="3"  border="1" 
                            style=" background-color:transparent; width:98%; border-collapse: collapse;border-color: #999999;border-style:outset;border-width:2px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2"  style="background-color:Gray;  font-size:11pt; color:Black;">  

                                <th style="width:32%" align="center" ><font size="3">PACKAGES BEING MANUFACTURED</font></th>
                               
                                <th style="width:32%" align="center" ><font size="3">PACKAGES READY FOR DISPATCH</font></th>
                             
                                <th style="width:32%" align="center" ><font size="3">PACKAGES DISPATCHED</font></th>
                                
                              
                                    
                            </tr>
                            <tr >
                                <td style="vertical-align:top;border-style:outset;border-width:2px;"> 
                                    
         <asp:ListView ID="BeingManufacturedListView" runat="server" DataKeyNames="id" 
            DataSourceID="beingManufacturedDataSource" >
        <ItemTemplate>
            <tr >
                
                
                <td style="width:90px">
                    <asp:Label ID="packageID" runat="server" Text='<%# Eval("id") %>' />
                </td>
                
                <td>
                    <asp:Label ID="wallDescr" runat="server" Text='<%# Eval("wall.wall_label") %>' />
                -
                    <asp:Label ID="packageDescription" runat="server" Text='<%# Eval("description") %>' />
                </td>
                <td>
                   <a href="javascript:void(0)" title="<%# Eval("job_list_item.description") %>" >  <%# Eval("job_list_order_id") %></a>

                </td>
                <td align="center" nowrap>
                     &nbsp&nbsp
                    <a  href="package_dispatch_log_popup.aspx?pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="logs" />
                        </a> 
                
                     &nbsp&nbsp

                  


                </td>
                
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        <asp:Label runat="server" ForeColor="#666666" ID="Label1">No Packages ready for this Section</asp:Label>
                            
                            </td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="100%" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
      
       
    </asp:ListView>

           </td>
                                <td style="vertical-align:top;border-style:outset;border-width:2px;">





           <asp:ListView ID="PackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="packagesDataSource" >
        <ItemTemplate>
            <tr >
                
                
                <td style="width:90px">
                    <asp:Label ID="packageID" runat="server" Text='<%# Eval("id") %>' />
                </td>
                
                <td>
                    <asp:Label ID="wallDescr" runat="server" Text='<%# Eval("wall.wall_label") %>' />
                -
                    <asp:Label ID="packageDescription" runat="server" Text='<%# Eval("description") %>' />
                </td>
                <td>
                  <a href="javascript:void(0)" title="<%# Eval("job_list_item.description") %>" >  <%# Eval("job_list_order_id") %></a>

                </td>
                <td align="center" nowrap>
                     &nbsp&nbsp
                    <a  href="package_dispatch_log_popup.aspx?pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="logs" />
                        </a> 
                
                     &nbsp&nbsp

                  


                </td>
                
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        <asp:Label runat="server" ForeColor="#666666" ID="Label1">No Packages ready for this Section</asp:Label>
                            
                            </td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="100%" runat="server" border="0" class="tableSpacing paddedTable themeContent"  >
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
      
       
    </asp:ListView>

           






                                </td>
                                <td style="vertical-align:top;border-style:outset;border-width:2px;">
                                    
<asp:ListView ID="DispatchEventListView" runat="server" DataKeyNames="id" 
            DataSourceID="EventsDataSource" 
     OnItemDataBound="DispatchEventListView_ItemDataBound">
        <ItemTemplate>
                
                
            <asp:Label ID="hiddenEventLabel" Visible="false" runat="server" Text='<%# Eval("dispatch_event") %>' />


                <li >
                   
                    <asp:Label ID="eventLabel" runat="server" Font-Size="Larger" Text='' /> 
                        
                    <div style="float:right;">
                        
                        <a runat="server" id="deliveryNoteLink" href="" target="_blank"  onclick="return ConfirmCloseEvent();" > </a>
                    </div>
                   
                 </li>
        
                                    
                                    
                                    
                                    
    <asp:ListView ID="DispatchedPackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="dispatchedPackagesDataSource" >
        <ItemTemplate>
            <tr >
                
                
                <td style="width:90px">
                    <asp:Label ID="packageID" runat="server" Text='<%# Eval("id") %>' />
                </td>
                <td>
                    <asp:Label ID="wallDescr" runat="server" Text='<%# Eval("wall.wall_label") %>' />
                -
                    <asp:Label ID="packageDescription" runat="server" Text='<%# Eval("description") %>' />
                </td>
               <td>
                 <a href="javascript:void(0)" title="<%# Eval("job_list_item.description") %>" >  <%# Eval("job_list_order_id") %></a>

                </td>

                    <td align="center" nowrap>
                    &nbsp&nbsp
                    <a  href="package_dispatch_log_popup.aspx?pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="logs" />
                        </a> 
               &nbsp&nbsp


                  
                    
                    
                    
                </td>
                 
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table>
                <tr>
                    <td>
                        No Packages Verifed for this section

                    </td>
                </tr>
                </table>
            
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="100%" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
      
       
    </asp:ListView>
   
 <asp:LinqDataSource ID="dispatchedPackagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="dispatchedPackageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
        <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenEventLabel" Name="eventID" PropertyName="Text" Type="String" />
        </SelectParameters>
        
    </asp:LinqDataSource>

             <br />
               
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <br />
            <br />
            <asp:Label runat="server" >No Dispatch Events</asp:Label>
                  <br />
            <br />      
                
        </EmptyDataTemplate>
       
        <LayoutTemplate>
           
                        <ul style="margin-left:20px" ID="itemPlaceholderContainer" runat="server" >   
                            <li ID="itemPlaceholder" runat="server"></li>
                        </ul>
                    
        </LayoutTemplate>
       
       
    </asp:ListView>

                                    








        </td>
    </tr>
</table>


   
    <asp:LinqDataSource ID="packagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="packageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
       
        
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="beingManufacturedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="beingManufacturedDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
       
        
    </asp:LinqDataSource>
   
</div>
   
  <asp:LinqDataSource ID="EventsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="EventsDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
    </asp:LinqDataSource>

    








<script type="text/javascript">
    setTimeout(function () { document.getElementById('barcode').focus(); }, 10);

</script>

</asp:Content>

