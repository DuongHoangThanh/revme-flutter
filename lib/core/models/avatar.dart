class Avatar {
  final String name;
  final String image;

  Avatar({required this.name, required this.image});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      name: json['name'],
      image: json['image'],
    );
  }
}