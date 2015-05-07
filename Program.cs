using System;
using System.Net;
using System.Xml.XPath;
using System.Net.Mail;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Timers;
using System.Threading;

namespace WebServiceTester
{
    class Program
    {
        private static System.Timers.Timer aTimer;
        private static int iterations = 0;
        static void Main(string[] args)
        {
            try
            {
                string settingsXML = System.Environment.CurrentDirectory + "\\Settings_new.xml";
                var xDoc = XDocument.Load(settingsXML);
                int interval = 1000 * 5 *  Convert.ToInt32(xDoc.Element("WebServiceTester").Element("FREQUENCY").Value);
                aTimer = new System.Timers.Timer(interval);
                aTimer.Elapsed += OnTimedEvent;
                aTimer.Enabled = true;
                Console.WriteLine("Press Q to quit");
                while (true)
                {
                    Thread.Sleep(1000); //TODO - change to one minute (the minimum time for notification in production)
                    string q = Console.ReadLine().ToUpper();
                    if (q == "Q")
                    {
                        break;
                    }
                }
            }
            finally
            {
                aTimer.Enabled = false;
                Console.WriteLine("DONE");
                Console.ReadLine();
            }
        }
        private static void OnTimedEvent(Object source, ElapsedEventArgs e)
        {
            try
            {
                aTimer.Enabled = false;
                Console.WriteLine("Iteration: " + iterations + " : " + DateTime.Now.ToString());
                string settingsXML = System.Environment.CurrentDirectory + "\\Settings_new.xml";
                var xDoc = XDocument.Load(settingsXML);
                string a = "WebServiceTester";
                var urls = xDoc.XPathSelectElements("/WebServiceTester/URLS/URL");
                foreach (XElement xel in urls)
                {
                    string path = xel.Element("PATH").Value;
                    var emails = xel.Element("EMAIL");
                    var name = xel.Element("NAME").Value;
                    var threshold = Convert.ToInt16(xel.Element("THRESHOLD").Value);
                    int failCount = Convert.ToInt16(xel.Element("CONSECUTIVEFAILCOUNT").Value);//LASTFAILURE
                    //Console.WriteLine("Fail Count = " + failCount);
                    //DateTime lastFailure = Convert.ToDateTime(xel.Element("LASTFAILURE").Value);
                    WebClient wc = new WebClient();
                    try
                    {
                        byte[] testReturn = wc.DownloadData(path);
                        if (failCount > 0)
                        {
                            Console.WriteLine("    " + path +  " is Back online!");
                            xel.Element("CONSECUTIVEFAILCOUNT").Value = "0";
                            xDoc.Save(settingsXML);
                            foreach (string email in emails.Value.Split(','))
                            {
                                Console.WriteLine("    Sending Back online email");
                                SendEmail(email, name + " - SUCCESS!!", path + " should be available now");
                            }
                        }
                        else
                        {
                            Console.WriteLine("    Success on " + path + " - no action taken");
                        }
                    }
                    catch (Exception ex)
                    {
                        string dt = DateTime.Now.ToLongDateString();
                        xel.Element("LASTFAILURE").Value = dt;
                        failCount++;
                        Console.WriteLine("    FAIL on " + path + "  FailCount = " +  failCount);
                        xel.Element("CONSECUTIVEFAILCOUNT").Value = failCount.ToString();
                        xel.Element("REASON").Value = ex.ToString();
                        xDoc.Save(settingsXML);
                        if (failCount == threshold)
                        {
                            foreach (string email in emails.Value.Split(','))
                            {
                                Console.WriteLine("    Sending failure email");
                                SendEmail(email, name + " FAILED!!", 
                                    "URL: " + path 
                                    + Environment.NewLine + "Time: "  + dt 
                                    + Environment.NewLine + "Additional Info: " +   ex.ToString());
                            }
                        }
                    }
                }
                iterations++;
                Console.WriteLine("");
                return;
            }
            catch (Exception ex)
            {
            }
            finally
            {
                aTimer.Enabled = true;
            }
        }

        private static void SendEmail( string address, string subject, string body)
        {
            var mailSMTPClient = new SmtpClient("smtp.gmail.com", 587)
            {  //Miner00!
                Credentials = new NetworkCredential("rivertaig@gmail.com", "Ropus7jay"),
                EnableSsl = true
            };
            var message = new MailMessage("rivertaig@gmail.com", address);
            message.Subject = subject;
            message.Body = body + Environment.NewLine + Environment.NewLine + "Current time: " + DateTime.Now.ToString();
            mailSMTPClient.Send(message);
            message.Dispose();
        }
    }
}
