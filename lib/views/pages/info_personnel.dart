import 'package:airbnb_clone/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoPersonnel extends GetView<UserController> {
  @override
  UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    // userController.getUserInfo();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:13,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back,size: 19,color: Colors.black87,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  InkWell(
                      child: const Text("sauvegarder",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical:8.0,horizontal: 10),
                child: Text("Modifier les informations personnelles",style: TextStyle(color:Colors.black,fontSize: 30,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10,8,10,0),
                    child: Text("Prénom",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  Obx(() =>
                  Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black87),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel,size: 18,),
                      onPressed: (){},
                    )
                  ),
                  controller: TextEditingController(
                    text: "${userController.userModel.value.prenom} "
                  ),
                  ),
          )),
                ],
              ),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10,8,10,0),
                    child: Text("Nom",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  Obx(() =>
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black87),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel,size: 18,),
                            onPressed: (){},
                          )
                      ),
                      controller: TextEditingController(
                          text: "${userController.userModel.value.nom}"
                      ),
                    ),
                  )),
                ],
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){

                },
                child: GestureDetector(
                  onTap: (){
                     // _askedToLead();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding:  EdgeInsets.fromLTRB(10,8,10,0),
                        child: Text("Le sexe",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                      ),
                      Obx(() =>
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                        child: Text("${userController.userModel.value.sexe} ",style: const TextStyle(color:Colors.black,fontSize: 17,fontWeight: FontWeight.w300),),
                        )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  _selectDate(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.fromLTRB(10,8,10,0),
                      child: Text("Date de naissance",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                    ),
                    Obx(() =>
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                        child: Text("${userController.userModel.value.dateNaissance}"),
                      )),
                  ],
                ),
              ),
              SizedBox(height: 25,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.fromLTRB(10,8,10,0),
                    child: Text("Numero de téléphone",style: TextStyle(color:Colors.black,fontSize: 15,fontWeight: FontWeight.w400),),
                  ),
                  Obx(() =>
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black87),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel,size: 18,),
                            onPressed: (){},
                          )
                      ),
                      controller: TextEditingController(
                          text: "${userController.userModel.value.telephone}"
                      ),
                    ),
                  )),
                ],
              ),
            ],
      ),
    ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(DateTime.now().year+1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

 /* Future<void> _askedToLead() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Sexe'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "Homme"); },
                child: const Text('Homme'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "Femme"); },
                child: const Text('Femme'),
              ),
            ],
          );
        }
    )) {
      case "Homme":
      // Let's go.
      // ...
        break;
      case "Femme":
      // ...
        break;
    }
  }*/
}
