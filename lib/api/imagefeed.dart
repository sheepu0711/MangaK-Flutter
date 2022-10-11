class ImageFeed {
  String? result;
  String? baseUrl;
  Chapter? chapter;

  ImageFeed({this.result, this.baseUrl, this.chapter});

  ImageFeed.fromJson(Map<String, dynamic> json) {
    if (json["result"] is String) result = json["result"];
    if (json["baseUrl"] is String) baseUrl = json["baseUrl"];
    if (json["chapter"] is Map) {
      chapter =
          json["chapter"] == null ? null : Chapter.fromJson(json["chapter"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["result"] = result;
    data["baseUrl"] = baseUrl;
    if (chapter != null) data["chapter"] = chapter?.toJson();
    return data;
  }
}

class Chapter {
  String? hash;
  List<String>? data;
  List<String>? dataSaver;

  Chapter({this.hash, this.data, this.dataSaver});

  Chapter.fromJson(Map<String, dynamic> json) {
    if (json["hash"] is String) hash = json["hash"];
    if (json["data"] is List) {
      data = json["data"] == null ? null : List<String>.from(json["data"]);
    }
    if (json["dataSaver"] is List) {
      dataSaver = json["dataSaver"] == null
          ? null
          : List<String>.from(json["dataSaver"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["hash"] = hash;
    if (this.data != null) data["data"] = this.data;
    if (dataSaver != null) data["dataSaver"] = dataSaver;
    return data;
  }
}
