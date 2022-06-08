import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../managers/Proxy.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input!.contains("@")
                              ? "Should be a valid email"
                              : null,
                          decoration: new InputDecoration(
                              hintText: "Email",
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
                        new TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input == null ? "Please enter a password" : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                              hintText: "Password",
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
                            onPressed: (){Proxy.sharedProxy.logIn("admin","admin").then((value) => print(value));},
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
}
