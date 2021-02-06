import 'package:bot_toast/bot_toast.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/conversationscreen.dart';
import 'package:social_app/widgets/widegets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  initiateSearch() {
    databaseMethods
        .getUserbyUserName(searchTextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  TextEditingController searchTextEditingController =
      new TextEditingController();
  Widget searchList() {
    if (searchSnapshot != null) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: searchSnapshot.docs.length,
          itemBuilder: (context, index) {
            return SearchFile(
              userName: searchSnapshot.docs[index].data()['name'],
              userEmail: searchSnapshot.docs[index].data()['email'],
            );
          });
    } else {
      return Container();
    }
  }

  createChatroomAndStartConversation({String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId, userName)));
    } else {
      BotToast.showText(
        borderRadius: BorderRadius.circular(30),
        textStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        contentColor: Colors.red,
        duration: Duration(seconds: 7),
        text: "${Constants.myName} cannot sent message to yourself...",
      );
    }
  }

  Widget SearchFile({String userName, String userEmail}) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Row(
            children: [
              Container(
                  width: 55,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text("${userName.substring(0, 1).toUpperCase()}",
                      style: TextStyle(color: Colors.white, fontSize: 25))),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: mediumTextStyle(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    userEmail,
                    style: mediumTextStyle(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      createChatroomAndStartConversation(
                        userName: userName,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(40)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                      child: Text(
                        "Message",
                        style: mediumTextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
            child: Container(
          color: Colors.blueGrey.shade800,
          height: 2,
        )),
      ],
    );
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [Container(width: 60, child: Icon(Icons.contacts))],
          title: Text("Search Contacts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/linuxworld.jpeg"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Container(
              color: Colors.white70,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEditingController,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      hintText: "Search username",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 20),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
                    },
                    child: Container(
                      child: Image.asset("assets/images/search_white.png"),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade800,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(8),
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
