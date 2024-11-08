class Posts {
  int id;
  String nameUser;
  String imageUser;
  String time;
  String content;
  String imagePost;
  int like;
  int comment;
  int share;

  Posts({
    this.id = 0,
    this.nameUser = '',
    this.imageUser = '',
    this.time = '',
    this.content = '',
    this.imagePost = '',
    this.like = 0,
    this.comment = 0,
    this.share = 0,
  });


  Posts.requiredFields({
    required this.id,
    required this.nameUser,
    required this.imageUser,
    required this.time,
    required this.content,
    required this.imagePost,
    required this.like,
    required this.comment,
    required this.share,
  });
}
