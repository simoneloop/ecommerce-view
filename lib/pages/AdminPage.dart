import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_view/Uti/Consts.dart';
import 'package:ecommerce_view/Uti/Support.dart';
import 'package:ecommerce_view/widgets/AppBarWidget.dart';
import 'package:ecommerce_view/widgets/CoolText.dart';
import 'package:ecommerce_view/widgets/CoolTextButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../entities/Product.dart';
import '../managers/Proxy.dart';
import '../widgets/CoolCircularProgress.dart';
import '../widgets/SearchForm.dart';
class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  late Future<List<Product>> productList;
  Map<String,bool>mapSelectedHotProduct={};
  Map<String,bool>mapSelectedProduct={};

  TextEditingController _nameController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  TextEditingController _priceController=TextEditingController();
  TextEditingController _quantityController=TextEditingController();




  String? _priceError=null;
  String? _descriptionError=null;
  String? _nameError=null;
  String? _quantityError=null;

  File? image=null;
  Uint8List webImage=Uint8List(8);
  File? modifingImage=null;
  Uint8List modifingWebImage=Uint8List(8);

  String _radioValue = "";


  TextEditingController _nameModifingController=TextEditingController();

  TextEditingController _descriptionModifingController=TextEditingController();
  TextEditingController _priceModifingController=TextEditingController();
  TextEditingController _quantityModifingController=TextEditingController();
  String _nameHint="nome";
  String _descriptionHint="descrizione";
  String _priceHint="prezzo";
  String _quantityHint="quantità disponibile";
  String? _urlHint=null;
  List<String> selected=[];
  String _modifingRadioValue="";
  bool _canModify=false;
  bool _isModifing=false;
  bool _retrieveModifing=false;
  Product? _isModifingProduct=null;
  List<Product>? totalProductHot=null;
  List<Product>? searchedProductHot=null;
  List<Product>? searchedProductModify=null;


  @override
  void initState() {
    productList=Proxy.sharedProxy.getAllProducts();
    productList.then((value) {
      setState(() {
        totalProductHot=value;
        searchedProductHot=value;
        searchedProductModify=value;
        value.forEach((element) {
          mapSelectedHotProduct['${element.name}']=element.hot;
          mapSelectedProduct['${element.name}']=false;
        });
      });

    });


  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(index: 1,),
      backgroundColor: Theme.of(context).colorScheme.secondary,

      body:Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Modifica vetrina", size: "m"),
                        SizedBox(height: 15,),
                        SearchForm(press:(value){filterHot(value);}),

                        SingleChildScrollView(
                          child: Container(
                            constraints:BoxConstraints(/*minWidth:size.width/3,*/minHeight: size.height/4,/*maxWidth: size.width/3,*/maxHeight: size.height/1.5),
                            child:searchedProductHot!=null? ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: searchedProductHot!.length,
                                itemBuilder: (context,i){

                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 1.0,color:i<searchedProductHot!.length-1? Colors.blueGrey.withOpacity(0.5):Colors.transparent))
                                      ),
                                      child: CheckboxListTile(
                                          title: CoolText(text:searchedProductHot![i].name, size: 's',),
                                          value: mapSelectedHotProduct[searchedProductHot![i].name],
                                          onChanged: (bool? value){
                                            setState(() {
                                              mapSelectedHotProduct[searchedProductHot![i].name]=value!;
                                            });
                                          }),
                                    ),
                                  );

                                }):CoolCircularProgress(),
                          ),
                        ),
                        CoolTextButton(gradient: Consts.PrimoGradient,
                            text: "SALVA",
                            press: (){
                          Proxy.sharedProxy.modifyHots(mapSelectedHotProduct).then((value) {
                            if(value==HttpResult.done){
                              showCoolSnackbar(context, "Vetrina modificata con successo", "ok");
                            }
                            else{
                              showCoolSnackbar(context, "Errore sconoscito", "err");
                            }
                          });
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Aggiungi prodotto", size: "m"),
                        SizedBox(height: 15,),




                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Nome del prodotto",
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
                                Icons.drive_file_rename_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),



                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: "Descrizione del prodotto",
                              errorText: _descriptionError,
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
                                Icons.description_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),


                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _priceController,
                                keyboardType: TextInputType.phone,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Prezzo",
                                    errorText: _priceError,
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
                                      Icons.price_change_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: "Quantità",
                                    errorText: _quantityError,
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
                                      Icons.production_quantity_limits_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CoolText(text: "Categoria", size: "s"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Radio(
                                    value: "bracciale",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Bracciale", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "collana",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Collana", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "orecchino",
                                    groupValue: _radioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _radioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Orecchino", size: "xs")
                                ],
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){pickImage(false);},
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child:DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(16),

                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: image==null?Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined),
                                      CoolText(text: "Carica una foto del prodotto", size: "xs"),
                                    ],
                                  ):kIsWeb?Image.memory(webImage,fit: BoxFit.fill,):Image.file(image!,fit: BoxFit.fill,),
                                ),)
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CoolTextButton(gradient: Consts.PrimoGradient, text: "AGGIUNGI", press: (){addProduct(); })),
                            ))

                      ],
                    ),



                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Stack(
                children: [
                  Container(

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0,10),
                              blurRadius: 2
                          )
                        ]
                    ),
                    child:!_isModifing? Column(
                      children: [
                        SizedBox(height: 10,),
                        CoolText(text: "Magazzino", size: "m"),
                        SizedBox(height: 15,),
                        SearchForm(press:(value){filterModify(value);}),
                        SingleChildScrollView(
                          child: Container(
                            constraints:BoxConstraints(/*minWidth:size.width/3,*/minHeight: size.height/4,/*maxWidth: size.width/3,*/maxHeight: size.height/1.5),
                            child: searchedProductModify!=null?ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: searchedProductModify!.length,
                                itemBuilder: (context,i){
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: 1.0,color:i<searchedProductModify!.length-1? Colors.blueGrey.withOpacity(0.5):Colors.transparent))
                                      ),
                                      child: CheckboxListTile(
                                          title: CoolText(text:searchedProductModify![i].name, size: 's',),
                                          value: mapSelectedProduct[searchedProductModify![i].name],
                                          onChanged: (bool? value){
                                            setState(() {
                                              mapSelectedProduct[searchedProductModify![i].name]=value!;
                                              updateCanModify();
                                            });
                                          }),
                                    ),
                                  );
                                }):CoolCircularProgress(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: CoolTextButton(gradient:_canModify? Consts.PrimoGradient:Consts.TerzoGradient, text: "MODIFICA", press: (){
                                    if(_canModify){

                                      Product p;
                                      Proxy.sharedProxy.getProductByName(selected[0]).then((value) {
                                        print(value.toString());
                                        if(value is Product){
                                          p=value;
                                          _nameHint=p.name;
                                          _descriptionHint=p.description;
                                          _priceHint=p.price.toString();
                                          _quantityHint=p.quantity.toString();
                                          _modifingRadioValue=p.typo;
                                          _urlHint=p.urlPropic;
                                          setState(() {
                                            _isModifingProduct=p;

                                            _isModifing=true;
                                            print("modifico il prodotto"+selected[0]);

                                          });

                                        }
                                      });


                                    }
                                    else{
                                      showCoolSnackbar(context, "Seleziona uno e un solo prodotto", "err");
                                    }
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: CoolTextButton(gradient: Consts.SecondoGradient, text: "RIMUOVI", press: (){deleteProducts();}),
                                )
                              ],
                            ),
                          ),
                        )

                      ],
                    )://TODO da qui
                    Column(

                      children: [
                        SizedBox(height: 10,),
                        Row(

                          children: [
                            Flexible(
                              flex: 1,
                              child: IconButton(icon:Icon(Icons.arrow_back_ios_outlined),color: Colors.deepPurpleAccent, onPressed: () {
                                setState(() {
                                  _isModifing=false;
                                  _isModifingProduct=null;
                                  _nameModifingController=TextEditingController();
                                  modifingImage=null;
                                  _descriptionModifingController=TextEditingController();
                                  _priceModifingController=TextEditingController();
                                  _quantityModifingController=TextEditingController();
                                });
                              },),
                            ),
                            Flexible(
                                flex: 4,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: CoolText(text: "Modifica prodotto", size: "m",textAlign: TextAlign.center,))),
                          ],
                        ),
                        SizedBox(height: 15,),




                        TextFormField(
                          controller: _nameModifingController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: _nameHint,
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
                                Icons.drive_file_rename_outline,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),



                        TextFormField(
                          controller: _descriptionModifingController,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                              hintStyle: Consts.smallTextStyle,

                              hintText: _descriptionHint,
                              errorText: _descriptionError,
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
                                Icons.description_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                              )),

                        ),
                        SizedBox(height: 10),


                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: _priceModifingController,
                                keyboardType: TextInputType.phone,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: _priceHint,
                                    errorText: _priceError,
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
                                      Icons.price_change_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _quantityModifingController,
                                keyboardType: TextInputType.number,

                                decoration: InputDecoration(
                                    hintStyle: Consts.smallTextStyle,

                                    hintText: _quantityHint,
                                    errorText: _priceError,
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
                                      Icons.production_quantity_limits_outlined,
                                      color: Theme.of(context).colorScheme.secondary,
                                    )),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CoolText(text: "Categoria", size: "s"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Radio(
                                    value: "bracciale",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Bracciale", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "collana",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Collana", size: "xs")
                                ],
                              ),
                              Column(
                                children: [
                                  Radio(
                                    value: "orecchino",
                                    groupValue: _modifingRadioValue,
                                    onChanged: (value){
                                      setState(() {
                                        _modifingRadioValue=value.toString();
                                      });
                                    },
                                  ),
                                  CoolText(text: "Orecchino", size: "xs")
                                ],
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: (){pickImage(true);},
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child:DottedBorder(
                                borderType: BorderType.RRect,
                                radius: Radius.circular(16),

                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child:modifingImage==null? _urlHint==null?Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined),
                                      CoolText(text: "Carica una foto del prodotto", size: "xs"),
                                    ],
                                  ):Image.network(_urlHint!,fit: BoxFit.fill):
                                  kIsWeb?Image.memory(modifingWebImage,fit: BoxFit.fill,):Image.file(modifingImage!,fit: BoxFit.fill,),
                                ),)
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: CoolTextButton(gradient: Consts.PrimoGradient, text: "SALVA MODIFICHE", press: (){modifyProduct(); })),
                            ))

                      ],
                    ),

                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
Future pickImage(bool isModifing) async{
    if(isModifing){
      if(!kIsWeb){
        final ImagePicker _picker=ImagePicker();
        XFile? image=await _picker.pickImage(source: ImageSource.gallery);
        if(image!=null){
          final imageTmp=File(image.path);
          setState(() {
            this.modifingImage=imageTmp;
          });

        }
        else{return;}
      }
      else if(kIsWeb){
        final ImagePicker _picker=ImagePicker();
        XFile? image=await _picker.pickImage(source: ImageSource.gallery);
        if(image!=null){
          var f=await image.readAsBytes();
          setState(() {
            modifingWebImage=f;
            this.modifingImage=File('a');
          });
        }
        else{
          return;
        }
      }
    }
    else{
      if(!kIsWeb){
        final ImagePicker _picker=ImagePicker();
        XFile? image=await _picker.pickImage(source: ImageSource.gallery);
        if(image!=null){
          final imageTmp=File(image.path);
          setState(() {
            this.image=imageTmp;
          });

        }
        else{return;}
      }
      else if(kIsWeb){
        final ImagePicker _picker=ImagePicker();
        XFile? image=await _picker.pickImage(source: ImageSource.gallery);
        if(image!=null){
          var f=await image.readAsBytes();
          setState(() {
            webImage=f;
            this.image=File('a');
          });
        }
        else{
          return;
        }
      }
    }


  }

  void addProduct(){
    bool _canAdd=true;
    final avoidForInt = RegExp(r'^[a-zA-Z+_\-=@,\.;]+$');
    final avoidForText = RegExp(r'^[0-9+_\-=@,\.;]+$');
    final avoidForDouble = RegExp(r'^[a-zA-Z+_\-=@,\;]+$');
    if(_nameController.text.isEmpty||avoidForText.hasMatch(_nameController.text)){
      _canAdd=false;
      setState(() {
        _nameError="Inserire un breve nome del prodotto, sono ammesse solo lettere";
      });
    }
    else{
      setState(() {
        _nameError=null;
      });
    }
    if(_quantityController.text.isEmpty||avoidForInt.hasMatch(_quantityController.text)){
      _canAdd=false;
      setState(() {
        _quantityError="Specificare il NUMERO INTERO";
      });
    }
    else{
      setState(() {
        _quantityError=null;
      });
    }
    if(_descriptionController.text.isEmpty||avoidForText.hasMatch(_descriptionController.text)){
      _canAdd=false;
      setState(() {
        _descriptionError="Inserire una breve descrizione del prodotto, sono ammesse solo lettere";
      });
    }
    else{
      setState(() {
        _descriptionError=null;
      });
    }
    if(_priceController.text.isEmpty||avoidForDouble.hasMatch(_priceController.text)){
      _canAdd=false;
      setState(() {
        _priceError="Specificare il prezzo, es 3.14";
      });
    }
    else{
      setState(() {
        _priceError=null;
      });
    }
    if(_radioValue==""){
      _canAdd=false;
    }
    if(image==null){
      _canAdd=false;
    }
    if(!_canAdd){
      showCoolSnackbar(context, "Compila tutti i campi del prodotto per poter aggiungerlo", "err");
    }
    else{
      Proxy.sharedProxy.getProductByName(_nameController.text).then((value) {
        if(value!=getProductResult.notExist){
          _canAdd=false;
          showCoolSnackbar(context, "Esiste già un prodotto con questo nome!", "err");
        }
        else{

            try{

              Proxy.sharedProxy.addProPic(webImage, _nameController.text).then((value) {
                Product p=Product(name: _nameController.text, description: _descriptionController.text, quantity: int.parse(_quantityController.text), price: double.parse((_priceController.text)), typo: _radioValue, hot: false,urlPropic: value, enabled: true);
                Proxy.sharedProxy.addProduct(p).then((value) {
                  if(value==HttpResult.done){
                    showCoolSnackbar(context,"Prodotto aggiunto con successo","ok");
                    reloadAll();
                  }
                  else{
                    showCoolSnackbar(context,"Problema con i campi inseriti, ricontrolla","err");
                  }
                });
              });
            }catch(err){
              showCoolSnackbar(context,"Problema con i campi inseriti, ricontrolla","err");
            }


        }
      });

    }

  }
  void deleteProducts(){
    selected=[];
    mapSelectedProduct.forEach((key, value) {
      if(value==true){
        selected.add(key);
      }
    });
    String text=selected.length>1?"Cancellati":"Cancellato";
    if(selected.length==0){
      showCoolSnackbar(context,"Seleziona almeno un prodotto","err");
      return;
    }
    Proxy.sharedProxy.deleteProducts(selected).then((value) {
      if(value==HttpResult.done){
        showCoolSnackbar(context, text+" con successo", "ok");
        reloadAll();
      }
      else{
        showCoolSnackbar(context, "Errore sconosciuto", "err");
      }
    });
  }

  void updateCanModify(){
    selected=[];
    mapSelectedProduct.forEach((key, value) {
      if(value==true){
        selected.add(key);
      }
    });
    _canModify=selected.length==1?true:false;
  }

  void modifyProduct(){
    bool _can=true;
    final avoidForInt = RegExp(r'^[a-zA-Z+_\-=@,\.;]+$');
    final avoidForText = RegExp(r'^[0-9+_\-=@,\.;]+$');
    final avoidForDouble = RegExp(r'^[a-zA-Z+_\-=@,\;]+$');
    if(!_nameModifingController.text.isEmpty && avoidForText.hasMatch(_nameModifingController.text)){
      _can=false;
      setState(() {
        _nameError="Inserire un breve nome del prodotto, sono ammesse solo lettere";
      });
    }
    else if(_nameModifingController.text.isEmpty){
      _nameModifingController.text=_isModifingProduct!.name;
    }
    else{
      setState(() {
        _nameError=null;
      });
    }
    if(_quantityModifingController.text.isEmpty && avoidForInt.hasMatch(_quantityModifingController.text)){
      _can=false;
      setState(() {
        _quantityError="Specificare il NUMERO INTERO";
      });
    }
    else if(_quantityModifingController.text.isEmpty){
      _quantityModifingController.text=_isModifingProduct!.quantity.toString();
    }
    else{
      setState(() {
        _quantityError=null;
      });
    }
    if(_descriptionModifingController.text.isEmpty && avoidForText.hasMatch(_descriptionModifingController.text)){
      _can=false;
      setState(() {
        _descriptionError="Inserire una breve descrizione del prodotto, sono ammesse solo lettere";
      });
    }
    else if(_descriptionModifingController.text.isEmpty){
      _descriptionModifingController.text=_isModifingProduct!.description;
    }
    else{
      setState(() {
        _descriptionError=null;
      });
    }
    if(_priceModifingController.text.isEmpty && avoidForDouble.hasMatch(_priceModifingController.text)){
      _can=false;
      setState(() {
        _priceError="Specificare il prezzo, es 3.14";
      });
    }
    else if(_priceModifingController.text.isEmpty){
      _priceModifingController.text=_isModifingProduct!.price.toString();
    }
    else{
      setState(() {
        _priceError=null;
      });
    }
    if(_modifingRadioValue==""){
      _modifingRadioValue=_isModifingProduct!.typo;
    }
    String? urlPropic=null;
    if(modifingImage==null){
      urlPropic=_isModifingProduct!.urlPropic;
    }
    if(!_can){
      showCoolSnackbar(context, "Compila tutti i campi del prodotto per poter aggiungerlo", "err");
    }
    else{

        try{
          if(modifingImage!=null){
            Proxy.sharedProxy.addProPic(modifingWebImage, _nameController.text).then((value) {
              Product p=Product(name: _nameModifingController.text, description: _descriptionModifingController.text, quantity: int.parse(_quantityModifingController.text), price: double.parse((_priceModifingController.text)), typo: _modifingRadioValue, hot: false,urlPropic: value,enabled:true);
              Proxy.sharedProxy.modifyProduct(p,_isModifingProduct!.name).then((value) {
                if(value==HttpResult.done){
                  showCoolSnackbar(context,"Prodotto modificato con successo","ok");
                  reloadAll();
                }
                else{
                  showCoolSnackbar(context,"Problema con i campi inseriti, ricontrolla","err");
                }
              });
            });
          }
          else{
            Product p=Product(name: _nameModifingController.text, description: _descriptionModifingController.text, quantity: int.parse(_quantityModifingController.text), price: double.parse((_priceModifingController.text)), typo: _modifingRadioValue, hot: false,urlPropic: urlPropic,enabled:true);
            Proxy.sharedProxy.modifyProduct(p,_isModifingProduct!.name).then((value) {
              if(value==HttpResult.done){
                showCoolSnackbar(context,"Prodotto modificato con successo","ok");
                reloadAll();
              }
              else{
                showCoolSnackbar(context,"Problema con i campi inseriti, ricontrolla","err");
              }
            });
          }

        }catch(err){
          showCoolSnackbar(context,"Problema con i campi inseriti, ricontrolla","err");
        }

    }

  }

  void reloadAll(){
    mapSelectedHotProduct={};
    mapSelectedProduct={};
    productList;
    setState(() {
      searchedProductModify=null;
      searchedProductHot=null;
      totalProductHot=null;

      _nameController=TextEditingController();
      _descriptionController=TextEditingController();
      _priceController=TextEditingController();
      _quantityController=TextEditingController();
      _nameModifingController=TextEditingController();

      _descriptionModifingController=TextEditingController();
      _priceModifingController=TextEditingController();
      _quantityModifingController=TextEditingController();
      image=null;
      _radioValue="";
      _isModifing=false;
      _isModifingProduct=null;
      List<String> selected=[];updateCanModify();
      productList=Proxy.sharedProxy.getAllProducts();
      productList.then((value) {
        setState(() {
          totalProductHot=value;
          searchedProductModify=value;
          searchedProductHot=value;
          value.forEach((element) {
            mapSelectedHotProduct['${element.name}']=element.hot;
            mapSelectedProduct['${element.name}']=false;
          });
        });

      });
    });
  }
  filterHot(String value){
    searchedProductHot=[];
    if(value==""){
      setState(() {
        searchedProductHot=totalProductHot;
      });
    }
    else{
      totalProductHot!.forEach((element) {
        if(element.name==value){
          setState(() {
            searchedProductHot!.add(element);
          });

        }
      });
    }

  }
  filterModify(String value){
    searchedProductModify=[];
    if(value==""){
      setState(() {
        searchedProductModify=totalProductHot;
      });
    }
    else{
      totalProductHot!.forEach((element) {
        if(element.name==value){
          setState(() {
            searchedProductModify!.add(element);
          });

        }
      });
    }

  }

}
