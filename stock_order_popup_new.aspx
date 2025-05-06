<%@ Page Title="SOPn" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="stock_order_popup_new.aspx.cs" Inherits="stock_order_popup_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div style="background:white !important;">

<div>
 

<%--<a id="sbclose" style="float:right; margin: -10px 0px 00px 0px;" href="#" onclick="parent.Shadowbox.close();"><img src="close.png" style="border: none;" /></a>--%>
 
 <div style="text-align:left; padding:5px;"> <h3 style="color:black;">
    Stock Orders for <asp:Label ID="clientNameLabel" runat="server" Text=""></asp:Label>  
</h3></div>
  
  
   
      <asp:ListView ID="JoblistItemsInsertListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsInsertDataSource" InsertItemPosition="FirstItem"
        OnItemInserting="joblist_items_ItemInserting" 
         OnItemInserted="joblist_items_ItemInserted" 
          OnDataBound="after_page_load">
         
        
        
        <InsertItemTemplate>
            <tr class="newJobList">
            
                <td >
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="100%" ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>' CssClass="ui-corner-all ui-widget" />
                    <br />
                    <asp:TextBox Width="75%" CssClass="ui-corner-all ui-widget-header" placeholder="Enter Required By Date..." ID="datepicker" class="processing_date_textbox" runat="server" Text='<%# Bind("receive_by_date") %>' />
                          
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                
                
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
                
           
            
        </ItemTemplate>
        <LayoutTemplate>
           
                        <table ID="client_info_table" runat="server" 
                            style=" width:90%;font-family: Verdana, Arial, Helvetica, sans-serif;" class="themeContent">
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"   runat="server">Place New Order</th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="JoblistItemsInsertDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="job_list_items">
</asp:LinqDataSource>
    <br />
    <h3><b><font size="3">Orders Pending</font></b></h3>
      <asp:ListView ID="JoblistItemsListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsDataSource" 
         OnItemUpdating = "joblist_items_ItemUpdating"
          OnItemUpdated="joblist_items_ItemUpdated">
        <ItemTemplate>
                
            <tr>

                <td style="width:30%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_ordered")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> &nbsp <%# Eval("order_no")%></font>
                </td>
                
                <td align="center">

                 <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received" target="new" > 
    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_delivered")) %>' /> </a>
                    
                    
                    
                    
                    <br />
                  <font size="1" color="grey">  <%#Eval("material_received_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>    
                

                <td align="center">
                   <%# Eval("date_expected", "{0:ddd, d MMM, yyyy}")%> 
                
                
                </td>
               
                
                
                <td class="TDwithButtons" colspan="2"  align="center" >
                
                 
                <%
        string pShowButtonParameter = Page.Request.QueryString["pShowButton"];
        if(pShowButtonParameter != null && pShowButtonParameter.Equals("true"))
        
        { %> 
             
     <a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" title="log order note" />  </a>&nbsp
  
          <%} %>

          <a href="print_site_order.aspx?pSectionId=<%#Eval("section_id") %>&itemId=<%#Eval("id") %>" target="new" > 
          <img src="Images/print.png" align="middle" />  </a>&nbsp

   
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse; color:black;">
                <tr>
                    <td>
                        No Current Orders.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
         
        <LayoutTemplate>
         
                        <table ID="client_info_table" runat="server" border="0"  class="themeContent"
                            style="width:95%; font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" ><font size="1">Ordered</font></th>
                                <th align="center" ><font size="1">Received</font></th>
                                
                                <th align="center" ><font size="1">Expected Date</font></th>
                                
                                <th colspan="2">&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="JoblistItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="joblist_items_DataSource_Selecting">
</asp:LinqDataSource>
    <br />
   <h3><b><font size="3">Orders Completed</font></b></h3>

     <asp:ListView ID="CompletedListView" runat="server" DataKeyNames="id" 
        DataSourceID="CompletedItemsDataSource" >
        <ItemTemplate>
                
            <tr>

                <td style="width:30%;">
  
                    <%# GetOpenTag(Eval("default_item_na")) %>    <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>
                    <%# GetCloseTag(Eval("default_item_na")) %>
                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("material_ordered")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("material_ordered_date", "{0:ddd, d MMM, yyyy}")%> &nbsp <%# Eval("order_no")%></font>
                </td>
                
                <td align="center">
                    <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
    <asp:Image ID="Image2" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("material_delivered")) %>' /> </a><br />
                  <font size="1" color="grey">  <%#Eval("material_received_date", "{0:ddd, d MMM, yyyy}")%></font>
                </td>    
                
<td>
               
               <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
     <img src="Images/print.png"  align="middle" />  </a>&nbsp
                
                
     </td>          
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;">
                <tr>
                    <td>
                        No Completed Items.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="client_info_table" runat="server" border="0" class="themeContent"
                            style="width:95%; margin:3px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" >Ordered</th>
                                <th align="center" >Received</th>
                               
                                <th align="center" >&nbsp</th>
                                
                                
                               
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="CompletedItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="completed_items_DataSource_Selecting">
</asp:LinqDataSource>
    
     




 




 </div>






 </div>
</asp:Content>

