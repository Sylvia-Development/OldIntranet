<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="production_dashboard.aspx.cs" Inherits="production_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<div id="one_column">
 <h1>Production Management</h1>



<br />
&nbsp
<hr />


<%  String Message = Page.Request.QueryString["pMessage"];
    if (Message != null && Message.Length > 0)
    {
        Response.Write("<div style=\"margin-left:40px;\"><font color='red' size='3'>" + Message + "</font><br/><br/><br/></div>");
    }
        %> 



     
                
                
        
    
   
 <br />
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="status_id" 
        DataSourceID="StatusLinqDataSource">
        <ItemTemplate>
            <li style="background-color:Transparent; color: #000000;">
                
                
                <asp:Label Font-Size="13px" ForeColor="DarkBlue" Font-Bold="true" ID="status_nameLabel" runat="server" 
                    Text='<%# Eval("status_name") %>' />
                <br />
                
                
                <input type="hidden" id="hiddenInput" value='<%# Eval("status_id") %>' runat="server" />
                
                
                <asp:ListView ID="ListView2" runat="server"
                DataSourceID="SectionLinqDataSource">
                <ItemTemplate>
                <input type="hidden" id="hiddenInput2" value='<%# Eval("section_id") %>' runat="server" />
                
                <tr style="background-color:#DCDCDC;color: #000000;">
                    <td>
                    
                        <a      style="color:black"  
                                href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%> "rel="shadowbox;height=490;width=650"> 
                                <b><u>   <%# Eval("client.job_name") %></u></b>
                        </a>
                                
                         - 
                         <a      style="color:black"  
                                href="section_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>"rel="shadowbox;height=280;width=400"> 
                                <b>  <%# Eval("section_name") %></b>
                        </a>        

                      </td>
                    
                    
                    
                    
                    
                    
                    
                    <td align="left"> 
                        <asp:FormView ID="ContactFormView" runat="server"
                            DataSourceID="ContactLinqDataSource">
                            <ItemTemplate>
                                <a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>    "><%# Eval("reminder1") %></a>
                                                
                                
                            </ItemTemplate>
                        </asp:FormView>      </td>
                    <td align="left"> <asp:FormView ID="WorkflowFormView" runat="server"
                            DataSourceID="WorkflowLinqDataSource">
                            <ItemTemplate>
                                <a href="section_view.aspx?pReminderType=1&pSectionId=<%# Eval("section_id")%>&pDepartmentId=<%# Eval("department_id")%>&pClientId=<%# Eval("section.client_id")%>    "><%# Eval("reminder1") %></a>
                
                                
                            </ItemTemplate>
                        </asp:FormView>  </td>
                        <td align="left"> <asp:FormView ID="FormView1" runat="server"
                            DataSourceID="WorkflowLinqDataSource">
                            <ItemTemplate>
                                 <%# Eval("reminder_due_date", "{0:dddd, d MMM, yyyy}")%>
                
                                
                            </ItemTemplate>
                        </asp:FormView>  </td>
                        
                    <td> <font color="black">  <%# Eval("client.consultant_name") %></font>   </td>
                    
                        
                </tr>
                
                
                <asp:LinqDataSource ID="ContactLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="ContactDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput2" Name="sectionId" PropertyName="value" Type="Int32" />
                        <asp:ControlParameter ControlID="hiddenInput" Name="statusId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                <asp:LinqDataSource ID="WorkflowLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                 OnSelecting="WorkflowDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput2" Name="sectionId" PropertyName="value" Type="Int32" />
                        <asp:ControlParameter ControlID="hiddenInput" Name="statusId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                
                
                </ItemTemplate>
                <LayoutTemplate>
                
              
                        <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr class="tableheaderrow">
                            <th >&nbsp</th>
                            <th>Graham's Tasks</th>
                            <th>Nkosana's Tasks</th>
                            <th>Nkosana's Reminder Date</th>
                            <th>Consultant Name</th>
                            
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            
                            </tr>
                        </table>

            </LayoutTemplate>
            
                </asp:ListView>
                
                <asp:LinqDataSource ID="SectionLinqDataSource" runat="server"
                ContextTypeName="IntranetDataDataContext"  
                TableName="sections" OnSelecting="SectionDataSource_Selecting">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hiddenInput" Name="statusId" PropertyName="value" Type="Int32" />
                    </SelectParameters>
                
                </asp:LinqDataSource>
                
                
                
                
                
                
                
                
               
            </li>
        </ItemTemplate>
        
        <EmptyDataTemplate>
            No data was returned.
        </EmptyDataTemplate>
        
        <LayoutTemplate>
            <ul ID="itemPlaceholderContainer" runat="server" 
                style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                <li ID="itemPlaceholder" runat="server" />
                </ul>
                <div style="text-align: center;background-color: #CCCCCC;font-family: Verdana, Arial, Helvetica, sans-serif;color: #000000;">
                </div>
            </LayoutTemplate>
            
            <ItemSeparatorTemplate>
                <br />
            </ItemSeparatorTemplate>
            <SelectedItemTemplate>
                <li style="background-color: #008A8C;font-weight: bold;color: #FFFFFF;">status_id:
                    <asp:Label ID="status_idLabel" runat="server" Text='<%# Eval("status_id") %>' />
                    <br />
                    status_name:
                    <asp:Label ID="status_nameLabel" runat="server" 
                        Text='<%# Eval("status_name") %>' />
                    <br />
                    department_id:
                    <asp:Label ID="department_idLabel" runat="server" 
                        Text='<%# Eval("department_id") %>' />
                    <br />
                    display_order:
                    <asp:Label ID="display_orderLabel" runat="server" 
                        Text='<%# Eval("display_order") %>' />
                    <br />
                    sections:
                    <asp:Label ID="sectionsLabel" runat="server" Text='<%# Eval("sections") %>' />
                    <br />
                    sections1:
                    <asp:Label ID="sections1Label" runat="server" Text='<%# Eval("sections1") %>' />
                    <br />
                    sections2:
                    <asp:Label ID="sections2Label" runat="server" Text='<%# Eval("sections2") %>' />
                    <br />
                </li>
            </SelectedItemTemplate>
    </asp:ListView>




    <asp:LinqDataSource ID="StatusLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" OrderBy="display_order" 
        TableName="status" OnSelecting="StatusDataSource_Selecting">
    </asp:LinqDataSource>
    </div>




</asp:Content>

