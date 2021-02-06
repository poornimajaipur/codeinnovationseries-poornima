import 'package:bot_toast/bot_toast.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/chatroomscreen.dart';
import 'package:social_app/widgets/widegets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formkey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signIn() async {
    if (formkey.currentState.validate()) {
      HelperFunctions.saveuserEmailSharedPreferences(
          emailTextEditingController.text);
      databaseMethods
          .getUserbyUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveuserNameSharedPreferences(
            snapshotUserInfo.docs[0].data()["name"]);
      });
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          BotToast.showText(
            borderRadius: BorderRadius.circular(30),
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            contentColor: Colors.red,
            contentPadding: EdgeInsets.all(10),
            duration: Duration(seconds: 7),
            text: "Login Successfully",
          );
          HelperFunctions.saveuserLoggedInSharedPreferences(false);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
          });
          BotToast.showText(
            borderRadius: BorderRadius.circular(30),
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            contentColor: Colors.red,
            contentPadding: EdgeInsets.all(10),
            duration: Duration(seconds: 7),
            text: "Login Failed due to account not found",
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Image.asset("assets/gif/login.gif",
                            width: 350, height: 350),
                      ),
                      Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Email"),
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Please provide a valid email id";
                              },
                            ),
                            TextFormField(
                              controller: passwordTextEditingController,
                              obscureText: true,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Password"),
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please provide Password more than 6 characters";
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.red,
                          ),
                          child: Text(
                            "Sign In",
                            style: mediumTextStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account? ",
                              style: mediumTextStyle()),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Register now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
