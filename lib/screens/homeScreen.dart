import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_api/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "An ErrorOccured",
                ),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text("Data Not Found!!"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data!.articles![index].urlToImage.toString()),
                  ),
                  title: Text(snapshot.data!.articles![index].title.toString()),
                  subtitle: Text(
                      snapshot.data!.articles![index].description.toString()),
                );
              },
              itemCount: snapshot.data!.articles!.length,
            );
          }),
    );
  }

  // Future Builder
  Future<NewsModel> getNews() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2024-09-24&sortBy=publishedAt&apiKey=7739b0725e63465a9a616aadcafd9569"));
    if (response.statusCode == 200) {
      Map<String, dynamic> responsedata = jsonDecode(response.body);
      //String message = responsedata['message'];
      NewsModel newsModel = NewsModel.fromJson(responsedata);
      return newsModel;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body)));
      return NewsModel();
    }
  }
}
