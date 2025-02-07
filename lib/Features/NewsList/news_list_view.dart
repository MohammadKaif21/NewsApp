import 'package:flutter_application/Features/NewsDetail/news_detail_view.dart';
import 'package:flutter_application/Components/no_data_screen.dart';
import 'package:flutter_application/Components/home_shimmer.dart';
import 'package:flutter_application/Components/cache_image.dart';
import 'package:flutter_application/Utilities/home_data.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'dart:convert';

class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _HomeState();
}

class _HomeState extends State<NewsListView> {
  List<Article> articles = [];
  bool loading = false;

  @override
  void initState() {
    getAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: HomeShimmer(
        inAsyncCall: loading,
        child: ShowNoDataScreen(
          onTryAgain: () => getAllNews(),
          on: articles.isEmpty,
          child: RefreshIndicator(
            onRefresh: () async => getAllNews(),
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailView(article: article),
                      ),
                    ),
                    child: ArticleView(article: article),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void getAllNews() async {
    setState(() => loading = true);
    String url = "https://newsapi.org/v2/everything?q=tesla&from=2025-01-06&sortBy=publishedAt&apiKey=1867d04a4fc9417ab01ee19032cefb4a";
    final apiURL = Uri.parse(url);

    try {
      final httpResponse = await http.get(apiURL);
      log(httpResponse.body.toString());
      final jsonResponse = jsonDecode(httpResponse.body.toString());
      final response = HomeDataModel.fromJson(jsonResponse);
      articles = response.articles ?? [];
      log("length ${articles.length}");
      setState(() => loading = false);
    } catch (e) {
      debugPrint(e.toString());
      setState(() => loading = false);
    }
  }
}

class ArticleView extends StatelessWidget {
  final Article article;
  const ArticleView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          CacheImage(
            fit: BoxFit.cover,
            width: size.width,
            height: size.width / 2,
            radius: BorderRadius.circular(8),
            image: article.urlToImage ?? "",
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "",
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                const Icon(Icons.podcasts, size: 12),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      article.source?.name ?? "",
                                      maxLines: 1,
                                      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.calendar_month, size: 12),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      DateFormat.yMMMd().format(DateTime.parse("${article.publishedAt ?? ""}")),
                                      maxLines: 1,
                                      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
