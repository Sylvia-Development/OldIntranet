<%@ Page Title="" Language="C#" MasterPageFile="~/MainMasterPage.master" AutoEventWireup="true" CodeFile="partner_view.aspx.cs" Inherits="partner_view" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MenuContentPlaceHolder" Runat="Server">

    <div>Referral Partner</div>
    <div style="color:black; background:white;">


        <div style="text-align:center">
            <a class="ui-button ui-corner-all" href="client_info_popup.aspx?pClientId=-1&pPartnerId=<%Response.Write(Page.Request.QueryString["pPartnerId"]);%>" rel="shadowbox;height=650;width=800" >new client</a>
        </div>

    <asp:FormView ID="FormView2" runat="server" 
        DataKeyNames="id"
        DefaultMode="Edit"
        OnItemUpdating = "referral_partner_itemUpdating"
        OnItemUpdated = "referral_partner_itemUpdated"

        DataSourceID="ReferralPartnerLinqDataSource" >
          
        <EditItemTemplate>
           

                <table id="referral_partner" class="tableSpacing paddedTable themeContent">
              <tr>
                   <td>
                        Referrer Name
                   </td>
                    <td>
                        <asp:TextBox ID="partner_nameTextBox" BorderStyle="None" runat="server" Text='<%# Bind("name") %>'/>
                        
                    </td>
                  <tr>
                  <td>
                        Liaison Officer
                  </td>
                    <td>    
                     <asp:TextBox ID="TextBox1" BorderStyle="None" runat="server" Text='<%# Bind("user_added") %>'/>
                    </td>
                      </tr>
                    <tr>
                     
                       
                
                    
                    <td colspan="2" align="right" style="background:white;"> 
                        <asp:Button ID="LinkButton1" runat="server" 
                            CausesValidation="True" 
                            CommandName="Update" 
                            Text="Save" CssClass="ui-button" /> 
                        

                    </td>
                    
                    </tr>
               
               
                

            </table>
            
            
        </EditItemTemplate>
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
        </asp:FormView>

<asp:LinqDataSource ID="ReferralPartnerLinqDataSource" runat="server" 
        ContextTypeName="IntranetDataDataContext"
         EnableUpdate="True"
        TableName="referral_partners"
         OnSelecting ="referral_partners_selecting">
    </asp:LinqDataSource>
</div> 


</asp:Content>

