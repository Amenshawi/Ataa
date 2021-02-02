// import 'package:flutter/material.dart';
// import 'package:Ataa/main.dart';

//  backPressed(BuildContext context){
//      Navigator.pop(context);
//    }

// class SignupWidget extends StatefulWidget {
//   @override
//   _SignupWidgetState createState() => _SignupWidgetState();
// }

// class _SignupWidgetState extends State<SignupWidget> {
//   @override
//   Widget build(BuildContext context) {

//     var emailController = TextEditingController();
//     var passwordController = TextEditingController();
//     var fNameController = TextEditingController();
//     var lNameController = TextEditingController();
//     DateTime pickedDate = DateTime.now();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color.fromRGBO(28,102,73,0),
//         title: Text("حساب جديد"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: backPressed(context))
//         ),
//       body: Column(
//         children: [
//           Container(
//             child:Stack(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(top: 350),
//                 // alignment: Alignment.center,
//                 margin: EdgeInsets.all(10.0),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   elevation: 100.0,
//                   color: Color.fromRGBO(28, 102, 74, 1),
//                   shadowColor: Colors.grey,
//                   child: Column(children: [
//                     textField(emailController, false, "البريد الإكتروني"),
//                     SizedBox(
//                       height: 10.0,
//                     ),
//                     textField(passwordController, true, "كلمة المرور"),
//                     SizedBox(
//                       height: 5.0,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 200.0),
//                       child: InkWell(
//                         child: Text("نسيت كلمة المرور",
//                             style: TextStyle(
//                                 fontSize: 20.0,
//                                 decoration: TextDecoration.underline,
//                                 color: Color.fromRGBO(244, 234, 146, 1))),
//                         onTap: () {
//                           print("I was pressed");
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                     )
//                   ]),
//                 ),
//                 )
//               ],) ,)
//         ],),

//     );
//   }
// }
