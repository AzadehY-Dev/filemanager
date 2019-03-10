<%@ Page Language="C#" AutoEventWireup="true" CodeFile="download.aspx.cs" Inherits="download" %>


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
    <form id="form2" runat="server">
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
                       <%-- <asp:LinkButton ID="lnkbtnlog" runat="server">LOG IN</asp:LinkButton>--%>
                    </li>
                 <%--   <li>
                        <a href="WO.aspx">Contracts</a>
                    </li>--%>
				<%--	<li class="dropdown">
						<a href="WO.aspx">WO</a>
						<ul class="dropdown-menu">
							<li><a href="#">reports</a></li>
							<li><a href="#">details</a></li>
						</ul>
					</li>--%>
                 <%-- 	<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">PO <span class="caret"></span></a>
						<ul class="dropdown-menu" >
							<li><a href="#">reports</a></li>
							<li><a href="#">details</a></li>
						</ul>
					</li>--%>
                    <%--  <li>
                        <a href="#">Invoice</a>
                    </li>--%>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
    </nav>
    <section class="intro">
        <asp:Panel ID="pnllogin" runat="server">
      
      
                     <div class="divround" style="width:1000px; background-color:white; height:300px;">
                 <br /><br />
                   <table style=" margin:30px auto; ">
                       <tr>
                           <td>
                                  <br /> <br />
                               <asp:Button ID="Button1" runat="server" Text="Download" OnClick="Button1_Click" Height="72px" Width="167px" />
                                <br /> <br />
                           </td>
                            <td>
                            <%--  <asp:DropDownList ID="ddpusername" Width="190px"
                                  runat="server" OnSelectedIndexChanged="ddpusername_SelectedIndexChanged" AutoPostBack="True">

                              </asp:DropDownList>--%>
                                <br /> <br />
                            </td>
                       </tr>
                         <tr>
                           <td>
                             
                                <br /> <br />
                           </td>
                            <td>
                               
                            </td>
                       </tr>
                      
                   </table>
               </div>
        </asp:Panel>

         </section>
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
