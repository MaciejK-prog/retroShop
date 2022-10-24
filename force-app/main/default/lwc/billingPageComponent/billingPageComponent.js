import { LightningElement, api } from 'lwc';

export default class BillingPageComponent extends LightningElement {

    paymentInfo = {};

paymentSubmit() {
    const isValid = this.validate();

    if (isValid) {
        this.dispatchEvent(new CustomEvent('submit', {detail: this.paymentInfo}));
    }
    
}

validate() {
    const allValid = [
        ...this.template.querySelectorAll('lightning-input'),
    ].reduce((validSoFar, inputCmp) => {
        inputCmp.reportValidity();
        return validSoFar && inputCmp.checkValidity();
    }, true);

    return allValid;
}


handleInputChange(event) {
    this.paymentInfo[event.target.dataset.id] = event.target.value;
}

}