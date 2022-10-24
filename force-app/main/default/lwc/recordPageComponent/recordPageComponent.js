import { LightningElement, api, track } from 'lwc';
import recieveRecordData from '@salesforce/apex/RecordPageController.recieveRecordData';

export default class RecordPageComponent extends LightningElement {

    @api recordId;
    @track product;
    productId;

    connectedCallback() {
        
        this.productId = this.recordId;
       
        recieveRecordData( { recordIdToDisplay : this.recordId} )
        .then(result => {
          
        })
        .catch(error => {
            
        });

    }


}