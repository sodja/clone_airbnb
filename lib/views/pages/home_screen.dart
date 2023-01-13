import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';

import '../../commons/Constants.dart';
import '../components/components.dart';

class HomeScreen extends GetView {
  HomeScreen({super.key});

  var searchText = ''.obs;
  var currentTab = 0.obs;

  final controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  Obx(() => Expanded(
                          child: Container(
                        margin:
                            const EdgeInsets.only(right: 0, left: 8, top: 0),
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
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 05.0),
                height: 60.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox.fromSize(
                          size: Size(70, 70),
                          child: ClipRect(
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Constants.greenAirbnb,
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.black,
                                    ), // <-- Icon
                                    Text("Chambre"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SizedBox.fromSize(
                          size: Size(70, 70),
                          child: ClipRect(
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Constants.greenAirbnb,
                                onTap: () {},
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: Colors.black,
                                    ), // <-- Icon
                                    Text("Chambre"), // <-- Text
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0.00,
          toolbarHeight: 150,
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.green, spreadRadius: 1.5),
                          ],
                        ),
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller,
                          children: <Widget>[
                            buildScrollActivities("les meilleures vacances",
                                "assets/images/3.jpg"),
                            buildScrollActivities(
                                "Logement familial", "assets/images/4.jpg"),
                            buildScrollActivities(
                                "Endroits calmes", "assets/images/1.jpg"),
                            buildScrollActivities("Les meilleures appartements",
                                "assets/images/2.jpg"),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "DARI DAREK",
                                      style:
                                          TextStyle(color: Color(0xfff35e0b)),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 10, left: 10),
                                child: Text(
                                  "Rencontrez des gens partout en Algérie et découverez les plus beaux endroits du pays. Avec DARI DAREK, trouvez les",
                                  style: TextStyle(
                                      fontSize: 13, color: Color(0xffd3d3d3)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 3,
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 10,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildScrollActivities(String text, String imgUri) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              height: 250,
              width: 350,
              child: Image.asset(
                imgUri,
                fit: BoxFit.fill,
              )),
          Container(
              width: double.infinity,
              color: Colors.black,
              child: Text(
                text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
