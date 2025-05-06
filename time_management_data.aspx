<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="time_management_data.aspx.cs" Inherits="time_management_data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">

<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker1']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });
    $(function () {
        $("input[id$='datepicker2']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });

    
</script>
<h1>Quote Lead Time Data Capture</h1>
<br />
<a  class="linkButton" href="time_management_data.aspx?pShowLast=true">Show All Closed Sections</a>


<br />
<br />

<asp:ListView ID="TimeMeasureFormView" runat="server"
             DataSourceID="timeMeasureLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate>
                   
         
          
          <tr >
            
            
              <td nowrap> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>

               <td nowrap> <%# Eval("section.client.consultant_name")%> </td>
  
              <td nowrap> <%# Eval("started_date", "{0:dddd, d MMM, yyyy}")%> </td>
              
              <td nowrap> <%# Eval("completed_date", "{0:dddd, d MMM, yyyy}")%> </td>
                
              <td nowrap> <%# Eval("comment")%></td>
              <td nowrap class="TDwithButtons">
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" 
                        Text="Edit" />
                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />
              
              </td>
            
          </tr>                      
        </ItemTemplate>
        <EditItemTemplate>
            <tr class="editrow">
            
              <td nowrap> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </td>
              <td nowrap> <%# Eval("section.client.consultant_name")%> </td>

              <td nowrap> <asp:TextBox  ID="datepicker1" runat="server" 
                        Text='<%# Bind("started_date","{0:ddd, d MMM, yyyy}") %>' />
                       
              </td>
              <td nowrap> <asp:TextBox  ID="datepicker2" runat="server" 
                        Text='<%# Bind("completed_date","{0:ddd, d MMM, yyyy}") %>' />
                        
              </td>
             
              <td nowrap> <asp:TextBox  ID="comment" runat="server" 
                        Text='<%# Bind("comment") %>' /></td>  
              <td nowrap class="TDwithButtons"> <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" /></td>
            
            
                       
          </tr> 
        
        
        
        
        </EditItemTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="0" class="themeContent" >
             <tr>
                <th >Job Name</th>
                <th >&nbsp</th>
                <th >Start Date</th>
                <th >Completed Date</th>
                <th >Comment</th>
                <th >&nbsp</th>
                
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

