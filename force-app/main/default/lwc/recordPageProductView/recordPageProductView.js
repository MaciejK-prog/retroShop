
import { LightningElement, api, track } from 'lwc';
import recieveRecordData from '@salesforce/apex/RecordPageController.recieveRecordData';
import getPhotoCollection from '@salesforce/apex/RecordPageController.getIdsOfDocumentContentVersion';

export default class RecordPageProductView extends LightningElement {
    @api productId;
    @track product;
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';

    connectedCallback() {
        recieveRecordData( { recordIdToDisplay : this.productId} )
        .then(result => {

           this.product = JSON.parse(JSON.stringify(result));

           this.product.mainPhotoUrl = this.standardImageUrl + this.product.image;

           
        })
        .catch(error => {
            
        });


        getPhotoCollection( { productId : this.productId} )
        .then(result => {

           this.photos = JSON.parse(JSON.stringify(result));


           for(let i = 0; i< this.photos.length; i++) {
            this.photos[i].otherPhotosUrl = this.standardImageUrl + this.photos[i].ContentDocument.LatestPublishedVersionId;
           
           }

           
        })
        .catch(error => {
  
        });

    }

    switchPhotos(event) {

        this.product.mainPhotoUrl = this.standardImageUrl + event.target.dataset.id;
    };

}

