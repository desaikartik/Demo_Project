// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ModelDataShow extends StatefulWidget {
  const ModelDataShow({super.key});

  @override
  State<ModelDataShow> createState() => _ModelDataShowState();
}

class _ModelDataShowState extends State<ModelDataShow> {
  Future<dynamic> getApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var jsondata = jsonDecode(response.body);

    print("response == == $jsondata");
    if (response.statusCode == 200) {
      return jsondata;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(snapshot.data[index]["title"]),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
