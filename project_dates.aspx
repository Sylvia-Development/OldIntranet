<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="project_dates.aspx.cs" Inherits="project_dates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<script type="text/javascript">

     $(function () {
         $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker2']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker3']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
     $(function () {
         $("input[id$='datepicker4']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });
 </script>

    <asp:ListView ID="ProjectDatesListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProjectDatesDataSource" 
         OnItemUpdating = "project_dates_ItemUpdating"
          OnItemUpdated="project_dates_ItemUpdated">
        <ItemTemplate>
                
              <tr class="<%# GetRowColour(Eval("site_delivery_date"),Eval("client_lead_time")) %>" style="color: #000000;">

                <td nowrap> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%>  - <%# getBrand(Eval("section.Brand").ToString())%>
                
                </td>
                <td nowrap align="right">
                   
                   Finalised on: <%#Eval("section.decision_date", "{0:ddd, d MMM, yyyy}")%> <br /> <br />
                   Add LeadTime:  <%# GetExactDate(Eval("section.decision_date")) %>                  

                </td>
                <td nowrap align="center">
                    <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                <td align="center" >
                    <%#Eval("client_lead_time")%> 

                </td>
                  <td style="font-weight:bold;" nowrap align="center">
                  
                      <%# GetIntoProductionByDate(Eval("site_delivery_date"),Eval("client_lead_time")) %> <br />
                      
                       <font size="1">     <%# GetLeadTimeInWeeks(Eval("client_lead_time")) %> </font>

                    </td>
                             
                <td align="center" nowrap>
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetApplianceYesNoImage(Eval("section")) %>' />

                </td>
                <td align="center" nowrap>
                   <asp:Image ID="Image5" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' />

                </td>
              
                <td colspan="2" class="TDwithButtons"  align="center" nowrap>
               
    <a class="ui-button ui-corner-all ui-widget"  href="notes_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);
        %>&pClientId=<%# Eval("section.client_id")%>&pSectionId=<%# Eval("section_id")%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                        </a>&nbsp&nbsp
             <%--        <button onclick="location='notes_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);
        %>&pClientId=<%# Eval("section.client_id")%>&pSectionId=<%# Eval("section_id")%>'" title="notes" class="ui-button ui-corner-all ui-widget fa-solid fa-file-lines" >
                                                            </button>--%>

                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> 
                     
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table11" runat="server" 
                style="border-color: #000000;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        You have no jobs waiting to go into production.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="table2" runat="server" border="0" width="100%">
                            <tr id="Tr12" runat="server">  
                                <th id="Th11"     runat="server" ></th>
                                <th  align="center" ><font size="2">Exact LeadTime <br />from signoff & deposit</font></th>
                                <th  align="center" ><font size="2">Site Delivery Date</font></th>
                                <th  align="center" ><font size="2">Production<br /> LeadTime</font></th>
                                <th  align="center" ><font size="2">Into Production By</font></th>
                                <th  align="center" ><font size="2">Appliances<br /> Confirmed</font></th>
                                <th  align="center" ><font size="2">Final<br /> Measurements</font></th>
                                <th colspan="2" align="center"><font size="2">&nbsp</font></th>
                                                                   
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                            
                        </table>
                   
        </LayoutTemplate>
        <EditItemTemplate>

            <tr class="editrow" >

                    <td nowrap> 
                        <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                        <asp:HiddenField ID="hiddenClientName" runat="server"  Value=' <%# Eval("section.client.job_name")%>'/>
                        <asp:HiddenField ID="hiddenSectionName" runat="server"  Value=' <%# Eval("section.section_name")%>'/>
                        <asp:HiddenField ID="hiddenProjectDateId" runat="server"  Value=' <%# Bind("id")%>'/>
                       
                    </td>
                   <td nowrap align="right">
                    
                   Finalised on: <%#Eval("section.decision_date", "{0:ddd, d MMM, yyyy}")%> <br />
                   Add LeadTime:  <%# GetExactDate(Eval("section.decision_date")) %>
                    
                </td>
                <td nowrap >
                   
                    
                       <asp:TextBox  style="border-color:yellow" placeholder="Site Delivery Date..." ID="datepicker2"  runat="server" Text='<%# Bind("site_delivery_date","{0:ddd, d MMM, yyyy}") %>' />

                </td>
                <td>
                    <asp:TextBox   Columns="5" ReadOnly='<%# getLeadTimeEdit() %>' placeholder="Lead Time..." ID="LeadTimeTextBox"  runat="server" Text='<%# Bind("client_lead_time") %>' />

                </td>
                <td nowrap align="center">
                  
                      <%# GetIntoProductionByDate(Eval("site_delivery_date"),Eval("client_lead_time")) %> 

                </td>
                
               <td align="center">
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetApplianceYesNoImage(Eval("section")) %>' />

                </td>
                <td align="center">
                 
                    <div style=" float:none;"><asp:CheckBox ID="CheckBox2"  Text="Measurements Done" TextAlign="Right" runat="server" Checked='<%# Bind("final_measurements_complete") %>' Enabled='true' /></div>
                 
                </td>
                <td >
                  <div style=" float:none;"><asp:CheckBox ID="CheckBox1"  Text="Send To Production" TextAlign="Right" runat="server" Checked='<%# Bind("in_production") %>' Enabled='<%# GetCanGoIntoProduction(Eval("section"),Eval("final_measurements_complete")) %>' /></div>
                 
                </td>    
                 
                <td class="TDwithButtons" nowrap>
                                  
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                        
                </td>
                
            </tr>
        </EditItemTemplate>
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProjectDatesDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="project_dates"
        OnSelecting="project_dates_DataSource_Selecting">
</asp:LinqDataSource>


<br />

<h1>Jobs In Production</h1>


     <asp:ListView ID="InProductionListView" runat="server" DataKeyNames="id" 
        DataSourceID="InProductionDataSource" 
         OnItemUpdating = "in_production_ItemUpdating"
          OnItemUpdated="in_production_ItemUpdated">

        <ItemTemplate>
                
             <tr>

                <td nowrap> 
               
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td align="center" nowrap>
                       <%#Eval("contract_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                
                <td align="center" nowrap>
                    <%#Eval("job_list_item.date_expected", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                <td align="center" nowrap>
                    <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                <td width="150px" nowrap>
               
    <a  href="notes_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("section.client_id")%>&pSectionId=<%# Eval("section_id")%>" class="ui-button" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/notes.png" title="notes"/>
                        </a> &nbsp&nbsp
               <%--<button onclick="location='notes_view_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("section.client_id")%>&pSectionId=<%# Eval("section_id")%>'" title="notes" class="ui-button ui-corner-all ui-widget fa-solid fa-file-lines" >
                                                            </button>--%>

                    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-style:none;">
                <tr>
                    <td>
                        You have no jobs in production.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tble1" cellpadding="5" runat="server" border="0" width="60%" class="themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1" class="tblhead" runat="server"></th>

                                <th  align="center" class="tblhead" ><font size="2">Exact LeadTime <br />from signoff & deposit</font></th>
                                <th  align="center" class="tblhead" ><font size="2">Initial Site Delivery Date</font></th>
                               
                                <th  align="center" class="tblhead"><font size="2">Into Production On</font></th>
                                                                
                                <th colspan="3" align="center" class="tblhead"><font size="2">&nbsp</font></th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >

                    <td nowrap> 
                        <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                        <asp:HiddenField ID="jobListItemId" runat="server"  Value='<%# Bind("job_list_item_id") %>'/>
                       <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                        <asp:HiddenField ID="hiddenClientName" runat="server"  Value=' <%# Eval("section.client.job_name")%>'/>
                        <asp:HiddenField ID="hiddenSectionName" runat="server"  Value=' <%# Eval("section.section_name")%>'/>
                       
                    </td>
                   <td nowrap >
                      
                      <%#Eval("contract_date", "{0:ddd, d MMM, yyyy}")%> 
                </td>
                
                <td nowrap >
                   
                    
                       <%#Eval("job_list_item.date_expected", "{0:ddd, d MMM, yyyy}")%> 
                </td>
               
                <td nowrap align="center">
                  
                  <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%>
                    
                    </td>              
              
                <td>
                  <div style=" float:none;"><asp:CheckBox ID="CheckBox1"  Text="Remove From Production" TextAlign="Right" runat="server" Checked='<%# Bind("in_production") %>'  /></div>
                 
                </td>
                 
                <td class="TDwithButtons" nowrap>
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                        
                </td>
                
            </tr>
        </EditItemTemplate>
              
    </asp:ListView>

      <asp:LinqDataSource ID="InProductionDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="project_dates"
        OnSelecting="in_production_DataSource_Selecting">
</asp:LinqDataSource>


</asp:Content>

