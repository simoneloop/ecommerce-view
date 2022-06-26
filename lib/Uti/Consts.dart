
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
  static const String REQUEST_GET_HOT_PRODUCTS="/products/getHotProduct";
  static const String REQUEST_GET_PRODUCT_PAGEABLE="products/getProductPageable";


  //STORAGE
  static const String USER_LOGGED_DETAILS="userLoggedDetails";
  static const String USER_LOGGED_IS_ADMIN="userLoggedIsAdmin";

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

  static const String REQUIRED_LOGIN_EXCEPTION="Devi prima effettuare il login";
  static const String IS_ADMIN_EXCEPTION="Sei admin non hai a disposizione questa funzione";



  static const TextStyle extraSmallTextStyle=TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle smallTextStyle=TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle mediumTextStyle=TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const TextStyle bigTextStyle=TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );
  static const bool TO_VALIDATE=false;


  static const Color kTextLightBlack=Colors.black26;
  static const Color kBlueColor=Color(0xFF0D47A1);
  static const LinearGradient kBlueGradient=LinearGradient(
    colors: <Color>[
      Color(0xFF0D47A1),
      Color(0xFF1976D2),
      Color(0xFF42A5F5),
    ],
  );
  static const LinearGradient kOrangeGradient=LinearGradient(
    colors: <Color>[
      Color(0xFFA1480D),
      Color(0xFFD27919),
      Color(0xFFF59642),
    ],
  );
  static const LinearGradient kGreyGradient=LinearGradient(
    colors: <Color>[
      Color(0xFF646464),
      Color(0xFF969696),
      Color(0xFFC8C8C8),
    ],
  );
  static const double kToolbarHeight=50;
  static const Color BRACCIALE_COLOR=Color(0xffd4b483);
  static const Color ORECCHINO_COLOR=Color(0xffccfbfe);
  static const Color COLLANA_COLOR=Color(0xffa26769);
  static const Color proviamoColor=Color(0xffff965e);

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