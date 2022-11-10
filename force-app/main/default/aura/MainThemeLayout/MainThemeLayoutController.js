({
    myAction : function(component, event, helper) {

    },

    returnToHomePage : function(component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "https://resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/"
        });
        urlEvent.fire();

    }




})
