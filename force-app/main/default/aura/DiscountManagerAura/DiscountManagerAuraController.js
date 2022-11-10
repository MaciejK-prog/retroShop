({
    
    doInit:function(component, event,helper){

        helper.getPricebookRecords(component, event);
        
    },
    
    endDateUpdated: function(component,event,helper){
        var target = event.getSource();
    
        if(!$A.util.isUndefinedOrNull(target)) {
            var enteredValue = target.get("v.value");
            var g = new Date();
            if(Date.parse(enteredValue) < g.getTime()){
                component.find("end-date").set("v.value",null);
                alert('Invalid Date');
            }
        }
    },

    handleDiscountChange: function(component, event) {

        if(component.get("v.value") === 'precentage') {
           component.set("v.isPrecentVisible", true);
           component.set("v.discountAmount", 0);

        } else {
            component.set("v.isPrecentVisible", false);
            component.set("v.discountAmount", 0);
        }

    },

    startDateUpdated: function(component,event,helper){
        var target = event.getSource();
    
        if(!$A.util.isUndefinedOrNull(target)) {
            var enteredValue = target.get("v.value");
            var g = new Date();
            if(Date.parse(enteredValue) < g.getTime()){
                component.find("start-date").set("v.value",null);
                alert('Invalid Date');
            }
        }
    },

    checkboxHandler: function (cmp, event, helper) {      
        var oldValue= event.getParam("oldValue");
        var newValue = event.getParam("value");

    
        // Identify the new checkbox value
        if(oldValue.length < newValue.length){
            
        }
       },

    sendDataHandler: function (component, event, helper) {
        let passEvent = component.getEvent('informationPassEvent');

        if(component.get('v.endDateTime') > component.get('v.startDateTime')) {

        passEvent.setParam("pricebookType", component.get('v.pricebookTypes'));
        passEvent.setParam("discountType", component.get('v.value'));
        passEvent.setParam("discount", component.get('v.discountAmount'));
        passEvent.setParam("discountStartDate", component.get('v.startDateTime'));
        passEvent.setParam("discountEndDate", component.get('v.endDateTime'));


        passEvent.fire();
        } else {

            let title='Warning!',
            message='End date is chosen before start date',
            type='warning';
            helper.showToast(component, event,title, message , type );
        }
    },

    sendDiscountValue: function(component,event,helper) {

        let discountEvent = component.getEvent('discountToUpdateEvent');

        discountEvent.setParam("discountType", component.get('v.value'));
        discountEvent.setParam("discount", component.get('v.discountAmount'));
        
        discountEvent.fire();

    }
});
