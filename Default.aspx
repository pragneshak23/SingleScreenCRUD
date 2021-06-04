<%@ Page Language="C#" Inherits="TestWebApp.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Default</title>
        <script src="~/Scripts/datetimepicker.js"></script>
        <script src="~/Scripts/jquery-1.11.1.js"></script>
        <script src="~/Scripts/jquery-ui.js"></script>
        <link href="~/CSS/jquery-ui.css" rel="stylesheet"/>
        <script type="text/javascript">
            $(document).ready(function(){
             $('#txtDate').datepicker();   
            })
           
        </script>
</head>
<body>
	<form id="form1" runat="server" class="row justify-content-center">
		<div>
        <asp:HiddenField ID="hfContactID" runat="server" />
        <table class="table-center">
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server" Text="DOB"></asp:Label>
                </td>
                <td colspan="2">
                   <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>     
                  
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Designation"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtDesignation" runat="server" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Skills"></asp:Label>
                </td>
                <td colspan="2">
                     <asp:ListBox ID="lstSkills" runat="server" SelectionMode="Multiple">
                        <asp:ListItem Text="C#" Value="1" />
                        <asp:ListItem Text="MVC" Value="2" />
                        <asp:ListItem Text="Web API" Value="3" />
                        <asp:ListItem Text="Azure" Value="4" />
                        <asp:ListItem Text=".Net Core" Value="5" />
                    </asp:ListBox>
                </td>
            </tr>
                   
            <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
                </td>
                <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            
        </table>
        <br />
        <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="DateOfBirth" HeaderText="DateOfBirth" />
                <asp:BoundField DataField="Designation" HeaderText="Designation" />
                <asp:BoundField DataField="Skills" HeaderText="Skills" />        
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("ContactID") %>' OnClick="lnk_OnClick">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
	</form>
</body> 
</html>
