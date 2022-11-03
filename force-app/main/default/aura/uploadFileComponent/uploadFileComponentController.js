({
    myAction : function(component, event, helper) {

    },

    handleFilesChange : function (cmp, event) {
        var files = event.getSource().get("v.files");
        alert(files.length + ' files !!');
    }
})