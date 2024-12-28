class UserModel {
  String username;
  String email;
  String imageUrl;
  bool isVerified;
  String location;
  double rate;
  double totalPoints;
  double type;

  UserModel({
    required this.username,
    required this.email,
    required this.imageUrl,
    required this.isVerified,
    required this.location,
    required this.rate,
    required this.totalPoints,
    required this.type,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      username: data['username'] ?? 'User',
      email: data['email'] ?? 'email@example.com',
      imageUrl: data['imageUrl'] ?? '',
      isVerified: data['isVerified'] ?? false,
      location: data['location'] ?? '',
      rate: (data['rate'] is int)
          ? (data['rate'] as int).toDouble()
          : (data['rate'] ?? 0).toDouble(),
      totalPoints: (data['totalPoints'] is int)
          ? (data['totalPoints'] as int).toDouble()
          : (data['totalPoints'] ?? 0).toDouble(),
      type: (data['type'] is int)
          ? (data['type'] as int).toDouble()
          : (data['type'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'imageUrl': imageUrl,
      'isVerified': isVerified,
      'location': location,
      'rate': rate,
      'totalPoints': totalPoints,
      'type': type,
    };
  }
}
