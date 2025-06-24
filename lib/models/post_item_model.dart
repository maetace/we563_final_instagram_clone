// lib/models/post_item_model.dart

// ===============================
// POST ITEM MODEL
// ===============================

/// PostItem model
/// - Used in feed / post detail
class PostItem {
  final String id;
  final String ownerName;
  final String ownerImage;
  final List<String> images;
  int likes;
  int comments;
  bool isLiked;
  final String description;
  final DateTime createdDate;

  PostItem({
    required this.id,
    required this.ownerName,
    required this.ownerImage,
    required this.images,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    required this.description,
    required this.createdDate,
  });

  /// From JSON
  factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
    id: json['id'],
    ownerName: json['ownerName'],
    ownerImage: json['ownerImage'],
    images: List<String>.from(json['images']),
    likes: json['likes'],
    comments: json['comments'],
    isLiked: json['isLiked'] ?? false,
    description: json['description'],
    createdDate: DateTime.parse(json['createdDate']),
  );

  /// To JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'ownerName': ownerName,
    'ownerImage': ownerImage,
    'images': images,
    'likes': likes,
    'comments': comments,
    'isLiked': isLiked,
    'description': description,
    'createdDate': createdDate.toIso8601String(),
  };
}
