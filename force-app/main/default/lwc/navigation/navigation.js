import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class Navigation extends NavigationMixin(LightningElement)  {

    accesoriesNavigate() {

        const config = {
            type: 'standard__webPage',
            attributes: {
                url: 'resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/accesories'
            }
        };
        this[NavigationMixin.Navigate](config);
      }

      consolesNavigate() {
        const config = {
            type: 'standard__webPage',
            attributes: {
                url: 'resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/consoles'
            }
        };
        this[NavigationMixin.Navigate](config);
      }

      toysNavigate() {

        const config = {
            type: 'standard__webPage',
            attributes: {
                url: 'resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/toys'
            }
        };
        this[NavigationMixin.Navigate](config);
      }

      phonesNavigate() {

        const config = {
            type: 'standard__webPage',
            attributes: {
                url: 'resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/phones'
            }
        };
        this[NavigationMixin.Navigate](config);
      }

      cartNavigate() {
 
        const config = {
            type: 'standard__webPage',
            attributes: {
                url: 'resilient-panda-sdj8lq-dev-ed.my.site.com/retro/s/cart'
            }
        };
        this[NavigationMixin.Navigate](config);
      }
}