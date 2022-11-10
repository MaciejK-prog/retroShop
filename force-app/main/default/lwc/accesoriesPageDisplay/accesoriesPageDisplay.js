import { LightningElement } from 'lwc';
import displayAccesoriesRecords from '@salesforce/apex/CategoryPagesController.getAccesoriesCategoryProducts';
import { NavigationMixin } from 'lightning/navigation';

export default class AccesoriesPageDisplay extends NavigationMixin(LightningElement) {
    
    accesories=[];
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    connectedCallback() {

        displayAccesoriesRecords()
        .then(result => {
            this.handleAccesoriesResponse(result);
        })
        .catch(error => {
            this.error = error;
        });

    }


    handleAccesoriesResponse(result) {
        let addedCurrency = " PLN";
        this.accesories = JSON.parse(JSON.stringify(result));
    
        this.accesories.forEach((accesory) => {
            accesory.mainPhotoUrl = this.standardImageUrl + accesory.image;
            accesory.discountString = accesory.discountedPrice + addedCurrency ;
            accesory.priceString = accesory.price + addedCurrency;
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