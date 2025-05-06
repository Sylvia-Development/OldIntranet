<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_verify_dispatch.aspx.cs" Inherits="section_verify_dispatch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">



        <div class="titleDiv">
         <h1>Verify Packages for :  <%Response.Write(GetClientNameSection(Page.Request.QueryString["pSectionId"]));%></h1>
            <br />
            <br />
    <a href="section_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > << Back To Section Page</a>
    </div>
    <div>
    <br />
        <br />
        <p>
            <asp:Label runat="server" ID="scanResult"></asp:Label>
        </p>
        <asp:Label runat="server" ForeColor="White" ID="Label1">Scan Barcode to Verify Package Ready for Dispatch : </asp:Label>
            <asp:TextBox ID="barcode" ClientIDMode="Static" TabIndex="-1" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="Verify" OnClick="Verify_Click" />
        
    <br />
    <br />
        </div>
    <div>
        
            <table ID="table1" cellpadding="3"  border="1" 
                            style=" background-color:transparent; width:98%; border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2"  style="background-color:Gray;  font-size:11pt; color:Black;">  
                               
                                <th style="width:49%" align="center" ><font size="3">PACKAGES BEING MANUFACTURED</font></th>
                             
                                <th style="width:49%" align="center" ><font size="3">PACKAGES VERIFIED AND READY FOR DISPATCH</font></th>
                                
                               
                                    
                            </tr>
                            <tr >
                                <td style="vertical-align:top;">




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
                    <a  href="package_dispatch_log_popup.aspx?pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=800"> 
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
                        <asp:Label runat="server" ForeColor="#666666" ID="Label1">No Packages for this Wall</asp:Label>
                            
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
                                <td style="vertical-align:top;">
                                    

        <asp:ListView ID="VerifiedPackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="verifiedPackagesDataSource" >
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
                 <td align="center">
                    
                      <asp:Button ID="remove" runat="server"  CommandArgument='<%# Eval("id") %>' OnCommand="Remove_Click" Text="Remove"></asp:Button>
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
            
                        <table ID="itemPlaceholderContainer" width="100%" runat="server" border="0"  class="tableSpacing tableSpacing themeContent">
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
      
       
    </asp:ListView>
<asp:LinqDataSource ID="verifiedPackagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="verifiedPackageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
        
        
    </asp:LinqDataSource>

                                    <br />
                                    <br />
                                    <br />
                                    <br />
        
        <asp:ListView ID="RemovedPackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="removedPackagesDataSource" >
        <ItemTemplate>
            <tr >
                
                
                <td style="width:90px">
                    <asp:Label ID="packageID" ForeColor="#808080" runat="server" Text='<%# Eval("id") %>' />
                </td>
                <td>
                    <asp:Label ID="wallDescr" ForeColor="#808080" runat="server" Text='<%# Eval("wall.wall_label") %>' />
                -
                    <asp:Label ID="packageDescription" ForeColor="#808080" runat="server" Text='<%# Eval("description") %>' />
                </td>
               

                    <td align="center">
                    &nbsp&nbsp
                    <a  href="package_dispatch_log_popup.aspx?pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="logs" />
                        </a> 
                          
                    
                    
                    
                </td>
                 <td align="center">
                    
                      <asp:Button ID="verify" runat="server"  CommandArgument='<%# Eval("id") %>' OnCommand="ReVerify_Click" Text="Re-Verify"></asp:Button>
                    </td>
                
            </tr>
        </ItemTemplate>
       
       
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="100%" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
      
       
    </asp:ListView>
<asp:LinqDataSource ID="removedPackagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="removedPackageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
</asp:LinqDataSource>
<asp:LinqDataSource ID="packagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="packageDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
        
        
    </asp:LinqDataSource>







                                </td>
                            </tr>
                        </table>


    
   
</div>
   
   <div>
   
        
      
</div>

    








<script type="text/javascript">
    setTimeout(function () { document.getElementById('barcode').focus(); }, 10);

</script>

</asp:Content>

