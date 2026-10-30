class ArticleModel {
  String? author;
  String? imgUrl;
  String? title;
  String? date;
  String? details;
  String? content;
  String? url;

  ArticleModel({
    this.author,
    this.imgUrl,
    this.title,
    this.date,
    this.details,
    this.content,
    this.url,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    imgUrl = json['urlToImage'];
    title = json['title'];
    date = json['publishedAt'];
    details = json['description'];
    content = json['content'];
    url = json['url'];
  }

  String get id => url ?? title ?? '';
}
