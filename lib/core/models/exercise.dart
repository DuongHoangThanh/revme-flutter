class Exercise {
  final int id;
  final String name ;
  final String image;
  final String video;
  final String time;

  Exercise({
    required this.id,
    required this.name,
    required this.image,
    required this.video,
    required this.time,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      time : json['time'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'video': video,
    };
  }
}