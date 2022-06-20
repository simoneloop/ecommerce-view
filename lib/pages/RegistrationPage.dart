import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:flutter/material.dart';
import '../entities/User.dart';
import '../managers/Proxy.dart';
import '../widgets/ProgressHUD.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _passwordConfirmationController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _lastNameController=TextEditingController();


  String? _passwordError=null;
  String? _passwordConfirmationError=null;
  String? _emailError=null;
  String? _addressError=null;
  String? _phoneError=null;
  String? _nameError=null;
  String? _lastNameError=null;

  bool hidePassword = true;
  bool isApiCallProcess=false;
  bool _canRegister=true;
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(child: _uiSetup(context), inAsyncCall: isApiCallProcess,opacity: 0.3,circularColor: Theme.of(context).colorScheme.secondary,);
  }



  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85,horizontal: 20),
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text("Registrati",style: Theme.of(context).textTheme.headline2,),
                        SizedBox(height: 25,),




                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintText: "Nome",
                              errorText: _nameError,
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
                                Icons.person,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 20),



                        TextFormField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintText: "Cognome",
                              errorText: _lastNameError,
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
                                Icons.supervised_user_circle,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 20),


                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,

                          decoration: InputDecoration(
                              hintText: "Numero di cellulare",
                              errorText: _phoneError,
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
                                Icons.phone,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 20),



                        TextFormField(
                          controller: _addressController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintText: "Indirizzo",
                              errorText: _addressError,
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
                                Icons.map,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 20),









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
                              labelText: "Password",
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
                        TextFormField(
                          controller: _passwordConfirmationController,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                          input == null ? "Confirm password!" : null,
                          obscureText: hidePassword,
                          decoration: InputDecoration(
                              hintText: "Conferma password",
                              labelText: "Conferma password",
                              errorText: _passwordConfirmationError,
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
                            onPressed: (){
                              ValidateAndRegister();


                            },
                            child: Text(
                              "Crea un account",
                              style: TextStyle(color: Colors.white),
                            ),
                            style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hai già un account?"),
                              TextButton(onPressed: (){Navigator.pushNamed(context, "LoginPage");}, child: Text("Accedi"))
                            ],
                          ),
                        )


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
  void Validate(){
    if(!_emailController.text.contains("@")){
      _emailError="Deve essere una email valida";
      _canRegister=false;
    }
    else{
      _emailError=null;
    }
    if(!(_passwordController.text.length>3)){
      _passwordError="La password dovrebbe contenere più di 3 caratteri";
      _canRegister=false;
    }else{_passwordError=null;}

    if(_addressController.text.isEmpty){
      _addressError="Inserisci un indirizzo a cui spedire";
      _canRegister=false;
    }
    else{
      _addressError=null;
    }


    if(_nameController.text.isEmpty){
      _nameError="Inserisci un nome a cui spedire";
      _canRegister=false;
    }
    else{
      _nameError=null;
    }

    if(_lastNameController.text.isEmpty){
      _lastNameError="Inserisci un cognome a cui spedire";
      _canRegister=false;
    }
    else{
      _lastNameError=null;
    }
    print(_passwordConfirmationController.text!=_passwordController.text);
    if(_passwordConfirmationController.text!=_passwordController.text){
      _passwordConfirmationError="Le due password devono essere uguali";
      _canRegister=false;
    }
    else{
      _passwordConfirmationError=null;
    }
    //TODO filter
    if(_phoneController.text.length<9 ||_phoneController.text.length>11){
      _phoneError="Inserisci un numero di cellulare valido";
      _canRegister=false;
    }
    else{
      _phoneError=null;
    }
  }
  void ValidateAndRegister(){
    _canRegister=true;
    if(Consts.TO_VALIDATE){
      setState(() {
        Validate();

      });

    }
    if(_canRegister){
      setState(() {
        isApiCallProcess=true;
      });
      Proxy.sharedProxy.addUser(new User(firstName: _nameController.text,lastName: _lastNameController.text,phoneNumber: _phoneController.text,email: _emailController.text,address: _addressController.text,password: _passwordController.text,roles: [])).then((value) {
        if(value==RegistrationResult.registered){
          Proxy.sharedProxy.logIn(_emailController.text, _passwordController.text).then((value) {
            if(value==LogInResult.logged) {
              final snackBar = SnackBar(
                  content: Text("Registrato con successo"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pushNamed(
                  context, 'HomePage');
            }
          });
        }
        else if(value==RegistrationResult.emailAlreadyExist){
          final snackBar=SnackBar(content: Text("Email già esistente"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if(value==RegistrationResult.unknown){
          final snackBar=SnackBar(content: Text("errore nella registrazione"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isApiCallProcess=false;
        });
      });
    }

  }
}
