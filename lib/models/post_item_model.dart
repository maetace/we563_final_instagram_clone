// lib/models/post_item_model.dart

class PostItem {
  final String id;
  final String ownerName;
  final String ownerImage;
  final List<String> images;
  final int likes;
  final int comments;
  final String description;
  final DateTime createdDate;

  PostItem({
    required this.id,
    required this.ownerName,
    required this.ownerImage,
    required this.images,
    required this.likes,
    required this.comments,
    required this.description,
    required this.createdDate,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
    id: json['id'],
    ownerName: json['ownerName'],
    ownerImage: json['ownerImage'],
    images: List<String>.from(json['images']),
    likes: json['likes'],
    comments: json['comments'],
    description: json['description'],
    createdDate: DateTime.parse(json['createdDate']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ownerName': ownerName,
    'ownerImage': ownerImage,
    'images': images,
    'likes': likes,
    'comments': comments,
    'description': description,
    'createdDate': createdDate.toIso8601String(),
  };
}
