({
    helperMethod : function() {

    },

    getDifference : function(oldValue, newValue) {
        var result = [];
        for (var i = 0; i < newValue.length; i++) {
            if (oldValue.indexOf(newValue[i]) === -1) {
                result.push(newValue[i]);
            }
        }
        for (i = 0; i < oldValue.length; i++) {
            if (newValue.indexOf(oldValue[i]) === -1) {
                result.push(oldValue[i]);
            }
        }
        return result;
    },

    showToast : function(component, event, title, message, type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type": type
        });
        toastEvent.fire();
    },

    getPricebookRecords: function(component, event) {
        const action = component.get("c.getPricebookList");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(state === 'SUCCESS')  {
                component.set('v.pricebooks', response.getReturnValue());
            } else {
                alert();
            }
        });
        $A.enqueueAction(action);
        
    }


})
