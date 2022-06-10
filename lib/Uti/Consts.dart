
import 'package:flutter/material.dart';

class Consts{



  static const String ADDRESS_SERVER="localhost:8080";


  //EVERYONE-REQUEST
  static const String REQUEST_REFRESH_TOKEN="/users/refreshToken";
  static const String REQUEST_LOGIN="/login";
  static const String REQUEST_ADD_USER="/users/add";

  //ADMIN-REQUEST
  static const String REQUEST_GET_ALL_USERS="users/getAll";
  static const String REQUEST_ADD_PRODUCT="/products/add";
  static const String REQUEST_MODIFY_PRODUCT="/products/modify";
  static const String REQUEST_GET_ALL_PRODUCTS="/products/getAll";

  //USER-REQUEST
  static const String REQUEST_ADD_PRODUCT_TO_CART="/users/addToCart";
  static const String REQUEST_GET_USER_CART="/users/getUserCart";
  static const String REQUEST_BUY_PRODUCT="/products/buy";
  static const String REQUEST_BUY_MY_CART="/products/buyMyCart";
  static const String REQUEST_REMOVE_FROM_CART="/users/removeFromCart";
  static const String REQUEST_GET_MY_ORDERS="/purchase/getMyOrders";
  static const String REQUEST_GET_MY_DETAILS="/users/getMyDetails";
  static const String REQUEST_MODIFY_MY_DETAILS="/users/modifyMyDetails";

  //ADMIN/USER-REQUEST
  static const String REQUEST_GET_HOT_PRODUCTS="/products/getHotProduct";
  static const String REQUEST_GET_PRODUCT_PAGEABLE="products/getProductPageable";


  //STORAGE
  static const String USER_LOGGED_DETAILS="userLoggedDetails";


  //EXCEPTIONS
  static const String RESPONSE_ERROR_USER_ALREADY_EXIST = "UserAlreadyExistException";
  static const String RESPONSE_ERROR_CART_IS_EMPTY = "CartIsEmptyException";
  static const String RESPONSE_ERROR_INSUFFICIENT_AMOUNT_EXCEPTION = "InsufficientAmountException";
  static const String RESPONSE_ERROR_PRODUCT_ALREADY_EXIST = "ProductAlreadyExistException";
  static const String RESPONSE_ERROR_PRODUCT_DOES_NOT_EXIST = "ProductDoesNotExistException";
  static const String RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE = "QuantityProductUnavailableException";
  static const String RESPONSE_ERROR_USER_DOES_NOT_EXIST = "UserDoesNotExistException";

  //TYPOS
  static const String TYPO_BRACCIALE="bracciale";
  static const String TYPO_COLLANA="collana";
  static const String TYPO_ORECCHINO="orecchino";

  static const bool TO_VALIDATE=false;


  static const MaterialColor kTextColor=Colors.indigo;
  static const double kToolbarHeight=50;
  static const Color BRACCIALE_COLOR=Color(0xffd4b483);
  static const Color ORECCHINO_COLOR=Color(0xffccfbfe);
  static const Color COLLANA_COLOR=Color(0xffa26769);

  //EXAMPLES
  /*Proxy.sharedProxy.logIn("user","user")*/
  /*Proxy.sharedProxy.addUser(User(lastName: "ehi",firstName: "from",email: "flutter",phoneNumber: "web",address: "app",password: "alle4",urlPropic: "dio",roles: []))*/
  /*Proxy.sharedProxy.getHotProduct()*/
  /*Proxy.sharedProxy.getProductPageable(page: 0,pageSize: 3,order: "ascending",typo: Consts.TYPO_BRACCIALE)*/
  /*Proxy.sharedProxy.getMyOrders()*/
  /*Proxy.sharedProxy.removeFromMyCart("collanagraziosa")*/
  /*Proxy.sharedProxy.buyMyCart()*/
  /*Proxy.sharedProxy.getUserCart()*/
  /*Proxy.sharedProxy.addToCart("bracciale gioioso", 3)*/
  /*Proxy.sharedProxy.getAllProducts()*/
/*
  Proxy.sharedProxy.addProduct(new Product(name: "daflutter", description: "bracciale inserito da flutter", quantity: 32, price: 25.5, typo: Consts.TYPO_BRACCIALE, hot: false))
*/
  /*Proxy.sharedProxy.modifyProduct(new Product(name: "dafluttter", description: "orecchino inserito da flutter", quantity: 32, price: 25.5, typo: Consts.TYPO_ORECCHINO, hot: true),"daflutter")
*/
}