import { LightningElement } from 'lwc';
import displayConsoleRecords from '@salesforce/apex/CategoryPagesController.getConsoleCategoryProducts';
import { NavigationMixin } from 'lightning/navigation';

export default class ConsolePageDisplay extends NavigationMixin(LightningElement) {

    consoles=[];
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    connectedCallback() {

        displayConsoleRecords()
        .then(result => {

            this.handleConsoleResponse(result);
        })
        .catch(error => {
  
            this.error = error;
        });

    }


    handleConsoleResponse(result) {
 
        let addedCurrency = " PLN";
        this.consoles = JSON.parse(JSON.stringify(result));
 
    
        this.consoles.forEach((console1) => {
    
            console1.mainPhotoUrl = this.standardImageUrl + console1.image;
  
            console1.discountString = console1.discountedPrice + addedCurrency ;

            console1.priceString = console1.price + addedCurrency;
        })
        
    }

    redirectToRecordPage(event) {

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.dataset.id,
                objectApiName: 'Product2',
                actionName: 'view'
            }

        });



    }
}