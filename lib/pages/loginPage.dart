import 'dart:html';
import 'dart:ui';

import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/ProgressHUD.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Uti/Consts.dart';
import '../managers/Proxy.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  String? _passwordError=null;
  String? _emailError=null;
  bool _canLogin=true;
  bool isApiCallProcess=false;

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess,opacity: 0.3,circularColor: Theme.of(context).colorScheme.secondary,);
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarWidget(index: 1,),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child: Form(
                    key: globalFormKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input!.contains("@")
                              ? "Should be a valid email"
                              : null,
                          decoration: InputDecoration(
                              hintText: "Email",
                              errorText: _emailError,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input == null ? "Please enter a password" : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "password",
                              errorText: _passwordError,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.4),
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                            onPressed: (){ValidateAndLogin();
                              setState(() {
                                isApiCallProcess=true;
                              });

                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary)),
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Color parseColor(String color) {
    String hex = color.replaceAll("#", "");
    if (hex.isEmpty) hex = "ffffff";
    if (hex.length == 3) {
      hex =
      '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
    }
    Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
    return col;
  }
  void ValidateAndLogin(){
    print(parseColor("#A26769"));
    _canLogin=true;
    if(Consts.TO_VALIDATE){
      setState(() {
        if(!_emailController.text.contains("@")){
          _emailError="Should be a valid email";
          _canLogin=false;
        }
        else{
          _emailError=null;
        }
        if(!(_passwordController.text.length>3)){
          _passwordError="password should be more than 3 char";
          _canLogin=false;
        }else{_passwordError=null;}
      });
    }

    if(_canLogin){
      Proxy.sharedProxy.logIn(_emailController.text,_passwordController.text)
          .then((value){
            if(value==LogInResult.logged){
              print(Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS));
              final snackBar=SnackBar(content: Text("Login Successfull"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushNamed(
                  context, 'HomePage');
            }
            else{
              final snackBar=SnackBar(content: Text("Error in Login"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              print(LogInResult.error);


            }
            setState(() {
              isApiCallProcess=false;
            });

          });
    }

  }
}
