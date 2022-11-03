import { LightningElement, api, track } from 'lwc';
import { FlowNavigationFinishEvent } from 'lightning/flowSupport';
import addMainPhoto from '@salesforce/apex/PhotoUploadController.addMainPhoto';
export default class FileUploadExample extends LightningElement {
    @api
    myRecordId;



    get acceptedFormats() {
        return ['.png'];
    }

    set todos(todos = []) {
        this._todos = [...todos];
    }

    @track _todos = [];

    get todosList() {
        return this._todos.map((todo) => {
            return { text: todo, id: Date.now().toString() };
        });
    }

    get hasTodos() {
        return this._todos && this._todos.length > 0;
    }

    handleUpdatedText(event) {
        this._text = event.detail.value;
    }

    filesList;

    @api
    availableActions = [];

    @api
    get todos() {
        return this._todos;
    }

    handleAddTodo() {
        this._todos.push(this._text);
        // notify the flow of the new todo list
        const attributeChangeEvent = new FlowAttributeChangeEvent(
            'todos',
            this._todos
        );
        this.dispatchEvent(attributeChangeEvent);
    }

    @api
    handleGoFinish() {
        console.log('wpadłem w event 1');
        if(this.fileList > 0) {
            const finishNavigationEvent = new FlowNavigationFinishEvent();
            console.log('wpadłem w event if');
        this.dispatchEvent(nextNavigationEvent);
        } else {
            alert('nope');
        }
    }



    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        let parsedUpload = JSON.parse(JSON.stringify(uploadedFiles));
        console.log(uploadedFiles[0].contentVersionId);
        addMainPhoto({productId: this.myRecordId, photoId : uploadedFiles[0].contentVersionId});
        alert('No. of files uploaded : ' + uploadedFiles.length);
        this.fileList = uploadedFiles.length;
    }
}