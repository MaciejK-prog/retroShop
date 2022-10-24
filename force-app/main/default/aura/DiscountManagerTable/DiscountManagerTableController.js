({
    init: function (component, event, helper) {

        component.set('v.columns', [
            {label: $A.get("$Label.c.Product"), fieldName: 'name', type: 'text'},
            {label: $A.get("$Label.c.Product_Code"), fieldName: 'productCode', type: 'text'},
            {label: $A.get("$Label.c.Description"), fieldName: 'description', type: 'text'},
            {label: $A.get("$Label.c.Status"), fieldName: 'status', type:'text', cellAttributes: { iconName: { fieldName: 'statusIcon' }, iconPosition: 'left' }},
            {label: $A.get("$Label.c.Discounted_Price"), fieldName: 'discountedPrice', type: 'currency', typeAttributes: { currencyCode: 'PLN'}},
            {label: $A.get("$Label.c.Standard_Price"), fieldName: 'price', type: 'currency', typeAttributes: { currencyCode: 'PLN'}},
            
        ]);

        helper.fetchData(component);
    },

    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        component.set('v.selectedRowsList', selectedRows);
        let products = component.get('v.products');
        for(let product of products) {
            let matchedRow = selectedRows.find(row => row.id === product.id);
            if(!matchedRow) {
                product.status = '';
                product.statusIcon='';
                product.discountedPrice='';
            }
        }

        component.set('v.products', products);
    },

    updateProductTable: function(component, event) {
       
        let stringToSearch=component.get('v.phraseToFind');
        let products = component.get('v.products');
        let productsToDisplay=[];
        
        

        for(let product of component.get('v.originalList')) {

            let nameOfProduct = product.name.toUpperCase();
            if(nameOfProduct.includes(stringToSearch.toUpperCase())) {
          
            productsToDisplay.push(product);
            
            }
        }

        component.set('v.products', productsToDisplay);

    },

    handleResponse : function(component, event) {
        let params = event.getParam('arguments');
        if(params) {
            let results = params.response;
            let products = component.get('v.products');
            for(let product of products) {
                let matchedResult = results.find(result => result.productId === product.id);
                if(matchedResult) {
                    
                    if(!matchedResult.isSucces) {
                    product.status = matchedResult.errorMessage;
                    product.statusIcon = 'utility:error';
                    } else {
                        product.status = 'Succes!';
                        product.statusIcon = 'utility:check';
                    }
                } 
                
            }

            component.set('v.products', products);
        }
    },

    
    applyDiscount : function(component, event) {
        let params = event.getParam('arguments');
        if(params) {
            let results = params.response;
            let products = component.get('v.products');
            for(let product of products) {
                let matchedResult = results.find(result => result.id === product.id);

                if(matchedResult) {
                    product.discountedPrice = matchedResult.price
                } 
                
            }

            component.set('v.products', products);
        }
    }
});
