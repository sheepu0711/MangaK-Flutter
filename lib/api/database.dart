class DataBase {
  String lastRead = '';
  List<String> favorites = [];
  List<String> genres = [];

  DataBase(
      {this.lastRead = '', this.favorites = const [], this.genres = const []});

  static DataBase fromJson(Map<String, dynamic> json) => DataBase(
        lastRead: json['lastRead'],
        favorites: List<String>.from(json['favorites']),
        genres: List<String>.from(json['genres']),
      );

  Map<String, dynamic> toJson() => {
        'lastRead': lastRead,
        'favorites': favorites,
        'genres': genres,
      };
}
