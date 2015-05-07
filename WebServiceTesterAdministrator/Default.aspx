<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript">
        function resize(x, over) {
            //alert("asdf");
            if (over) {
                x.style.width = "31px";
                x.style.height = "31px";
            }
            else {
                x.style.height = "32px";
                x.style.height = "32px";
            }
            
        }
    </script>
    <style type="text/css">
        .auto-style2
        {
            font-size: small;
        }
        .auto-style3
        {
            background-color: #FFFF99;
            text-align: left;
        }
        .imageBtn
        {
            margin-left:10px;
            margin-right:10px;
            margin-top:2px;
            margin-bottom:2px;
        }
        .auto-style4
        {
            text-align: center;
        }
        .sans-serif
        {
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel runat="server" id="UpdatePanel" updatemode="Conditional">
        <ContentTemplate>
            <div>
            </div>
    <p class="auto-style4" style="font-family: 'segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: large; font-weight: bold; color: #009B3E; background-color: #C0C0C0;">
        Web Service Test Administrator<div align="left">

        <asp:Image ID="Image1" ImageAlign="Left" runat="server" Height="146px" ImageUrl="~/Tester.png" Width="177px" />
    <div class="auto-style2" style="font-family: 'Segoe UI'">
            <p class="MsoNormal">
                The Web Service Tester is designed to periodically attempt to reach a configured set of URLs to ensure they are available; the most common use case for this being ArcGIS Server Map Services which are being used in a demonstration environment.&nbsp; If a URL cannot be reached, an email is sent to one or more interested parties after a configurable number of consecutive failures have occurred.&nbsp; When the URL later becomes available, a follow-up email is sent.&nbsp; On this page, you can create, update, or delete tests, and specify email notifications, and the number of times that a test must fail before notification occurs.&nbsp; You can also s<span style="mso-spacerun:yes">&nbsp; pecify a global &quot;Polling Frequency&quot; in minutes which applies to all tests. </span>This page also includes a “Test URL” button to allow a one-time test, however this page does not perform the periodic testing itself.<span style="mso-spacerun:yes"></span>The periodic testing occurs on the same server where this page exists in 
                an application named WebServiceTesterAdministrator.<o:p>exe.</o:p></p>
        </div>
        <hr style="background:#111111; border:0; height:3px"  style="horizontal-align:center" />
    </div>

    <div  style="clear: both;margin:10px;background-color:#efefef;min-width:500px;max-width:500px;">
        
            <!--<p style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">-->
            <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;margin-left:10px">Polling Frequency (Minutes) :</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="txtFrequency" runat="server" Width="24px" CssClass="auto-style3" OnTextChanged="txtName_TextChanged">15</asp:TextBox>
            <p></p>
            <asp:ImageButton ID="btnPrevious" runat="server" onmouseover="resize(this,true)" onmouseout="resize(this,false)" CssClass="imageBtn" ImageUrl="~/LeftArrows.png" OnClick="btnPrevious_Click" />
            &nbsp;&nbsp; 
            <span style="vertical-align:top">
            <asp:Label ID="lblShowing" runat="server" Font-Names="Segoe UI" ForeColor="#FF9900" Text="Test "></asp:Label>
            <asp:Label ID="lblCurrentIndex" runat="server" Font-Names="Segoe UI" ForeColor="#FF9900" Text="0 "></asp:Label>
            <asp:Label ID="lblOf" runat="server" Font-Names="Segoe UI" ForeColor="#FF9900" Text=" of "></asp:Label>
            <asp:Label ID="lblMaxIndex" runat="server" Font-Names="Segoe UI" ForeColor="#FF9900" Text="0 "></asp:Label>
            </span>
            <asp:ImageButton ID="btnNext" onmouseover="resize(this,true)" onmouseout="resize(this,false)" runat="server" CssClass="imageBtn" ImageUrl="~/RightArrows.png" OnClick="btnNext_Click" />
            <asp:ImageButton ID="ImageButton2" onmouseover="resize(this,true)" onmouseout="resize(this,false)" runat="server" ImageUrl="~/Close.png" OnClick="btnDelete_Click" CssClass="imageBtn" ImageAlign="Right" />
            <asp:ImageButton ID="ImageButton1" onmouseover="resize(this,true)" onmouseout="resize(this,false)" runat="server" ImageUrl="~/edit_add.png" CssClass="imageBtn" OnClick="btnAdd_Click"  ImageAlign="Right" />
                
                                          
            <div style="background-color:#dddddd;padding:2px;border-radius: 25px;margin:10px;"  >
          

            
            <div style="background-color:#bbbbbb;padding:2px;border-radius: 25px;margin:10px"  >
            <p>
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Name</strong></p>
            <p style="margin-top:-12px">
                &nbsp;<asp:TextBox ID="txtName" runat="server" CssClass="auto-style3" OnTextChanged="txtName_TextChanged" placeholder="Friendly Name (used in email subject)" Width="80%"></asp:TextBox>
            </p>
            <p >
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">URL</strong></p>
                <p style="margin-top:-12px">
                &nbsp;<asp:TextBox ID="txtURL" runat="server" CssClass="auto-style3" OnTextChanged="txtName_TextChanged" placeholder="http://example.com" Width="60%"></asp:TextBox>
                &nbsp;
                
                <asp:Button ID="Button1" runat="server" Font-Bold="True" Font-Names="Segoe UI" OnClick="Button1_Click" Text="Test URL" />
                <asp:Label ID="lblTestResult" runat="server"></asp:Label>
                </p>
            <p></p>
            </div>


            <!--<div style="background-color:#bbbbbb;padding:2px;border-radius: 25px;margin:10px" >

            </div>-->
            
            <div style="background-color:#bbbbbb;padding:2px;border-radius: 25px;margin:10px"  >
            <p>
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Send Emails After
                <asp:TextBox ID="txtThreshold" runat="server" CssClass="auto-style3" OnTextChanged="txtName_TextChanged" Width="20px">2</asp:TextBox>
                &nbsp;Consecutive Failures</strong></p>
            <p>
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Emails (comma delimited)</strong></p>
            <p style="margin-top:-12px">
                &nbsp;<asp:TextBox ID="txtEmail" runat="server" CssClass="auto-style3" OnTextChanged="txtName_TextChanged" placeholder="ExamplePerson@GMail.com" Width="80%"></asp:TextBox>
            </p>
            </div>
            <p>
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Last Failure Time:</strong></p>
            <p style="margin-top:-12px">
                <asp:Label ID="lblLastFailDateTime" runat="server" Font-Names="Segoe UI" ForeColor="#FF0066"></asp:Label>
            </p>
            <p>
                <strong style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Failure Reason:</strong>
            </p>
            <p style="margin-top:-12px">
                <asp:Label ID="lblFailureReason" runat="server" Font-Names="Segoe UI" ForeColor="#FF0066"></asp:Label>
            </p>
            </div>
            <p >
                <asp:Button ID="btnSave" runat="server" BackColor="#33CC33" CssClass="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif" Font-Bold="True"  Font-Names="Segoe UI" Font-Size="Larger" Height="50px" OnClick="btnSave_Click" Text="Save" Width="119px"  />
            </p>
            <p>
                <asp:Label ID="lblSaved" runat="server" Font-Names="Segoe UI"></asp:Label>
            </p>
            <p>
            </p>
            <p>
            </p>
            <!--</p>-->
        </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
