({
    recieveAndSaveDataFromCalculator : function(component, event) {

        var action = component.get('c.createNewEntries');
        action.setParams({selectedProductsString: JSON.stringify(component.get('v.selectedRowsList')), discountValue: event.getParam("discount"), 
        discountType: event.getParam("discountType"), pricebookType: event.getParam("pricebookType"), endDate: event.getParam("discountEndDate"),
         startDate: event.getParam("discountStartDate")});



        action.setCallback(this, function (response) {
            const state = response.getState();
            if(state === "SUCCESS") {
                let results = response.getReturnValue();
                component.find("table").handleResponse(results);
                let failCounter = 0;

                for(let result of results) {

                    if(!result.isSucces) {
                        failCounter = failCounter + 1;
                    }
                }

                if(failCounter === 0) {
                    this.navigate(component, event);
                    let title='Success!',
                    message='Discount has been added!',
                    type='success';
                   this.showToast(component, event,title, message , type );
                }

            } else {

            }
        });

        $A.enqueueAction(action);


        },

        navigate : function(component, event, helper) {
        
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": 'https://resilient-panda-sdj8lq-dev-ed.lightning.force.com/lightning/o/Pricebook2/list?filterName=Recent'
            });
            urlEvent.fire();
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


})
