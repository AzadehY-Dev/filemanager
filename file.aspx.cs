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

public partial class file : System.Web.UI.Page
{
    string strcon = System.Configuration.ConfigurationManager.ConnectionStrings["FmExampleDbConnectionString"].ConnectionString;
    Dictionary<string, string> extensionsDisplayName;

    Dictionary<string, string> ExtensionsDisplayName
    {
        get
        {
            if (extensionsDisplayName == null)
                extensionsDisplayName = XDocument.Load(MapPath("~/Content/FileManager/ExtensionsDisplayName.xml")).Descendants("Extension").ToDictionary(n => n.Attribute("Extension").Value, n => n.Attribute("DisplayName").Value);
            return extensionsDisplayName;
        }
    }
    FileListView CurrentView
    {
        get
        {
            var view = Session["View"];
            return view == null ? FileListView.Thumbnails : (FileListView)Session["View"];
        }
        set
        {
            FileManager.SettingsFileList.View = value;
            Session["View"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["id"]!=null)
            {
                pnlfiles.Visible = true;
            }
            else
            {
                Session["id"] = null;
                Response.Redirect("Default.aspx");
                lnkbtnlog.Text = "LOG IN";
            }
        }
    }
    protected void ASPxFileManager_CustomCallback(object source, CallbackEventArgsBase e)
    {
        CurrentView = (FileListView)Enum.Parse(typeof(FileListView), e.Parameter.ToString());
    }
    protected void FileManager_ItemRenaming(object source, FileManagerItemRenameEventArgs e)
    {
        ValidateSiteEdit(e);
    }
    protected void FileManager_ItemMoving(object source, FileManagerItemMoveEventArgs e)
    {
        ValidateSiteEdit(e);
    }
    protected void FileManager_ItemCopying(object source, FileManagerItemCopyEventArgs e)
    {
        ValidateSiteEdit(e);
    }
    protected void FileManager_ItemDeleting(object source, FileManagerItemDeleteEventArgs e)
    {
        ValidateSiteEdit(e);
    }
    protected void PopupControl_WindowCallback(object source, PopupWindowCallbackArgs e)
    {
        switch (e.Parameter)
        {
            case "Files":
                var file = FileManager.SelectedFile;
                var fileInfo = new FileInfo(MapPath(file.FullName));
                PopupControl.JSProperties["cpHeaderText"] = Path.GetFileNameWithoutExtension(fileInfo.FullName);
                // Type.Text = ExtensionsDisplayName[file.Extension];

                Size.Text = file.Length.ToString("#,#") + " bytes";
                Created.Text = fileInfo.CreationTime.ToString("U");
                // Modified.Text = fileInfo.LastWriteTime.ToString("U");
                //  Accessed.Text = fileInfo.LastAccessTime.ToString("U");
                FormLayout.FindItemOrGroupByName("Contains").Visible = false;
                // DownloadLink.Text = fileInfo.ToString();
                // DownloadLink.Text = file.GetType().ToString();
                SetFileManagerItemInfo(file);
                break;
            case "Folders":
                FormLayout.Visible = false;
                // PopupControl.ShowOnPageLoad = false;
                var folder = FileManager.SelectedFolder;
                var path = MapPath(folder.FullName);
                Name.Visible = false;   //Type.Visible = false;
                btndownload.Visible = false; //  DownloadLink.Visible = false;
                Size.Visible = false; Contains.Visible = false;
                //  var directoryInfo = new DirectoryInfo(path);
                //  var filesInfo = directoryInfo.GetFiles("*", SearchOption.AllDirectories);
                //  long folderSize = 0;
                //  foreach (var info in filesInfo)
                //      folderSize += info.Length;
                //  var filesCount = filesInfo.Length;
                //  var subDirectoriesCount = directoryInfo.GetDirectories("*", SearchOption.AllDirectories).Length;

                ////  Type.Text = "Folder";
                //  Size.Text = folderSize.ToString("#,#") + " bytes";
                //  Contains.Text = filesCount + " Files, " + subDirectoriesCount + " Folders";
                //  PopupControl.JSProperties["cpHeaderText"] = folder.Name;
                Created.Text = Directory.GetCreationTime(path).ToString("U");
                //   DownloadLink.Text = "None!";
                btndownload.Visible = false;
                //FormLayout.FindItemOrGroupByName("Modified").Visible = false;
                //FormLayout.FindItemOrGroupByName("Accessed").Visible = false;
                //  SetFileManagerItemInfo(folder);
                break;
        }
    }
    protected void fileManager_FileUploading(object sender, FileManagerFileUploadEventArgs e)
    {
        ValidateSiteEdit(e);
    }

    protected void fileManager_FolderCreating(object sender, FileManagerFolderCreateEventArgs e)
    {
        ValidateSiteEdit(e);
    }
    void SetFileManagerItemInfo(FileManagerItem item)
    {
        PopupControl.JSProperties["cpHeaderText"] += " Properties";
        Name.Text = item.Name;
        // Location.Text = item.FullName;
        //  RelativeLocation.Text = item.RelativeName;
    }
    void SetFileManagerToolbarItemCheckedState(string commandName, bool checkedState)
    {
        var item = FileManager.SettingsToolbar.Items.FindByCommandName(commandName);
        (item as FileManagerToolbarCustomButton).Checked = checkedState;
    }

    void ValidateSiteEdit(FileManagerActionEventArgsBase e)
    {
        //e.Cancel = Utils.IsSiteMode;
        //e.ErrorText = Utils.GetReadOnlyMessageText();
    }
    protected void btndownload_Click(object sender, EventArgs e)
    {
        var file = FileManager.SelectedFile;
        string id = file.Id;
        PopupControl.ShowOnPageLoad = false;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "popup", "window.open('" + "download.aspx?Hid=" + encrypt(id) + "','_blank')", true);
        //Response.Redirect("Default2.aspx?id=" + id);
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

   
    protected void lnkbtnlog_Click(object sender, EventArgs e)
    {
        if (lnkbtnlog.Text == "LOG OUT")
        {
            Session["id"] = null;
            Response.Redirect("Default.aspx");
            lnkbtnlog.Text = "LOG IN";
        }
    }
}