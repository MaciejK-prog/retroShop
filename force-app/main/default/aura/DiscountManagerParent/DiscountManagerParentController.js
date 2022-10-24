({

    launchEntryInsert: function(component, event, helper) {
          
           if(component.get('v.selectedRowsList').length > 0) {

              helper.recieveAndSaveDataFromCalculator(component, event);
           } else {
              let title='Warning!',
              message='Empty list of products!',
              type='warning';
              helper.showToast(component, event,title, message , type );
           }
    },

    
    pushUpdatedDiscountPriceIntoTable: function(component, event, helper) { 
  

       let getSelectedList = JSON.parse(JSON.stringify(component.get('v.selectedRowsList')));
       let typeOfDiscount = event.getParam("discountType");
       let discountValue = event.getParam("discount");


       if(getSelectedList && typeOfDiscount === 'precentage') {

              for(let i=0; i < getSelectedList.length; i++) {
              let discountValueToCount = 1-(discountValue/100);
              let valueAfterDiscount = getSelectedList[i].price * discountValueToCount;
              getSelectedList[i].price = valueAfterDiscount;

       } 

       } else {
              
              for(let i=0;  i < getSelectedList.length ; i++) {
              let valueAfterDiscount = getSelectedList[i].price - discountValue;
              getSelectedList[i].price = valueAfterDiscount;


              }

       }
       
       component.find("table").applyDiscount(getSelectedList);
    }

       
       

              
 })
