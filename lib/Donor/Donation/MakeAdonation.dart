// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import 'furniture.dart';

// final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
// final Color ataaGreenField = Color.fromRGBO(28, 102, 74, .5);
// final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);
// final Color ataaWhite = Color.fromRGBO(255, 255, 255, 0.75);

// class MakeAdonation extends StatefulWidget {
//   @override
//   _MakeAdonationState createState() => _MakeAdonationState();
// }

// class _MakeAdonationState extends State<MakeAdonation> {
//   double hieghtSize, widthSize;
//   PageController _pageController = new PageController();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     hieghtSize = size.height;
//     widthSize = size.width;
//     return Expanded(
//       child: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             children: [
//               page('Food', ataaWhite, Icons.food_bank, Furniture()),
//               page('Electronics', ataaWhite, Icons.power, Furniture()),
//               page('Clothes', ataaWhite, Icons.accessibility_rounded,
//                   Furniture()),
//               page('Furniture', ataaWhite, Icons.house_rounded, Furniture()),
//             ],
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(10),
//                 child: Center(
//                     child: SmoothPageIndicator(
//                         controller: _pageController,
//                         count: 4,
//                         effect: WormEffect(
//                             dotColor: Colors.grey, activeDotColor: ataaGreen),
//                         onDotClicked: (index) => _pageController.animateToPage(
//                               index,
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.bounceOut,
//                             ))),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget page(String name, Color color, IconData icon, Widget content) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       color: color,
//       child: Column(
//         children: [
//           Padding(
//               padding: EdgeInsets.all(widthSize * 0.1),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       name,
//                       style: TextStyle(
//                           color: ataaGreen,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 30),
//                     ),
//                     Icon(
//                       icon,
//                       color: ataaGreen,
//                       size: 40,
//                     )
//                   ])),
//           content,
//         ],
//       ),
//     );
//   }
// }
