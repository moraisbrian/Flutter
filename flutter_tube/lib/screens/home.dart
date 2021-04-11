import 'package:flutter/material.dart';
import 'package:flutter_tube/delegates/data_search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 55,
          child: Image.asset('images/youtube_logo.jpg'),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 39, 39, 39),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(
                context: context,
                delegate: DataSearch(),
              );
              print(result);
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
