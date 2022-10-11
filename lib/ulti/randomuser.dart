class RandomUser {
  List<Results>? results;
  Info? info;

  RandomUser({this.results, this.info});

  RandomUser.fromJson(Map<String, dynamic> json) {
    if (json["results"] is List) {
      results = json["results"] == null
          ? null
          : (json["results"] as List).map((e) => Results.fromJson(e)).toList();
    }
    if (json["info"] is Map) {
      info = json["info"] == null ? null : Info.fromJson(json["info"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data["results"] = results?.map((e) => e.toJson()).toList();
    }
    if (info != null) data["info"] = info?.toJson();
    return data;
  }
}

class Info {
  String? seed;
  int? results;
  int? page;
  String? version;

  Info({this.seed, this.results, this.page, this.version});

  Info.fromJson(Map<String, dynamic> json) {
    if (json["seed"] is String) seed = json["seed"];
    if (json["results"] is int) results = json["results"];
    if (json["page"] is int) page = json["page"];
    if (json["version"] is String) version = json["version"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["seed"] = seed;
    data["results"] = results;
    data["page"] = page;
    data["version"] = version;
    return data;
  }
}

class Results {
  String? gender;
  Name? name;
  Location? location;
  String? email;
  Login? login;
  Dob? dob;
  Registered? registered;
  String? phone;
  String? cell;
  Id? id;
  Picture? picture;
  String? nat;

  Results(
      {this.gender,
      this.name,
      this.location,
      this.email,
      this.login,
      this.dob,
      this.registered,
      this.phone,
      this.cell,
      this.id,
      this.picture,
      this.nat});

  Results.fromJson(Map<String, dynamic> json) {
    if (json["gender"] is String) gender = json["gender"];
    if (json["name"] is Map) {
      name = json["name"] == null ? null : Name.fromJson(json["name"]);
    }
    if (json["location"] is Map) {
      location =
          json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if (json["email"] is String) email = json["email"];
    if (json["login"] is Map) {
      login = json["login"] == null ? null : Login.fromJson(json["login"]);
    }
    if (json["dob"] is Map) {
      dob = json["dob"] == null ? null : Dob.fromJson(json["dob"]);
    }
    if (json["registered"] is Map) {
      registered = json["registered"] == null
          ? null
          : Registered.fromJson(json["registered"]);
    }
    if (json["phone"] is String) phone = json["phone"];
    if (json["cell"] is String) cell = json["cell"];
    if (json["id"] is Map) {
      id = json["id"] == null ? null : Id.fromJson(json["id"]);
    }
    if (json["picture"] is Map) {
      picture =
          json["picture"] == null ? null : Picture.fromJson(json["picture"]);
    }
    if (json["nat"] is String) nat = json["nat"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["gender"] = gender;
    if (name != null) data["name"] = name?.toJson();
    if (location != null) data["location"] = location?.toJson();
    data["email"] = email;
    if (login != null) data["login"] = login?.toJson();
    if (dob != null) data["dob"] = dob?.toJson();
    if (registered != null) data["registered"] = registered?.toJson();
    data["phone"] = phone;
    data["cell"] = cell;
    if (id != null) data["id"] = id?.toJson();
    if (picture != null) data["picture"] = picture?.toJson();
    data["nat"] = nat;
    return data;
  }
}

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture({this.large, this.medium, this.thumbnail});

  Picture.fromJson(Map<String, dynamic> json) {
    if (json["large"] is String) large = json["large"];
    if (json["medium"] is String) medium = json["medium"];
    if (json["thumbnail"] is String) thumbnail = json["thumbnail"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["large"] = large;
    data["medium"] = medium;
    data["thumbnail"] = thumbnail;
    return data;
  }
}

class Id {
  String? name;
  dynamic value;

  Id({this.name, this.value});

  Id.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) name = json["name"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["value"] = value;
    return data;
  }
}

class Registered {
  String? date;
  int? age;

  Registered({this.date, this.age});

  Registered.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) date = json["date"];
    if (json["age"] is int) age = json["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["date"] = date;
    data["age"] = age;
    return data;
  }
}

class Dob {
  String? date;
  int? age;

  Dob({this.date, this.age});

  Dob.fromJson(Map<String, dynamic> json) {
    if (json["date"] is String) date = json["date"];
    if (json["age"] is int) age = json["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["date"] = date;
    data["age"] = age;
    return data;
  }
}

class Login {
  String? uuid;
  String? username;
  String? password;
  String? salt;
  String? md5;
  String? sha1;
  String? sha256;

  Login(
      {this.uuid,
      this.username,
      this.password,
      this.salt,
      this.md5,
      this.sha1,
      this.sha256});

  Login.fromJson(Map<String, dynamic> json) {
    if (json["uuid"] is String) uuid = json["uuid"];
    if (json["username"] is String) username = json["username"];
    if (json["password"] is String) password = json["password"];
    if (json["salt"] is String) salt = json["salt"];
    if (json["md5"] is String) md5 = json["md5"];
    if (json["sha1"] is String) sha1 = json["sha1"];
    if (json["sha256"] is String) sha256 = json["sha256"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["uuid"] = uuid;
    data["username"] = username;
    data["password"] = password;
    data["salt"] = salt;
    data["md5"] = md5;
    data["sha1"] = sha1;
    data["sha256"] = sha256;
    return data;
  }
}

class Location {
  Street? street;
  String? city;
  String? state;
  String? country;
  int? postcode;
  Coordinates? coordinates;
  Timezone? timezone;

  Location(
      {this.street,
      this.city,
      this.state,
      this.country,
      this.postcode,
      this.coordinates,
      this.timezone});

  Location.fromJson(Map<String, dynamic> json) {
    if (json["street"] is Map) {
      street = json["street"] == null ? null : Street.fromJson(json["street"]);
    }
    if (json["city"] is String) city = json["city"];
    if (json["state"] is String) state = json["state"];
    if (json["country"] is String) country = json["country"];
    if (json["postcode"] is int) postcode = json["postcode"];
    if (json["coordinates"] is Map) {
      coordinates = json["coordinates"] == null
          ? null
          : Coordinates.fromJson(json["coordinates"]);
    }
    if (json["timezone"] is Map) {
      timezone =
          json["timezone"] == null ? null : Timezone.fromJson(json["timezone"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (street != null) data["street"] = street?.toJson();
    data["city"] = city;
    data["state"] = state;
    data["country"] = country;
    data["postcode"] = postcode;
    if (coordinates != null) data["coordinates"] = coordinates?.toJson();
    if (timezone != null) data["timezone"] = timezone?.toJson();
    return data;
  }
}

class Timezone {
  String? offset;
  String? description;

  Timezone({this.offset, this.description});

  Timezone.fromJson(Map<String, dynamic> json) {
    if (json["offset"] is String) offset = json["offset"];
    if (json["description"] is String) description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["offset"] = offset;
    data["description"] = description;
    return data;
  }
}

class Coordinates {
  String? latitude;
  String? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    if (json["latitude"] is String) latitude = json["latitude"];
    if (json["longitude"] is String) longitude = json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    return data;
  }
}

class Street {
  int? number;
  String? name;

  Street({this.number, this.name});

  Street.fromJson(Map<String, dynamic> json) {
    if (json["number"] is int) number = json["number"];
    if (json["name"] is String) name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["number"] = number;
    data["name"] = name;
    return data;
  }
}

class Name {
  String? title;
  String? first;
  String? last;

  Name({this.title, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    if (json["title"] is String) title = json["title"];
    if (json["first"] is String) first = json["first"];
    if (json["last"] is String) last = json["last"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["first"] = first;
    data["last"] = last;
    return data;
  }
}
