class Feed {
  String? result;
  String? response;
  List<DataFeed>? data;
  int? limit;
  int? offset;
  int? total;

  Feed(
      {this.result,
      this.response,
      this.data,
      this.limit,
      this.offset,
      this.total});

  Feed.fromJson(Map<String, dynamic> json) {
    if (json["result"] is String) result = json["result"];
    if (json["response"] is String) response = json["response"];
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => DataFeed.fromJson(e)).toList();
    }
    if (json["limit"] is int) limit = json["limit"];
    if (json["offset"] is int) offset = json["offset"];
    if (json["total"] is int) total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["result"] = result;
    data["response"] = response;
    if (this.data != null) {
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    }
    data["limit"] = limit;
    data["offset"] = offset;
    data["total"] = total;
    return data;
  }
}

class DataFeed {
  String? id;
  String? type;
  Attributes? attributes;
  List<Relationships>? relationships;

  DataFeed({this.id, this.type, this.attributes, this.relationships});

  DataFeed.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) id = json["id"];
    if (json["type"] is String) type = json["type"];
    if (json["attributes"] is Map) {
      attributes = json["attributes"] == null
          ? null
          : Attributes.fromJson(json["attributes"]);
    }
    if (json["relationships"] is List) {
      relationships = json["relationships"] == null
          ? null
          : (json["relationships"] as List)
              .map((e) => Relationships.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    if (attributes != null) data["attributes"] = attributes?.toJson();
    if (relationships != null) {
      data["relationships"] = relationships?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Relationships {
  String? id;
  String? type;

  Relationships({this.id, this.type});

  Relationships.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) id = json["id"];
    if (json["type"] is String) type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    return data;
  }
}

class Attributes {
  Map? volume;
  String? chapter;
  String? title;
  String? translatedLanguage;
  String? externalUrl;
  String? publishAt;
  String? readableAt;
  String? createdAt;
  String? updatedAt;
  int? pages;
  int? version;

  Attributes(
      {this.volume,
      this.chapter,
      this.title,
      this.translatedLanguage,
      this.externalUrl,
      this.publishAt,
      this.readableAt,
      this.createdAt,
      this.updatedAt,
      this.pages,
      this.version});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["volume"] is Map) volume = json["volume"];
    if (json["chapter"] is String) chapter = json["chapter"];
    if (json["title"] is String) title = json["title"];
    if (json["translatedLanguage"] is String) {
      translatedLanguage = json["translatedLanguage"];
    }
    if (json["externalUrl"] is String) externalUrl = json["externalUrl"];
    if (json["publishAt"] is String) publishAt = json["publishAt"];
    if (json["readableAt"] is String) readableAt = json["readableAt"];
    if (json["createdAt"] is String) createdAt = json["createdAt"];
    if (json["updatedAt"] is String) updatedAt = json["updatedAt"];
    if (json["pages"] is int) pages = json["pages"];
    if (json["version"] is int) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["volume"] = volume;
    data["chapter"] = chapter;
    data["title"] = title;
    data["translatedLanguage"] = translatedLanguage;
    data["externalUrl"] = externalUrl;
    data["publishAt"] = publishAt;
    data["readableAt"] = readableAt;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["pages"] = pages;
    data["version"] = version;
    return data;
  }
}
