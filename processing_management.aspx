<%@ Page Title="" Language="C#" MasterPageFile="~/ManagementLeftNavMasterPage.master" AutoEventWireup="true" CodeFile="processing_management.aspx.cs" Inherits="processing_management" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentPlaceHolder" Runat="Server">
 <script type="text/javascript">

     var sbx = window.parent.Shadowbox;
     function openTopSBX(el) {
         if (sbx) {
             sbx.open({ content: el.href
                   , player: 'iframe'
                   , width: 650
                   , height: 490
             }
                );
             return false;
         } else { //no Shadowbox in parent window! 
             return true;
         }
     }
        


     $(function () {
         $("input[id$='datepicker']").datepicker({ dateFormat: 'D, d M, yy', showOtherMonths: true, selectOtherMonths: true });

     });

    
    </script>
    

<asp:ListView ID="ProcessingListView" runat="server" DataKeyNames="id" 
        DataSourceID="ProcessingDataSource" 
         OnItemUpdating = "processing_ItemUpdating"
          OnItemUpdated="processing_ItemUpdated">
        <ItemTemplate>
                
             <tr style="background-color:  <%# GetRowColour(Eval("processing_completed_by")) %>; color: #000000;">

                <td nowrap> 
               <asp:Image ID="high_pri_image" Visible='<%# Eval("is_main_material_order") %>' runat="server" ImageUrl="Images/priority-high.png" />
                <%# Eval("section.client.job_name")%> - <%# Eval("section.section_name")%> 
                
                </td>
                <td style="width:40%;">
                       
                        
                        <%#Eval("description").ToString().Replace("\n", "<br/>") %><br />
                 <font size="1" >     (<%# Eval("id")%>)</font>


                </td>
                
                <td nowrap >
                    <%#Eval("processing_completed_by", "{0:ddd, d MMM, yyyy}")%> 

                </td>
                
                
                
                
              
                <td class="TDwithButtons"  align="center">
               
    
                    
                     <a href="<%# GetPrintTarget( Eval("is_main_material_order")) %>?pSectionId=<%#Eval("section_id") %>&itemId=<%#Eval("id") %>" target="new" > 
          <img src="Images/print.png" align="middle" />  &nbsp
     <a href="job_list_notes_popup.aspx?pJobListId=<%#Eval("id") %>" rel="nofollow" target="_top" onclick="return openTopSBX(this);"> 
     <img src="Images/notes.png" />  </a>
                    
                </td>
                
            </tr>
            
        </ItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" >
                <tr>
                    <td>
                        You have no items to Process.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        
        <LayoutTemplate>
         
                        <table ID="tablesorter" cellpadding="3" runat="server" border="1" >
                            <tr id="Tr2" runat="server" class="tableheaderrow">  
                                <th id="Th1"  colspan="2"   runat="server"></th>
                                <th  align="left" ><font size="2">To Be Completed By 16h30 on</font></th>
                                
                                <th  align="left" ><font size="2">&nbsp</font></th>
                                
                                
                               
                                
                                    
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                   
        </LayoutTemplate>
        
        
    </asp:ListView>

      <asp:LinqDataSource ID="ProcessingDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext" EnableDelete="False" 
        EnableInsert="False" EnableUpdate="True" TableName="job_list_items"
        OnSelecting="processing_DataSource_Selecting">
</asp:LinqDataSource>



</asp:Content>

