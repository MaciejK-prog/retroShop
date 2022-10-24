import { LightningElement, track } from 'lwc';
import searchHotDealsProducts from '@salesforce/apex/mainMenuController.searchHotDealsProducts';
import searchSalesProducts from '@salesforce/apex/mainMenuController.searchSalesProducts';
import HOT_DEAL_TEXT from '@salesforce/resourceUrl/HotDeals';
import SALE_TEXT from '@salesforce/resourceUrl/Sale';
import UserPreferencesTaskRemindersCheckboxDefault from '@salesforce/schema/User.UserPreferencesTaskRemindersCheckboxDefault';
import { NavigationMixin } from 'lightning/navigation';

export default class HomePageDisplayProducts extends NavigationMixin(LightningElement) {

    hotDealsUrl = HOT_DEAL_TEXT;
    saleUrl = SALE_TEXT;
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    @track products;
    @track sales;

    connectedCallback() {
        searchHotDealsProducts()
        .then(result => {
            this.handleHotDealsResponse(result);
        })
        .catch(error => {
            this.error = error;
        });

        searchSalesProducts()
        .then(result => {
            this.handleSalesResponse(result);
        })
        .catch(error => {
            this.error = error;
        });
    }

    

    handleHotDealsResponse(result) {

        let addedCurrency = " PLN";
        this.products = JSON.parse(JSON.stringify(result));
        this.products.forEach((product) => {
 
            product.mainPhotoUrl = this.standardImageUrl + product.image;

            product.discountString = product.discountedPrice + addedCurrency ;

            product.priceString = product.price + addedCurrency;
            
        })

    }


    handleSalesResponse(result) {
        this.sales = JSON.parse(JSON.stringify(result));
        let addedCurrency = " PLN";
    
        this.sales.forEach((sale) => {
 
            sale.mainPhotoUrl = this.standardImageUrl + sale.image;
            sale.discountString = sale.discountedPrice + addedCurrency ;

            sale.priceString = sale.price + addedCurrency;

        })
;
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