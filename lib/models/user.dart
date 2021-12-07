class UserModel {
  late final String firstName;
  late final String lastName;
  late final String about;
  late final String phoneNumber;
  late final String emailAddress;

  UserModel.fromJson(Map<String, String> json)
      : firstName = json['firstName']!,
        lastName = json['lastName']!,
        about = json['about']!,
        phoneNumber = json['phoneNumber']!,
        emailAddress = json['emailAddress']!;

  Map<String, String> toMap() => {
        "firstName": firstName,
        "lastName": lastName,
        "about": about,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress
      };
}
