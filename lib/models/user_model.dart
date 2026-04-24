class UserModel {
  final String id;
  String name;
  String email;
  String phone;
  String address;
  String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.address = '',
    this.city = '',
  });
}
