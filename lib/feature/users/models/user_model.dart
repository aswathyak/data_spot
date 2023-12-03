class User {
  final String name;
  final String email;
  final String image;
  final String region;
  final String mobileNo;
  final String zone;
  final bool isOnline;

  User({
    required this.name,
    required this.email,
    required this.image,
    required this.region,
    required this.mobileNo,
    required this.zone,
    required this.isOnline,
  });
  static User fromJson(json) => User(
      name: json['Name'],
      email: json['Email'],
      image: json['image'],
      region: json['region'],
      mobileNo: json['mobile'],
      zone: json['zone'],
      isOnline: json['isOnline']);
}
