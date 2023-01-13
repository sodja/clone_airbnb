import 'package:airbnb_clone/commons/Constants.dart';
import 'package:airbnb_clone/controllers/message_controller.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class Chat extends GetView<MessageController>{

  @override
  MessageController messageController = Get.put(MessageController());

  Chat({Key? key, String? idDest, String? idExp, String? nomExp}) : super(key: key) {
    if(idDest != null && idExp != null){
      messageController.idDest.value = idDest;
      messageController.idExp.value = idExp;
      print(messageController.idDest.value);
      messageController.getDetailsMessage(idDest, idExp);
    }
    if(nomExp!=null){
      messageController.nomExpeditaire.value = nomExp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  CircleAvatar(
                    backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/5.jpg"),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() =>
                        Text(messageController.nomExpeditaire.value,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),)),
                        SizedBox(height: 6,),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert_outlined,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
        body: Obx(()=> Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: messageController.detailMessages.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 10,bottom: 50),
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child:
                  Align(
                    alignment: (messageController.detailMessages[index].idExpeditaire != messageController.idDest.value?Alignment.topLeft:Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (messageController.detailMessages[index].idExpeditaire  != messageController.idDest.value?Colors.grey.shade200:Colors.blue[200]),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(messageController.detailMessages[index].message, style: TextStyle(fontSize: 15),),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Constants.greenAirbnb,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                          controller: messageController.messageController,
                        decoration: InputDecoration(
                            hintText: "ecrivez votre message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: (){
                        messageController.sendMessage();
                      },
                      child: Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Constants.greenAirbnb,
                      elevation: 0,
                    ),
                  ],

                ),
              ),
            ),
          ],
        )),
    );
  }

}