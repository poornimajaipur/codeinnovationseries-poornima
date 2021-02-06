import 'package:flutter/rendering.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/views/map.dart';
import 'package:social_app/services/database.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String recipent;
  ConversationScreen(this.chatRoomId, this.recipent);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessagesScreen;
  FocusNode textFieldFocus = new FocusNode();
  bool showEmojiPicker = false;
  bool isWriting = false;
  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessagesScreen,
        builder: (context, snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  padding: EdgeInsets.all(10),
                  reverse: false,
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                        snapshots.data.documents[index].data()["message"],
                        snapshots.data.documents[index].data()["sendby"] ==
                            Constants.myName);
                  })
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendby": Constants.myName ?? Constants.recName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversionMessages(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();

  hideEmojiContainer() {
    setState(() {
      showEmojiPicker = false;
    });
  }

  showEmojiContainer() {
    setState(() {
      showEmojiPicker = true;
    });
  }

  emojiContainer() {
    return EmojiPicker(
      bgColor: Colors.black,
      indicatorColor: Colors.black,
      rows: 2,
      columns: 7,
      onEmojiSelected: (emoji, category) {
        setState(() {
          isWriting = true;
        });
        messageController.text = messageController.text + emoji.emoji;
      },
      recommendKeywords: ["face", "happy", "party", "sad"],
      numRecommended: 50,
    );
  }

  @override
  void initState() {
    databaseMethods.getConversionMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesScreen = val;
      });
    });
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget setWritingTo(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipent,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyGoogleMap(widget.chatRoomId, widget.recipent)));
              },
              icon: Icon(Icons.pin_drop, color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/linuxworld.jpeg",
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Column(
            children: [
              Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ChatMessageList())),
              Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                      ),
                      height: MediaQuery.of(context).size.height * 0.10,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: textFieldFocus,
                              controller: messageController,
                              onTap: () => hideEmojiContainer(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              decoration: InputDecoration(
                                hintText: "Type a Message",
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 20),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                (value.length > 0 && value.trim() != "")
                                    ? setWritingTo(true)
                                    : setWritingTo(false);
                              },
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(250)),
                            child: IconButton(
                              onPressed: () {
                                if (!showEmojiPicker) {
                                  hideKeyboard();
                                  showEmojiContainer();
                                } else {
                                  showKeyboard();
                                  hideEmojiContainer();
                                }
                              },
                              icon: Icon(
                                Icons.tag_faces,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              sendMessage();
                            },
                            child: Container(
                              child: Image.asset("assets/images/send.png"),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              showEmojiPicker
                  ? SingleChildScrollView(
                      child: Container(
                        child: emojiContainer(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 10, right: isSendByMe ? 10 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: isSendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
          color: isSendByMe ? Colors.red : Colors.white70,
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSendByMe ? Colors.white : Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
