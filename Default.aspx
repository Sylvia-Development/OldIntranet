<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">


</asp:Content>












































<%-- <% 
	          String[] userRoles = Roles.GetRolesForUser();   
	          int roleCount = userRoles.GetLength(0);
               %>  




<table>
<tr>
<td  style="padding: 5px; vertical-align:top;  width:50%;">
<div style="padding-left:10px;  padding-right:10px;">
    <h1>Designs<font style="font-size:xx-small;" > 7 days</font>   <span style="float:right; padding-top:10px;" >     </span>       </h1>  
    <font style="font-size:small;" >Current Average - <asp:Label runat="server" ID="quotes"  OnLoad="getLeadTimeAverage" > </asp:Label> days</font> 
   
</div>
<table>
    <tr>
    <td colspan="2" ><table width="100%"><tr><td class="transparentRow">&nbsp</td><td class="transparentRow">&nbsp</td><td class="transparentRow">&nbsp</td><td class="transparentRow">&nbsp</td><td class="transparentRow">&nbsp</td></tr></table></td>
</tr>
<tr>
 <td  style="vertical-align:top;" >
<asp:LinqDataSource ID="quotesInProgressLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="quotesInProgressDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="QuotesInProgressFormView" runat="server"
             DataSourceID="quotesInProgressLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
                   
         
          
          <tr class='<%# GetRowStyle(Eval("started_date"),Eval("completed_date"),null,0) %>'>
            
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font></td>
              <td><font color="black"> <%# Eval("section.client.consultant_name")%> </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("started_date"),System.DateTime.Now,0)%></font></td>
              
            
            
                       
          </tr>                      
        </ItemTemplate>
       <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1">
             <tr  class="tableheaderrow">
                <th colspan="2" ><font color="black">Designs In Progress</font> </th>
                
                </tr>
                <tr>
                    <td>
                        No Designs To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
             <tr  class="tableheaderrow">
                <th colspan="3" >Designs In Progress</th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
</td> 
<td style="vertical-align:top;" >
<asp:LinqDataSource ID="quotesCompletedLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="quotesCompletedDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="quotesCompletedLinqDataSourceListView" runat="server"
             DataSourceID="quotesCompletedLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
                   
         
          
          <tr class='<%# GetRowStyle(Eval("started_date"),Eval("completed_date"),null,0) %>'>
            
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font></td>
              <td><font color="black"> <%# Eval("section.client.consultant_name")%> </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("started_date"), Eval("completed_date"), 0)%></font></td>
              
            
            
                       
          </tr>                      
        </ItemTemplate>
       <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr  class="tableheaderrow">
                <th colspan="2" ><font color="black">Designs Completed</font> <font color="black" style=" font-size:x-small;">   (Last 30 Days)</font> </th>
                
                </tr>
                <tr>
                    <td>
                        No Designs To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr class="tableheaderrow">
                <th colspan="3" ><font color="black">Designs Completed</font> <font color="black" style=" font-size:x-small;">   (Last 30 Days)</font></th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
</td>   

 </tr>   
 </table>   
    
    
</td>




<td valign="top" style="border-left: 2px ridge gray; vertical-align:top; padding: 5px; width:50%;" >
<%if (roleCount > 0)
    {
        if (!Context.User.IsInRole("Training"))

        { %> 

<div style="padding-left:10px;  padding-right:10px;">
<h1>Installations </h1>

<font style="font-size:small;" >Current Average - <asp:Label runat="server" ID="installations"  OnLoad="getLeadTimeAverage" > </asp:Label> days </font>
</div>
  

<table>
    <tr>
    <td colspan="2" ><table width="100%"><tr><td class="greenRow">100% Bonus</td><td class="blueRow">75% Bonus</td><td class="purpleRow">50% Bonus</td><td class="amberRow">25% Bonus</td><td class="redRow">No Bonus</td></tr></table></td>
</tr>
<tr>
 <td style="vertical-align:top;">
<asp:LinqDataSource ID="installationsInProgressLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="installationsInProgressDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="ListView1" runat="server"
             DataSourceID="installationsInProgressLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
                   
         
          
          <tr class='<%# GetRowStyle(Eval("started_date"),Eval("completed_date"),Eval("section"),2) %>'>
            
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font>  <font color="black" style="font-size:x-small;" ><%# GetInstallationTime(Eval("section.quote_value"))%> days </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("started_date"),System.DateTime.Now,2)%></font></td>
              
            
            
                       
          </tr>                      
        </ItemTemplate>
      <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr class="tableheaderrow">
                <th colspan="2" ><font color="black">Installations In Progress</font> </th>
                
                </tr>
                <tr>
                    <td>
                        No Installations To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr class="tableheaderrow">
                <th colspan="2" ><font color="black">Installations In Progress</font></th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
</td> 
<td style="vertical-align:top;" >
<asp:LinqDataSource ID="installationsCompletedLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="installationsCompletedDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="ListView2" runat="server"
             DataSourceID="installationsCompletedLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
                   
         
          
          <tr class='<%# GetRowStyle(Eval("started_date"),Eval("completed_date"),Eval("section"),2) %>'>
            
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font>&nbsp&nbsp<font color="black" style="font-size:x-small;" ><%# GetInstallationTime(Eval("section.quote_value"))%> days </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("started_date"), Eval("completed_date"), 2)%></font></td>
              
            
            
                       
          </tr>                      
        </ItemTemplate>
      <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr class="tableheaderrow">
                <th colspan="2" ><font color="black">Installations Completed</font> <font color="black" style=" font-size:x-small;">   (Last 60 Days)</font></th>
                
                </tr>
                <tr>
                    <td>
                        No Installations To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
                            
             <tr class="tableheaderrow">
                <th colspan="2" ><font color="black">Installations Completed</font> <font color="black" style=" font-size:x-small;">   (Last 60 Days)</font></th>
                
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>
</td>   

 </tr>   
 </table>   

    <%}
    } %>

</td>

</tr>

</table>

  
<hr />
    <table>
<tr>
<td>
<%if (roleCount > 0)
  {
      if ((Context.User.IsInRole("Director")
          ||Context.User.IsInRole("Design Consultant")) && !Context.User.IsInRole("Training") )
          
      { %> 
     
    


 <div class="smallheading"> Group Stats</div><br />
   


  <a href="data_validation.aspx?pType=TotalQuotes">   <font size='2'><asp:Label runat="server" ID="Label1"  OnLoad="getStatsQuotes" ></asp:Label></font> <br /><br />     </a>
  <a href="data_validation.aspx?pType=LostLeads">     <font size='2'><asp:Label runat="server" ID="Label2"  OnLoad="getStatsLostLeads" ></asp:Label></font> <br /><br />  </a>
  <a href="data_validation.aspx?pType=HitRate">       <font size='2'><asp:Label runat="server" ID="Label3"  OnLoad="getStatsHitRate" ></asp:Label></font> <br /><br />    </a>
  <font size='2'><asp:Label runat="server" ID="Label4"  OnLoad="getStatsLeadTime" ></asp:Label></font> <br /><br />










<%}
		} %>
</td>
</tr>
</table>
    <hr />
<table>
<tr>
<td>
<%if (roleCount > 0)
  {
      if (Context.User.IsInRole("Director")
          ||Context.User.IsInRole("Customer Experience Manager")
          ||Context.User.IsInRole("Design Consultant")
   )
          
      { %> 
     
    <div class="smallheading"> Individual Stats</div><br />





<%
      if (Context.User.IsInRole("Director")
          ||Context.User.Identity.Name.ToLower().Equals("reino")||Context.User.Identity.Name.ToLower().Equals("sheraine"))
          
      { %> 
<br />
<p><font size='2'>Sheraine : </font></p>


<table cellpadding="4" ID="salesSheraine" runat="server" border="1" >
    <tr style="background-color:Grey;">
         <th  align="center" style=" width:70px;  ">
        
        </th>
        <th  align="center" style=" width:70px;   ">
            <asp:Label ForeColor="black" runat="server" ID="backy00"  OnLoad="getMonthHeaders" ></asp:Label>   
            
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black" runat="server" ID="backy01"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy02"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy03"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy04"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy05"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
         <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy06"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy07"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label  ForeColor="black" runat="server" ID="backy08"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy09"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th  align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy10"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backy11"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        
    </tr>

   
    <tr >
        <th  align="center" style=" width:70px; background-color:Grey;  ">
          <asp:Label ForeColor="black" runat="server" ID="LabelSheraine7"   > Sales</asp:Label>   
        </th>
        <td align="center" >
          <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_00" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine00"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_01" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine01"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_02" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine02"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_03" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine03"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_04" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine04"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_05" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine05"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_06" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine06"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_07" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine07"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_08" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine08"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_09" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine09"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_10" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine10"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Sheraine_11" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataSheraine11"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        

    </tr>
    
</table>

<%} %>





<%
      if (Context.User.IsInRole("Director")
          ||Context.User.Identity.Name.ToLower().Equals("reino")||Context.User.Identity.Name.ToLower().Equals("jacque"))
          
      { %> 
<br />
<p><font size='2'>Jacque : </font></p>


<table cellpadding="4" ID="Table1" runat="server" border="1" >
    <tr style="background-color:Grey;">
         <th  align="center" style=" width:70px;  ">
        
        </th>
        <th  align="center" style=" width:70px;   ">
            <asp:Label ForeColor="black" runat="server" ID="backj00"  OnLoad="getMonthHeaders" ></asp:Label>   
            
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black" runat="server" ID="backj01"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj02"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj03"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj04"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj05"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
         <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj06"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj07"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label  ForeColor="black" runat="server" ID="backj08"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj09"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th  align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj10"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backj11"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        
    </tr>

   
    <tr >
        <th  align="center" style=" width:70px; background-color:Grey;  ">
          <asp:Label ForeColor="black" runat="server" ID="Label17"   > Sales</asp:Label>   
        </th>
        <td align="center" >
          <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_00" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque00"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_01" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque01"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_02" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque02"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_03" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque03"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_04" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque04"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_05" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque05"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_06" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque06"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_07" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque07"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_08" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque08"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_09" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque09"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_10" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque10"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Jacque_11" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataJacque11"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        

    </tr>
    
</table>

<%} %>




    

<%
      if (Context.User.IsInRole("Director")
          ||Context.User.Identity.Name.ToLower().Equals("reino")||Context.User.Identity.Name.ToLower().Equals("mark"))
          
      { %> 
<br />
<p><font size='2'>Mark : </font></p>


<table cellpadding="4" ID="Table2" runat="server" border="1" >
    <tr style="background-color:Grey;">
         <th  align="center" style=" width:70px;  ">
        
        </th>
        <th  align="center" style=" width:70px;   ">
            <asp:Label ForeColor="black" runat="server" ID="backm00"  OnLoad="getMonthHeaders" ></asp:Label>   
            
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black" runat="server" ID="backm01"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm02"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm03"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm04"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm05"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
         <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm06"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm07"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label  ForeColor="black" runat="server" ID="backm08"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm09"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th  align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm10"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backm11"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        
    </tr>

   
    <tr >
        <th  align="center" style=" width:70px; background-color:Grey;  ">
          <asp:Label ForeColor="black" runat="server" ID="Label30"   > Sales</asp:Label>   
        </th>
        <td align="center" >
          <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_00" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark00"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_01" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark01"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_02" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark02"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_03" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark03"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_04" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark04"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_05" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark05"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_06" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark06"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_07" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark07"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_08" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark08"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_09" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark09"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_10" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark10"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Mark_11" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataMark11"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        

    </tr>
    
</table>

<%} %>




    

<%
      if (Context.User.IsInRole("Director")
          ||Context.User.Identity.Name.ToLower().Equals("reino")||Context.User.Identity.Name.ToLower().Equals("ashley"))
          
      { %> 
<br />
<p><font size='2'>Ashley : </font></p>


<table cellpadding="4" ID="Table3" runat="server" border="1" >
    <tr style="background-color:Grey;">
         <th  align="center" style=" width:70px;  ">
        
        </th>
        <th  align="center" style=" width:70px;   ">
            <asp:Label ForeColor="black" runat="server" ID="backa00"  OnLoad="getMonthHeaders" ></asp:Label>   
            
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black" runat="server" ID="backa01"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa02"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa03"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa04"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa05"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
         <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa06"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa07"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label  ForeColor="black" runat="server" ID="backa08"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa09"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th  align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa10"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backa11"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        
    </tr>

   
    <tr >
        <th  align="center" style=" width:70px; background-color:Grey;  ">
          <asp:Label ForeColor="black" runat="server" ID="Label43"   > Sales</asp:Label>   
        </th>
        <td align="center" >
          <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_00" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley00"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_01" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley01"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_02" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley02"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_03" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley03"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_04" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley04"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_05" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley05"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_06" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley06"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_07" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley07"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_08" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley08"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_09" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley09"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_10" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley10"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_Ashley_11" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDataAshley11"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        

    </tr>
    
</table>

<%} %>






<%
      if (Context.User.IsInRole("Director")
          ||Context.User.Identity.Name.ToLower().Equals("reino"))
          
      { %> 


<br />
<hr />
<div class="smallheading">  Group Target Report</div>
<br />
<table cellpadding="4" ID="salesgroup" runat="server" border="1" >
    <tr style="background-color:Grey;">
         <th  align="center" style=" width:70px;  ">
        <%if (Context.User.IsInRole("Director")||Context.User.Identity.Name.ToLower().Equals("reino")){ %> 
            <a href="target_validation.aspx" rel="shadowbox;height=460;width=600">
         <%} %> 
             <img src="Images/chart.png" />
         <%if (Context.User.IsInRole("Director")||Context.User.Identity.Name.ToLower().Equals("reino")){ %> 
            </a>
         <%} %>
        </th>
        <th  align="center" style=" width:70px;   ">
            <asp:Label ForeColor="black" runat="server" ID="backz00"  OnLoad="getMonthHeaders" ></asp:Label>   
            
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black" runat="server" ID="backz01"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz02"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz03"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz04"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz05"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
         <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz06"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz07"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label  ForeColor="black" runat="server" ID="backz08"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz09"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th  align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz10"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        <th align="center" style=" width:70px;  ">
            <asp:Label ForeColor="black"  runat="server" ID="backz11"  OnLoad="getMonthHeaders" ></asp:Label>   
        </th>
        
    </tr>

    
      

    <tr >
        <th  align="center" style=" width:70px; background-color:Grey;  ">
          <asp:Label ForeColor="black" runat="server" ID="Labelgroup7"   > Sales</asp:Label>   
        </th>
        <td align="center" >
          <a href="sales_validation.aspx?pType=Jobsx_Received_group_00" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup00"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_01" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup01"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_02" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup02"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_03" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup03"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_04" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup04"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_05" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup05"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_06" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup06"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_07" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup07"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_08" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup08"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_09" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup09"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_10" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup10"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        <td align="center" >
           <a href="sales_validation.aspx?pType=Jobsx_Received_group_11" rel="shadowbox;height=460;width=700">  <asp:Label runat="server" ID="backDatagroup11"  OnLoad="getSalesByMonth" ></asp:Label> </a>
        </td>
        

    </tr>
    
     
  

   

</table>



<%} %>



<%}
  } %>
</td>
</tr>
</table>



<hr />

<%if (Context.User.IsInRole("Director")
            || Context.User.IsInRole("Customer Experience Manager")
            || Context.User.IsInRole("Design Consultant"))
    {%>


<table>
<tr>
<td><div class="smallheading"> Designs not yet started</div></td>
</tr>
<tr>
<td>
<asp:LinqDataSource ID="quotesNotStartedLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="quotesNotStartedDataSource_Selecting"
                 EnableUpdate="False"
                 TableName="job_times">
                  
</asp:LinqDataSource> 
<asp:ListView ID="ListView3" runat="server"
             DataSourceID="quotesNotStartedLinqDataSource"
              DataKeyNames="id">
        <ItemTemplate >
                   
         
          
          <tr  >
            
            
              <td><font color="black"> <%# Eval("section.client.job_name")%>-<%# Eval("section.section_name")%> </font></td>
              <td><font color="black"><%# GetDaysElapsed(Eval("section.date_added"),System.DateTime.Now,0)%></font></td>
              <td><font color="black"> <%# Eval("section.client.consultant_name")%> </font></td>
              <td><a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section.section_id")%>&pDepartmentId=0&pClientId=<%# Eval("section.client_id")%>    "><font color="black">View Notes >></font></a></td>
              
            
            
                       
          </tr>                      
        </ItemTemplate>
       <EmptyDataTemplate>
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
             <tr style="background-color:Gray;">
                <th colspan="2" > </th>
                
                </tr>
                <tr>
                    <td>
                        No Designs To List.</td>
                </tr>
            </table>
            
        </EmptyDataTemplate>
        <LayoutTemplate>
          
            <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" >
             <tr class="tableheaderrow">
                <th ><font color="black">Client Name</font></th>
                 <th ><font color="black">Days Elapsed</font></th>
                 <th ><font color="black">Consultant</font></th>
                 <th>&nbsp</th>
                </tr>
                <tr ID="itemPlaceholder" runat="server">
                
                </tr>
            </table>
            </LayoutTemplate>
              
</asp:ListView>




</td>
</tr>
</table>

    <%} %>

  


</asp:Content>
--%>
