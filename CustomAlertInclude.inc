
  <!-- Alert Message box -->
	    <div id="divoverlaysuccess" class="lightbox-overlay" style="display: none"></div>
           <div id="divalert" class="light-box" style="display: none">
        <div id="divheader" class="light-box-heading">
           <asp:Image runat="server" ID='imgSucess' ImageUrl="~/images/right.png" width="33px" height="25px"/>
		    <asp:Image runat="server"   ID='imgError' ImageUrl="~/images/wrong.png" width="20px" height="24px"/>
          <span id="spnHeader"></span>
          <span id="spnHeader"></span>
        </div>
        <div class="light-box-body">
            <span id="spnMessage" class="lightbox-msg-style" style="text-align: left">
                <asp:Label ID="lblMsgAlert" runat="server" Text=""></asp:Label><br/>
            </span>
            <div style="text-align: center; padding: 10px 10px 0">
                <input id="btnClosePopup"  onclick="HideAlertBox()" class="btn_Confirm btn-success gradient" style="width: 100px !important;padding: 4px 9px" value="Ok" type="button"/>
            </div>
        </div>
    </div>

            <div id="divalertConfirm" class="light-box" style="display: none">
                <div id="divheaderConfirm" class="light-box-heading">
                 <asp:Image runat="server" ID='imgQuestion' ImageUrl="~/images/Question.png" width="33px" height="25px"/>
                    CONFIRMATION
                </div>
                <div class="light-box-body">
                    <span id="spnMessageConfirm" class="lightbox-msg-style" style="text-align: left"></span>
                </div>
                <div style="text-align: center; padding: 10px 10px 0">
                    <input id="btnYesPopupConfirm"  class="btn_Confirm btn-success gradient" style="width: 100px !important; padding: 1px 9px" value="Yes" type="button" />
                    <div style="display: inline; width: 10%"></div>
                    <input id="btnNoPopupConfirm"  class="btn_Confirm btn-success gradient" style="width: 100px !important; padding: 1px 9px" value="No" type="button" />
                </div>
            </div>


<!-- Unsaved Confirm Message box-->
			<div id="divUnSavedConfirm" class="light-box" style="display: none">
        <div id="divUnSavedheaderConfirm" class="light-box-heading">
         
           <asp:Image runat="server" ID='imgUnsaveQuestion' ImageUrl="~/images/Question.png" width="33px" height="25px"/>CONFIRMATION</div>
        <div class="light-box-body">
            <span id="spnUnSavedMessageConfirm" class="lightbox-msg-style" style="text-align: left"> <asp:Label ID="lblUnsavedMsgConfirm" runat="server" Text=""></asp:Label></span>
          <div id="divUnSavedTermCondition" class="card m-t-10 m-b-10 float-left" >

            <div class="card-padding card-header">
              <div class="row">

                <div class="col-md-12 clearfix footer-bar">

                  <div class="col-md-12 "> 
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
            <div style="text-align: center; padding: 10px 10px 0">
                <input id="btnUnSavedYesPopupConfirm" onclick="OnUnSavedConfirm()" class="btn btn-success gradient" style="padding: 4px 9px" value="Yes" type="button"/>
                <input id="btnUnSavedNoPopupConfirm"  onclick="HideUnSavedConfirmBox()" class="btn btn-danger gradient" style="padding: 4px 9px" value="No" type="button"/>
            </div>
        </div>