import 'package:flutter/material.dart';

class DonorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Donate Page",
            style: TextStyle(
                color: Color.fromRGBO(244, 234, 146, 1),
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: Color.fromRGBO(28, 102, 74, 1),
          elevation: 0,
        ),
        body: Donor());
  }
}

class Donor extends StatefulWidget {
  @override
  _DonorState createState() => _DonorState();
}

class _DonorState extends State<Donor> {
  bool folded = true;
  @override
  Widget build(BuildContext context) {
    double hieghtSize = MediaQuery.of(context).size.height;
    double widthSize = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: Color.fromRGBO(28, 102, 74, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello Abadi',
                    style: TextStyle(
                        color: Color.fromRGBO(244, 234, 146, 1), fontSize: 40)),
                SizedBox(height: 10),
                Text('welcome back :)',
                    style: TextStyle(
                        color: Color.fromRGBO(244, 234, 146, 1), fontSize: 20)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50))),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                      child: AnimatedContainer(
                        duration: Duration(microseconds: 400),
                        width: folded ? 56 : 300,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.white,
                          boxShadow: kElevationToShadow[6],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: !folded
                                    ? TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Search',
                                            hintStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    28, 102, 74, 1)),
                                            border: InputBorder.none),
                                      )
                                    : Text(""),
                              ),
                            ),
                            AnimatedContainer(
                                duration: Duration(microseconds: 400),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(folded ? 32 : 0),
                                      topRight: Radius.circular(32),
                                      bottomLeft:
                                          Radius.circular(folded ? 32 : 0),
                                      bottomRight: Radius.circular(32),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(
                                          folded ? Icons.search : Icons.close,
                                          color: Color.fromRGBO(28, 102, 74, 1),
                                        )),
                                    onTap: () {
                                      setState(() {
                                        print("i was pressed");
                                        folded = !folded;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: !folded,
                        child: IconButton(
                          tooltip: "Search",
                          icon: Icon(
                            Icons.send,
                            color: Color.fromRGBO(28, 102, 74, 1),
                          ),
                          onPressed: () {},
                        )),
                    SizedBox(height: 30),
                    folded
                        ? Container(
                            width: widthSize,
                            height: hieghtSize * .4,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            // color: Color.fromRGBO(28, 102, 74, 1),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: [
                                button("Make a donation", Icons.add),
                                button("Schedul a donation", Icons.timer),
                                button("Donations History", Icons.menu_book),
                                button("Cancel Donation", Icons.cancel),
                              ],
                            ))
                        : Expanded(child: listView())
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

button(String name, IconData icon) {
  return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(28, 102, 74, 1)),
          borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Column(
            children: [
              Icon(icon, color: Color.fromRGBO(28, 102, 74, 1), size: 60),
              Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(28, 102, 74, 1)),
                textAlign: TextAlign.center,
              )
            ],
          ),
          onTap: () {
            print("See you next week :)");
          },
        ),
      ));
}

listView() {
  return ListView(
    children: [
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home_work_outlined,
            color: Color.fromRGBO(28, 102, 74, 1)),
        title: Text(
          "Abadi is the best",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromRGBO(28, 102, 74, 1)),
        ),
        subtitle: Text(
          "Yes i am",
          style: TextStyle(color: Color.fromRGBO(28, 102, 74, 1)),
        ),
      ),
    ],
  );
}
