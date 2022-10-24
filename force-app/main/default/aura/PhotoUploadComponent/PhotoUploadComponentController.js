({

    doInit: function(component, event, helper) {

        var action = component.get("c.getIdsOfDocumentContentVersion");
        action.setParams({productId: component.get("v.recordId")});
        action.setCallback(this, function(response) {

            let contentDocuments = response.getReturnValue();

            let contentDocumentIds=[];

            

            for(let contentDocument of contentDocuments) {
                contentDocumentIds.push(contentDocument.ContentDocument.LatestPublishedVersionId);
            }


            if(contentDocumentIds.length > 0) {
            component.set("v.idOfMainPhoto", contentDocumentIds[0]);
            component.set("v.idsOfPhotos", contentDocumentIds);
        

            $A.get('e.force:refreshView').fire();

            } else {

            component.set("v.idOfMainPhoto", "0687Q0000042moRQAQ");
            }

            component.set('v.validate', function() {

                var photoIds = component.get("v.idsOfPhotos");
        
                if(photoIds.length > 0 )  {
                    // If the component is valid...
                  
                return { isValid: true };
        
                } else {
                            // If the component is invalid...
                alert('Photo is required!');
                return { isValid: false, errorMessage: 'A value is required.' };
               }})

            })
        
        $A.enqueueAction(action);
    },

    refreshListView: function(component) {
        var action = component.get("c.getIdsOfDocumentContentVersion");
        action.setParams({productId: component.get("v.recordId")});
        action.setCallback(this, function(response) {

            let contentDocuments = response.getReturnValue();

            let contentDocumentIds=[];

            for(let contentDocument of contentDocuments) {
                contentDocumentIds.push(contentDocument.ContentDocument.LatestPublishedVersionId);
            }
            component.set("v.idOfMainPhoto", contentDocumentIds[0]);
            component.set("v.idsOfPhotos", contentDocumentIds);
        

            $A.get('e.force:refreshView').fire();
        })

        $A.enqueueAction(action);
    },


    handleClick : function (component, event, helper) {
        var action = component.get("c.deletePhoto");
        action.setParams({productId: component.get("v.recordId"), productToDelete: event.getSource().get('v.name') });
        action.setCallback(this, function(response) {
            const state = response.getState();

            let productToDeleteID = response.getParam('productToDelete');

            if(state === "SUCCESS") {

                let listOfIds = [];

                listOfIds = component.get("v.idsOfPhotos");


                let idToDelete = listOfIds.find(id => id === productToDeleteID);


                let index = listOfIds.indexOf(idToDelete);

                listOfIds.splice(index, 1);

                if(listOfIds.length > 0) {

                component.set("v.idsOfPhotos", listOfIds);

                component.set("v.reRenderLayout", true);
                } else {
                    component.set("v.idOfMainPhoto", "0687Q0000042moRQAQ");
                    component.set("v.reRenderLayout", true);
                }

                
            
            } else  {

                let title='Warning!',
                message='whooops, something went wrong!',
                type='warning';
                helper.showToast(component, event,title, message , type );

            }
        })

        $A.enqueueAction(action);
        component.set("v.reRenderLayout", false);
        
    },

    


        handleUploadFinished: function (component, event) {

            var action = component.get("c.getIdsOfDocumentContentVersion");
            action.setParams({productId: component.get("v.recordId")});
            action.setCallback(this, function(response) {

                let contentDocuments = response.getReturnValue();

                let contentDocumentIds=[];

                for(let contentDocument of contentDocuments) {
                    contentDocumentIds.push(contentDocument.ContentDocument.LatestPublishedVersionId);
                }
                component.set("v.idOfMainPhoto", contentDocumentIds[0]);
                component.set("v.idsOfPhotos", contentDocumentIds);
            

                $A.get('e.force:refreshView').fire();
            })

            $A.enqueueAction(action);
        },


        selectPhotoAsMain: function(component, event, helper) {

            var action=component.get("c.setPhotoAsMain");
            action.setParams({idOfPRoduct: component.get("v.recordId"), idOfPhoto: event.getSource().get('v.name')});
            component.set("v.idOfMainPhoto", event.getSource().get('v.name'));
            action.setCallback(this, function(response) {
               
            });

            $A.enqueueAction(action);
        },

       
        
         


})
