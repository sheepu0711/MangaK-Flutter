class CoverArt {
  String? result;
  String? response;
  Data? data;

  CoverArt({this.result, this.response, this.data});

  CoverArt.fromJson(Map<String, dynamic> json) {
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
  String? description;
  Map? volume;
  String? fileName;
  String? locale;
  String? createdAt;
  String? updatedAt;
  int? version;

  Attributes(
      {this.description,
      this.volume,
      this.fileName,
      this.locale,
      this.createdAt,
      this.updatedAt,
      this.version});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["description"] is String) description = json["description"];
    if (json["volume"] is Map) volume = json["volume"];
    if (json["fileName"] is String) fileName = json["fileName"];
    if (json["locale"] is String) locale = json["locale"];
    if (json["createdAt"] is String) createdAt = json["createdAt"];
    if (json["updatedAt"] is String) updatedAt = json["updatedAt"];
    if (json["version"] is int) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["description"] = description;
    data["volume"] = volume;
    data["fileName"] = fileName;
    data["locale"] = locale;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["version"] = version;
    return data;
  }
}
