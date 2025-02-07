class NewsListData {
  String? status;
  int? totalResults;
  List<NewsData>? articles;

  NewsListData({this.status, this.totalResults, this.articles});

  factory NewsListData.fromJson(Map<String, dynamic> json) => NewsListData(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null ? [] : List<NewsData>.from(json["articles"]!.map((x) => NewsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}

class NewsData {
  NewsSourceData? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  NewsData({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        source: json["source"] == null ? null : NewsSourceData.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}

class NewsSourceData {
  String? id;
  String? name;

  NewsSourceData({this.id, this.name});

  factory NewsSourceData.fromJson(Map<String, dynamic> json) => NewsSourceData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
