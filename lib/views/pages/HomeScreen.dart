import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../commons/constants.dart';
import '../components/components.dart';

class HomeScreen extends GetView {
   HomeScreen({super.key});
   var searchText = ''.obs;


  final controller = PageController(
    initialPage: 1,
  );

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            title:
            Column(
              children: [
                Row(
                  children: [
                    Obx(() => Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 0,
                              left: 8,
                              top: 0
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(50.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.transparent,
                                    blurRadius: 4,
                                    offset: Offset(0, 3))
                              ]),
                          child: TextFormField(
                            initialValue: searchText.value,
                            onChanged: (value) =>
                            {searchText.value = value.toString()},
                            autofocus: false,
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              hintText: "Rechercher",
                              hintStyle: const TextStyle(fontSize: 12),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 5, bottom: 5),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1.5, color: Colors.black),
                                borderRadius:
                                BorderRadius.circular(50.0), //<-- SEE HERE
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ))),
                  ],
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            elevation: 0.00,
            toolbarHeight: 120,
            backgroundColor: Colors.white),
        body:  SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset("assets/images/landing_page_img.png",fit: BoxFit.scaleDown,),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Center(child: Text("Explorez",style:TextStyle(fontSize: 25,fontWeight:FontWeight.bold,color: Colors.white))),
                          Center(child: Text("l'Algérie",style:TextStyle(fontSize: 20,color: Colors.white))),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,

                        child: MaterialButton(
                          onPressed: (){
                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Photo()),
                              );*/
                          },
                          elevation: 3,
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Text("Explorez",style: TextStyle(color: Colors.red),)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("DARI DAREK",style: TextStyle(color:Color(0xfff35e0b)),)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
                        child: Text("Rencontrez des gens partout en Algérie et découverez les plus beaux endroits du pays. Avec DARI DAREK, trouvez les",style: TextStyle(fontSize: 13,color:Color(0xffd3d3d3)),),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: controller,
                            children: <Widget>[
                              buildScrollActivities("les meilleures vacances", "assets/images/3.jpg"),
                              buildScrollActivities("Logement familial", "assets/images/4.jpg"),
                              buildScrollActivities("Endroits calmes", "assets/images/1.jpg"),
                              buildScrollActivities("Les meilleures appartements", "assets/images/2.jpg"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

}