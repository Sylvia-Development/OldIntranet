<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="archived_clients.aspx.cs" Inherits="archived_clients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
<div id="one_column">
 <h1>Archived Clients</h1>








                
                
        
   
        
     
 <br />
    
      
                
                <asp:ListView ID="ListView2" runat="server"
                DataSourceID="SectionLinqDataSource">
                <ItemTemplate>
                
                
                <tr>
                    <td>
                    
                        

                        <a href="client_info_new.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>" rel="shadowbox;height=500;width=700"> 
                                  <%# Eval("client.job_name") %>
                        </a>
                                
                         - 
                         <a href="section_info.aspx?pDepartmentId=<%Response.Write(Page.Request.QueryString["pDepartmentId"]);%>&pClientId=<%# Eval("client_id")%>&pSectionId=<%# Eval("section_id")%>" rel="shadowbox;height=400;width=600"> 
                                  <%# Eval("section_name") %>
                        </a>        

                      </td>
                    
                    
                    
                   <td align="left">  
                    
                    
                    
                    
                                <a href="section_view.aspx?pReminderType=0&pSectionId=<%# Eval("section_id")%>&pDepartmentId=0&pClientId=<%# Eval("client_id")%>    ">View History >></a>
                               
                               
                                    
                                    
                             
                   
                   
                   
                   </td>
                  
                    
                     
                      
                        
                   
                        
                </tr>
                
                
               
                
                
                
                </ItemTemplate>
                <LayoutTemplate>
                
              
                        <table cellpadding="4" ID="itemPlaceholderContainer" runat="server" border="1">
                            
                            <tr ID="itemPlaceholder" runat="server">
                            
                            </tr>
                        </table>

            </LayoutTemplate>
            
                </asp:ListView>
                
                <asp:LinqDataSource ID="SectionLinqDataSource" runat="server"
                    ContextTypeName="IntranetDataDataContext"  
                    TableName="sections" 
                    OnSelecting="SectionDataSource_Selecting">

                </asp:LinqDataSource>
                
               
                
                
                
                
                
                
               
      
       
    </div>
</asp:Content>

