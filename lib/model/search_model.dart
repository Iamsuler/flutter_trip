class SearchModel {
  final List<SearchModelItem> data;

  SearchModel({required this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final List<SearchModelItem> data = [];
    if (json['data'] is List) {
      for (final dynamic item in json['data']) {
        if (item != null) {
          data.add(SearchModelItem.fromJson(new Map<String, String>.from(item)));
        }
      }
    }
    return SearchModel(
        data: data
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data
  };
}

class SearchModelItem {
  final String? word;
  final String? type;
  final String? districtname;
  final String url;
  final String? price;

  SearchModelItem(
      {required this.word,
      required this.type,
      required this.districtname,
      required this.url,
      required this.price});

  factory SearchModelItem.fromJson(Map<String, String> json) {
    return SearchModelItem(
        word: json['word'] ?? '',
        type: json['type'] ?? '',
        districtname: json['districtname'] ?? '',
        url: json['url'] ?? '',
        price: json['price'] ?? '');
  }

  Map<String, String> toJson() => {
    'word': word!,
    'type': type!,
    'districtname': districtname!,
    'url': url,
  };
}
