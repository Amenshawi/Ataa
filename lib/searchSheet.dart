import 'package:flutter/material.dart';
import 'package:Ataa/database.dart';

class SearchSheet extends StatefulWidget {
  @override
  _SearchSheetState createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  // var emailController = TextEditingController();
  final database = Database();
  var charities;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .85,
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Search",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Color.fromRGBO(28, 102, 74, 1)),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel_rounded,
                  size: 30,
                  color: Color.fromRGBO(28, 102, 74, 1),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              // controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Search for a charity...',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(28, 102, 74, 1), fontSize: 20),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(28, 102, 74, 1))),
                  labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(28, 102, 74, 1))),
              onChanged: (val) {
                if (val != '') {
                  setState(() async {
                    charities = await database.searchForCharity(val);
                    setState(
                        () {}); //IDK why is has to be here but it's the only way I could find to make it work
                    print(charities.first.data());
                  });
                } else {
                  setState(() {
                    charities = null;
                  });
                }
              }, // should be implemented with the future function to keep changing with the input
            ),
            SizedBox(height: 25),
            Expanded(child: listView())
          ],
        ));
  }

  listView() {
    if (charities == null) {
      return new ListView();
    }
    return new ListView.builder(
        itemCount: charities.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Icon(Icons.home_work_outlined,
                color: Color.fromRGBO(28, 102, 74, 1)),
            title: Text(
              charities[index].data()['name'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(28, 102, 74, 1)),
            ),
            subtitle: Text(
              (charities[index].data()['specialty'] == null
                  ? ' '
                  : charities[index].data()['specialty']),
              style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
            ),
          );
        });
  }
}
