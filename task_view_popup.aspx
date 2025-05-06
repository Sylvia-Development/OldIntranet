<%@ Page Title="" Language="C#" MasterPageFile="~/popup_master.master" AutoEventWireup="true" CodeFile="task_view_popup.aspx.cs" Inherits="task_view_popup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="margin:50px 5px;">
<tasks:tasksControl id="taskscontrol" runat="server" />
<br />
 <completedTasks:completedTasksControl id="completedTasksControl" runat="server" />      
   
</div>
</asp:Content>

