import 'package:Ataa/SignupWidget.dart';
import 'package:flutter/material.dart';
import 'package:Ataa/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Ataa/signup.dart';
import 'package:Ataa/auth.dart';

login(String email, String password, BuildContext context, _auth) async {
  dynamic result = await _auth.loginWithEmailAndPassword(email, password);

  if (result == null) {
    // we should set the state of the widget here to error

    print('Could not log in with the givven credentials');
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => homePage()),
    );
  }
}

class Login extends StatelessWidget {
  static const PrimaryColor = const Color(0xFF1c664a);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),

      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => LoginPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/signup': (context) => SignupPage(),
      },
      debugShowCheckedModeBanner: false,
      title: "Log In",
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
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
                padding: EdgeInsets.only(top: 550.0),
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
                            context, _auth);
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
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
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

textField(c, bool password, String labelText) {
 Icon icon;
  if(password){
     icon= Icon(Icons.vpn_key,
     color: Color.fromRGBO(244, 234, 146, 0.8),
     );
  }else{
    icon = Icon(Icons.person,
    color: Color.fromRGBO(244, 234, 146, 0.8),
    );
  }
  return TextField(
    style: TextStyle(
      color: Color.fromRGBO(251,247,239,1),
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    controller: c,
    obscureText: password,
    decoration: InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(244, 234, 146, 1))),
      prefixIcon: icon,
      labelText: labelText,
      labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Color.fromRGBO(244, 234, 146, 0.7)),
    ),
    textAlign: TextAlign.start,
  );
}
