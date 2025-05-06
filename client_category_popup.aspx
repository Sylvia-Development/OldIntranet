<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="client_category_popup.aspx.cs" Inherits="client_category_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div style="background:white; color:black;"

 <asp:FormView ID="FormView1" runat="server" 
        DataKeyNames="id" 
        DataSourceID="LinqDataSource1">
        
      <ItemTemplate>
      <h1><%# Eval("client_category.description") %></h1>
      <br />
      <asp:TextBox style="resize:none; background-color:transparent; border-color:transparent;" readonly TextMode="MultiLine" Rows="60" Columns="90" ID="TextBox" runat="server" 
                        Text=' <%# Eval("description") %>' />
      
      
      </ItemTemplate>
        <EmptyDataTemplate>
            
           No Data
            
            
        
        </EmptyDataTemplate>
    </asp:FormView>
    
    <hr />
    <asp:LinqDataSource ID="LinqDataSource1" runat="server"
        ContextTypeName="IntranetDataDataContext" 
        EnableInsert="False" 
        EnableUpdate="False" 
        TableName="client_category_responses" 
        OnSelecting="client_category_selecting">
    </asp:LinqDataSource>





</asp:Content>

