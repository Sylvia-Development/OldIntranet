<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="SectionFileManagement.aspx.cs" Inherits="SectionFileManagement" %>
<%@ Register TagPrefix="CuteWebUI" Namespace="CuteWebUI" Assembly="CuteWebUI.AjaxUploader" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
 <script type="text/javascript">
      
     $(function  () {
               $("#outertabs").tabs({
                   show: function() {
                       var selectedTab = $('#outertabs').tabs('option', 'selected');
                       $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
                   },
                   selected: <%= hdnSelectedTab.Value %>
                   });
           });    
     
     
    

      </script>



    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
  





<h1> 
    <font color="white"><asp:Label runat="server" ID="Label4"  OnLoad="getClientAndSectionName" ></asp:Label> - File Management</font>

</h1>
     <div align="right" style="margin: 0 100px 0px 0">

      
        
        
  
        <a class="ui-button ui-corner-all ui-widget"  href="SectionRenderings.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                        <img src="Images/pics.png" title="images" />
                        </a> 
      </div>
    <br />
    <a href="section_view.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > << Back To Section Page</a>
    
    <br />
    <br />


    <div id="outertabs" style="background:white; border:0px;" >
    <ul style="background:white; border:0px;">
       
        

        
      
        <li id="outerTabs1"><a href="#SignoffPlans">Signoff Plans &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>

        <li id="outerTabs2"><a href="#PEPlans">P&E Plans &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>

        <li id="outerTabs3" ><a href="#Signoffs">Signoffs &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp </a></li>

        <li id="outerTabs4" ><a href="#Contracts">Contracts &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp </a></li>
      
        <li id="outerTabs5"><a href="#AO">AO's &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>

        <li id="outerTabs6" ><a href="#VO">VO's &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp </a></li>
      
        <li id="outerTabs7"><a href="#Other">Other Docs &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>
       
       
         
    </ul>
        

    <div id="SignoffPlans">  
     <%if (true)//Context.User.IsInRole("Director"))
         { %> 

   

 
    <div runat="server" id="Div5">
           <CuteWebUI:Uploader runat="server" ID="Uploader6" InsertText="Upload Signoff Plans" OnFileUploaded="plans_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

    


     <asp:ListView ID="PlansListView" runat="server" DataKeyNames="id" 
        DataSourceID="PlansDataSource" 
         OnItemUpdating = "plans_ItemUpdating"
          OnItemUpdated="plans_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Signoff Plans Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"     runat="server">Plans Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="PlansDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="plans_DataSource_Selecting">
</asp:LinqDataSource>

       <br />
        <br />

            <asp:ListView ID="ArchivedPlansListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedPlansDataSource" 
         OnItemUpdating = "archived_plans_ItemUpdating"
          OnItemUpdated="archived_plans_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Signoff Plans Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter"
                         runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"  colspan="3"   runat="server">Archived Plans</th>                             
                                                                                            
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedPlansDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_plans_DataSource_Selecting">
</asp:LinqDataSource>

           

    <%} %>

 </div>   

    <div id="PEPlans">  
     <%if (true)//Context.User.IsInRole("Director"))
         { %> 

   

 
    <div runat="server" id="Div6">
           <CuteWebUI:Uploader runat="server" ID="Uploader7" InsertText="Upload PE Plans" OnFileUploaded="PEPlans_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

   


     <asp:ListView ID="PEPlansListView" runat="server" DataKeyNames="id" 
        DataSourceID="PEPlansDataSource" 
         OnItemUpdating = "peplans_ItemUpdating"
          OnItemUpdated="peplans_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No PE Plans Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server">PE Plans Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="PEPlansDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="PEPlans_DataSource_Selecting">
</asp:LinqDataSource>

       <br /><br />

            <asp:ListView ID="ArchivedPEPlansListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedPEPlansDataSource" 
         OnItemUpdating = "archived_PEPlans_ItemUpdating"
          OnItemUpdated="archived_PEPlans_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No PE Plans Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"  colspan="3"   runat="server">Archived P&E Plans</th>                             
                                                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedPEPlansDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_peplans_DataSource_Selecting">
</asp:LinqDataSource>

          

    <%} %>

 </div> 

    <div id="Signoffs">  
     <%if (true)//Context.User.IsInRole("Director"))
         { %> 

   

 
    <div runat="server" id="Div4">
           <CuteWebUI:Uploader runat="server" ID="Uploader5" InsertText="Upload Signoff" OnFileUploaded="signoff_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

   


     <asp:ListView ID="signoffListView" runat="server" DataKeyNames="id" 
        DataSourceID="SignoffDataSource" 
         OnItemUpdating = "signoff_ItemUpdating"
          OnItemUpdated="signoff_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Signoffs Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"     runat="server">Signoff Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="SignoffDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="signoff_DataSource_Selecting">
</asp:LinqDataSource>

       <br />
        <br />

            <asp:ListView ID="archivedSignoffListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedSignoffDataSource" 
         OnItemUpdating = "archived_signoff_ItemUpdating"
          OnItemUpdated="archived_signoff_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Signoff's Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"  colspan="3"   runat="server">Archived Signoff Forms</th>                             
                                                                                            
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedSignoffDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_signoff_DataSource_Selecting">
</asp:LinqDataSource>

          

    <%} %>

 </div>       

    <div id="Contracts">  
     <%if (Context.User.IsInRole("Director")
             ||Context.User.IsInRole("Projects Director")
             ||Context.User.IsInRole("Procurement Coordinator")
             ||Context.User.IsInRole("Finance Admin Administrator")
             ||Context.User.IsInRole("Finance Admin Manager")
             ||Context.User.IsInRole("Customer Experience Manager")
             ||Context.User.IsInRole("Design Consultant"))
         { %> 

    

 
    <div runat="server" id="contracts_upload_div">
           <CuteWebUI:Uploader runat="server" ID="Uploader1" InsertText="Upload Contract" OnFileUploaded="mainContract_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />
   

   
    


     <asp:ListView ID="ContractsListView" runat="server" DataKeyNames="id" 
        DataSourceID="ContractsDataSource" 
         OnItemUpdating = "contracts_ItemUpdating"
          OnItemUpdated="contracts_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Contracts Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server" >  
                                <th id="Th1"     runat="server">Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ContractsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="contracts_DataSource_Selecting">
</asp:LinqDataSource>

       <br />
    <br />
   

            <asp:ListView ID="ArchivedContractsListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedContractsDataSource" 
         OnItemUpdating = "archived_contracts_ItemUpdating"
          OnItemUpdated="archived_contracts_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Contracts Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server">  
                                <th id="Th1" colspan="3" runat="server">Archived Contracts</th>                             
                                                                                        
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedContractsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_contracts_DataSource_Selecting">
</asp:LinqDataSource>

            

    <%} %>

 </div> 
    
    <div id="AO">  
     <%if (Context.User.IsInRole("Director")
             ||Context.User.IsInRole("Projects Director")
             ||Context.User.IsInRole("Procurement Coordinator")
             ||Context.User.IsInRole("Finance Admin Administrator")
             ||Context.User.IsInRole("Finance Admin Manager")
             ||Context.User.IsInRole("Customer Experience Manager")
             ||Context.User.IsInRole("Design Consultant")
             ||Context.User.IsInRole("Technical Plan Generation Head")
              ||Context.User.IsInRole("Production Controller"))
         { %> 

    

 
    <div runat="server" id="Div1">
           <CuteWebUI:Uploader runat="server" ID="Uploader2" InsertText="Upload AO" OnFileUploaded="AO_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

   


     <asp:ListView ID="AOListView" runat="server" DataKeyNames="id" 
        DataSourceID="AODataSource" 
         OnItemUpdating = "AO_ItemUpdating"
          OnItemUpdated="AO_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No AO's Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server">AO Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="AODataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="AO_DataSource_Selecting">
</asp:LinqDataSource>

       <br />
    <br />

            <asp:ListView ID="ArchivedAOListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedAODataSource" 
         OnItemUpdating = "archived_AO_ItemUpdating"
          OnItemUpdated="archived_AO_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No AO's Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1" colspan="3"    runat="server">Archived AO's</th>                             
                                                                                            
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedAODataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_AO_DataSource_Selecting">
</asp:LinqDataSource>

           

    <%} %>

 </div> 

    <div id="VO">  
     <%if (Context.User.IsInRole("Director")
             ||Context.User.IsInRole("Projects Director")
             ||Context.User.IsInRole("Procurement Coordinator")
             ||Context.User.IsInRole("Finance Admin Administrator")
             ||Context.User.IsInRole("Finance Admin Manager")
             ||Context.User.IsInRole("Customer Experience Manager")
             ||Context.User.IsInRole("Design Consultant")
             ||Context.User.IsInRole("Technical Plan Generation Head")
              ||Context.User.IsInRole("Production Controller"))
         { %> 

     

 
    <div runat="server" id="Div2">
           <CuteWebUI:Uploader runat="server" ID="Uploader3" InsertText="Upload VO" OnFileUploaded="VO_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

    
     
        

   


     <asp:ListView ID="VOListView" runat="server" DataKeyNames="id" 
        DataSourceID="VODataSource" 
         OnItemUpdating = "VO_ItemUpdating"
          OnItemUpdated="VO_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No VO's Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server">VO Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="VODataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="VO_DataSource_Selecting">
</asp:LinqDataSource>

      <br />
        <br />

            <asp:ListView ID="ArchiveVOListView" runat="server" DataKeyNames="id" 
        DataSourceID="ArchivedVODataSource" 
         OnItemUpdating = "archived_VO_ItemUpdating"
          OnItemUpdated="archived_VO_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No VO's Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"  colspan="3"   runat="server">Archived VO's</th>                             
                                                                                           
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="ArchivedVODataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="archived_VO_DataSource_Selecting">
</asp:LinqDataSource>

          

    <%} %>

 </div> 

    <div id="Other">  
     <%if (true)//Context.User.IsInRole("Director"))
         { %> 

    

 
    <div runat="server" id="Div3">
           <CuteWebUI:Uploader runat="server" ID="Uploader4" InsertText="Upload Other" OnFileUploaded="Other_FileUploaded">
                <ValidateOption AllowedFileExtensions="pdf" EnableMimetypeChecking="true" />
            </CuteWebUI:Uploader>
    </div>
   <br />

   


     <asp:ListView ID="OtherListView" runat="server" DataKeyNames="id" 
        DataSourceID="OtherDataSource" 
         OnItemUpdating = "other_ItemUpdating"
          OnItemUpdated="other_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_icon.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Archive" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Other Docs Uploaded.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"     runat="server">Filename</th>                             
                                <th  align="center" >Last Action Username</th>
                                <th  align="center" >Last Action Date</th>                                                             
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                
                    <td colspan="3"> 
                        Change the dropdown to 'Archived' and click 'Save' : 
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="OtherDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="other_DataSource_Selecting">
</asp:LinqDataSource>

      <br />
        <br />

            <asp:ListView ID="otherArchivedListView" runat="server" DataKeyNames="id" 
        DataSourceID="otherArchivedDataSource" 
         OnItemUpdating = "other_archived_ItemUpdating"
          OnItemUpdated="other_archived_ItemUpdated">
        <ItemTemplate>
                
             <tr>

               
                <td >        
                    <a href="<%# GetFilePath(Eval("id"),Eval("type"),Eval("section"),Eval("filename")) %>" target="_blank" >
                        <img src="pdf_archive.png" /> &nbsp <%#Eval("filename")%> 
                    </a>
                </td>
                
                <td align="center">
                    <%#Eval("last_action_user")%> 

                </td>
                <td align="center">
                    <%#Eval("last_action_date", "{0:ddd, d MMM, yyyy  H:mm:ss}")%> 

                </td>
                 
           
              
                <td >
               
    
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Restore" /> 
                     
                     
               </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Other Docs Archived.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="0"  class="tableSpacing paddedTable themeContent">
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1" colspan="3" runat="server">Archived Other Docs</th>                             
                                                                                           
                                <th colspan="2" align="center" ><font size="2">&nbsp</font></th>                                                            
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
          <EditItemTemplate>

            <tr class="editrow" >
                 
                    <td colspan="3"> 
                        Change the dropdown to 'Current' and click 'Save' :
                      <asp:DropDownList  ID="DropDownList2"  SelectedValue='<%# Bind("status") %>' runat="server">
                            <asp:ListItem Value="current" Text="Current"></asp:ListItem>
                            <asp:ListItem Value="archived" Text="Archived"></asp:ListItem>
                            
                        </asp:DropDownList>
                       
                    </td>
                 
                 
     
                 
                <td class="TDwithButtons">
               
                    
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                       
                       
                        
                        
                </td>
                
            </tr>
        </EditItemTemplate>
       
        
    </asp:ListView>

      <asp:LinqDataSource ID="otherArchivedDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="section_files"
        OnSelecting="other_archived_DataSource_Selecting">
</asp:LinqDataSource>

           

    <%} %>

 </div> 

</div>

</asp:Content>

