<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1
        {
            font-size: x-large;
        }
        .auto-style2
        {
            font-size: small;
        }
        .auto-style3
        {
            background-color: #FFFF99;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <div class="auto-style1" style="background-color: #C0C0C0; color: #0000FF; font-family: Tahoma;">Web Service Tester Administrator</div>
        <br />
        <span class="auto-style2">The Web Service Tester is designed to periodically test URLs to ensure that they are available; the most common use case for this being ArcGIS Server Map Services being used in a demonstration environment.&nbsp; If a URL can not be reached, an email is sent to one or more interested parties after a configurable number of consecutive failures have occurred.&nbsp; When the URL later becomes available, a follow-up email is sent.&nbsp; On this page, you can create, update, or delete the URLs that you want to test, and set up the Email notifications. 
        <br />
        </span>
        <hr />

    </div>
        <p>
            Polling frequency in minutes :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtFrequency" runat="server" Width="52px" CssClass="auto-style3" OnTextChanged="txtName_TextChanged">15</asp:TextBox>
        </p>
        <asp:Button ID="btnPrevious" runat="server" Text="&lt;&lt;" OnClick="btnPrevious_Click" />&nbsp;&nbsp; 
        <asp:Label ID="lblShowing" runat="server" Text="Showing Test " ForeColor="#FF9900"></asp:Label> 
        <asp:Label ID="lblCurrentIndex" runat="server" Text="0" ForeColor="#FF9900"></asp:Label> 
        <asp:Label ID="lblOf" runat="server" Text=" of " ForeColor="#FF9900"></asp:Label>
        <asp:Label ID="lblMaxIndex" runat="server" Text="0" ForeColor="#FF9900"></asp:Label>  
        <asp:Button ID="btnNext" runat="server" Text="&gt;&gt;" OnClick="btnNext_Click" />
            &nbsp;&nbsp;     
            <asp:Button ID="btnAdd" runat="server" Text="+" OnClick="btnAdd_Click" />   
            &nbsp;&nbsp;   
            <asp:Button ID="btnDelete" runat="server" Text="X" OnClick="btnDelete_Click" />   
            &nbsp;&nbsp;   
        <p>
            <strong>Friendly Name:</strong>
            <asp:TextBox ID="txtName" runat="server" Width="666px" CssClass="auto-style3" OnTextChanged="txtName_TextChanged"></asp:TextBox>
        </p>
        <p>
            <strong>URL:</strong>
            <asp:TextBox ID="txtURL" runat="server" Width="756px" CssClass="auto-style3" OnTextChanged="txtName_TextChanged"></asp:TextBox>
        </p>
        <p>
            <strong>Send Emails after
            <asp:TextBox ID="txtThreshold" runat="server" CssClass="auto-style3" OnTextChanged="txtName_TextChanged" Width="20px">2</asp:TextBox>
&nbsp;consecutive failures</strong></p>
        <p>
            <strong>Emails (comma delimited):</strong>
            <asp:TextBox ID="txtEmail" runat="server" Width="647px" CssClass="auto-style3" OnTextChanged="txtName_TextChanged"></asp:TextBox>
        </p>
        <p>
            <strong>Last Failure Time:
            </strong>
            <asp:Label ID="lblLastFailDateTime" runat="server" ForeColor="#FF0066"></asp:Label>
        </p>
        <p>
            <strong>Failure Reason:</strong>
            <asp:Label ID="lblFailureReason" runat="server" ForeColor="#FF0066"></asp:Label>
        </p>
        <p>

            <asp:Button ID="btnSave" runat="server" Text="Save" Width="109px" OnClick="btnSave_Click" />
        </p>
        <p>

            <asp:Label ID="lblSaved" runat="server"></asp:Label>
        </p>
    </form>
</body>
</html>
