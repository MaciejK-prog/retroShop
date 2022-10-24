import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import recieveRecordData from '@salesforce/apex/RecordPageController.recieveRecordData';
import checkIfTheresAnAuction from '@salesforce/apex/RecordPageController.checkIfProductIsOnAuction';
import cartService from 'c/cartService'
import Id from '@salesforce/user/Id';
import bidPriceUpdate from '@salesforce/apex/RecordPageController.updatePriceAfterAuction';



export default class ProductDescriptionComponent extends LightningElement {

    @api productId;
    @track product;
    @track photos;
    @track auctionProduct;
    isThereAnAuction = false;
    auctionPrice;
    priceToInsert;
    auctionPriceToDisplay;
    userId = Id;
    inactiveAuction = false;
    hideOthers = false;
    userWhichWonAuction = false;

    connectedCallback() {

        console.log('user id' + this.userId);
        let pln = ' PLN';
        recieveRecordData( { recordIdToDisplay : this.productId} )
        .then(result => {
           this.product = JSON.parse(JSON.stringify(result));

            this.product.updatedPrice = this.product.price + pln;
            this.product.mainPhotoUrl = this.standardImageUrl + this.product.image

           
        })
        .catch(error => {
            console.log('wtf');
        });

        checkIfTheresAnAuction({idOfProduct : this.productId}) 
            .then(result => {

                this.auctionProduct = JSON.parse(JSON.stringify(result));

                if(result.length > 0) {

                    console.log('1szy if');
                    console.log( JSON.parse(JSON.stringify(result)));
                    this.auctionPrice = result[0].Start_Price__c;

                    console.log(this.userId);
                    console.log(result[0].UserId__c);

                    this.auctionPriceToDisplay = result[0].Start_Price__c + ' pln' ;
                    console.log(this.auctionPriceToDisplay);

                    if(result[0].Status__c === true) {
                        this.isThereAnAuction = true;
                        console.log('if w ifie');


                    } else if( result[0].Status__c === false && result[0].UserId__c === this.userId ) {
                        console.log('1szy else if');
                        this.hideOthers = true;
                        this.inactiveAuction = true;
                        this.userWhichWonAuction = true;

                  } else if( result[0].Status__c === false && result[0].UserId__c !== this.userId) {
                        console.log('2gi else if');
                        this.hideOthers = true;
                        this.inactiveAuction = true;
                        this.userWhichWonAuction = false;
                  }

                } else {

                    console.log('else if');

                    this.isThereAnAuction = false;
                }

                console.log('czemu tu kurwa');
            })
            .catch(error => {

            })
        

    }

    addToCart() {
        const event = new ShowToastEvent({
            title: 'Product Added',
            message:
                'Your product have been added to cart!',
            variant:
                'success'
        });
        this.dispatchEvent(event);

        cartService.addProduct(this.productId);
    }


    placeYourBid() {

        if(parseInt(this.priceToInsert) > parseInt(this.auctionPrice)) {
            this.auctionPrice = this.priceToInsert;
            this.auctionPriceToDisplay = this.priceToInsert + " pln";

            bidPriceUpdate({idOfProduct : this.productId, newPrice : this.auctionPrice, idOfUser : this.userId});

            const event = new ShowToastEvent({
                title: 'Your bid has been accepted!',
                message:
                    'Your product have been added to cart!',
                variant:
                    'success'
            });

            this.dispatchEvent(event);

        } else {

            console.log(this.auctionPrice);

            const event = new ShowToastEvent({
                title: 'Bid rejected',
                message:
                    'Your bid is rejected!',
                variant:
                    'error'
            });
            this.dispatchEvent(event);

        }

    }

    handleAuctionPriceChange(event) {
        this.priceToInsert = event.target.value;
        console.log(this.priceToInsert);
    }

}
