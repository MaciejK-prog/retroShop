import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getOrder from '@salesforce/apex/cartController.getOrder';
import createCase from '@salesforce/apex/cartController.createACase';
import recieveCase from '@salesforce/apex/cartController.recieveCaseBody';

export default class CartHistoryPreview extends LightningElement {

    @api recordId;
    order = {};
    standardImageUrl = '/retro/sfc/servlet.shepherd/version/download/';
    @track isModalOpen = false;
    @track is2ndModalOpen = false;
    descriptionOfComplain;
    subjectOfComplain;
    productId;
    orderItemId;
    isComplainedAlready;
    caseToDisplay;
    subjectToDisplay;
    reasonToDisplay;
    statusToDisplay;



    connectedCallback() {


        getOrder( { orderId : this.recordId} )
        .then(result => {

            console.log(result);

           this.order=JSON.parse(JSON.stringify(result));

        
           for(const orderItem of this.order.OrderItems) {
            console.log(orderItem);
                orderItem.mainPhotoUrl = this.standardImageUrl + orderItem.Product2.Main_Photo__c;
                if(orderItem.Cases__r) {
                    orderItem.complained = true;
                    orderItem.CaseId = orderItem.Cases__r[0].Id;
                   
                } else {
                    orderItem.complained = false;
                }
           }
           
           
        })
        .catch(error => {

        });


        

    }

    submitCase() {


        createCase({subject : this.subjectOfComplain , reason: this.descriptionOfComplain, idOfProduct: this.productId, idOfOrderItem: this.orderItemId})
        .then(result => {

        }) .catch ( error => {
         
        });

    
    }

    handleSubjectChange(event) {
        this.subjectOfComplain = event.target.value;
    }

    handleReasonChange(event) {
        this.descriptionOfComplain = event.target.value;
    }

    openModal(event) {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
        this.productId = event.target.dataset.id;
        this.orderItemId = event.target.dataset.key;
    }
    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

    open2ndModal(event) {
        // to open modal set isModalOpen tarck value as true
        console.log(event.target.dataset.key);
        this.caseToDisplay = event.target.dataset.key;
        this.is2ndModalOpen = true;
        recieveCase ({caseId : this.caseToDisplay})
        .then(result => {
            this.subjectToDisplay = result.Subject;
            this.reasonToDisplay = result.Description;
            this.statusToDisplay= result.Status;

        }).catch(error => {
            console.log(error);
        });
    }

    close2ndModal() {
        // to close modal set isModalOpen tarck value as false
        this.is2ndModalOpen = false;
    }


    submitDetails() {

        this.submitCase();
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
        const event = new ShowToastEvent({
            title: 'Case Submitted',
            message:
                'Your case has been submitted!',
            variant:
                'success'
        });

        this.dispatchEvent(event);
    }
}