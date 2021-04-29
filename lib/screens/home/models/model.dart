class News {
  String title;
  String description;
  String content;
  String author;
  String publishedAt;
  bool highlight;
  String url;
  String imageUrl;

  News(
      {this.title,
      this.description,
      this.content,
      this.author,
      this.publishedAt,
      this.highlight,
      this.url,
      this.imageUrl});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    content = json['content'];
    author = json['author'];
    publishedAt = json['published_at'];
    highlight = json['highlight'];
    url = json['url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['content'] = this.content;
    data['author'] = this.author;
    data['published_at'] = this.publishedAt;
    data['highlight'] = this.highlight;
    data['url'] = this.url;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
