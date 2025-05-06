<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="verify_sitelist_items.aspx.cs" Inherits="verify_sitelist_items" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">


<h1> 
   <%Response.Write(GetWallClientNameSection(Page.Request.QueryString["pWallId"]));%>
</h1>
<br />

<a href="section_walls.aspx?pSectionId=<%Response.Write(Page.Request.QueryString["pSectionId"]);%>"><< Back</a>
    <br />
    <br />
   
<h1> Wall Catagories</h1>
<asp:ListView ID="ListView1" runat="server" DataKeyNames="id" 
            DataSourceID="WallsChecklistCategoryDataSource" >
        <ItemTemplate>
            <tr >
                
                
                <td>
                   
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("description") %>' />
                       
                   
                </td>
              
                <td align="center" nowrap>
                    
                        
                       <asp:Button ID="toggle" runat="server"  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="set_is_catagory_relevant" Text="YES"></asp:Button>
                    &nbsp&nbsp&nbsp

                    <asp:Button ID="LinkButton1" runat="server"  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="set_is_catagory_NOT_relevant" Text="NO"></asp:Button>
                    
                        
                    



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
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                               
                                
                                <th id="Th1" colspan="2" runat="server">
                                    Catagory Question</th>
                               
                               
                               
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
     
       
    </asp:ListView>


<br />
     <h1>Individual Items</h1>  
<asp:ListView ID="ListView2" runat="server" DataKeyNames="id" 
            DataSourceID="WallsChecklistDataSource" InsertItemPosition="LastItem"
            OnItemInserting="wall_checklist_ItemInserting">
        <ItemTemplate>
            <tr >
                
                
                <td>
                    <div id="Div1" runat="server" Visible='<%# Eval("item_relevant_to_wall") == null %>'>

                    <font color="maroon"><asp:Label ID="cheklistLabel" runat="server" Text='<%# Eval("description") %>' /></font>
                        </div>
                    <div id="Div3" runat="server" Visible='<%# Eval("item_relevant_to_wall")==null?false : Eval("item_relevant_to_wall").ToString().Equals("True")?true:false %>'>

                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("description") %>' />
                        </div>
                    <div id="Div2" runat="server" Visible='<%# Eval("item_relevant_to_wall")==null?false : Eval("item_relevant_to_wall").ToString().Equals("False")?true:false %>'>
                           <strike><font color="#666666"> <asp:Label ID="Label1" runat="server" Text='<%# Eval("description") %>' /></font> </strike>

                        </div>
                </td>

                


               
                <td align="center" nowrap>
                    
                        
                       <asp:Button ID="toggle" runat="server"  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="set_is_relevant" Text="YES"></asp:Button>
                    &nbsp&nbsp&nbsp

                    <asp:Button ID="LinkButton1" runat="server"  CommandArgument='<%# Eval("id") %>'
                                        OnCommand="set_is_NOT_relevant" Text="NO"></asp:Button>
                    
                        
                    </div>



                </td>
                <td nowrap>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="Delete" />

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
                
                
                <td>
                    <asp:TextBox ID="walllabelTextBox" runat="server" 
                        Text='<%# Bind("description") %>' Width="90%" />
                        
                    
               <asp:DropDownList ID="type_DropDownList"  
                                                      SelectedValue='<%# Bind("item_type") %>' Visible="false" runat="server">
                                                      
           
                                                     
                      
                      <asp:ListItem Value="0" Text="Initial" Selected="True"></asp:ListItem>
                      <asp:ListItem Value="1" Text="Finishing"></asp:ListItem>
                      
                            
                        </asp:DropDownList></td>
                
               
                <td>&nbsp</td>
                <td >
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                   
                </td>
                
            </tr>
        </InsertItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">
                               
                                
                                <th id="Th1" runat="server">
                                    Checklist Item Description</th>
                                
                                <th id="Th3" runat="server">
                                    Is Relevant ?
                                </th>
                                <th>&nbsp</th>
                               
                                
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
               
            </table>
        </LayoutTemplate>
        <EditItemTemplate>
            <tr class="editrow">
                
                
                <td>
                    <asp:TextBox ID="walllabelTextBox" runat="server" 
                        Text='<%# Bind("description") %>' Width="90%" />
                        
                </td>

               


                
                <td align="center">
                
                        
                        &nbsp
                    
                
                
                
                </td>
                <td nowrap>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="X" />
                </td>
                
            </tr>
        </EditItemTemplate>
       
    </asp:ListView>


<asp:LinqDataSource ID="WallsChecklistDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="wall_checklist_items"
        OnSelecting="WallsChecklistDataSource_Selecting" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True">
    </asp:LinqDataSource>
<asp:LinqDataSource ID="WallsChecklistCategoryDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" 
        TableName="wall_checklist_catagories"
        OnSelecting="WallsChecklistCatagoryDataSource_Selecting" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="False" >
    </asp:LinqDataSource>


</asp:Content>

