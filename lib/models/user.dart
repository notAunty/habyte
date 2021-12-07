class UserModel {
  late final String firstName;
  late final String lastName;
  late final String about;
  late final String phoneNumber;
  late final String emailAddress;
  late final int points;
  late final int scores;

  UserModel.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        about = json['about'],
        phoneNumber = json['phoneNumber'],
        emailAddress = json['emailAddress'],
        points = json['points'],
        scores = json['scores'];

  Map<String, dynamic> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "about": about,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "points": points,
        "scores": scores
      };
}
