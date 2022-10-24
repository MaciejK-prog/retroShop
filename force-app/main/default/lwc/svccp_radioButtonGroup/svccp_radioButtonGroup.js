import {api, LightningElement} from 'lwc';
import BLIK from '@salesforce/resourceUrl/blik';
import PRZELEWY24 from '@salesforce/resourceUrl/przelewy24';
import PAYU from '@salesforce/resourceUrl/payU';

export default class RadioButtonGroup extends LightningElement {
    //@api buttons = [];

    handleChange(event) {
        this.dispatchEvent(new CustomEvent('change', {detail: event.target.value}));
    }

    buttons = [
        {
            name: 'test1',
            label: 'Blik',
            imageId: BLIK,
        },
        {
            name: 'test2',
            label: 'Przelewy24',
            imageId: PRZELEWY24,
        },
        {
            name: 'test3',
            label: 'PayU',
            imageId: PAYU,
        }
    ];
}