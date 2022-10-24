import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import CONSOLE_LOGO from '@salesforce/resourceUrl/consolePNG';
import ACCESORIES_LOGO from '@salesforce/resourceUrl/accesoriesPNG';
import PHONE_LOGO from '@salesforce/resourceUrl/phonePNG';
import TOY_LOGO from '@salesforce/resourceUrl/toyPNG';
import CART_LOGO from '@salesforce/resourceUrl/cartPNG';

export default class MainMenuComponent extends NavigationMixin(LightningElement) {

    consoleLogoUrl = CONSOLE_LOGO;
    accesoriesLogoUrl = ACCESORIES_LOGO;
    phoneLogoUrl = PHONE_LOGO;
    toyLogoUrl = TOY_LOGO;
    cartLogoUrl = CART_LOGO;




}