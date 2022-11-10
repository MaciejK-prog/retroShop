import { LightningElement } from 'lwc';
import displayPhonesRecords from '@salesforce/apex/CategoryPagesController.getPhonesCategoryProducts';
import { NavigationMixin } from 'lightning/navigation';

export default class PhonePageDisplay extends NavigationMixin(LightningElement) {

    phones=[];
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    connectedCallback() {

        displayPhonesRecords()
        .then(result => {
            this.handlePhonesResponse(result);
        })
        .catch(error => {         
            this.error = error;
        });

    }


    handlePhonesResponse(result) {

        let addedCurrency = " PLN";
        this.phones = JSON.parse(JSON.stringify(result));
    
        this.phones.forEach((phone) => {
            phone.mainPhotoUrl = this.standardImageUrl + phone.image;
            phone.discountString = phone.discountedPrice + addedCurrency ;
            phone.priceString = phone.price + addedCurrency;
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