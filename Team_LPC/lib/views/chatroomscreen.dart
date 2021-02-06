import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:social_app/helper/authenticate.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/conversationscreen.dart';
import 'package:social_app/views/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomStream;

  Widget ChatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  itemCount: snapshots.data.documents.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        snapshots.data.documents[index]
                            .data()['chatroomId']
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(Constants.myName, ""),
                        snapshots.data.documents[index].data()['chatroomId']);
                  })
              : Container();
        });
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getuserNameSharedPreferences();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/gif/engati-chat-icon-v2.gif"),
        title: Text("Chats",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              BotToast.showText(
                borderRadius: BorderRadius.circular(30),
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                contentColor: Colors.red,
                contentPadding: EdgeInsets.all(10),
                duration: Duration(seconds: 7),
                text: "${Constants.myName} logged out Successfully",
              );
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/linuxworld.jpeg"),
                  fit: BoxFit.fill)),
        ),
        ChatRoomList()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ConversationScreen(chatRoomId, userName)));
          },
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.only(bottom: 5),
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
                SizedBox(width: 8),
                Text(userName,
                    style: TextStyle(color: Colors.white, fontSize: 23)),
              ],
            ),
          ),
        ),
        SizedBox(
          child: Container(
            color: Colors.blueGrey.shade800,
            height: 2,
          ),
        ),
      ],
    );
  }
}
