<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_verify_select_order.aspx.cs" Inherits="section_verify_select_order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

     <div class="titleDiv">
         <h1>Select Order to add Packages for :  <%Response.Write(GetClientNameSection(Page.Request.QueryString["pSectionId"]));%></h1>
            <br />
            <br />
    <a href="section_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > << Back To Section Page</a>
    </div>
    <br />
    <br />
    <div>
          <asp:ListView ID="MainMaterialListView" runat="server" DataKeyNames="id" 
            DataSourceID="mainMaterialDataSource" >
        <ItemTemplate>
            <tr >
                             
                <td align="center"  style="padding-top:10px;">
                    <font size="4" >
                      <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %>
                     </font>

                </td>
                <td><%#Eval("id")%></td>
               
                <td align="center" nowrap>
                    
                   <a href="section_add_packages.aspx?pType=Main Production&pOrderId=<%#Eval("id")%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>"><button type="button">Add Packages >></button></a>
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Main Material Order for this Section</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
             
                        <table ID="itemPlaceholderContainer" width="50%" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                           
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
       
       
    </asp:ListView>
    <asp:LinqDataSource ID="mainMaterialDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="job_list_items"
        OnSelecting="mainMaterialDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
    </asp:LinqDataSource>

        <br />
        <br />
 
      <asp:ListView ID="SiteOrdersListView" runat="server" DataKeyNames="id" 
            DataSourceID="siteOrdersDataSource" >
        <ItemTemplate>
            <tr >
                               
                <td>
                      <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                <td><%#Eval("id")%></td>
               
                <td style="width:250px;" align="center" nowrap>
                    
                   <a href="section_add_packages.aspx?pType=Site Order&pOrderId=<%#Eval("id")%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>"><button type="button">Add Packages >></button></a>
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Site Orders for this Section</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="80%" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server" style="background-color:Gray;  font-size:11pt; color:White;">  
                                <th id="Th1" align="left" colspan="3"  runat="server">Site Orders</th>
                            
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>      
       
    </asp:ListView>
    <asp:LinqDataSource ID="siteOrdersDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="job_list_items"
        OnSelecting="siteOrdersDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
    </asp:LinqDataSource>

        <br />
        <br />
                             
         <asp:ListView ID="disptchOrderListView" runat="server" DataKeyNames="id" 
            DataSourceID="dispatchOrdersDataSource" >
        <ItemTemplate>
            <tr >
                
                <td>
                      <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                <td><%#Eval("id")%></td>
               
                <td style="width:250px;" align="center" nowrap>
                    
                   <a href="section_add_packages.aspx?pType=Production Order&pOrderId=<%#Eval("id")%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>"><button type="button">Add Packages >></button></a>
                </td>
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Default Dispatch Order for this Section</td>
                </tr>
            </table>
        </EmptyDataTemplate>
       
        <LayoutTemplate>
            
                        <table ID="itemPlaceholderContainer" width="50%" runat="server" border="0" class="tableSpacing paddedTable themeContent">
                            
                                <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
             
    </asp:ListView>
    <asp:LinqDataSource ID="dispatchOrdersDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="job_list_items"
        OnSelecting="dispatchOrdersDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False">
    </asp:LinqDataSource>

          





                                


    
   
</div>



</asp:Content>

