import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import saveNewCommentary from '@salesforce/apex/CommentaryContrller.saveNewCommentary';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCommentList from '@salesforce/apex/CommentaryContrller.getCommentList';
import { refreshApex } from '@salesforce/apex';
import Id from '@salesforce/user/Id';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class ProductRatingComponent extends LightningElement {

    userId = Id;
    @api productId;
    @wire(CurrentPageReference) pageRef;
    commentValue;
    starRating;
    commentaryList
    wiredActivities;
    userComment;
    userCommentId;
    userRating;

connectedCallback(){

   getCommentList ({ productId: this.productId })
    .then (result => {

        this.wiredActivities = result;

        if (result) {
            this.commentaryList = result;
            let obj =JSON.parse(JSON.stringify(result));
            let userCommentary = obj.find(element => element.OwnerId == this.userId);
            if (userCommentary) {
               
                this.userCommentId = userCommentary.Id;
                this.userComment = userCommentary.Commentary__c;
                this.userRating = userCommentary.rating__c;
        
        }}})
        .catch(error => {

        });
    }



    saveComment() {
        const textarea = this.template.querySelector('lightning-textarea');
        this.commentValue = textarea.value;

        saveNewCommentary({
            commentId: this.userCommentId,
            comment: this.commentValue,
            rating: this.starRating,
            productId: this.pageRef.attributes.recordId
        }).then(
            (result) => {
                this.dispatchEvent(new ShowToastEvent({
                    title: 'Success',
                    message: 'Adding comment success',
                    variant: 'success',
                    mode: 'dismissable'
                }));
            }).finally(() => {
            // this.refreshApexFunction();
            refreshApex(this.wiredActivities)
        }).catch((error) => {
            
        });
    }

    onStarRatingClick(event) {
        this.starRating = event.detail.rating;
    }


    getDeleteEvent(event) {
        deleteRecord(this.userCommentId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
            }).finally(() => {
                this.userCommentId = '';
                this.userComment = '';
                this.userRating = 0;
                refreshApex(this.wiredActivities)
            }).catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            })
    }

    refreshApexFunction() {
        refreshApex(this.wiredActivities)
    }
}