import 'dart:ui';

import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/entities/Purchase.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/material.dart';

import '../Uti/Consts.dart';
import '../entities/User.dart';
import '../managers/Proxy.dart';
import '../widgets/PurchaseCard.dart';
class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _passwordConfirmationController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _nameController=TextEditingController();
  TextEditingController _lastNameController=TextEditingController();
  UserDetailsForm uForm=UserDetailsForm();

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


  bool isModifing=false;
  dynamic u=Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS);
  User user=new User(firstName: "simo", lastName: "prova",phoneNumber: "3482942524",email: "simo@",address: "via g bruno",);
  late Future<List<Purchase>> orders;
  @override
  void initState() {

    if(u==null){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "LoginPage");
      });
    }
    orders=Proxy.sharedProxy.getMyOrders();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBarWidget(index: 1,),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(

              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30,horizontal:20),
                  margin: EdgeInsets.only(top:10,bottom:10,left: 20,right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: Offset(0,10)
                      )
                    ]
                  ),
                  child: !isModifing?Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                u!=null?Text("Nome: "+u.firstName,style: Theme.of(context).textTheme.headline4,):Container(),
                                u!=null?Text("Cognome: "+u.lastName,style: Theme.of(context).textTheme.headline4,):Container(),
                                u!=null?Text("Email: "+u.email,style: Theme.of(context).textTheme.headline4,):Container(),
                                u!=null?Text("Numero: "+u.phoneNumber,style: Theme.of(context).textTheme.headline4,):Container(),
                                u!=null?Text("Indirizzo: "+u.address,style: Theme.of(context).textTheme.headline4,):Container(),
                                SizedBox(
                                  height: 30,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(

                          children: [
                            CoolTextButton(gradient: Consts.kOrangeGradient, text: "Modifica i dettagli", press: (){setState(() {
                              isModifing=true;
                            }); }),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: CoolTextButton(gradient: Consts.kBlueGradient, text: "LOGOUT", press: (){logOut(); }),
                            ),
                          ],
                        ),
                      )
                    ],
                  ):
                  Form(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Modifica i dettagli",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(height: 25,),




                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: u.firstName,
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
                              hintStyle: Consts.smallTextStyle,

                              hintText: u.lastName,
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
                              hintStyle: Consts.smallTextStyle,

                              hintText: u.phoneNumber,
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
                              hintStyle: Consts.smallTextStyle,

                              hintText: u.address,
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
                              hintStyle: Consts.smallTextStyle,

                              hintText: u.email,
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


                        SizedBox(
                          height: 30,
                        ),
                        CoolTextButton(gradient: Consts.kOrangeGradient, text: "Salva", press: (){ValidateAndSave(); })

                      ],
                    ),
                  ),
                )
              ],
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.only(bottom:10,left: 20,right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                      ]),
                  child:Column(
                    children: [
                      Text("Ordini effettuati",style: Theme.of(context).textTheme.headline3,),
                      Container(
                        constraints:BoxConstraints(minWidth:size.width,minHeight: size.height/4,maxWidth: size.width,maxHeight: size.height),
                        child: FutureBuilder(
                            future: orders,
                            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot){
                              if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                                return ScrollConfiguration(behavior: ScrollConfiguration.of(context).copyWith(
                                    dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context,i){
                                        return PurchaseCard(purchase:snapshot.data![i]);
                                        return Text(snapshot.data![i].purchaseTime.toString());
                                      }),);
                              }
                              else{
                                return CircularProgressIndicator();
                              }
                            }),
                      )
                    ],
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
    _canRegister=true;
    if (_emailController.text.isNotEmpty) {
      if(!_emailController.text.contains("@")){
        _emailError="Deve essere una email valida";
        _canRegister=false;
      }
      else{
        uForm.email=_emailController.text;
        _emailError=null;
      }
    }
    else{
      uForm.email=u.email;


    }
    /*if(!(_passwordController.text.length>3)){
      _passwordError="La password dovrebbe contenere più di 3 caratteri";
      _canRegister=false;
    }else{_passwordError=null;}
    */
    if(_addressController.text.isEmpty){
      uForm.address=u.address;
    }
    else{
      uForm.address=_addressController.text;
    }


    if(_nameController.text.isEmpty){
      uForm.name=u.firstName;
    }
    else{
      uForm.name=_nameController.text;
    }

    if(_lastNameController.text.isEmpty){
      uForm.lastName=u.lastName;
    }
    else{
      uForm.lastName=_lastNameController.text;
    }
    /*
    if(_passwordConfirmationController.text!=_passwordController.text){
      _passwordConfirmationError="Le due password devono essere uguali";
    }
    else{
      _passwordConfirmationError=null;
    }
    */
    //TODO filter
    if(_phoneController.text.length<9 ||_phoneController.text.length>11){
      uForm.phone=u.phoneNumber;
    }
    else{
      uForm.phone=_phoneController.text;
    }
  }
  void ValidateAndSave(){
    _canRegister=true;
    //TODO add Consts.toValidate
    if(true){
      setState(() {
        Validate();
      });
    }
    if(_canRegister){
      Proxy.sharedProxy.modifyMyDetails(new User(email: uForm.email,firstName: uForm.name,lastName: uForm.lastName,phoneNumber: uForm.phone,address: uForm.address)).then((value) {
        if(value==ModifyResult.modified){
          setState(() {
            u=Proxy.appState.getValue(Consts.USER_LOGGED_DETAILS);
            isModifing=false;
          });
          showCoolSnackbar(context, "Modificato con successo", "ok");
        }
        else{
          setState(() {
            isModifing=false;
          });
          showCoolSnackbar(context, "Errore nella modifica", "err");

        }
      });
    }
    //todo to finish
  }
  void logOut(){
    Proxy.appState.resetState();
    Navigator.pushNamed(context, "LoginPage");
  }



}
class UserDetailsForm{
  dynamic name;
  dynamic lastName;

  dynamic phone;
  dynamic email;
  dynamic address;

}