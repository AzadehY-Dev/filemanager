<%@ Page Language="C#" AutoEventWireup="true" CodeFile="manager.aspx.cs" Inherits="manager" %>

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
                        <asp:LinkButton ID="lnkbtnlog" runat="server" OnClick="lnkbtnlog_Click">LOG IN</asp:LinkButton>
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
                               <asp:Label ID="Label1" runat="server" Text="User Name: ">  </asp:Label> &nbsp; &nbsp;
                                <br /><br />
                           </td>
                            <td>
                                <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>
                            <%--  <asp:DropDownList ID="ddpusername" Width="190px"
                                  runat="server" OnSelectedIndexChanged="ddpusername_SelectedIndexChanged" AutoPostBack="True">

                              </asp:DropDownList>--%>
                                <br /> <br />
                            </td>
                       </tr>
                         <tr>
                           <td>
                               <asp:Label ID="Label3" runat="server" Text="Password: ">  </asp:Label>
                                <br /> <br />
                           </td>
                            <td>
                                <asp:TextBox ID="txtpassword"  runat="server"></asp:TextBox>
                                <br /> <br />
                            </td>
                       </tr>
                         <tr>
                             <td></td>
                           <td >
                               <asp:Button ID="BtnLogin" runat="server" Text="Log In" Height="39px" Width="97px" OnClick="BtnLogin_Click" />
                           </td>
                       </tr>
                   </table>
               </div>
        </asp:Panel>
       
        <asp:Panel ID="pnlmanage" runat="server" Visible="false" >
             <div class="divround3" >
 <dx:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" DataSourceID="SqlDataSource1"
      AutoGenerateColumns="False" Width="100%" Theme="Aqua" KeyFieldName="id">
        <Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="id" VisibleIndex="1" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="name" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="username" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="pass" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="manager" VisibleIndex="4">
            </dx:GridViewDataCheckColumn>
        </Columns>
        <SettingsEditing EditFormColumnCount="3"/>
        <SettingsPager Mode="ShowAllRecords"/>
        <Settings ShowTitlePanel="true" />
        <SettingsText Title="Manage users for accessing files" />
    </dx:ASPxGridView>
<%--            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FmExampleDbConnectionString %>" 
                SelectCommand="SELECT * FROM [userTbl]" ></asp:SqlDataSource>
                 OnInserting="SqlDataSource1_Inserting">--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FmExampleDbConnectionString %>"
        SelectCommand="SELECT [id], [name], [username], [pass], [manager] FROM [userTbl]"
        InsertCommand="INSERT INTO [userTbl] ([name], [username], [pass], [manager]) VALUES (@name, @username, @pass, @manager)" 
                DeleteCommand="DELETE FROM userTbl WHERE (id = @id)" 
                UpdateCommand="UPDATE userTbl SET name = @name, username = @username, pass = @pass, manager = @manager where id=@id">
                <DeleteParameters>
                    <asp:Parameter Name="id" />
                </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="pass" Type="String" />
            <asp:Parameter Name="manager" Type="Boolean" />
        </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="name" />
                    <asp:Parameter Name="username" />
                    <asp:Parameter Name="pass" />
                    <asp:Parameter Name="manager" />
                     <asp:Parameter Name="id" />
                </UpdateParameters>
    </asp:SqlDataSource>
   <%-- <demo:DemoDataSource runat="server" ID="DemoDataSource1" IdentityKey="EmployeeID" DataSourceID="EmployeesDataSource" />
    <ef:EntityDataSource runat="server" ID="EmployeesDataSource"
        ContextTypeName="NorthwindContext"
        EnableDelete="True" EnableInsert="True" EnableUpdate="True"
        EntitySetName="Employees">
    </ef:EntityDataSource>--%></div>
        </asp:Panel></section>
                    <script src="Business%202_files/jquery-1.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="Business%202_files/bootstrap.js"></script>

    <!-- Plugin JavaScript -->
    <script src="Business%202_files/jquery.js"></script>
    
    <!-- Custom Javascript -->
           <script src="Business%202_files/custom.js"></script>
        <asp:Label ID="lblpass" runat="server" Text="Label"></asp:Label>
    </div>
    </form>
</body>
</html>
