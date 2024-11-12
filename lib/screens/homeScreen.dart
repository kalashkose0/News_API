import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_api/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<NewsModel> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New App"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An Error Occurred"));
          } else if (!snapshot.hasData || snapshot.data!.articles == null) {
            return Center(child: Text("Data Not Found!!"));
          }

          return ListView.builder(
            itemCount: snapshot.data?.articles?.length ?? 0,
            itemBuilder: (context, index) {
              final article = snapshot.data!.articles![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: article.urlToImage != null
                      ? NetworkImage(article.urlToImage!)
                      : AssetImage('assets/placeholder.png') as ImageProvider,
                ),
                title: Text(article.title ?? "No Title"),
                subtitle: Text(article.description ?? "No Description"),
              );
            },
          );
        },
      ),
    );
  }

  Future<NewsModel> getNews() async {
    final response = await http.get(Uri.parse(
      "https://newsapi.org/v2/everything?q=India&from=2024-11-08&sortBy=publishedAt&apiKey=7739b0725e63465a9a616aadcafd9569",
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responsedata = jsonDecode(response.body);
      return NewsModel.fromJson(responsedata);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
      return NewsModel(); // Return an empty model to avoid null issues
    }
  }
}
