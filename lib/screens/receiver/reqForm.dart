import 'package:Ataa/models/app_user.dart';
import 'package:Ataa/models/donation_request.dart';
import 'package:Ataa/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';
import '../location_page.dart';

final Color ataaGreen = Color.fromRGBO(28, 102, 74, 1);
final Color ataaGold = Color.fromRGBO(244, 234, 146, .8);

class ReqForm extends StatefulWidget {
  @override
  _ReqFormState createState() => _ReqFormState();
}

class _ReqFormState extends State<ReqForm> {
  final database = Database();
  double hieghtSize, widthSize;
  bool private = false;
  bool isSwitched = false;
  var changeLocation;
  LatLng location;
  final typeController = TextEditingController();
  final importanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    Size size = MediaQuery.of(context).size;
    hieghtSize = size.height;
    widthSize = size.width;
    return reqDonation(user);
  }

  Widget reqDonation(AppUser user) {
    return Container(
      width: widthSize,
      child: Column(children: [
        // Card(
        //   elevation: 8,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //   color: ataaGreen,
        //   child:
        Padding(
          padding: EdgeInsets.only(
              top: hieghtSize * 0.04, bottom: hieghtSize * 0.04),
          // child: Column(
          //   children: [
          //     Text('Type'),
          //     TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Food, Clothes, Electronics, Furniture',
          //         hintStyle: TextStyle(color: ataaGold, fontSize: 20),
          //       ),
          //     ),
          //   ],
          child: Column(
            children: [
              customCard(Icons.receipt, 'Type',
                  'Food, Clothes, Devices, Furniture', typeController),
              customCard(Icons.label_important_outline, 'importance',
                  'High, Medium, Low', importanceController),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 50,
                color: Color.fromRGBO(
                    255, 255, 255, 0.75), // for now leave it at white !
                child: Padding(
                  padding: EdgeInsets.only(
                      top: hieghtSize * 0.01, left: widthSize * 0.02),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(widthSize * 0.02),
                            child: !private
                                ? Icon(
                                    Icons.visibility,
                                    size: 25,
                                    color: ataaGreen,
                                  )
                                : Icon(Icons.visibility_off,
                                    size: 25, color: ataaGreen)),
                        Padding(
                            padding: EdgeInsets.only(
                                top: hieghtSize * 0.009,
                                right: widthSize * 0.3),
                            child: Text('Anonimity',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ataaGreen,
                                    fontWeight: FontWeight.bold))),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = !isSwitched;
                              private = !private;
                              // database.changePrivacy(user, value);
                            });
                          },
                          activeTrackColor: ataaGreen,
                          activeColor: ataaGold,
                        ),
                      ]),
                ),
              ),
              SizedBox(height: hieghtSize * 0.01),
              !isSwitched
                  ? Container(
                      height: hieghtSize * 0.2,
                      width: widthSize,
                      child: Card(
                        color: ataaWhite,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 8,
                        child: Column(
                          children: [
                            Expanded(
                              child: TextField(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LocationPage(
                                              user, changeLocation)));
                                }),
                                readOnly: true,
                                cursorColor: ataaGreen,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ataaGreen)),
                                    prefixIcon: Icon(
                                      Icons.location_on,
                                      size: 25,
                                      color: ataaGreen,
                                    ),
                                    hintText: 'Location..',
                                    hintStyle: TextStyle(
                                        color: ataaGreen, fontSize: 20)),
                              ),
                            ),
                            Container(
                                height: hieghtSize * 0.14,
                                child: location != null
                                    ? GoogleMap(
                                        initialCameraPosition: CameraPosition(
                                        target: location,
                                        zoom: 16.0,
                                      ))
                                    : Center(
                                        child: Text(
                                          'no Location selcted',
                                          style: TextStyle(
                                              fontSize: 18, color: ataaGreen),
                                        ),
                                      ))
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: hieghtSize * 0.03),
              Container(
                height: hieghtSize * 0.05,
                width: widthSize * 0.2,
                child: FloatingActionButton(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: ataaGreen,
                    child: Icon(Icons.done, color: ataaGold, size: 30),
                    onPressed: () {
                      final request = DonationRequest(
                          type: typeController.text,
                          user: user,
                          location: location,
                          anonymous: private,
                          importance: importanceController.text);
                      database.addDonationRequest(request);
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
        // ),
        // ),
      ]),
    );
  }

  Card customCard(IconData icon, String label, String hint,
      TextEditingController controller) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 50,
      color: Color.fromRGBO(255, 255, 255, 0.75), // for now leave it at white
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: ataaGreen),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: ataaGreen, fontSize: 15),
                labelText: label,
                labelStyle: TextStyle(color: ataaGreen, fontSize: 20),
                prefixIcon: Icon(
                  icon,
                  color: ataaGreen,
                  size: 25,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
