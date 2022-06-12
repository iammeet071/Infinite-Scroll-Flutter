import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var result;

class Cards extends StatefulWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  List<String> images = [];
  List<String> names = [];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    fetchTen();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) fetchTen();
    });
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView.builder(
      controller: _scrollController,
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  images[index],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(names[index])
              ],
            ),
          ),
          width: 100,
          height: 100,
        );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    ));
  }

  fetchTen() async {
    for (int i = 0; i < 10; i++) {
      var url = 'https://picsum.photos/v2/list';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          images.add(json.decode(response.body)[i]['download_url']);
          names.add(json.decode(response.body)[i]['author']);
        });
      } else {
        throw Exception('Failed to load images');
      }
    }
  }
}
