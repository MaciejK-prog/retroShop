import { LightningElement } from 'lwc';
import displayToysRecords from '@salesforce/apex/CategoryPagesController.getToysCategoryProducts';
import { NavigationMixin } from 'lightning/navigation';

export default class ToysPageDisplay extends NavigationMixin(LightningElement) {
    toys=[];
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    connectedCallback() {

        displayToysRecords()
        .then(result => {
            this.handleToysResponse(result);
        })
        .catch(error => {
            this.error = error;
        });

    }


    handleToysResponse(result) {

        let addedCurrency = " PLN";
        this.toys = JSON.parse(JSON.stringify(result));
    
        this.toys.forEach((toy) => {
            toy.mainPhotoUrl = this.standardImageUrl + toy.image;
            toy.discountString = toy.discountedPrice + addedCurrency ;
            toy.priceString = toy.price + addedCurrency;
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