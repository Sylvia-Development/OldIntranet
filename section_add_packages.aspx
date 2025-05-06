<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_add_packages.aspx.cs" Inherits="section_add_packages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

    <script type="text/javascript">

    
   



    function ConfirmDelete()
    {
      var x = confirm("Are you sure you want to delete the package?");
      if (x)
          return true;
      else
        return false;
    }

</script>


        <div class="titleDiv">
         <h1>Add Packages for :  <%Response.Write(GetClientNameSection(Page.Request.QueryString["pSectionId"]));%></h1>
       
            <br />
            <br />
      <a  href="section_verify_select_order.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                        << Back To Select Order Page
                        </a>        
        
        </div>
    <br /><br />

    <hr />

             <table  runat="server" border="0" >
                <tr>
                 <td>
                      Order No: <%Response.Write(Page.Request.QueryString["pOrderId"]);%><br />
                     
                      <%Response.Write(GetOrderDescription(Page.Request.QueryString["pOrderId"]).Replace("\n", "<br/>"));%>

                       
                     

                </td>
               </tr>
              </table>

    <hr />
    <br />
    <br />

    <font size="4" style="text-decoration:underline;">
        Below are Packages per Wall that are busy being manufactured and have NOT yet been Verified


    </font>

            <br />
            <br />
    
    
   
    <div>
        
           



<asp:ListView ID="WallsListView" runat="server" DataKeyNames="id" 
            DataSourceID="WallsDataSource" >
        <ItemTemplate>
                
            <asp:Label ID="hiddenWallIdLabel" Visible="false" runat="server" Text='<%# Eval("id") %>' />


                <li >
                   
                    <asp:Label ID="wallLabel" runat="server" Font-Size="Larger" Text='<%# Eval("wall_label") %>' /> &nbsp&nbsp&nbsp&nbsp  
                    
                    <a  href="print_all_package_barcodes_by_wall.aspx?pType=<%Response.Write(Page.Request.QueryString["pType"]);%>&pWallId=<%# Eval("id")%>&pOrderId=<%Response.Write(Page.Request.QueryString["pOrderId"]);%>" target="_blank" > 
                        <img src="Images/print.png" title="print" />
                        </a> 
                   
                 </li>

           <asp:ListView ID="PackageListView" runat="server" DataKeyNames="id" 
            DataSourceID="packagesDataSource" InsertItemPosition="FirstItem"
            OnItemInserting="package_ItemInserting"
                OnItemUpdating="package_ItemUpdating"
               OnItemUpdated="package_ItemUpdated"
                OnItemDeleting="package_ItemDeleting">
        <ItemTemplate>
            <tr >
                
                
                <td style="width:90px">
                    <asp:Label ID="packageID" runat="server" Text='<%# Eval("id") %>' />
                </td>
                
                <td>
                    <asp:Label ID="packageDescription" runat="server" Text='<%# Eval("description") %>' />
                </td>
                <td align="center" nowrap>
                    <a  href="package_dispatch_log_popup.aspx?pPackageId=<%# Eval("id") %>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="logs" />
                        </a> 
                
                     &nbsp&nbsp

                   <a  href="print_single_package_barcode.aspx?pType=<%Response.Write(Page.Request.QueryString["pType"]);%>&pPackageId=<%# Eval("id") %>" target="_blank" > 
                        <img src="Images/print.png" title="print" />
                        </a> 


                </td>
                <td align="center" nowrap>
                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete"   OnClientClick="return ConfirmDelete();"
                        Text="Delete" />
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        Enter Packages for this wall</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">             
                <td colspan="4">
                    <asp:TextBox ID="descriptionTextBox" Columns="29"  MaxLength="30"  runat="server" 
                        Text='<%# Bind("description") %>' />                      
                    
               &nbsp&nbsp&nbsp
                               
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save New Package" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
                             
                <td style="width:90px">
                     
                     <asp:TextBox ID="TextBox1" ReadOnly="true"  runat="server" 
                        Text='<%# Bind("id") %>' />
                        
                </td>
                <td colspan="2">
                   <asp:TextBox ID="descriptionTextBox" Columns="29"  MaxLength="30"  runat="server" 
                        Text='<%# Bind("description") %>' />
                </td>
                
                <td align="center" nowrap >
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>
<asp:LinqDataSource ID="packagesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="section_dispatch_items"
        OnSelecting="packageDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
     OnInserted="package_ItemInserted">
        <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenWallIdLabel" Name="wallId" PropertyName="Text" Type="Int32" />
        </SelectParameters>
        
    </asp:LinqDataSource>

            <br />
               
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <br />
            <br />
            <asp:Label ForeColor="Red" runat="server" >There are no walls loaded for this section. Please ask Plan Generation Dept to load Walls</asp:Label>
                  <br />
            <br />      
                
        </EmptyDataTemplate>
       
        <LayoutTemplate>
           
                        <ul style="margin-left:20px" ID="itemPlaceholderContainer" runat="server" >   
                            <li ID="itemPlaceholder" runat="server"></li>
                        </ul>
                    
        </LayoutTemplate>      
       
    </asp:ListView>
 
</div>
<asp:LinqDataSource ID="WallsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="walls"
        OnSelecting="WallsDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
</asp:LinqDataSource>

</asp:Content>


