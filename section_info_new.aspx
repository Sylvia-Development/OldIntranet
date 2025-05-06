<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="section_info_new.aspx.cs" Inherits="section_info_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <%--<script type="text/javascript">
  function popup(mylink, windowname) { 
    if (! window.focus)return true;
    var href;
    if (typeof(mylink) == 'string') href=mylink;
    else href=mylink.href; 
    window.open(href, windowname, 'width=500,height=300,scrollbars=yes'); 
    return false; 
  }
</script>--%>


    
   
    <asp:Label style="font-size:6; float:left; margin-left:15px;" ID="clientNameLabel" runat="server" Text="" Visible="false"></asp:Label>
 
    
    <%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<font color='black' size='4'>" + Message + "</font>");
    }
        %> 
    
    <div style=" background: white; color:black;">
    <asp:FormView ID="FormView1" runat="server" 
        DataKeyNames="section_id" 
        DataSourceID="LinqDataSource1"
        OnItemInserting="section_info_ItemInserting"
        OnItemInserted = "section_info_itemInserted"
         OnItemUpdating = "section_info_itemUpdating"
          OnItemUpdated = "section_info_itemUpdated"
           OnItemCreated = "section_item_created"
            OnLoad ="formview_load">
        <EditItemTemplate>
            <div style="text-align:left; margin:50px 5px;">
        <asp:ValidationSummary ID="ValidationSummary1"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            <asp:TextBox ID="clientIdTextBox" runat="server" 
                            Text='<%# Bind("client_id") %>' 
                              Visible = "false"/>
                    
            <table style="text-align:left;"  class="tableSpacing paddedTable">
                <tr>
                    <td style="padding:6px; margin:3px;">
                        <span style="padding:6px 0px">Section Name</span><asp:requiredfieldvalidator id="RequiredFieldValidator1" 
                             runat="server" 
                             ControlToValidate="section_nameTextBox" 
                             ErrorMessage="Section Name cannot be blank">*
                         </asp:requiredfieldvalidator>
                    </td>
                    <td style="padding:6px; margin:3px;"> 
                    
                    
                        <asp:TextBox ID="section_nameTextBox" runat="server" 
                            Text='<%# Bind("section_name") %>' 
                            padding="6px"
                            Width="100%"/>
                    </td>
                    
                 </tr>
                <tr>
                    <td style="padding:6px; margin:3px;">
                        <span style="padding:6px 0px">Brand</span><asp:requiredfieldvalidator id="RequiredFieldValidator2" 
                             runat="server" 
                             ControlToValidate="brand_nameTextBox" 
                             ErrorMessage="Brand Name is required">*
                         </asp:requiredfieldvalidator>
                    </td>
                    <td style="padding:6px; margin:3px;"> 
                    
                    
                        <asp:TextBox ID="brand_nameTextBox" runat="server" 
                            Text='<%# Bind("Brand") %>' 
                            padding="6px"
                            Width="100%"/>
                    </td>
                    
                 </tr>
                
                 <tr>
                    <td style="padding:6px; margin:3px;">
                       <span> Referred From </span>
                    </td>
                    <td style="padding:6px; margin:3px;">
                        <asp:DropDownList ID="referrer_list" Width="100%" class="ui-corner-all ui-autocomplete-input ui-widget-content"
                                                      DataSourceID = "ReferrerLinqDataSource" 
                                                      DataValueField = "referrer_id"  
                                                      DataTextField="referrer_name"
                                                      padding="6px"
                                                      SelectedValue='<%# Bind("referrer_id") %>'
                                                         
                                                      runat="server">
                            
                        </asp:DropDownList> 
                    
                      
                    </td>
                   
                 </tr>
                <tr>
                 <td style="padding:6px; margin:3px;">
               
                        In Ops Department
                       
                    </td>
                    <td style="padding:6px; margin:3px;">
                    
                        <asp:DropDownList  ID="DropDownList2" Width="100%"  class="ui-corner-all ui-autocomplete-input ui-widget-content "
                                               
                                                      SelectedValue='<%# Bind("in_ops_dept") %>'
                                                      
                                                      runat="server">
                            <asp:ListItem Value="0" Text="No"></asp:ListItem>
                            <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
                            <asp:ListItem Value="" Text=""></asp:ListItem>
                        </asp:DropDownList>
                       
                    </td>
             
                 
                 </tr>
           
                
               <tr>
                    <td  ">&nbsp</td>
                    <td  align="right"><asp:Button ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="Save" /></td>
                
                </tr>
            
            
           </div> 
        </EditItemTemplate>
        <InsertItemTemplate>
       <asp:ValidationSummary ID="ValidationSummary2"
            
            DisplayMode="List"
            EnableClientScript="true"
            runat="server"/>
            <asp:TextBox ID="TextBox1" runat="server" 
                            Text='<%# Bind("client_id") %>' 
                              Visible = "false"/>
        
            <asp:TextBox ID="clientIdTextBox" runat="server" 
                            Text='<%# Bind("client_id") %>' 
                              Visible = "false"/>
                <br />    
            <table id="section_info_table">
                <tr>
                    <td style="padding:6px; margin:3px;">
                        Section Name<asp:requiredfieldvalidator id="RequiredFieldValidator1" 
                             runat="server" 
                             ControlToValidate="section_nameTextBox" 
                             ErrorMessage="Section Name cannot be blank">*
                         </asp:requiredfieldvalidator>
                    </td>
                    <td style="padding:6px; margin:3px;">
                    
                    
                        <asp:TextBox ID="section_nameTextBox" runat="server" 
                            Text='<%# Bind("section_name") %>' 
                            Width="100%"/>
                            
                    </td>
                    <td>
                        &nbsp
                    </td>
                    <td>
                        &nbsp 
                        
                        
                    </td>
                 </tr>
                 <tr>
                    <td style="padding:6px; margin:3px;">
                        <span style="padding:6px 0px">Brand</span>
                        <%--<asp:requiredfieldvalidator id="RequiredFieldValidator2" 
                             runat="server" 
                             ControlToValidate="ddlBrand" 
                             ErrorMessage="Brand Name is required">*
                         </asp:requiredfieldvalidator>--%>
                         <asp:CustomValidator  id="CustomValidator2" runat="server" 
                             ControlToValidate="ddlBrand" 
                             ErrorMessage="Please Select a Brand Name" 
                             OnServerValidate="validate_brand"> *
                         </asp:CustomValidator>
                    </td>
                    <td style="padding:6px; margin:3px;"> 
                    
                    <asp:DropDownList ID="ddlBrand" ClientIDMode="Static" Width="100%" padding="6px"  class="ui-corner-all  ui-widget-content" float="right"
                                        
                                        
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
                    <td style="padding:6px; margin:3px;">
                        Referred From
                    </td>
                    <td style="padding:6px; margin:3px;" >
                        <asp:DropDownList ID="referrer_list" Width="100%" class="ui-corner-all ui-widget-content"
                                                      DataSourceID = "ReferrerLinqDataSource" 
                                                      DataValueField = "referrer_id"  
                                                      DataTextField="referrer_name"
                                                      SelectedValue='<%# Bind("referrer_id") %>'
                                                         
                                                      runat="server">
                            
                        </asp:DropDownList> 
                    
                      
                    </td>
                    <td style="padding:6px; margin:3px;">
                       <asp:TextBox Visible="false" ID="quote_valueTextBox" runat="server" 
                            Text='<%# Bind("quote_value") %>' Width="100%"/>

                    </td>
                    <td>
                       &nbsp
                    </td>
                 </tr>
                 <tr>
                <td>&nbsp</td>
                    <td align="right" style="padding:6px; margin:3px;">
                    
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="Save" /></td>
                
                
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                
                </tr>
                 <tr>
                 
                    <td>
                        &nbsp 
                    </td>
                    <td>
                        
                    
                    
                    
                    
                        <asp:DropDownList Visible='false' ID="quote_status_list" Width="100%" 
                                                      DataSourceID = "QuoteStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("quote_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList> 
                        <asp:DropDownList Visible="false" ID="production_status_list" Width="100%" 
                                                      DataSourceID = "ProductionStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("production_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList> 
                        <asp:DropDownList Visible="false" ID="project_status_list" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset"
                                                      DataSourceID = "ProjectStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("projects_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList> 
                        <asp:DropDownList Visible="false" ID="site_status_list" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset"
                                                      DataSourceID = "SiteStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("site_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                        <asp:DropDownList Visible="false" ID="service_status_list" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-accordion ui-widget ui-helper-reset"
                                                      DataSourceID = "ServiceStatusLinqDataSource" 
                                                      DataValueField = "status_id"  
                                                      DataTextField="status_name"
                                                      SelectedValue='<%# Bind("service_call_status_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                    
                    
                    
                        
                    </td>
                    
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                 </tr>
            </table>
            <table  id="quote_status_table">
                <tr>
                    <td>
                        &nbsp
                    </td>
                    <td>
                        <asp:DropDownList Visible="false" ID="DropDownList1" Width="100%" class="ui-corner-all ui-widget-header ui-autocomplete-input ui-helper-reset"
                                               
                                                      SelectedValue='<%# Bind("quote_status") %>'
                                                      
                                                      runat="server">
                            <asp:ListItem Value="Pending" Text="Pending"></asp:ListItem>
                            <asp:ListItem Value="Won" Text="Won (Deposit Received)"></asp:ListItem>
                            <asp:ListItem Value="Lost" Text="Lost"></asp:ListItem>
                        </asp:DropDownList>
                        
                    </td>
                    <td>&nbsp</td>
                    <td>&nbsp</td>
                
                </tr>
                
                <tr>
                    <td>
                        &nbsp
                    </td>
                    <td>
                       
                    
                        
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                
               
                

            
            
        </InsertItemTemplate>
        <EmptyDataTemplate>
            
          No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="True" 
        EnableUpdate="True" TableName="sections" OnSelecting="section_info_selecting">
        
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="QuoteStatusLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="status" OnSelecting="quote_status_selecting"> 
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




    <asp:LinqDataSource ID="ReferrerLinqDataSource" runat="server"
    ContextTypeName="IntranetDataDataContext" 
         TableName="referrers" OrderBy="referrer_name" 
        Select="new (referrer_id, referrer_name)" > 
    </asp:LinqDataSource>
  
   

    </div>
 <%--</div>
 </div>--%>

 
 

</asp:Content>

