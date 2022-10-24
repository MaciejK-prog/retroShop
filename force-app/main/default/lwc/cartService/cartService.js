const addProduct = (productId) => {
    const listOfProducts = JSON.parse(sessionStorage.getItem('productsIds')) || [];
    listOfProducts.push(productId);

    sessionStorage.setItem("productsIds", JSON.stringify(listOfProducts));
};

const removeProduct = (productId) => {
    const listOfProducts = JSON.parse(sessionStorage.getItem('productsIds')) || [];

const modifiedListOfProducts = listOfProducts.filter(id => id!== productId);


sessionStorage.setItem("productsIds", JSON.stringify(modifiedListOfProducts));
};

const hasProduct = (productId) => {
    const listOfProducts = JSON.parse(sessionStorage.getItem('productsIds')) || [];
    return !isEmpty(listOfProducts.find(id => id === productId));
};

const getProducts = () => {
    const listOfProducts = JSON.parse(sessionStorage.getItem('productsIds')) || [];
    if (!Array.isArray(listOfProducts)) {
        listOfProducts = listOfProducts.split(',');
    }
    return listOfProducts;
};

const clear = () => {
    sessionStorage.setItem("productsIds", JSON.stringify([]));
}

const isEmpty = (value) => {
    return value === undefined || value === null || value === '';
};

export {
    addProduct,
    removeProduct,
    hasProduct,
    getProducts,
    clear
};