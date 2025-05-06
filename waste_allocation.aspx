<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="waste_allocation.aspx.cs" Inherits="waste_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

 <script type="text/javascript">
  

$(function () {
    var activeIndex = parseInt($('#<%=hidAccordionIndex.ClientID %>').val());

    $("#accordion").accordion({
         collapsible: true,
        
        change: function (event, ui) {
            var index = $(this).children('h3').index(ui.newHeader);
            $('#<%=hidAccordionIndex.ClientID %>').val(index);
        },
        active: activeIndex
    });
});
</script>
<asp:HiddenField ID="hidAccordionIndex" runat="server" Value="0" />
<h1>Waste Allocation</h1>


<div id="accordion">
  <h3><a href="#">To be Allocated</a></h3>
  <div>
 <asp:ListView ID="WasteListView" runat="server" DataKeyNames="id" 
        DataSourceID="WasteDataSource" 
         OnItemUpdating = "waste_ItemUpdating"
          OnItemUpdated="waste_ItemUpdated">
        <ItemTemplate>
                
              <tr >

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <font color="gray" size="1">logged by: <%#Eval("user_logged")%> - <%#Eval("date_logged", "{0:ddd, d MMM, yyyy}")%> </font>
                </td>
                
                <td align="center"> - </td>
              
                <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Allocate Waste" />
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Waste to allocate</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1">
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr class="editrow">

                    <td> 
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                        
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    </td>
                    <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <font color="white" size="1">logged by: <%#Eval("user_logged")%> - <%#Eval("date_logged", "{0:ddd, d MMM, yyyy}")%> </font>

                </td>

                
                <td >
                
               
               <asp:CheckBoxList id="check_box_name_list" TextAlign="Right" runat="server"
                DataSourceID = "WasteNamesLinqDataSource"
                DataValueField = "UserName"  
                DataTextField="UserName"
                 RepeatColumns="4">

                </asp:CheckBoxList>

                
                 
                    


                </td>
                 
               
                <td class="TDwithButtons" align="center">
               <div >
               
                     
                     <%  if (Context.User.IsInRole("Director"))
                         {%>
                    <asp:CheckBox ID="CheckBox2"  Text="is Waste" TextAlign="Left" runat="server" Checked='<%# Bind("is_waste") %>' Enabled='true' />
                    <%  }
                         else
                         {%>

                         <asp:CheckBox ID="CheckBox1" Visible="false"  Text="is Waste" TextAlign="Left" runat="server" Checked='<%# Bind("is_waste") %>' Enabled='true' />
                    <%} %>

                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

    <asp:LinqDataSource ID="WasteDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="waste_DataSource_Selecting">
</asp:LinqDataSource>

</div>
 <h3><a href="#">Waste already Allocated (last 60 days)</a></h3>
  <div>
   <asp:ListView ID="WasteListView2" runat="server" DataKeyNames="id" 
        DataSourceID="AllocatedWasteDataSource" 
         OnItemUpdating = "allocated_waste_ItemUpdating"
          OnItemUpdated="allocated_waste_ItemUpdated">
        <ItemTemplate>
                
              <tr>

                <td> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <font color="gray" size="1">logged by: <%#Eval("user_logged")%> - <%#Eval("date_logged", "{0:ddd, d MMM, yyyy}")%> </font>
                </td>
                
                <td align="center"> <%# GetWasteNames(Eval("waste_names")) %> </td>
              
                <td   align="center">
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Allocate Waste" />
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No Waste to allocated</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>





            <tr class="editrow">

                    <td> 
                        <asp:HiddenField ID="jobListId" runat="server"  Value='<%# Bind("id") %>'/>
                        
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                    </td>
                    <td style="width:40%;">
  
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                        <font color="white" size="1">logged by: <%#Eval("user_logged")%> - <%#Eval("date_logged", "{0:ddd, d MMM, yyyy}")%> </font>

                </td>

                
                <td >
                
               
               <asp:CheckBoxList id="check_box_name_list" TextAlign="Right" runat="server"
                DataSourceID = "WasteNamesLinqDataSource"
                DataValueField = "UserName"  
                DataTextField="UserName"
                 RepeatColumns="4">

                </asp:CheckBoxList>

                
                 
                    


                </td>
                 
               
                <td class="TDwithButtons" align="center">
               <div >
               
                     
                     <%  if( Context.User.IsInRole("Director")){%>
                    <asp:CheckBox ID="CheckBox2"  Text="is Waste" TextAlign="Left" runat="server" Checked='<%# Bind("is_waste") %>' Enabled='true' />
                    <%  }else
                         {%>

                         <asp:CheckBox ID="CheckBox1" Visible="false"  Text="is Waste" TextAlign="Left" runat="server" Checked='<%# Bind("is_waste") %>' Enabled='true' />
                    <%} %>

                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                    </div>    
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

    <asp:LinqDataSource ID="AllocatedWasteDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="allocated_waste_DataSource_Selecting">
</asp:LinqDataSource>



  

  </div>

  </div>
   <asp:LinqDataSource ID="WasteNamesLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" TableName="aspnet_Users"
         OnSelecting ="waste_names_info_selecting">
    </asp:LinqDataSource>
</asp:Content>

