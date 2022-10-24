import { LightningElement} from 'lwc';
import HOT_DEAL_TEXT from '@salesforce/resourceUrl/HotDeals';
import SALE_TEXT from '@salesforce/resourceUrl/Sale';
import searchHotDealsProducts from '@salesforce/apex/mainMenuController.searchHotDealsProducts';

export default class MailHotDealsDisplay extends LightningElement {

    // hotDealsUrl = HOT_DEAL_TEXT;
    // saleUrl = SALE_TEXT;
    // standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';
    // products;


//     connectedCallback() {
//         searchHotDealsProducts()
//         .then(result => {
//             this.handleHotDealsResponse(result);
//         })
//         .catch(error => {
//             this.error = error;
//         });

//     }

    

// handleHotDealsResponse(result) {

//     let addedCurrency = " PLN";
//     this.products = JSON.parse(JSON.stringify(result));
//     this.products.forEach((product) => {
 
//         product.mainPhotoUrl = this.standardImageUrl + product.image;

//         product.discountString = product.discountedPrice + addedCurrency ;

//         product.priceString = product.price + addedCurrency;
            
//         })

//     }
}