<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="add_asset_items.aspx.cs" Inherits="add_asset_items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<script type="text/javascript">
    $(function () {
        $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

    });

  
    
       
    
 </script>


<div style=" padding-left:20px;">
<%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<font color='black' size='4'>" + Message + "</font>");
    }
        %>
        
        </div> 
        <div class="titleDiv">
        <h1>Add Asset</h1>
        </div>
    <asp:FormView ID="FormView1" runat="server" 
     DefaultMode="Insert"
        DataKeyNames="id" 
        DataSourceID="LinqDataSource3"
         
         OnItemInserted = "asset_item_itemInserted"
          OnItemInserting = "asset_item_itemInserting">
          
        
        <InsertItemTemplate>
          
            <table id="asset_item_table">
                <tr>
                    
                    <td>    
                        Asset Class
                    </td>
                    <td>
                        <asp:DropDownList ID="class_DropDownList" Width="100%" 
                                                      DataSourceID = "AssetClassesLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      SelectedValue='<%# Bind("class_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                        
                    </td>   
                </tr>
                <tr>
                    
                    <td>    
                        Asset Group
                    </td>
                    <td>
                        <asp:DropDownList ID="Group_DropDownList" Width="100%" 
                                                      DataSourceID = "AssetGroupsLinqDataSource" 
                                                      DataValueField = "id"  
                                                      DataTextField="description"
                                                      SelectedValue='<%# Bind("group_id") %>'
                                                          
                                                      runat="server">
                            
                        </asp:DropDownList>
                        
                    </td>   
                </tr>
                <tr>
                    <td>    
                        Description
                    </td>
                    <td >
                        <asp:TextBox ID="descriptionTextBox" runat="server" 
                            Text='<%# Bind("description") %>' 
                             
                            Width="100%"/>
                    </td>  
                   
                        
                
                    
                </tr>  
                <tr>
                   <td>    
                        Purchase Price  R
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="priceTextBox" runat="server" 
                            Text='<%# Bind("purchase_price") %>' 
                             
                            Width="100%"/>
                    </td>        
                </tr>
                <tr>
                    <td>    
                        Purchase Date
                    </td>
                    <td>
                       <asp:TextBox   ID="datepicker" runat="server" 
                        Text='<%# Bind("purchase_date") %>'  Width="100%"/> 
                    </td>  
                   
                </tr>   
                <tr>
                    <td>    
                       Extra Info
                    </td>
                    <td>
                        <asp:TextBox ID="notes_TextBox" runat="server" 
                            Text='<%# Bind("notes") %>' 
                             
                            Width="100%"/>
                    </td>
                    
                </tr>
                
               
                <tr>
                   
                    <td>&nbsp;</td>
                    <td> 
                        <asp:Button ID="LinkButton2" runat="server" 
                        CausesValidation="True" 
                        CommandName="Insert" 
                        Text="Save" />
                    </td>
                </tr>

            </table>

            
            
        </InsertItemTemplate>
        
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>

<asp:LinqDataSource ID="LinqDataSource3" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="True" 
        EnableUpdate="False" TableName="asset_items"
         OnInserted="datasource_Inserted">
    </asp:LinqDataSource>
    <asp:LinqDataSource ID="AssetClassesLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableInsert="False" 
        EnableUpdate="False" Select="new (id, description)" 
        TableName="asset_classes">
    </asp:LinqDataSource>

    <asp:LinqDataSource ID="AssetGroupsLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" OrderBy="description" 
        Select="new (id, description)" 
        TableName="asset_groups">
    </asp:LinqDataSource>



</asp:Content>

