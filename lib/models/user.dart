class UserModel {
  late String name;
  late String? about;
  late String? profilePicPath;
  late int points;
  late int scores;

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        about = json['about'],
        profilePicPath = json['profilePicPath'],
        points = json['points'],
        scores = json['scores'];

  Map<String, dynamic> toMap() => {
        "name": name,
        "about": about,
        "profilePicPath": profilePicPath,
        "points": points,
        "scores": scores
      };
}
