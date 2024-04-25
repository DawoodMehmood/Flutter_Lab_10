const titleConstant = 'title';
const urlConstant = 'url';
const contentTypeConstant = 'contentType';
const dateConstant = 'date';
const tagsConstant = 'tags';

class Search {
  final String title;
  final String url;
  final String contentType;
  final String date;
  final List<String> tags;

  Search({
    required this.title,
    required this.url,
    required this.contentType,
    required this.date,
    required this.tags,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      title: json[titleConstant].toString(),
      url: json[urlConstant].toString(),
      contentType: json[contentTypeConstant].toString(),
      date: json[dateConstant].toString(),
      tags: (json[tagsConstant] as List).map((tag) => tag.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      titleConstant: title,
      urlConstant: url,
      contentTypeConstant: contentType,
      dateConstant: dateConstant,
      tagsConstant: tags
    };
  }

  @override
  String toString() {
    return 'Title: $title, URL: $url, ContentType: $contentType, Date: $date, Tags: $tags';
  }
}
