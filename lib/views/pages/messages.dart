import 'package:airbnb_clone/views/pages/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/message_controller.dart';
class MessagesPage extends GetView {
  @override
  final MessageController controller =  Get.put(MessageController());
    List<String> items =["a", "b"];

    @override
    Widget build(BuildContext context) {
      controller.getAllMessage();
      return Scaffold(

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Boîte de réception", textAlign: TextAlign.start, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),)
                ],
              ),
              SizedBox(height: 20.0),
              DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    Container(
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: 'Messages'),
                          Tab(text: 'Notifications'),
                        ],
                      ),
                    ),
                    Container(
                        height:  MediaQuery.of(context).size.height/1.5, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                        ),
                        child: TabBarView(children: <Widget>[
                          Obx(() =>
                          Container(
                            child: Center(
                                child: ListView.builder(
                                    itemCount: controller.messages.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context,i){
                                      return Container(
                                        padding: EdgeInsets.all(8),
                                        child: Dismissible(
                                          key: Key(controller.messages[i].idDestinataire),
                                          child: Material(
                                            elevation: 0.25,
                                            child: InkWell(
                                              onTap: (){
                                                controller.nomExpeditaire.value = controller.messages[i].nomExpeditaire;
                                                Get.to(()=>Chat(idDest: controller.messages[i].idDestinataire, idExp: controller.messages[i].idExpeditaire));
                                              },
                                              child:  Container(
                                                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                child: Row(
                                                  children:[
                                                    Container(
                                                      margin: EdgeInsets.only(right: 10),
                                                      height: 65,
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.blueGrey
                                                      ),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 50,
                                                      ),
                                                    ),
                                                    Flexible(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("${controller.messages[i].nomExpeditaire} . ${controller.messages[i].villeExpeditaire}",style: TextStyle(fontSize:10, fontWeight: FontWeight.w100),maxLines:1,overflow: TextOverflow.ellipsis, textAlign: TextAlign.start,),
                                                            Text("${controller.messages[i].message}",style: TextStyle(fontSize:12, fontWeight: FontWeight.w400, color: Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                                            Text("${controller.messages[i].dateEnvoi}",style: TextStyle(fontSize:10, fontWeight: FontWeight.w100),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                                          ],)),

                                                  ],
                                                ),
                                              ),
                                            )
                                          ),
                                          onDismissed: (direction){
                                            items.removeAt(i);
                                          },
                                        ),
                                      );
                                    }),

                            ),
                          ),
                          ),
                          Container(
                            child: Center(
                                child: ListView.builder(
                                    itemCount: items.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context,i){
                                      return Container(
                                        padding: EdgeInsets.all(8),
                                        child: Dismissible(
                                          key: Key(items[i]),
                                          child: Material(
                                            elevation: 0.25,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(right: 10),
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.grey
                                                    ),
                                              child: Icon(
                                              Icons.notification_important_rounded,
                                              size: 50,
                                            ),
                                                  ),
                                                  Flexible(
                                                      child: Text("Un Admin a accepté votre demande",style: TextStyle(fontSize:12),maxLines: 2,overflow: TextOverflow.ellipsis,)),

                                                ],
                                              ),
                                            ),
                                          ),
                                          onDismissed: (direction){
                                            items.removeAt(i);
                                          },
                                        ),
                                      );
                                    }),

                            ),
                          ),
                        ])
                    )
                  ])
              ),
            ],
          ),
        ),
      );
    }
  }
