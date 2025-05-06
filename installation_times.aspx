<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="installation_times.aspx.cs" Inherits="installation_times" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

    
<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker1']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });
    $(function () {
        $("input[id$='datepicker2']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });

    
</script>
<h1>
           Installation Time Data Capture </h1>
<br />
<a  class="linkButton" href="installation_times.aspx?pShowLast=true">Show All Closed Jobs</a>


<br />
<br />

<asp:ListView ID="TimeMeasureFormView" runat="server"
             DataSourceID="timeMeasureLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate>
                   
         
          
          <tr class='<%# GetRowColour(Eval("started_date"),Eval("section.quote_value")) %>' >
            
            
              <td> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td> <%# Eval("section.installation_team1.description")%></td>
              <td> <%# Eval("started_date", "{0:dddd, d MMM, yyyy}")%> </td>
               <td> <%# GetInstallationTime(Eval("section.quote_value"))%> </td>
              <td> <%# GetElapsedTime(Eval("started_date"))%> </td>
              <td> <%# GetRemainingTime(Eval("started_date"),Eval("section.quote_value"))%> </td>
              
              <td> <%# Eval("completed_date", "{0:dddd, d MMM, yyyy}")%> </td>
                
              
              <td class="TDwithButtons">
                  
                  <div style="visibility:<%#getEditEnabled(Eval("section"),Eval("started_date"),Eval("completed_date")) %>">
                <asp:Button ID="EditButton"   runat="server" CommandName="Edit" 
                        Text="Edit" />
                      </div>
              </td>
              <td nowrap><a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section.section_id")%>&pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]); %>&pClientId=<%# Eval("section.client_id")%>   ">Go to Section >></a></td>
            </td>
            
          </tr>                      
        </ItemTemplate>
        <EditItemTemplate>
            <tr class="editrow">
            
              <td> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td> <%# Eval("section.installation_team1.description")%></td>

              <td> <asp:TextBox  ID="datepicker1" runat="server" 
                        Text='<%# Bind("started_date","{0:ddd, d MMM, yyyy}") %>' />
                       
              </td>
                <td> <%# GetInstallationTime(Eval("section.quote_value"))%> </td>
              <td> <%# GetElapsedTime(Eval("started_date"))%> </td>
              <td> <%# GetRemainingTime(Eval("started_date"),Eval("section.quote_value"))%> </td>
             
              <td> <asp:TextBox  ID="datepicker2" runat="server" 
                        Text='<%# Bind("completed_date","{0:ddd, d MMM, yyyy}") %>' />
                        
              </td>
             
              
              <td class="TDwithButtons"> <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" /></td>
            
            
                       
          </tr> 
        
        
        
        
        </EditItemTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
             <tr class="tableheaderrow">
                <th >Job Name</th>
                <th >Team</th>
                <th >Start Date</th>
                 
                 <th ><font style="font-size:x-small;">Allocated</font></th>
                 <th ><font style="font-size:x-small;">Elapsed</font></th>
                 <th ><font style="font-size:x-small;">Remaining/Overdue</font></th>
                 
                <th >Completed Date</th>
                
                <th colspan="2" >&nbsp</th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>


<asp:LinqDataSource ID="timeMeasureLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="measureTimeDataSource_Selecting"
                 EnableUpdate="True"
                  EnableDelete="true"
                 TableName="job_times">
</asp:LinqDataSource>



</asp:Content>

