<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="section_view.aspx.cs" Inherits="section_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
   <script type="text/javascript">
       $(function () {
           $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

       });
       $(function () {
           $("input[id$='datepicker2']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

       });


       $(function ()
       {
                   $("#tabs").tabs({
                                     show: function() {
                                                          var selectedTab = $('#tabs').tabs('option', 'selected');
                           $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
						   
                                                       },
                                                     selected: <%= hdnSelectedTab.Value %>
                                     });
        });

      
      
     

       $(function  () {
           var hideTasks = $("#"+ '<%= hideTaskTab.ClientID %>').val();
           var selectedTab = $('#tabs').tabs('option', 'selected');
           var hideOrders = $("#"+ '<%= hideOrdersAndListTab.ClientID %>').val();
           var hideNotes = $("#"+ '<%= hideNotesTab.ClientID %>').val();
           
           


           //alert(selectedTab);
           
           if(hideTasks == 'yes'){
               $('#liTabs1').css('display', 'none');
               $('#tabs_1').css('display', 'none');
               if(selectedTab == 0){
                   $( "#tabs" ).tabs({ selected: 1 });
               }
           }
           if(hideNotes == 'yes'){
               $('#liTabs2').css('display', 'none');
               $('#tabs_2').css('display', 'none');
               if(selectedTab == 0 || selectedTab == 1){
                   $( "#tabs" ).tabs({ selected: 2 });
               }
           }
           if(hideOrders == 'yes'){
               $('#liTabs3').css('display', 'none');
               $('#tabs_3').css('display', 'none');
               $('#liTabs4').css('display', 'none');
               $('#tabs_4').css('display', 'none');
               
           }
           document.getElementById("ctl00_ctl00_LoginView2_MenuContentPlaceHolder_MainContentPlaceHolder_FormView1_section_name").parentElement.setAttribute("style", "background:white;border:0");


           $("#tabs").css("background", "white");
           $("#tabs").css("border", "white");
           $("#tabs ul").css("background", "white");
           $("#tabs ul").css("border", "white");
           });
      
      
           
       

       $(document).ready(
           function() 
           {
              var selectTag = $("#ddlBrand");

              selectTag.on(
                  "load", 
                  function() 
                  {
                      var selectedOptionText = $(selectTag).find('option:selected').text();
                      var imageElement = $("#brandLogo");
                      
                      imageElement.attr("src", "Images/" + selectedOptionText + ".png");
                      });
            });


   </script>
 <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />

    <asp:HiddenField ID="hdnSelectedInnerTab" runat="server" Value="0" />
    <asp:HiddenField ID="hideTaskTab" runat="server" Value="na" />
    <asp:HiddenField ID="hideNotesTab" runat="server" Value="na" />
    <asp:HiddenField ID="hideSelectFirstTab" runat="server" Value="yes" />
    <asp:HiddenField ID="hideOrdersAndListTab" runat="server" Value="na" />


<%
    String userName = Page.Request.QueryString["pUserName"];
    String pSeeAll = Page.Request.QueryString["pSeeAll"];

    if (pSeeAll != null && pSeeAll.Equals("yes"))
    {
        userName = "";
    }
    else
    {

        if ((userName == null || userName.Length <= 0) && Context.User.IsInRole("Design Consultant"))
        {
            userName = Context.User.Identity.Name;
        }
    }
    
    
     %>

<div class="titleDiv">
<h1> 
    <asp:Label ID="clientNameLabel" runat="server" Text=""></asp:Label>  -  <asp:Label ID="sectionLabel" runat="server" Text=""></asp:Label> 
</h1>
<span>
    <img ID="brandLogo" width="128" height="64"   src="<%= loadBrandLogo() %>"  title="Brand"/>
</span>
<div id="toolbar" style="float:right">
    
    <%if (!Context.User.IsInRole("Design Consultant")
         && !Context.User.IsInRole("Design Aministrator")
         && !Context.User.IsInRole("Customer Experience Manager")
         && !Context.User.IsInRole("Brand Manager")
         && !Context.User.IsInRole("Assembly Team"))
        { %> 
       &nbsp
        <a class="ui-button ui-corner-all ui-widget" href="section_dispatch.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                        <img src="Images/dispatch_package.png" title="dispatch packages" />
                        </a>
        
        <%} %>
    <%if (!Context.User.IsInRole("Design Consultant")
         && !Context.User.IsInRole("Design Aministrator")
         && !Context.User.IsInRole("Customer Experience Manager")
         && !Context.User.IsInRole("Brand Manager"))
        { %> 

        &nbsp
        <a class="ui-button ui-corner-all ui-widget"  href="section_verify_dispatch.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                        <img src="Images/verify_package.png" title="verify packages" />
         </a> 
     
    <%} %>
        <%if (!Context.User.IsInRole("Design Consultant")
         && !Context.User.IsInRole("Design Aministrator")
         && !Context.User.IsInRole("Customer Experience Manager")
         && !Context.User.IsInRole("Brand Manager"))
        { %> 
        
       &nbsp
  
     
    <button onclick="location='section_verify_select_order.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>'" title="add packages" class="ui-button ui-corner-all ui-widget fa-solid fa-box" >
                                                            </button>

        
        <%} %>
       &nbsp&nbsp
  
  
    <button onclick="location='SectionRenderings.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>'" title="images" class="ui-button ui-corner-all ui-widget fa-solid fa-camera" >
                                                            </button>

        
        &nbsp&nbsp
  
       
        <button onclick="location='SectionFileManagement.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>'" title="documents" class="ui-button ui-corner-all ui-widget fa-solid fa-file-lines" >
                                                            </button>

        &nbsp&nbsp  
       
    <button onclick="location='client_category_popup.aspx?pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>'" title="client responses" rel="shadowbox;height=500;width=800" class="ui-button ui-corner-all ui-widget fa-solid fa-message" >
                                                            </button>

        &nbsp&nbsp
      <%if (Context.User.IsInRole("Director")
         || Context.User.IsInRole("Project Manager")
         || Context.User.IsInRole("Client Liaison"))
        { %> 
        <a class="ui-button ui-corner-all ui-widget" href="task_view_popup.aspx?pDepartmentId=10&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" rel="shadowbox;height=550;width=850"> 
                        <img src="Images/tasks.png" title="admin tasks" />
                        </a>

        &nbsp&nbsp
       <%} %>
        <a class="ui-button ui-corner-all ui-widget" id="clientInfoPopup" href="client_info_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pPartnerId=<%= getPartnerId() %>" rel="shadowbox;height=690;width=800"> 
<img src="Images/client_info.png" title="client info" />

</a>

        &nbsp&nbsp
        <a class="ui-button ui-corner-all ui-widget" href="section_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" rel="shadowbox;height=500;width=750"> 
                                 <img src="Images/section_info.png" title="section info" />
        </a> 
    
        
    &nbsp&nbsp     
        <a class="ui-button ui-corner-all ui-widget"  href="section_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=-1" rel="shadowbox;height=500;width=750"> 
                          <img src="Images/add_section.png" title="add section" />
            </a>
    
        &nbsp&nbsp
        <a class="ui-button ui-corner-all ui-widget" href="sms_log_popup.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/cell-phone.png" title="sms logs" />
            
        </a>

        
        &nbsp&nbsp
      <%if (Context.User.IsInRole("Director")
         || Context.User.IsInRole("Design Consultant")
         || Context.User.IsInRole("Design Administrator"))
        { %> 
       
  
     <a class="ui-button ui-corner-all ui-widget" href="transfer_lead_popup.aspx?pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" rel="shadowbox;height=500;width=650">
                <img src="Images/Right-facing-Arrow-icon.png" title="transfer lead" />
         </a>
        &nbsp&nbsp
       <%} %>
       
        
</div>
</div>

<br />
<br />



<asp:FormView ID="FormView1" runat="server"
        DataKeyNames="section_id,client_id"
        DataSourceID="LinqDataSource1"
         OnItemUpdating = "section_status_itemUpdating"
        OnItemUpdated = "section_status_itemUpdated"
         OnDataBound="after_page_load">
        <EditItemTemplate>
            <asp:HiddenField ID="section_name" runat="server"  Value='<%# Bind("section_name") %>'/>
            <asp:HiddenField ID="in_ops_dept" runat="server"  Value='<%# Bind("in_ops_dept") %>'/>
         <table style="background-color:white; border:none;width:100%;" class=" whiteTr whiteTd">   
         <tr>
             <td  style="vertical-align:top; background:white;">       
            <table id="change_section_status" style="border-spacing:0 0; width:100%; margin-right:0px;" class="whiteTr whiteTd">
                 <tr style="background-color:white;">
                 
                    <td style="background-color:white;" >Brand</td>
                    <td style="background-color:white;">
                    <asp:DropDownList ID="ddlBrand" ClientIDMode="Static" Width="100%" padding="6px"  class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset" float="right"
                                        
                                        
                                        SelectedValue='<%# Bind("Brand") %>'
                                                     
                                            
                                        runat="server">
                            <asp:ListItem Value=0 Text="None"></asp:ListItem>
                            <asp:ListItem Value=1 Text="blu_line"></asp:ListItem>
                            <asp:ListItem Value=2 Text="nuuma"></asp:ListItem>
                            <asp:ListItem Value=3 Text="twelve"></asp:ListItem>
                            <asp:ListItem Value=4 Text="OCD"></asp:ListItem>
                        </asp:DropDownList> 
   
                    </td>

                 </tr>
                 <tr>

                    <td>

                        Lead time(Per Brand)

                    </td>

                    <td >

                        <asp:TextBox ID="TextBox2" runat="server"

                        Text='<%# getLeadTime(getBrandName(Eval("Brand").ToString())) %>' Width="100%" style="padding:6px 0px"  CssClass="ui-corner-all ui-widget-header" />

                    </td>

                   

                </tr>


                <tr>
                    <td style="background-color:white;"> Referral Partner</td>
                    <td style="background-color:white;">
                        <asp:Label ID="refLabel" Text= '<%# Eval("client.referral_partners.name")  ?? "None" %>' Width="100%" style="padding:6px 0px 6px 1px" class="ui-corner-all ui-widget-header ui-accordion ui-widget ui-helper-reset" runat="server" />
                    </td>
                </tr>
                 <tr style="background-color:white;">
                 
                    <td style="background-color:white;" >Change Section Status</td>
                    <td style="background-color:white;">
                    <asp:DropDownList Visible="<%#getSectionStatusVisiblility(0) %>" ID="quote_status_list" Width="100%" padding="6px"  class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset"
                                                      DataSourceID = "QuoteStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("quote_status_id") %>'
                                                     
                                                      OnSelectedIndexChanged = "section_status_changed"    
                                                      runat="server">
                            
                        </asp:DropDownList> 
                        <asp:DropDownList Visible="<%#getSectionStatusVisiblility(2) %>" ID="production_status_list" padding="6px" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset" Width="100%" 
                                                      DataSourceID = "ProductionStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("production_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList> 
                        
                        <asp:DropDownList Visible="<%#getSectionStatusVisiblility(4) %>"  ID="service_status_list" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset" Width="100%" float="right" 
                                                      DataSourceID = "ServiceStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("service_call_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList> 
                    
                        
                    </td>
            
                 </tr>
                
                 <tr style="background-color:white;">
                 
                    <td style="background-color:white;">
                   
                    
                       Quote Value (incl VAT) R
                     
                    </td>
                    <td>
                   
                       <asp:TextBox Visible="<%#getAllowedToViewFinance() %>" CssClass="ui-corner-all ui-widget-header ui-helper-reset" ID="quote_valueTextBox" runat="server"  style="padding:6px 0px 6px 1px"  width="100%"
                            Text='<%# Bind("quote_value") %>'/>
                            
                    </td>
                
                 </tr>
                 
                 <tr>
                    <td>
                        Quote Status
                    </td>
                    <td>
                        <asp:DropDownList  Enabled="<%#getAllowedToView() %>" ID="DropDownList2" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset" Width="100%" float="right" 
                                               
                                                      SelectedValue='<%# Bind("quote_status") %>'
                                                      
                                                      runat="server">
                            <asp:ListItem Value="Pending" Text="Pending"></asp:ListItem>
                            <asp:ListItem Value="Won" Text="Won (Deposit Received)"></asp:ListItem>
                            <asp:ListItem Value="Lost" Text="Lost"></asp:ListItem>
                        </asp:DropDownList>
                        
                    </td>
                
                </tr>
               
                <tr>
                    
                    <td colspan="2">
                        <asp:TextBox placeholder="Reason..." ID="lost_reason_otherTextBox" runat="server" style="padding:6px 0px"  CssClass="ui-corner-all ui-widget-header"
                        Text='<%# Bind("lost_reason_other") %>' Width="100%"/>
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        Scheduled Installation
                    </td>
                    <td >
                        <asp:TextBox ID="TextBox1" runat="server"
                        Text='<%# Bind("notes") %>' Width="100%" style="padding:6px 0px"  CssClass="ui-corner-all ui-widget-header" />
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        Installation Team
                    </td>
                    <td >
                        <asp:DropDownList class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion-content-active ui-accordion ui-widget ui-helper-reset"  ID="TeamDropDownList" Width="100%" 
                                                      DataSourceID = "InstallersLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      SelectedValue='<%# Bind("installation_team") %>'
                                                      AppendDataBoundItems=true    
                                                      runat="server">
                            <asp:ListItem Text="--- Select Team ---" Value=""></asp:ListItem>
                        </asp:DropDownList> 
                    </td>
                    
                </tr>
                <tr>
                    <td colspan="2">
                    <font color="black"><%# GetInstallationTime(Eval("quote_value"))%></font>
</td>
                </tr>
                
                 <tr>
                 <td>&nbsp</td>
                 <td align="right"> <asp:Button ID="UpdateButton" runat="server" 
                            CausesValidation="False" 
                            CommandName="Update" Text="Save" />  </td>
                 </tr>
                
                 
                 
                 
                 
                 
                 
            </table>
            </td>
            <td style="background:white; margin-block:30px;">
            
            <table style="width:100%;" class="whiteTr whiteTd">
            <tr style="background-color:white;" class="whiteTr">
            <td style="vertical-align:top; background:white" class="whiteTr">   <div style="margin:5px; background-color:white;"><strong> Details:</strong></div>
            <asp:TextBox style="resize:none; background-color:white; border-color:transparent;" readonly="true" ID="namesTextBox" Columns="40" runat="server" 
                            Text='<%# Eval("client.names") %>' 
                            TextMode="MultiLine" Rows="9" 
                            Width="100%"/>  
            </td>
            <td style="vertical-align:top; background:white" class="whiteTd"> 
            <div style="margin:5px;background-color:white;"><strong> Address:</strong></div>
            <asp:TextBox style="resize:none; background-color:white; border-color:transparent;" readonly="true" ID="install_addressTextBox" runat="server" 
                            Text='<%# Eval("client.install_address") %>' 
                            TextMode="MultiLine" Rows="8" 
                            Width="100%"/>  </td>
            

            </tr>
            
            
            
            </table>





            </td>
                </tr>
            </table>
            
            
        </EditItemTemplate>
      
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>
    
    <hr  style="border-color:#718b9e;"/>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server"
        ContextTypeName="IntranetDataDataContext" 
        EnableInsert="True" 
        EnableUpdate="True" 
        TableName="sections" 
        OnSelecting="status_info_selecting">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="QuoteStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="quote_status_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="CategoryLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="client_categories" OnSelecting="client_categories_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="ProductionStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="production_status_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="ProjectStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="project_status_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="SiteStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="site_status_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="ServiceStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="service_status_selecting"> 
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="InstallersLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="installation_teams" OnSelecting="installation_teams_selecting"> 
    </asp:LinqDataSource>





<br />
<table>

</table>
<br />

    

 
 
<div id="tabs"  border="0px">
    <ul class="ui-widget" border="0px">
       
        <li id="liTabs1" ><a href="#tabs_1">Tasks &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp </a></li>
      
        <li id="liTabs2"><a href="#tabs_2">Notes &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>
       
        <li id="liTabs3" ><a href="#tabs_3">Orders &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp <font size="3" style="color:maroon"><asp:Label runat="server" ID="orderCountLabel" ></asp:Label></font></a></li>
         
        <li id="liTabs4"><a href="#tabs_4"><asp:UpdatePanel runat="server"><ContentTemplate> Plan Gen Lists &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp<font size="3" style="color:maroon"> <asp:Label runat="server" ID="initialSnagCountLabel" ></asp:Label></font></ContentTemplate></asp:UpdatePanel></a></li>
        
        <li id="liTabs5" ><a href="#tabs_5">Appliances &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp  <img src="<% Response.Write( GetYesNoImageAppliances(Page.Request.QueryString["pSectionId"])); %>" /></a></li>
         
        <li id="liTabs6" ><a href="#tabs_6">Ops Workflow &nbsp&nbsp&nbsp &nbsp&nbsp&nbsp</a></li>
         
    </ul>
     
        

    <div id="tabs_1"  class="ui-widget-content">
        <tasks:tasksControl id="taskscontrol" runat="server" />
        <br />
        <completedTasks:completedTasksControl id="completedTasksControl" runat="server" /> 
      
</div>
    
      
 <div id="tabs_2">
  
        <notes:notesControl id="notescontrol" runat="server" />
     
 </div>


<div id="tabs_3" class="ui-widget-content" >
   <%if (!Context.User.IsInRole("Design Consultant") || Context.User.IsInRole("Customer Experience Manager") || Context.User.IsInRole("Director")|| Context.User.IsInRole("Production Controller"))
       { %> 
      <asp:ListView ID="JoblistItemsInsertListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsInsertDataSource" InsertItemPosition="FirstItem"
        OnItemInserting="joblist_items_ItemInserting" 
         OnItemInserted="joblist_items_ItemInserted" >
         
        
        
        <InsertItemTemplate>
            <tr class="newJobList" style="background:white !important; width:500px;">
            
                <td colspan="2">
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="100%" ID="descriptionTextBox" runat="server" Text='<%# Bind("description") %>'  CssClass="ui-corner-all ui-widget"/>
                    <br />
                    <div style="text-align:right">
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert"
                        Text="Save" />
                        </div>
                </td>
                
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>               
                      
        </ItemTemplate>
        <LayoutTemplate>
           
                        <table ID="JobListTable" runat="server" border="0" 
                            style=" width:50%;" class="themeContent">
                            <tr id="Tr2" runat="server" style="font-size:11pt;">  
                                <th id="Th1" align="left"  runat="server">Place New Order</th>

                                <th id="Th2" align="right"   runat="server">
                                    
                                   <%    if (Context.User.IsInRole("Director")
                                         || Context.User.IsInRole("Production Manager")
                                         || Context.User.IsInRole("Production Controller")
                                         || Context.User.IsInRole("Procurement Coordinator")
                                         || Context.User.IsInRole("Technical Services Technician2"))
                                       { %>   
                                    <a class="ui-button ui-corner-all ui-widget"  href="stock_order_popup_new.aspx?pDepartmentId=5&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>" rel="shadowbox;height=550;width=750"> 
                        <img src="Images/tasks.png" title="stock orders" />
                                        <%} %>
                                        </th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
              
    </asp:ListView>

<asp:LinqDataSource ID="JoblistItemsInsertDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="job_list_items"
     OnInserted="joblist_items_OnInserted">
</asp:LinqDataSource>
    <br />
    <h3><b><font size="3">Orders Pending</font></b></h3>
      <asp:ListView ID="JoblistItemsListView" runat="server" DataKeyNames="id" 
        DataSourceID="JoblistItemsDataSource" 
         OnItemUpdating = "joblist_items_ItemUpdating"
          OnItemUpdated="joblist_items_ItemUpdated">
        <ItemTemplate>
                
            <tr>

                <td style="width:30%;" >
                      <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey">Order No: <%#Eval("id") %> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage( Eval("manager_has_processed_order")) %>' /><br />
                  <font size="1" color="grey">  <%#Eval("manager_processed_date", "{0:ddd, d MMM, yyyy}")%> - <%# Eval("manager_processed_name")%></font>
                </td>
                
                <td>
               
                    Date Expeceted:<br /> <%# Eval("date_expected","{0:ddd, d MMM, yyyy}") %>

                    <br />
                    <br />

               <a  href="section_dispatch.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                         <%# GetDispatchInfo(Eval("id")) %> 
                        </a>    



                </td>
               
                
                
                <td class="TDwithButtons" colspan="2"  align="center" >
                
                 
                <%
        string pShowButtonParameter = Page.Request.QueryString["pShowButton"];
        if(pShowButtonParameter != null && pShowButtonParameter.Equals("true"))
        
        { %> 
             
     <a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" title="log order note" />  </a>&nbsp
  
          <%} %>

          <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=SITE ORDER - Due : <%# Eval("date_expected","{0:ddd, d MMM, yyyy}") %> "  target="new" > 
                        <img src="Images/print.png"  align="middle" />  
                    </a> 


            
                    
                    &nbsp

    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;">
                <tr>
                    <td>
                        No Current Orders.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
          
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" runat="server" border="0" class="tableSpacing paddedTable themeContent"
                            style="width:95%; border-collapse: collapse;">
                            <tr id="Tr2" runat="server">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" ><font size="1">Authorised</font></th>
                             
                                <th align="center" ><font size="1">Dispatch Info</font></th>
                                
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
                
            <tr >

                <td style="width:30%;" >
                   <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                    <%# GetOpenTag(Eval("default_item_na")) %>    <%#Eval("description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey">Order No: <%#Eval("id") %>  Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>
                    <%# GetCloseTag(Eval("default_item_na")) %>
                </td>
                <td align="center">
                    <asp:Image ID="imgStatus" runat="server" CssClass="label" ImageURL='<%# GetImage(Eval("item_completed")) %>' /><br />
                  <font size="1">  <%#Eval("date_completed", "{0:ddd, d MMM, yyyy}")%> - <%# Eval("user_completed")%></font>
                </td>
                <td align="center">
                    
                <a  href="section_dispatch.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%Response.Write(Page.Request.QueryString["pClientId"]);%>&pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>" > 
                         <%# GetDispatchInfo(Eval("id")) %> 
                        </a>    

                </td>
               
<td align="center">
               
               <a href="print_generic_job_list_info.aspx?pSectionId=<%#Eval("section_id") %>&pJobListId=<%#Eval("id") %>&pType=Order Received"  target="new" > 
     <img src="Images/print.png"  align="middle" />  </a>&nbsp
                               
     </td>          
            </tr>
          
        </ItemTemplate>
        
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Completed Items.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" class="tableSpacing paddedTable themeContent" runat="server" border="0" 
                            style="width:95%;">
                            <tr id="Tr2" runat="server" style="font-size:11pt;">  
                                <th id="Th1"   runat="server">&nbsp</th>
                                <th align="center" ><font size="1">Completed</font></th>
                                <th align="center" ><font size="1">Dispatch Info</font></th>
                                
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
    
     <%} %>

</div>
    
      
<div id="tabs_4" class="ui-widget-content" >
    <%if (!Context.User.IsInRole("Design Consultant") || Context.User.IsInRole("Director") ||  Context.User.IsInRole("Customer Experience Manager"))
        { %> 
 


    <div id="container" 
        style="width: 100%;
        border:none;
        overflow: hidden;">

    <div id="v_tabs" 
        style="width: 20%;
        float:left; 
        border:none;">
    
        
       
    
<br />
       


                                        
 <asp:ListView ID="WallsListView" runat="server" DataKeyNames="id" 
        DataSourceID="WallsDataSource" >
        <ItemTemplate>
                 <li style="list-style-type: none; " runat="server">
            
               <div style="white-space:nowrap;">           
                <asp:Button runat="server" Width="180px"  ID='button1'  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="change_wall" Text='<%# Eval("wall_label") %>'/>
                     <font size="2" style="color:maroon"> <asp:Label runat="server" ID="initialSnagCountLabel2" Text='<%# getFullWallCount(Eval("id")) %>' ></asp:Label></font>
                </div>
              </li>
            <br />
            
        </ItemTemplate>
        <EmptyDataTemplate>
           There are no Walls loaded
        </EmptyDataTemplate>
         
        <LayoutTemplate>
         <ul ID="itemPlaceholder" runat="server" style="list-style-type: none; ">
                            
                          
             
        </ul>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="WallsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" TableName="walls"
        OnSelecting="walls_DataSource_Selecting">
</asp:LinqDataSource>


    
</div>
        <br />
    <div id="content" 
        style="border:none;
        float: left; width:500px; margin-left:50px;">


    
   

         <asp:HiddenField ID="hideWallId" runat="server" Value="-100" />
        
        <asp:ListView ID="wallListListViewInitial" runat="server" DataKeyNames="id" 
            DataSourceID="WallsChecklistDataSourceInitial" InsertItemPosition="FirstItem"
             OnItemInserting="wall_checklist_ItemInserting_Initial"
             OnItemInserted="wall_checklist_ItemInserted_Initial">
        <ItemTemplate>
            <tr >
              
                <td style="width:300px;">
                    <div id="Div1" runat="server" Visible='<%# Eval("completed") == null %>'>

                        <asp:Label ID="cheklistLabel" runat="server" Text='<%# Eval("description") %>' /><br /><br />
                        <font size="1" color="grey"> 
                            Logged by: <%#Eval("added_user") %> - <%#Eval("added_date","{0:ddd, d MMM, yyyy}") %>
                        </font>

                    </div>
                    <div id="Div3" runat="server" Visible='<%# Eval("completed")==null?false : Eval("completed").ToString().Equals("True")?true:false %>'>

                        <strike><font color="#666666"> <asp:Label ID="Label2" runat="server" Text='<%# Eval("description") %>' /></font> </strike><br /><br />
                        <font size="1" color="#666666"> 
                            Logged by: <%#Eval("added_user") %> - <%#Eval("added_date","{0:ddd, d MMM, yyyy}") %><br />
                            Completed by: <%#Eval("completed_user")%> - <%#Eval("completed_date", "{0:ddd, d MMM, yyyy}")%>
                        </font>
                    </div>
                    <div id="Div2" runat="server" Visible='<%# Eval("completed")==null?false : Eval("completed").ToString().Equals("False")?true:false %>'>
                           
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("description") %>' /><br /><br />
                        <font size="1" color="grey"> 
                            Logged by: <%#Eval("added_user") %> - <%#Eval("added_date","{0:ddd, d MMM, yyyy}") %>
                        </font>

                    </div>
                </td>
                
                <td align="center">
                    
                        
                       <asp:Button ID="toggle" runat="server"  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="change_list_item_status" Text="Change Status"></asp:Button>
                    
                    
                        
                    </div>



                </td>
                
                
                
            </tr>
        </ItemTemplate>
       
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr class="insertrow">
                <%if (hideWallId.Value != null && !hideWallId.Value.Equals("-100"))
                       { %>
                
                <td>
                   
                    
                     <asp:TextBox Columns="50" ID="walllabelTextBox" runat="server" 
                        Text='<%# Bind("description") %>' />
                         </td>
                    <%}
    else
    { %>
                <td colspan="2">
                    NO WALL SELECTED - PLEASE SELECT A WALL
                </td>
                    <%} %>
               

                
                    <%if (hideWallId.Value != null && !hideWallId.Value.Equals("-100"))
                       { %>
                    <td >
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                        </td>
                    <%}
     %>
                   
                   
                
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table  id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table  ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                               
                                
                                <th id="Th1" runat="server" colspan="2">
                                  <%= getWallDescription() %></th>
                                
                                
                               
                                
                            </tr>
                            <tr  ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
       
       
    </asp:ListView>
    <asp:UpdateProgress id="updateProgress" runat="server">
    <ProgressTemplate>
        <div id="blocker">
            <div><i class="icon-spinner icon-spin icon-large"></i> Loading...</div>
         </div>
    </ProgressTemplate>
</asp:UpdateProgress>


<asp:LinqDataSource ID="WallsChecklistDataSourceInitial" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="wall_checklist_items"
        OnSelecting="WallsChecklistDataSource_Selecting_Initial" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True"
        >
    </asp:LinqDataSource>

    </div>
    </div>
    <%} %>
   
</div>

 <div id="tabs_5" >
  
      <asp:ListView ID="ApplianceInsertListView" runat="server" DataKeyNames="id" 
        DataSourceID="ApplianceInsertDataSource" InsertItemPosition="FirstItem"
        OnItemInserting="appliance_items_ItemInserting" 
         OnItemInserted="appliance_items_ItemInserted" >
         
        
        
        <InsertItemTemplate>
            <tr class="newJobList">
            
                <td >
                    <asp:TextBox TextMode="MultiLine" Rows="7" Width="100%" ID="descriptionTextBox" runat="server" Text='<%# Bind("appliance_description") %>' />
                    <br />
                     <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Save" />
                            
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
                
        </ItemTemplate>
        <LayoutTemplate>
           
                        <table ID="JobListTable" runat="server" border="0" class="tableSpacing paddedTable themeContent"
                            style=" width:50%;">
                            <tr id="Tr2" runat="server" style="font-size:11pt;">  
                                <th id="Th1"   runat="server">Enter Appliance Listing</th>
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    
        </LayoutTemplate>
    </asp:ListView>

<asp:LinqDataSource ID="ApplianceInsertDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="True" EnableUpdate="False" TableName="section_appliances">
</asp:LinqDataSource>
    <br />
      <asp:ListView ID="ApplianceItemsListView" runat="server" DataKeyNames="id" 
        DataSourceID="ApplianceItemsDataSource" 
         OnItemUpdating = "appliance_items_ItemUpdating"
          OnItemUpdated="appliance_items_ItemUpdated">
        <ItemTemplate>
                
            <tr>

                <td style="width:50%;">
  
                        <%#Eval("appliance_description").ToString().Replace("\n", "<br/>") %><br /><br />
                      <font size="1" color="grey"> Logged by: <%#Eval("user_logged") %> - <%#Eval("date_logged","{0:ddd, d MMM, yyyy}") %> </font>

                </td>
                
                
               
                <td align="center">
                    <asp:Image ID="Image1" runat="server" CssClass="label" ImageURL='<%# GetApplianceConfirmedImage( Eval("confirmed")) %>' /><br />
                  <font size="1" color="grey"> <%#Eval("user_confirmed") %> -  <%#Eval("date_confirmed", "{0:ddd, d MMM, yyyy}")%></font>
                </td>
               
                <td class="TDwithButtons"   align="center" >
                
               <div style=" vertical-align:top">    
             <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Update" />
</div>
      
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" class="tableSpacing paddedTable themeContent" >
                <tr>
                    <td>
                        No Appliances Listed.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
          <EditItemTemplate>

            <tr>
 
                <td style="width:50%;">
                    <asp:TextBox TextMode="MultiLine" Rows="10" Width="95%"  ID="descriptionTextBox" runat="server" Text='<%# Bind("appliance_description") %>' />
                     
                </td>
                 
                <td align="center" >
                    
                 <asp:CheckBox ID="CheckBox3" Text="Confirmed" TextAlign="Left"  runat="server" Checked='<%# Bind("confirmed") %>'  /><br />
                    <font size="1"> (Built-In & Free-standing)</font>
                    
                </td>
               
                <td class="TDwithButtons"   align="center" >
                
                
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                  
                </td>
                
            </tr>

        </EditItemTemplate>
        <LayoutTemplate>
         
                        <table ID="itemPlaceholderContainer" cellpadding="3" runat="server" border="0" class="tableSpacing paddedTable themeContent" 
                            style="width:95%;">
                            <tr id="Tr2" runat="server" style="font-size:11pt;">  
                                
                                <th align="center" ><font size="2">Appliance Listing</font><font size="1"> (Built-In & Free-standing)</font></th>
                                <th align="center" ><font size="2">Confirmed</font></th>
                                
                                
                                <th >&nbsp</th>
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

<asp:LinqDataSource ID="ApplianceItemsDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="section_appliances"
        OnSelecting="appliance_items_DataSource_Selecting">
</asp:LinqDataSource>
        
     
 </div>

 <div id="tabs_6" >
     <asp:FormView ID="FormView2" runat="server" 
        DataKeyNames="id" 
        DataSourceID="OpsWorkflowDataSource"
        OnItemUpdating = "ops_workflow_ItemUpdating"
          OnItemUpdated="ops_workflow_ItemUpdated">

        <ItemTemplate>
           <table runat="server" cellpadding="3" border="0" class="ui-widget-content paddedTable tableSpacing">     
             <tr class="ui-corner-all ui-widget ui-helper-reset">

                <td class="headingTD ui-widget-header ui-accordion-header-active"> 
               
                Contract / Expectation Date
                
                </td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                       <%#Eval("contract_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                </tr>
               <tr>
                   <td class="headingTD ui-widget-header ui-accordion-header-active"> 
               
                Planned Site Delivery Date
                
                </td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                    <%#Eval("site_delivery_date", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                 </tr>
               <tr>
                   <td class="headingTD ui-widget-header ui-accordion-header-active">Appliances Confirmed</td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                    <asp:Image ID="Image4" runat="server" CssClass="label" ImageURL='<%# GetApplianceYesNoImage(Eval("section")) %>' /><br />
                    



                </td>
                   </tr>
               <tr>
                   <td class="headingTD ui-widget-header ui-accordion-header-active">Final Measurements Complete</td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                   <asp:Image ID="Image5" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("final_measurements_complete")) %>' /><br />
                    <font size="1" color="black">completed by : <%#Eval("final_measurements_complete_by")%> - <%#Eval("final_measurements_complete_date", "{0:ddd, d MMM, yyyy}")%></font>



                </td>
                   </tr>
               <tr>
                   <td class="headingTD ui-widget-header ui-accordion-header-active">In Production</td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                   <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("in_production")) %>' />
                    <font size="1" color="black"> <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>



                </td>

                   </tr>
               <tr>
                   <td class="headingTD ui-widget-header ui-accordion-header-active">Production Complete</td>
                <td class="headingTD ui-widget-header ui-accordion-header-active" align="center">
                   <asp:Image ID="Image6" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("production_complete")) %>' />
                    <font size="1" color="black"> <%#Eval("production_complete_date", "{0:ddd, d MMM, yyyy}")%></font>



                </td>

                   </tr>


                
                <tr>
                
                
              
                <td colspan="2" class="TDwithButtons"  align="right">
               
    
                   
                </td>
                
            </tr>
         </table>
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" 
                style="border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                        No Data.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
       
        <EditItemTemplate>
             <table runat="server" cellpadding="3" border="0">     
             <tr >

                <td class="headingTD"> 
              
                Contract / Expectation Date
                
                </td>
                <td align="center">
                    <asp:HiddenField ID="sectionId" runat="server"  Value='<%# Bind("section.section_id") %>'/>
                       <asp:TextBox  style="border-color:Gray" placeholder="Contract Date..." ID="datepicker"  runat="server" Text='<%# Bind("contract_date","{0:ddd, d MMM, yyyy}") %>' />


                </td>
                </tr>
               <tr >
                   <td class="headingTD"> 
               
                Planned Site Delivery Date
                
                </td>
                <td align="center">
                    <asp:TextBox  style="border-color:Gray" placeholder="Site Delivery Date..." ID="datepicker2"  runat="server" Text='<%# Bind("site_delivery_date","{0:ddd, d MMM, yyyy}") %>' Enabled='<%# GetCanChangeSiteDate(Eval("in_production")) %>' />


                </td>
                 </tr>
               <tr>
                   <td class="headingTD">Appliances Confirmed</td>
                <td align="center">
                    <asp:Image ID="Image7" runat="server" CssClass="label" ImageURL='<%# GetApplianceYesNoImage(Eval("section")) %>' /><br />
                    



                </td>
                   </tr>
               <tr >
                   <td class="headingTD">Final Measurements Complete</td>
                <td align="center">
                   <asp:CheckBox ID="CheckBox7"  Text="Final Measurements Complete" TextAlign="Right" runat="server" Checked='<%# Bind("final_measurements_complete") %>' Enabled='true' />
                
                    


                </td>
                   </tr>
               <tr>
                   <td class="headingTD">In Production</td>
                <td align="center">
                   <asp:Image ID="Image3" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("in_production")) %>' />
                    <font size="1" color="black"> <%#Eval("into_production_date", "{0:ddd, d MMM, yyyy}")%></font>



                </td>

                   </tr>
               <tr>
                   <td class="headingTD">Production Complete</td>
                <td align="center">
                   <asp:Image ID="Image6" runat="server" CssClass="label" ImageURL='<%# GetYesNoImage(Eval("production_complete")) %>' />
                    <font size="1" color="black"> <%#Eval("production_complete_date", "{0:ddd, d MMM, yyyy}")%></font>



                </td>

                   </tr>


                
                <tr>
                
                
              
                <td colspan="2" class="TDwithButtons"  align="right">
               
    
                    <asp:Button ID="Button2" runat="server" CommandName="Update" 
                        Text="Save" />
                    <asp:Button ID="Button3" runat="server" CommandName="Cancel" 
                        Text="X" />
                     
                </td>
                
            </tr>
         </table>




           
                   
                
                 
              
        </EditItemTemplate>
        
    </asp:FormView>

      <asp:LinqDataSource ID="OpsWorkflowDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="True" 
        EnableInsert="False" EnableUpdate="True" TableName="project_dates"
        OnSelecting="ops_workflow_DataSource_Selecting">
       <UpdateParameters>
            <asp:Parameter Name="contract_date" ConvertEmptyStringToNull="true"/>
           <asp:Parameter Name="site_delivery_date" ConvertEmptyStringToNull="true"/>
        </UpdateParameters>
</asp:LinqDataSource>



 </div>

   
 
 </div>
           
 








    




   





</asp:Content>