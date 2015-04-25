﻿<%@ Page Language="C#" Inherits="GA.Web.Default"  %>
<!DOCTYPE html>
<html>
<head runat="server">
	<title>Default</title>
</head>
<body>
	<form id="form1" runat="server">
		<asp:ScriptManager ID="ScriptManager1" runat="server">
		</asp:ScriptManager>

		<h2>Admin</h2>

TODO: add GridView Control 
TODO: add SqlDataSource Control that uses MYSQL 

<asp:SqlDataSource id="dsCollectionQueue" 
		ConnectionString="<%$ConnectionStrings:Database_CollectionItemQueue %>" 
		ProviderName="<%$ ConnectionStrings:Database_CollectionItemQueue.providerName%>"
		SelectCommand = "SELECT `collectionitemqueue`.`ItemID`,
						    `collectionitemqueue`.`ItemTitle`,
						    `collectionitemqueue`.`ItemUrl`,
						    `collectionitemqueue`.`ItemDescription`,
						    `collectionitemqueue`.`ItemTags`,
						    `collectionitemqueue`.`ItemProcessed`
						FROM `ga`.`collectionitemqueue`;
						 "
		UpdateCommand = "UPDATE `collectionitemqueue`
						SET
						`ItemTitle` = @ItemTitle,
						`ItemUrl` = @ItemUrl,
						`ItemDescription` = @ItemDescription,
						`ItemTags` = @ItemTags
						WHERE `ItemID` = @ItemID;
						"
		DeleteCommand = "DELETE FROM `ga`.`collectionitemqueue` WHERE `ItemID` = @ItemID;"
		InsertCommand = "INSERT INTO `ga`.`collectionitemqueue`
							(
							`ItemTitle`,
							`ItemUrl`,
							`ItemDescription`,
							`ItemTags`,
							`ItemProcessed`)
							VALUES
							(
							@ItemTitle,
							@ItemUrl,
							@ItemDescription,
							@ItemTags,
							0);
							"
			runat="server">
		</asp:SqlDataSource>

	<asp:UpdatePanel ID="UpdatePanel1" runat="server">
      <ContentTemplate>

      	<asp:Button id="btnLongRunningProcess" runat="server" OnClick="btnLongRunningProcess_Click" Text="Long Run"></asp:Button>

		<asp:GridView id="gvCollectionQueue" 
			DataSourceID="dsCollectionQueue"
			DataKeyNames="ItemID"
			AutoGenerateColumns="true"
			AutoGenerateEditButton="true"
			AutoGenerateDeleteButton="true" 
			runat="server">
			</asp:GridView>


		<asp:FormView id="fvCollectionQueue"
			DataSourceID="dsCollectionQueue"
			DataKeyNames="ItemID"
			runat="server"
			AllowPaging="true"
			DefaultMode="Insert"
			>
			<InsertItemTemplate>
				Title: <asp:TextBox id="txtItemTitle" runat="server" Text='<%# Bind("ItemTitle") %>' ></asp:TextBox><br>
				URL:<asp:TextBox id="txtItemUrl" runat="server" Text='<%# Bind("ItemUrl") %>' ></asp:TextBox><br>
				Description:<asp:TextBox id="txtItemDescription" runat="server" Text='<%# Bind("ItemDescription") %>' TextMode="MultiLine" ></asp:TextBox><br>
				Tags: <asp:TextBox id="txtItemTags" runat="server" Text='<%# Bind("ItemTags") %>' ></asp:TextBox><br>
				<asp:LinkButton id="lbInsertItem" runat="server" CommandName="Insert"  >Insert</asp:LinkButton>
			</InsertItemTemplate>
			<ItemTemplate>
				<asp:Label id="lblItemTitle" runat="server" Text='<%# Eval("ItemTitle") %>' />
			</ItemTemplate>
		</asp:FormView>

</ContentTemplate>
</asp:UpdatePanel>


<asp:UpdateProgress ID="UpdateProgress1" runat="server" DynamicLayout="true" AssociatedUpdatePanelID="UpdatePanel1" >

   <ProgressTemplate>
   	
      Loading...
      <img src="http://www.ajaxload.info/cache/FF/FF/FF/00/00/00/1-0.gif">

      </ProgressTemplate>
   
</asp:UpdateProgress>


	</form>
</body>
</html>

