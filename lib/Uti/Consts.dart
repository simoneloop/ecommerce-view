
import 'package:flutter/material.dart';

class Consts{



  static const String ADDRESS_SERVER="localhost:8080";
  static const String KEY_IMGBB="ab5164733cebc27977aa124a2190e060";
  static const String ADDRESS_IMGBB="api.imgbb.com";
  static const String REQUEST_UPLOAD_IMAGE_BB="/1/upload";

  //EVERYONE-REQUEST
  static const String REQUEST_REFRESH_TOKEN="/users/refreshToken";
  static const String REQUEST_LOGIN="/login";
  static const String REQUEST_ADD_USER="/users/add";
  static const String REQUEST_GET_PRODUCT="/products/getProduct";

  //ADMIN-REQUEST
  static const String REQUEST_GET_ALL_USERS="users/getAll";
  static const String REQUEST_ADD_PRODUCT="/products/add";
  static const String REQUEST_MODIFY_PRODUCT="/products/modify";
  static const String REQUEST_GET_ALL_PRODUCTS="/products/getAll";
  static const String REQUEST_GET_ALL_PURCHASE="/purchase/getAllPurchase";
  static const String REQUEST_SET_PURCHASE_DONE="/purchase/setPurchaseDone";

  //USER-REQUEST
  static const String REQUEST_ADD_PRODUCT_TO_CART="/users/addToCart";
  static const String REQUEST_GET_USER_CART="/users/getUserCart";
  static const String REQUEST_BUY_PRODUCT="/products/buy";
  static const String REQUEST_BUY_MY_CART="/products/buyMyCart";
  static const String REQUEST_REMOVE_FROM_CART="/users/removeFromCart";
  static const String REQUEST_GET_MY_ORDERS="/purchase/getMyOrders";
  static const String REQUEST_GET_MY_DETAILS="/users/getMyDetails";
  static const String REQUEST_MODIFY_MY_DETAILS="/users/modifyMyDetails";
  static const String REQUEST_SET_QUANTITY_TO_CART="/users/setQuantityToCart";
  static const String REQUEST_MODIFY_HOTS="/products/modifyHots";
  static const String REQUEST_DELETE_PRODUCTS="/products/deleteProducts";



  //ADMIN/USER-REQUEST
  // ignore: constant_identifier_names
  static const String REQUEST_GET_HOT_PRODUCTS="/products/getHotProduct";
  // ignore: constant_identifier_names
  static const String REQUEST_GET_PRODUCT_PAGEABLE="products/getProductPageable";


  //STORAGE
  // ignore: constant_identifier_names
  static const String USER_LOGGED_DETAILS="userLoggedDetails";
  // ignore: constant_identifier_names
  static const String USER_LOGGED_IS_ADMIN="userLoggedIsAdmin";

  //EXCEPTIONS
  static const String RESPONSE_ERROR_USER_ALREADY_EXIST = "UserAlreadyExistException";
  static const String RESPONSE_ERROR_CART_IS_EMPTY = "CartIsEmptyException";
  // ignore: constant_identifier_names
  static const String RESPONSE_ERROR_INSUFFICIENT_AMOUNT_EXCEPTION = "InsufficientAmountException";
  // ignore: constant_identifier_names
  static const String RESPONSE_ERROR_PRODUCT_ALREADY_EXIST = "ProductAlreadyExistException";
  // ignore: constant_identifier_names
  static const String RESPONSE_ERROR_PRODUCT_DOES_NOT_EXIST = "ProductDoesNotExistException";
  // ignore: constant_identifier_names
  static const String RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE = "QuantityProductUnavailableException";
  // ignore: constant_identifier_names
  static const String RESPONSE_ERROR_USER_DOES_NOT_EXIST = "UserDoesNotExistException";


  // ignore: constant_identifier_names
  static const String REQUIRED_LOGIN_EXCEPTION="Devi prima effettuare il login";
  // ignore: constant_identifier_names
  static const String IS_ADMIN_EXCEPTION="Sei admin non hai a disposizione questa funzione";



  // ignore: constant_identifier_names
  static const String TITLE="3DMade";

  static const double extraSmallText=15;
  static const double smallText=20;
  static const double mediumText=25;
  static const double bigText=30;
  // ignore: constant_identifier_names
  static const bool TO_VALIDATE=false;
  // ignore: constant_identifier_names
  static const int PAGE_SIZE=7;
  // ignore: constant_identifier_names
  static const int shadow_intensity=2;

  static const Color kTextLightBlack=Colors.black26;
  // ignore: constant_identifier_names
  static const Color checkbox_radio_color=Colors.white;
  // ignore: constant_identifier_names
  static const Color checkbox_check_color=Colors.black;
  // ignore: constant_identifier_names
  static const Color checkbox_active_color=kBlueColor;
  static const Color kBlueColor=Color(0xFF0D47A1);
  // ignore: constant_identifier_names
  static const LinearGradient PrimoGradient=LinearGradient(
    colors: <Color>[
      Color(0xFF002A76),
      Color(0xFF002D5F),
      Color(0xFF230063),
    ],
  );
  // ignore: constant_identifier_names
  static const LinearGradient SecondoGradient=LinearGradient(
    colors: <Color>[
      Color(0xFF960000),
      Color(0xFF5E1C00),
      Color(0xFF7A16FF),
    ],
  );
  // ignore: constant_identifier_names
  static const LinearGradient TerzoGradient=LinearGradient(
    colors: <Color>[
      Color(0xFF646464),
      Color(0xFF969696),
      Color(0xFFC8C8C8),
    ],
  );
  static const double kToolbarHeight=50;
  // ignore: constant_identifier_names
  static const Color primary_color=Color(0xff001055);
  // ignore: constant_identifier_names
  static const Color secondary_color=Colors.yellowAccent;










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