class UserModel {
  final String id;
  String name;
  String email;
  String phone;
  String address;
  String city;
<<<<<<< HEAD
  String? photoUrl;   // from Google profile or Firebase Storage
=======
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.address = '',
    this.city = '',
<<<<<<< HEAD
    this.photoUrl,
  });

  // ── Firestore → UserModel ─────────────────────────────────────────────────
  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      id: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      photoUrl: map['photoUrl'],
    );
  }

  // ── UserModel → Firestore ─────────────────────────────────────────────────
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'photoUrl': photoUrl,
    };
  }
=======
  });
>>>>>>> 2e7c3c7aa8e9056bddd5feebd689e1a7245174b4
}
