import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mythesis96/firebase/searchservice.dart';

class Sharefeeds extends StatefulWidget {
  @override
  _SharefeedsState createState() => _SharefeedsState();
}

class _SharefeedsState extends State<Sharefeeds> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
   var capitalizedValue  =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1){
      SearchService().searchByName(value).then((QuerySnapshot docs){
       for (int i = 0; i < docs.documents.length; ++i) {
         queryResultSet.add(docs.documents[i].data);
       }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element){
        if (element['Concertname'].startsWith(capitalizedValue)){
          setState(() {
            tempSearchStore.add(element);
          });
        }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('ค้นหาการแชร์'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25),
                hintText: 'ค้นหาด้วยชื่อคอนเสิรต์',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ),
          ),
          SizedBox(height: 10),
          GridView.count(
            padding: EdgeInsets.only(left: 10, right: 10),
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            primary: false,
            shrinkWrap: true,
            children: tempSearchStore.map((element){
              return buildResultCard(element); 
            }).toList()
          )
        ],
      ),
    );
  }
}

Widget buildResultCard(data){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 2,
    child: Container(
      child: Center(
      child: Text(data['Concertname'],
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      ),
    ),
    )
  );
}