<%@ Page Language="C#" AutoEventWireup="true" CodeFile="file.aspx.cs" Inherits="file" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link href="Business%202_files/bootstrap.css" rel="stylesheet"/>
    <link href="Business%202_files/custom.css" rel="stylesheet"/>
    <link href="Business%202_files/css.css" rel="stylesheet" type="text/css"/>
       <style type="text/css">
        .dxpc-mainDiv.DetailsPopup
        {
            border-width: 4px;
        }
        .dxpc-mainDiv.DetailsPopup .dxpc-content
        {
            padding: 0;
        }
        .dxpc-mainDiv.DetailsPopup .dxpc-content > div
        {
            margin: auto;
        }
        .dxpc-mainDiv.DetailsPopup .dxflGroupSys
        {
            padding-top: 12px;
            padding-bottom: 12px;
        }
        .dxpc-mainDiv.DetailsPopup .dxflCaptionCellSys label
        {
            color: #929292;
        }
    </style>
    <script>
        function OnCustomCommand(s, e) {
            switch (e.commandName) {
                case "ChangeView-Thumbnails":
                    FileManager.PerformCallback("Thumbnails");
                    break;
                case "ChangeView-Details":
                    FileManager.PerformCallback("Details");
                    break;
                case "Properties":
                    PopupControl.PerformCallback(FileManager.GetActiveAreaName());
                    break;
            }
        }
        function OnToolbarUpdating(s, e) {
            var enabled = (e.activeAreaName == "Folders" || FileManager.GetSelectedItems().length > 0) && e.activeAreaName != "None";
            FileManager.GetToolbarItemByCommandName("Properties").SetEnabled(enabled);
            FileManager.GetContextMenuItemByCommandName("Properties").SetEnabled(enabled);
        }
        function OnPopupEndCallback(s, e) {
            PopupControl.SetHeaderText(PopupControl.cpHeaderText);
            PopupControl.ShowAtElement(FileManager.GetMainElement());
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
          <nav id="siteNav" class="navbar navbar-default navbar-fixed-top affix-top" role="navigation">
        <div class="container">
            <!-- Logo and responsive toggle -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">
               <%-- 	<span class="glyphicon glyphicon-fire"></span> 
                	LOGO--%>   <p>  <img src="images/photo_2016-08-07_15-29-43.png" alt="">
                	West Power Co.</p>
                </a>
            </div>
            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="nav navbar-nav navbar-right">
                    <li class="active">
                        <asp:LinkButton ID="lnkbtnlog" runat="server" OnClick="lnkbtnlog_Click">LOG OUT</asp:LinkButton>
                    </li>
               <%--   <li>
                        <a href="WO.aspx">Contracts</a>
                    </li>
					<li class="dropdown">
						<a href="WO.aspx">WO</a>
						<ul class="dropdown-menu">
							<li><a href="#">reports</a></li>
							<li><a href="#">details</a></li>
						</ul>
					</li>
              	<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">PO <span class="caret"></span></a>
						<ul class="dropdown-menu" >
							<li><a href="#">reports</a></li>
							<li><a href="#">details</a></li>
						</ul>
					</li>
                    <li>
                        <a href="#">Invoice</a>
                    </li>--%>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
    </nav>
    <section class="intro">

        <asp:Panel ID="pnlfiles" runat="server"  style=" margin:30px 25px; ">
        <dx:ASPxFileManager ID="FileManager"  ClientInstanceName="FileManager" runat="server" DataSourceID="SqlDataSource1"
             OnCustomCallback="ASPxFileManager_CustomCallback"
            OnItemRenaming="FileManager_ItemRenaming" OnFolderCreating="fileManager_FolderCreating" OnFileUploading="fileManager_FileUploading"
        OnItemMoving="FileManager_ItemMoving" OnItemCopying="FileManager_ItemCopying" OnItemDeleting="FileManager_ItemDeleting" Theme="Aqua"><Settings ThumbnailFolder="~\Thumb\"/><SettingsDataSource KeyFieldName="Id" ParentKeyFieldName="ParentId" NameFieldName="Name"
            IsFolderFieldName="IsFolder" FileBinaryContentFieldName="Data" LastWriteTimeFieldName="LastWriteTime" /><SettingsDataSource /><ClientSideEvents CustomCommand="OnCustomCommand" ToolbarUpdating="OnToolbarUpdating" /><Settings AllowedFileExtensions=".jpg,.jpeg,.gif,.rtf,.txt,.avi,.png,.mp3,.xml,.doc,.pdf,.docx,.zip" /><SettingsEditing AllowRename="true" AllowMove="true" AllowCopy="true" AllowDelete="true" AllowDownload="true" AllowCreate="true" /><SettingsUpload Enabled="True" /><SettingsToolbar><Items><dx:FileManagerToolbarCustomButton CommandName="Properties"><Image IconID="setup_properties_16x16" /></dx:FileManagerToolbarCustomButton><dx:FileManagerToolbarRefreshButton BeginGroup="false" /></Items></SettingsToolbar><SettingsContextMenu Enabled="true"><Items><dx:FileManagerToolbarMoveButton /><dx:FileManagerToolbarCreateButton/><dx:FileManagerToolbarCopyButton /><dx:FileManagerToolbarDownloadButton /><dx:FileManagerToolbarRenameButton BeginGroup="true" /><dx:FileManagerToolbarDeleteButton /><dx:FileManagerToolbarRefreshButton BeginGroup="false" /><dx:FileManagerToolbarCustomButton Text="Properties" CommandName="Properties" BeginGroup="true"><Image IconID="setup_properties_16x16" /></dx:FileManagerToolbarCustomButton></Items></SettingsContextMenu></dx:ASPxFileManager>
        <asp:Label ID="lblUid" runat="server" Visible="false" ></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FmExampleDbConnectionString %>"
        SelectCommand="SELECT * FROM [FileSystem] where person=@uid or person='all'" DeleteCommand="DELETE FROM [FileSystem] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO [FileSystem] ([Name], [IsFolder], [ParentId], [Data], [LastWriteTime], [person]) VALUES (@Name, @IsFolder, @ParentId, @Data, @LastWriteTime, @uid)"
        UpdateCommand="UPDATE [FileSystem] SET [Name] = @Name, [IsFolder] = @IsFolder, [ParentId] = @ParentId, [Data] = @Data, [LastWriteTime] = @LastWriteTime WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter Name="uid" SessionField="id" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="IsFolder" Type="Boolean" />
            <asp:Parameter Name="ParentId" Type="Int32" />
            <asp:Parameter Name="Data" DbType="Binary" />
            <asp:Parameter Name="LastWriteTime" Type="DateTime" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="IsFolder" Type="Boolean" />
            <asp:Parameter Name="ParentId" Type="Int32" />
            <asp:Parameter Name="Data" DbType="Binary" />
            <asp:Parameter Name="LastWriteTime" Type="DateTime" />
             <asp:SessionParameter Name="uid" SessionField="id" />
        </InsertParameters>
    </asp:SqlDataSource>
    <dx:ASPxPopupControl ID="PopupControl" runat="server" ClientInstanceName="PopupControl" OnWindowCallback="PopupControl_WindowCallback" Width="430"
        ShowHeader="true" ShowFooter="false" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" AllowDragging="true" DragElement="Header" CssClass="DetailsPopup" CloseOnEscape="true"><ClientSideEvents EndCallback="OnPopupEndCallback" /><ContentCollection><dx:PopupControlContentControl><dx:ASPxFormLayout ID="FormLayout" runat="server" AlignItemCaptionsInAllGroups="True"><Items><dx:LayoutGroup Caption=" " GroupBoxDecoration="None"><Items><dx:LayoutItem Caption="Name"><LayoutItemNestedControlCollection><dx:LayoutItemNestedControlContainer><dx:ASPxLabel ID="Name" runat="server" /></dx:LayoutItemNestedControlContainer></LayoutItemNestedControlCollection></dx:LayoutItem></Items></dx:LayoutGroup><dx:LayoutGroup Caption=" " GroupBoxDecoration="None"><Items><dx:LayoutItem Caption="Download Link"><layoutitemnestedcontrolcollection><dx:LayoutItemNestedControlContainer><%--                   <asp:LinkButton ID="DownloadLink" runat="server" Text="Download" OnClick="DownloadFile">

                                              </asp:LinkButton>--%><asp:Button ID="btndownload" runat="server" OnClick="btndownload_Click" OnClientClick="aspnetForm.target ='_blank';" Text="make download link" /><%--  <dx:ASPxLabel ID="DownloadLink" runat="server"></dx:ASPxLabel>--%><br /><br /><br /></dx:LayoutItemNestedControlContainer></layoutitemnestedcontrolcollection></dx:LayoutItem><%--    <dx:LayoutItem Caption="Location">
                                    <LayoutItemNestedControlCollection >
                                        <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxLabel ID="Location" runat="server" />
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>--%><dx:LayoutItem Caption="Size"><LayoutItemNestedControlCollection ><dx:LayoutItemNestedControlContainer><dx:ASPxLabel ID="Size" runat="server" /></dx:LayoutItemNestedControlContainer></LayoutItemNestedControlCollection></dx:LayoutItem><dx:LayoutItem Caption="Contains" Name="Contains"><LayoutItemNestedControlCollection ><dx:LayoutItemNestedControlContainer><dx:ASPxLabel ID="Contains" runat="server" /></dx:LayoutItemNestedControlContainer></LayoutItemNestedControlCollection></dx:LayoutItem></Items></dx:LayoutGroup><dx:LayoutGroup Caption=" " GroupBoxDecoration="None"><Items><dx:LayoutItem Caption="Created"><LayoutItemNestedControlCollection ><dx:LayoutItemNestedControlContainer><dx:ASPxLabel ID="Created" runat="server" /></dx:LayoutItemNestedControlContainer></LayoutItemNestedControlCollection></dx:LayoutItem></Items></dx:LayoutGroup></Items></dx:ASPxFormLayout></dx:PopupControlContentControl></ContentCollection></dx:ASPxPopupControl></asp:Panel>    </section>
            <script src="Business%202_files/jquery-1.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="Business%202_files/bootstrap.js"></script>

    <!-- Plugin JavaScript -->
    <script src="Business%202_files/jquery.js"></script>
    
    <!-- Custom Javascript -->
           <script src="Business%202_files/custom.js"></script>
    </div>
    </form>
</body>
</html>
