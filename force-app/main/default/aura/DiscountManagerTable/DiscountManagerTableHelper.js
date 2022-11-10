({
  
    fetchData : function(component) {
            const action = component.get("c.getProducts");
            action.setCallback(this, function(response){
                const state = response.getState();
                if(state === "SUCCESS") {
                    component.set("v.products", response.getReturnValue());
                    component.set("v.originalList", response.getReturnValue());
                } else {

                }

            });
            $A.enqueueAction(action);
    }
})
