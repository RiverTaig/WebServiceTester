using System;
using System.Collections.Generic;
using System.Net;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;

public partial class _Default : System.Web.UI.Page 
{
    //private static int currentIndex = 0;
    //private static int maxIndex= 0;
    private static XDocument _xmlDoc = null;
    string settingsNewXML = @"C:\Code\Git\WebServiceTester\bin\Debug\settings_New.xml";
    string settingsXML = @"C:\Code\Git\WebServiceTester\bin\Debug\settings.xml";
    string settingsBackXML = @"C:\Code\Git\WebServiceTester\bin\Debug\settings_Back.xml";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int currentIndex = 0;
            int maxIndex = 0;

            File.Copy(settingsNewXML, settingsXML, true);

            _xmlDoc = XDocument.Load(settingsXML);
            UpdatePageElements(0);

        }
    }
    private void PerformLocalSave(int index)
    {   
        var urls = _xmlDoc.XPathSelectElements("/WebServiceTester/URLS/URL");
        int counter = 0;
        _xmlDoc.Element("WebServiceTester").Element("FREQUENCY").Value = txtFrequency.Text;
        foreach (XElement url in urls)
        {
            if (counter == index)
            {
                url.Element("THRESHOLD").Value = txtThreshold.Text;
                url.Element("NAME").Value = txtName.Text;
                url.Element("PATH").Value = txtURL.Text;
                url.Element("EMAIL").Value = txtEmail.Text;
            }
            counter++;
        }
    }
    private void UpdatePageElements(int index)
    {

        var urls = _xmlDoc.XPathSelectElements("/WebServiceTester/URLS/URL");
        int counter = 0;
        int maxIndex = 0;
        foreach (XElement url in urls)
        {
            maxIndex = maxIndex + 1;
            if (counter == index)
            {
                int interval = Convert.ToInt32(_xmlDoc.Element("WebServiceTester").Element("FREQUENCY").Value);
                txtFrequency.Text = interval.ToString();
                string path = url.Element("PATH").Value;
                var emails = url.Element("EMAIL").Value;
                var name = url.Element("NAME").Value;
                var threshold = Convert.ToInt16(url.Element("THRESHOLD").Value);
                var reason = Convert.ToString(url.Element("REASON").Value);
                int failCount = Convert.ToInt16(url.Element("CONSECUTIVEFAILCOUNT").Value);//LASTFAILURE
                var lastFailureValue = url.Element("LASTFAILURE").Value;
                if (lastFailureValue != "")
                {
                    lastFailureValue = Convert.ToDateTime(url.Element("LASTFAILURE").Value).ToLongDateString();
                }
                txtEmail.Text = emails;
                lblFailureReason.Text = reason;
                if (reason == "")
                {
                    lblFailureReason.ForeColor = System.Drawing.Color.ForestGreen;
                    lblLastFailDateTime.ForeColor = System.Drawing.Color.ForestGreen;
                    lblFailureReason.Text = "No failures yet!";
                    lblLastFailDateTime.Text = "No failures yet!";
                }
                else
                {
                    lblFailureReason.ForeColor = System.Drawing.Color.Red;
                    lblLastFailDateTime.ForeColor = System.Drawing.Color.Red;
                    lblLastFailDateTime.Text = lastFailureValue;
                }
                txtURL.Text = path;
                txtThreshold.Text = threshold.ToString();
                txtName.Text = name;
                
            }            
            int start = index + 1;
            lblCurrentIndex.Text = start.ToString();
            lblMaxIndex.Text = maxIndex.ToString() + "&nbsp;&nbsp;&nbsp;   ";
            lblTestResult.Text = "";
            //lblst.Text = "Showing " + start + " of " + maxIndex;
            counter++;
        }
    }
    protected void btnAdd_Click(object sender, ImageClickEventArgs e)
    {
        int currentMax = Convert.ToInt16(lblMaxIndex.Text);
        lblMaxIndex.Text = Convert.ToString(currentMax + 1);
        lblCurrentIndex.Text = lblMaxIndex.Text;
        txtEmail.Text = "";
        txtFrequency.Text = "1";
        txtName.Text = "";
        txtURL.Text = "";
        lblLastFailDateTime.Text = "No failures yet!";
        lblFailureReason .Text = "No failures yet!";
        lblFailureReason.ForeColor = System.Drawing.Color.ForestGreen;
        lblTestResult.ForeColor = System.Drawing.Color.ForestGreen;
        var urls = _xmlDoc.XPathSelectElement("/WebServiceTester/URLS");
        XElement name = new XElement("NAME", "");
        XElement path = new XElement("PATH", "");
        XElement threshold = new XElement("THRESHOLD", "2");
        XElement email = new XElement("EMAIL", "");
        XElement failCount = new XElement("CONSECUTIVEFAILCOUNT", "0");
        XElement lastfailure = new XElement("LASTFAILURE", "");
        XElement reason = new XElement("REASON", "");
        XElement url = new XElement("URL", "");
        urls.Add(url);
        url.Add(name, path, threshold, email, failCount, lastfailure, reason);
    }
    protected void btnDelete_Click(object sender, ImageClickEventArgs e)
    {
        int currentIndex = Convert.ToInt16(lblCurrentIndex.Text) - 1;
        int currentMax = Convert.ToInt16(lblMaxIndex.Text);
        lblMaxIndex.Text = Convert.ToString(currentMax - 1);
        lblCurrentIndex.Text = "0";
        var urls = _xmlDoc.XPathSelectElements("/WebServiceTester/URLS/URL");
        int counter = 0;
        XElement xelToDelete = null;
        foreach (XElement url in urls)
        {
            if (currentIndex == counter)
            {
                xelToDelete = url;
            }
            counter++;
        }
        xelToDelete.Remove();
        UpdatePageElements(0);
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        int currentIndex = Convert.ToInt16(lblCurrentIndex.Text)-1;
        PerformLocalSave(currentIndex);
        currentIndex--;
        if (currentIndex < 0)
        {
            currentIndex = 0;
        }

        UpdatePageElements(currentIndex);
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        int currentIndex = Convert.ToInt16(lblCurrentIndex.Text)-1;
        int maxIndex = Convert.ToInt16(lblMaxIndex.Text.Substring(0, lblMaxIndex.Text.IndexOf("&")));
        //int maxIndex = Convert.ToInt16(lblMaxIndex.Text);
        PerformLocalSave(currentIndex);
        currentIndex++;
        if (currentIndex > maxIndex -1)
        {
            currentIndex = maxIndex-1;
        }
        
        UpdatePageElements(currentIndex);
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int currentIndex = Convert.ToInt16(lblCurrentIndex.Text) - 1;
        PerformLocalSave(currentIndex);
        _xmlDoc.Save(settingsNewXML);
        lblSaved.ForeColor = System.Drawing.Color.ForestGreen;
        lblSaved.Text = "Edits saved.";
        lblSaved.BackColor = System.Drawing.Color.White;
    }
    protected void txtName_TextChanged(object sender, EventArgs e)
    {
        lblSaved.Visible = true;
        lblSaved.ForeColor = System.Drawing.Color.Red;
        lblSaved.Text = "Remember to Save!!";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            WebClient wc = new WebClient();
            byte[] testReturn = wc.DownloadData(txtURL.Text);
            lblTestResult.ForeColor = System.Drawing.Color.ForestGreen;
            lblTestResult.Text = "Success!";
        }
        catch
        {
            lblTestResult.ForeColor = System.Drawing.Color.Red;
            lblTestResult.Text = "Failure!";
        }
    }

}