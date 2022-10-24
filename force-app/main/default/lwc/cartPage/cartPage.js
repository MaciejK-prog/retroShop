import { LightningElement, api } from 'lwc';
import cartService from 'c/cartService'
import getCart from '@salesforce/apex/cartController.getProducts';
import saveOrderDetails from '@salesforce/apex/cartController.saveOrderDetails';


import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CartPage extends NavigationMixin(LightningElement)  {

    cart;
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';
    addedCurrency = " PLN";
    totalPrice = 0;
    recordId;
    redirectId;
    discountCodeValue;
    totalPriceWithoutCurrency;
    isValid;

    _showCart = true;

    connectedCallback() {
        this.getCartItems();
    }

    get showCart() {
        return this._showCart;
    }

    get showPayment() {
        return !this._showCart;
    }

    getCartItems() {
    const productIds = cartService.getProducts();
    getCart({productIds: productIds})
        .then((result) => {
   
            this.cart = JSON.parse(JSON.stringify(result));
            this.calculateTotalPrice();
            this.cart.forEach((item) => {
                item.mainPhotoUrl = this.standardImageUrl + item.image;
                item.discountString = item.price + this.addedCurrency ;
            });
            
        })
        .catch((error) => {

        })
        .finally(() => {
            this.isActive = true;
            
        })
    }

    deleteProduct(event) {
        cartService.removeProduct(event.target.dataset.id);
        this.getCartItems();

    }

    calculateTotalPrice() {
        let totalPrice = 0;
        let totalCustomPrice = 0;
    
        for (const cartItem of this.cart) {
            let calculatedProductStandardPrice = cartItem.price < cartItem.discountedPrice ? cartItem.discountedPrice : cartItem.price;
            totalPrice += (calculatedProductStandardPrice);
            totalCustomPrice += (cartItem.discountedPrice);  
        }

        
        this.totalPriceWithoutCurrency = totalPrice;

        this.totalPrice = totalPrice + this.addedCurrency;

       // totalCustomPrice = totalCustomPrice;
       // totalQuantity = totalQuantity;
    }

    goToPayment() {
        this._showCart = false;
    }

    discountCodeValueDetector(event) {
    this.discountCodeValue=event.target.value;
    console.log(this.discountCodeValue);
     if(this.discountCodeValue && this.discountCodeValue === "MINUS20") {
        console.log('minus20 jestem');
         this.totalPrice = this.totalPriceWithoutCurrency * 0.8;
         console.log(this.totalPrice + ' w ifie ');
         this.totalPrice = this.totalPrice + this.addedCurrency;
         this.isValid = true;
      } else if(this.discountCodeValue && this.discountCodeValue === "MINUS10") {
            this.totalPrice = this.totalPriceWithoutCurrency * 0.9;
            this.totalPrice = this.totalPrice + this.addedCurrency;
            console.log('minus10 jestem');
            this.isValid = true;
         } else {
            this.totalPrice = this.totalPriceWithoutCurrency + this.addedCurrency;
            this.isValid = false;
     }

     console.log(this.totalPrice);



     console.log(this.totalPrice + 'HALO KURKA');
    }

    saveOrder(event) {
        //todo save order
        const paymentInfo = event.detail;


        const payload = this.getPayload(paymentInfo);
        saveOrderDetails({orderDetailJson: JSON.stringify(payload)})
        .then(result => {
            this.redirectId = result;
            this.handleSuccess();
        })
        .catch(error => {

        });
    }

    getPayload(paymentInfo) {
        return {
            data: {
                BillingCountry: paymentInfo.country,
                BillingCity: paymentInfo.city,
                TotalAmount: this.totalPrice
            },
            items: this.cart
        }
    }

    handleSuccess() {

        const event = new ShowToastEvent({
            title: 'Payment Succeed',
            message:
                'Your purchase has been completed!',
            variant:
                'success'
        });
    
        this.dispatchEvent(event);
    
        const config = {
            type: 'standard__recordPage',
            attributes: {
                recordId: this.redirectId,
                objectApiName: 'Order',
                actionName: 'view'
            }
        };
        this[NavigationMixin.Navigate](config);
    }

}