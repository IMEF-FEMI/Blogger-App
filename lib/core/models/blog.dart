class BlogPost {
  String id;
  String createdAt;
  String title;
  String imageUrl;

  BlogPost({this.createdAt, this.id, this.title, this.imageUrl});

  BlogPost.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() => {
        'createdA': this.createdAt,
        'id': this.id,
        'title': this.title,
        'imageUrl': this.imageUrl,
      };
}
