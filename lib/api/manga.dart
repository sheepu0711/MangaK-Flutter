class Manga {
  String? result;
  String? response;
  List<DataManga>? data;
  int? limit;
  int? offset;
  int? total;

  Manga(
      {this.result,
      this.response,
      this.data,
      this.limit,
      this.offset,
      this.total});

  Manga.fromJson(Map<String, dynamic> json) {
    if (json["result"] is String) result = json["result"];
    if (json["response"] is String) response = json["response"];
    if (json["data"] is List) {
      data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => DataManga.fromJson(e)).toList();
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

class DataManga {
  String? id;
  String? type;
  Attributes? attributes;
  List<Relationships>? relationships;

  DataManga({this.id, this.type, this.attributes, this.relationships});

  DataManga.fromJson(Map<String, dynamic> json) {
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
  Title? title;
  List<AltTitles>? altTitles;
  Description? description;
  bool? isLocked;
  Links? links;
  String? originalLanguage;
  String? lastVolume;
  String? lastChapter;
  String? publicationDemographic;
  String? status;
  Map? year;
  String? contentRating;
  List<Tags>? tags;
  String? state;
  bool? chapterNumbersResetOnNewVolume;
  String? createdAt;
  String? updatedAt;
  int? version;

  Attributes(
      {this.title,
      this.altTitles,
      this.description,
      this.isLocked,
      this.links,
      this.originalLanguage,
      this.lastVolume,
      this.lastChapter,
      this.publicationDemographic,
      this.status,
      this.year,
      this.contentRating,
      this.tags,
      this.state,
      this.chapterNumbersResetOnNewVolume,
      this.createdAt,
      this.updatedAt,
      this.version});

  Attributes.fromJson(Map<String, dynamic> json) {
    if (json["title"] is Map) {
      title = json["title"] == null ? null : Title.fromJson(json["title"]);
    }
    if (json["altTitles"] is List) {
      altTitles = json["altTitles"] == null
          ? null
          : (json["altTitles"] as List)
              .map((e) => AltTitles.fromJson(e))
              .toList();
    }
    if (json["description"] is Map) {
      description = json["description"] == null
          ? null
          : Description.fromJson(json["description"]);
    }
    if (json["isLocked"] is bool) isLocked = json["isLocked"];
    if (json["links"] is Map) {
      links = json["links"] == null ? null : Links.fromJson(json["links"]);
    }
    if (json["originalLanguage"] is String) {
      originalLanguage = json["originalLanguage"];
    }
    if (json["lastVolume"] is String) lastVolume = json["lastVolume"];
    if (json["lastChapter"] is String) lastChapter = json["lastChapter"];
    if (json["publicationDemographic"] is String) {
      publicationDemographic = json["publicationDemographic"];
    }
    if (json["status"] is String) status = json["status"];
    if (json["year"] is Map) year = json["year"];
    if (json["contentRating"] is String) {
      contentRating = json["contentRating"];
    }
    if (json["tags"] is List) {
      tags = json["tags"] == null
          ? null
          : (json["tags"] as List).map((e) => Tags.fromJson(e)).toList();
    }
    if (json["state"] is String) state = json["state"];
    if (json["chapterNumbersResetOnNewVolume"] is bool) {
      chapterNumbersResetOnNewVolume = json["chapterNumbersResetOnNewVolume"];
    }
    if (json["createdAt"] is String) createdAt = json["createdAt"];
    if (json["updatedAt"] is String) updatedAt = json["updatedAt"];
    if (json["version"] is int) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (title != null) data["title"] = title?.toJson();
    if (altTitles != null) {
      data["altTitles"] = altTitles?.map((e) => e.toJson()).toList();
    }
    if (description != null) {
      data["description"] = description?.toJson();
    }
    data["isLocked"] = isLocked;
    if (links != null) data["links"] = links?.toJson();
    data["originalLanguage"] = originalLanguage;
    data["lastVolume"] = lastVolume;
    data["lastChapter"] = lastChapter;
    data["publicationDemographic"] = publicationDemographic;
    data["status"] = status;
    data["year"] = year;
    data["contentRating"] = contentRating;
    if (tags != null) {
      data["tags"] = tags?.map((e) => e.toJson()).toList();
    }
    data["state"] = state;
    data["chapterNumbersResetOnNewVolume"] = chapterNumbersResetOnNewVolume;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["version"] = version;
    return data;
  }
}

class Tags {
  String? id;
  String? type;
  Attributes1? attributes;
  List<dynamic>? relationships;

  Tags({this.id, this.type, this.attributes, this.relationships});

  Tags.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) id = json["id"];
    if (json["type"] is String) type = json["type"];
    if (json["attributes"] is Map) {
      attributes = json["attributes"] == null
          ? null
          : Attributes1.fromJson(json["attributes"]);
    }
    if (json["relationships"] is List) {
      relationships = json["relationships"] ?? [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["type"] = type;
    if (attributes != null) data["attributes"] = attributes?.toJson();
    if (relationships != null) data["relationships"] = relationships;
    return data;
  }
}

class Attributes1 {
  Name? name;
  List<dynamic>? description;
  String? group;
  int? version;

  Attributes1({this.name, this.description, this.group, this.version});

  Attributes1.fromJson(Map<String, dynamic> json) {
    if (json["name"] is Map) {
      name = json["name"] == null ? null : Name.fromJson(json["name"]);
    }
    if (json["description"] is List) {
      description = json["description"] ?? [];
    }
    if (json["group"] is String) group = json["group"];
    if (json["version"] is int) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data["name"] = name?.toJson();
    if (description != null) data["description"] = description;
    data["group"] = group;
    data["version"] = version;
    return data;
  }
}

class Name {
  String? en;

  Name({this.en});

  Name.fromJson(Map<String, dynamic> json) {
    if (json["en"] is String) en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["en"] = en;
    return data;
  }
}

class Links {
  String? al;
  String? ap;
  String? amz;

  Links({this.al, this.ap, this.amz});

  Links.fromJson(Map<String, dynamic> json) {
    if (json["al"] is String) al = json["al"];
    if (json["ap"] is String) ap = json["ap"];
    if (json["amz"] is String) amz = json["amz"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["al"] = al;
    data["ap"] = ap;
    data["amz"] = amz;
    return data;
  }
}

class Description {
  String? en;

  Description({this.en});

  Description.fromJson(Map<String, dynamic> json) {
    if (json["en"] is String) en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["en"] = en;
    return data;
  }
}

class AltTitles {
  String? en;

  AltTitles({this.en});

  AltTitles.fromJson(Map<String, dynamic> json) {
    if (json["en"] is String) en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["en"] = en;
    return data;
  }
}

class Title {
  String? en;

  Title({this.en});

  Title.fromJson(Map<String, dynamic> json) {
    if (json["en"] is String) en = json["en"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["en"] = en;
    return data;
  }
}
