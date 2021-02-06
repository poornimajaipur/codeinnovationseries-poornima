import 'package:bot_toast/bot_toast.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/chatroomscreen.dart';
import 'package:social_app/widgets/widegets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  SignMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpwithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        // print("${val.uid}");
        Map<String, String> userInfoMap = {
          "name": userNameTextEditingController.text,
          "email": emailTextEditingController.text
        };
        HelperFunctions.saveuserEmailSharedPreferences(
            emailTextEditingController.text);
        HelperFunctions.saveuserNameSharedPreferences(
            userNameTextEditingController.text);
        HelperFunctions.saveuserLoggedInSharedPreferences(true);
        databaseMethods.uploadUserInfo(userInfoMap);
        BotToast.showText(
          borderRadius: BorderRadius.circular(30),
          textStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          contentColor: Colors.red,
          contentPadding: EdgeInsets.all(10),
          duration: Duration(seconds: 7),
          text:
              "Registration of ${userNameTextEditingController.text} Successfully",
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
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
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
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
                            width: 270, height: 270),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Please provide userName"
                                    : null;
                              },
                              controller: userNameTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Username"),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Please provide a valid email id";
                              },
                              controller: emailTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Email"),
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please provide Password more than 6 characters";
                              },
                              controller: passwordTextEditingController,
                              style: simpleTextFieldStyle(),
                              decoration: textFieldInputDecoration("Password"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          SignMeUp();
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
                            "Sign Up",
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
                          Text("Already have an account? ",
                              style: mediumTextStyle()),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "SignIn now",
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
