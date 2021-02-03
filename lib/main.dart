import 'package:Ataa/ForgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

var visible = false;

auth_subscribe() {
  FirebaseAuth.instance.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
}

login(String email, String password, BuildContext context) async {
  // try {
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password);
  //   print("user is signed in");
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomePage()),
  //   );
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'user-not-found') {
  //     print("Email not found");
  //     print('No user found for that email.');
  //   } else if (e.code == 'wrong-password') {
  //     print("Wrong password or email");
  //     visible = true;
  //   }
  // }
}

textField(c, bool password, String labelText, IconData iconName) {
  return TextField(
    controller: c,
    obscureText: password,
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      prefixIcon: Icon(
        iconName,
        color: Color.fromRGBO(244, 234, 146, 1),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color.fromRGBO(244, 234, 146, 1)),
    ),
    textAlign: TextAlign.start,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: "Log In", home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Image(
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/Images/Ataa-Logo.png')),
                  Container(
                    padding: EdgeInsets.only(top: 300),
                    // alignment: Alignment.center,
                    margin: EdgeInsets.all(10.0),
                    // child:
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 25),
                          child: Visibility(
                              visible: visible,
                              child: Text(
                                "Invalid Email or Password!",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.redAccent),
                              ))),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 100.0,
                        color: Color.fromRGBO(28, 102, 74, 1),
                        shadowColor: Colors.grey,
                        child: Column(children: [
                          textField(
                              emailController, false, "Email", Icons.person),
                          SizedBox(
                            height: 10.0,
                          ),
                          textField(passwordController, true, "Password",
                              Icons.vpn_key),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 200.0),
                            child: InkWell(
                              child: Text("Forget Password",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      decoration: TextDecoration.underline,
                                      color: Color.fromRGBO(244, 234, 146, 1))),
                              onTap: () {
                                _forgetPassword(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          )
                        ]),
                      )
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 590.0),
                    // alignment: Alignment.bottomCenter,
                    // height: 100.0,
                    margin: EdgeInsets.all(10.0),
                    child: Column(children: [
                      isLoading
                          ? Container(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromRGBO(244, 234, 146, 1),
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromRGBO(28, 102, 74, 1)),
                              ),
                            )
                          : Material(
                              borderRadius: BorderRadius.circular(20.0),
                              shadowColor: Colors.grey,
                              color: Colors.white70,
                              elevation: 100.0,
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                    loginAction(emailController.text,
                                        passwordController.text);
                                  });
                                },
                                child: Center(
                                  heightFactor: 3.0,
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(28, 102, 74, 1)),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 10.0),
                      Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.grey,
                        color: Color.fromRGBO(28, 102, 74, 1),
                        elevation: 100.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            heightFactor: 3.0,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(244, 234, 146, 1)),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future<bool> loginAction(String email, String password) async {
    //replace the below line of code with your login request
    await new Future.delayed(const Duration(seconds: 3));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("user is signed in");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Email not found");
        print('No user found for that email.');
        setState(() {
          isLoading = false;
          visible = true;
        });
      } else if (e.code == 'wrong-password') {
        print("Wrong password or email");
        setState(() {
          isLoading = false;
          visible = true;
        });
      }
    }
    return true;
  }
}

void _forgetPassword(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      elevation: 100,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return ForgetPassword();
      });
}
