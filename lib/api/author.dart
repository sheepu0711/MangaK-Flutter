class Author {
  String? result;
  String? response;
  Data? data;

  Author({this.result, this.response, this.data});

  Author.fromJson(Map<String, dynamic> json) {
    if (json["result"] is String) result = json["result"];
    if (json["response"] is String) response = json["response"];
    if (json["data"] is Map) {
      data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["result"] = result;
    data["response"] = response;
    if (this.data != null) data["data"] = this.data?.toJson();
    return data;
  }
}

class Data {
  String? id;
  String? type;
  Attributes? attributes;
  List<Relationships>? relationships;

  Data({this.id, this.type, this.attributes, this.relationships});

  Data.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Map? imageUrl;
  List<dynamic>? biography;
  String? twitter;
  String? pixiv;
  Map? melonBook;
  Map? fanBox;
  Map? booth;
  Map? nicoVideo;
  Map? skeb;
  Map? fantia;
  Map? tumblr;
  Map? youtube;
  Map? weibo;
  Map? naver;
  Map? website;
  String? createdAt;
  String? updatedAt;
  int? version;

  Attributes(
      {this.name,
      this.imageUrl,
      this.biography,
      this.twitter,
      this.pixiv,
      this.melonBook,
      this.fanBox,
      this.booth,
      this.nicoVideo,
      this.skeb,
      this.fantia,
      this.tumblr,
      this.youtube,
      this.weibo,
      this.naver,
      this.website,
      this.createdAt,
      this.updatedAt,
      this.version});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) name = json["name"];
    if (json["imageUrl"] is Map) imageUrl = json["imageUrl"];
    if (json["biography"] is List) biography = json["biography"] ?? [];
    if (json["twitter"] is String) twitter = json["twitter"];
    if (json["pixiv"] is String) pixiv = json["pixiv"];
    if (json["melonBook"] is Map) melonBook = json["melonBook"];
    if (json["fanBox"] is Map) fanBox = json["fanBox"];
    if (json["booth"] is Map) booth = json["booth"];
    if (json["nicoVideo"] is Map) nicoVideo = json["nicoVideo"];
    if (json["skeb"] is Map) skeb = json["skeb"];
    if (json["fantia"] is Map) fantia = json["fantia"];
    if (json["tumblr"] is Map) tumblr = json["tumblr"];
    if (json["youtube"] is Map) youtube = json["youtube"];
    if (json["weibo"] is Map) weibo = json["weibo"];
    if (json["naver"] is Map) naver = json["naver"];
    if (json["website"] is Map) website = json["website"];
    if (json["createdAt"] is String) createdAt = json["createdAt"];
    if (json["updatedAt"] is String) updatedAt = json["updatedAt"];
    if (json["version"] is int) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["imageUrl"] = imageUrl;
    if (biography != null) data["biography"] = biography;
    data["twitter"] = twitter;
    data["pixiv"] = pixiv;
    data["melonBook"] = melonBook;
    data["fanBox"] = fanBox;
    data["booth"] = booth;
    data["nicoVideo"] = nicoVideo;
    data["skeb"] = skeb;
    data["fantia"] = fantia;
    data["tumblr"] = tumblr;
    data["youtube"] = youtube;
    data["weibo"] = weibo;
    data["naver"] = naver;
    data["website"] = website;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["version"] = version;
    return data;
  }
}
