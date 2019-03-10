using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
public partial class manager : System.Web.UI.Page
{
    string strcon = System.Configuration.ConfigurationManager.ConnectionStrings["FmExampleDbConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string encrypt(string encryptString)
    {
        string EncryptionKey = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        byte[] clearBytes = Encoding.Unicode.GetBytes(encryptString);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {  
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76  
        });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                encryptString = Convert.ToBase64String(ms.ToArray());
            }
        }
        return encryptString;
    }
    public string Decrypt(string cipherText)
    {
        string EncryptionKey = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] {  
            0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76  
        });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }  
   
    protected void BtnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = strcon;
            myConnection.Open();

            //  string strSql = "SELECT COUNT(*) FROM Users WHERE userName=N' " + ddpusername.SelectedItem.Text + "' AND pass=N'" + txtpassword.Text + "'";
            string strSql = "SELECT COUNT(*) FROM userTbl WHERE manager='true' and username=N'" + txtusername.Text + "' and pass=N'" + txtpassword.Text + "'";
            SqlCommand command = new SqlCommand(strSql, myConnection);
            int count = Convert.ToInt32(command.ExecuteScalar());
            //   myConnection.Close();

            if (count == 1)
            {
                Session["username"] = txtusername.Text;

                pnllogin.Visible = false;
                lnkbtnlog.Text = "LOG OUT";
                pnlmanage.Visible = true;
                //strSql = "SELECT id FROM userTbl WHERE manager=true and username=N'" + txtusername.Text + "' and password=N'" + Encrypt(txtpassword.Text) + "'";
                //command = new SqlCommand(strSql, myConnection);
                //string id = (command.ExecuteScalar()).ToString();

                //Session["id"] = id;

                //Response.Redirect("file.aspx");
            }

            //else
            //    Label1.Text = Convert.ToString(count);

        }

        catch (Exception k)
        {
            // lblStatus.Text = k.Message;
        }


    }
    protected void lnkbtnlog_Click(object sender, EventArgs e)
    {
        if (lnkbtnlog.Text == "LOG OUT")
        {
            pnllogin.Visible = true;
            pnlmanage.Visible = false;
            lnkbtnlog.Text = "LOG IN";
        }
    }

    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
      // e.Command.Parameters["pass"].Value=
    }
    protected void SqlDataSource1_Inserting(object sender, SqlDataSourceCommandEventArgs e)
    {
        string s;
        e.Command.Parameters["@pass"].Value = encrypt(e.Command.Parameters["@pass"].Value.ToString());
    }
}