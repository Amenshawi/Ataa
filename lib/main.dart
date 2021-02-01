import 'package:flutter/material.dart';
import 'package:Ataa/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

var signedIn = false;

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
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("user is signed in");
    signedIn = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homePage()),
    );
    // return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

textField(c, bool password, String labelText) {
  return TextField(
    controller: c,
    obscureText: password,
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      prefixIcon: Icon(
        Icons.person,
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
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        body: Column(
      children: [
        Container(
          child: Stack(
            children: [
              Image(
                  alignment: Alignment.topCenter,
                  image: AssetImage('assets/Images/Ataa-Logo.png')),
              Container(
                padding: EdgeInsets.only(top: 350),
                // alignment: Alignment.center,
                margin: EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 100.0,
                  color: Color.fromRGBO(28, 102, 74, 1),
                  shadowColor: Colors.grey,
                  child: Column(children: [
                    textField(emailController, false, "البريد الإكتروني"),
                    SizedBox(
                      height: 10.0,
                    ),
                    textField(passwordController, true, "كلمة المرور"),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 200.0),
                      child: InkWell(
                        child: Text("نسيت كلمة المرور",
                            style: TextStyle(
                                fontSize: 20.0,
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(244, 234, 146, 1))),
                        onTap: () {
                          print("I was pressed");
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    )
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 590.0),
                // alignment: Alignment.bottomCenter,
                // height: 100.0,
                margin: EdgeInsets.all(10.0),
                child: Column(children: [
                  Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.grey,
                    color: Colors.white70,
                    elevation: 100.0,
                    child: GestureDetector(
                      onTap: () {
                        login(emailController.text, passwordController.text,
                            context);
                        // if (signedIn) {
                        //   emailController.text = "";
                        //   passwordController.text = "";
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => homePage()),
                        //   );
                        // }
                      },
                      child: Center(
                        heightFactor: 3.0,
                        child: Text(
                          "تسجيل الدخول",
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
                          "حساب جديد",
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
}
