<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TextArea.ascx.cs" Inherits="WebUserControl" %>
<script type="text/javascript">
    /* jQuery textarea resizer plugin usage */
    $(document).ready(function () {

        $('textarea.resizable:not(.processed)').TextAreaResizer();

    });
    function countChar(val, maxlength) {
     
        var len = val.value.length;
        if (len >= maxlength) {
            val.value = val.value.substring(0, maxlength);
        }
    };
  
    function removeClassName(elem, fromClassName, ToClassName) {

        var remClass = elem.className;
        var re = new RegExp('(^| )' + fromClassName + '( |$)');
        var reWith = ' ' + ToClassName + ' ';

        remClass = remClass.replace(re, reWith);
        remClass = remClass.replace(/ $/, '');

        elem.className = remClass;
    }

    function textboxsize(btnObj, txtboxObj) {

        var txtbox_suffix = btnObj.id.substr(0, btnObj.id.lastIndexOf('_'));
        var txtbox = txtbox_suffix + "_" + txtboxObj;
        var txt = document.getElementById(txtbox);
        if (document.getElementById(btnObj.id).className == "textarea_small_btn") {

            document.getElementById(btnObj.id).title = "Expand";
            document.getElementById(btnObj.id).className = "textarea_big_btn";
            removeClassName(document.getElementById(txt.id), 'textarea_resize_ctrl_small', 'textarea_resize_ctrl_big')

        }
        else {

            document.getElementById(btnObj.id).title = "Collapse";
            document.getElementById(btnObj.id).className = "textarea_small_btn";

            removeClassName(document.getElementById(txt.id), 'textarea_resize_ctrl_big', 'textarea_resize_ctrl_small')
        }

    }
</script>
<style type="text/css">
    div.grippie
    {
        background: #EEEEEE url(images/grippie.png) no-repeat scroll center 2px;
        border-color: #DDDDDD;
        border-style: solid;
        border-width: 0pt 1px 1px;
        cursor: s-resize;
        height: 9px;
        overflow: hidden;
    }
    .resizable-textarea textarea
    {
        display: block;
        margin-bottom: 0pt;
        width: 100%;
        height: 50%;
    }
</style>
<style type="text/css">
    .textarea_resize_ctrl_main
    {
        position: relative;
        width: 100%;
        padding: 0 5px 0 0;
    }
    
    .textarea_small_btn
    {
        background: url(../../images/expand_left.png) no-repeat #fff bottom left;
        border: 0;
        width: 16px;
        height: 15px;
        margin: 0;
        position: absolute;
        bottom: 0;
        right: 5px;
    }
    
    .textarea_big_btn
    {
        background: url(../../images/expand_right.png) no-repeat #fff bottom left;
        border: 0;
        width: 16px;
        height: 15px;
        margin: 0;
        position: absolute;
        bottom: 0;
        right: 5px;
    }
    
    
    
    .resize_bar
    {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        border-right: solid 1px #000;
        border-top: solid 1px #000;
        border-bottom: solid 1px #000;
        width: 16px;
    }
    
    .textarea_resize_ctrl_big
    {
        width: 99%;
        border: solid 1px #000;
        border-right: 0;
        margin: 0;
        height: 500px;
    }
    
    .textarea_resize_ctrl_small
    {
        width: 100%;
        border: solid 1px #000;
        border-right: 0;
        margin: 0;
        height: 200px;
    }
</style>
<asp:TextBox ID="txtAreaBox" runat="server"  Wrap="true" CssClass="resizable textarea_resize_ctrl_small nomasking"
    TextMode="MultiLine" autocomplete="off"></asp:TextBox>
