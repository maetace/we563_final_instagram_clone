// lib/models/comment_item_model.dart

// ===============================
// COMMENT ITEM MODEL
// ===============================

/// CommentItem model
/// - Used in post detail / comment list
class CommentItem {
  final String id;
  final String postId;
  final String ownerName;
  final String ownerImage;
  final String message;
  final DateTime createdDate;

  CommentItem({
    required this.id,
    required this.postId,
    required this.ownerName,
    required this.ownerImage,
    required this.message,
    required this.createdDate,
  });

  /// From JSON
  factory CommentItem.fromJson(Map<String, dynamic> json) => CommentItem(
    id: json['id'],
    postId: json['postId'],
    ownerName: json['ownerName'],
    ownerImage: json['ownerImage'],
    message: json['message'],
    createdDate: DateTime.parse(json['createdDate']),
  );

  /// To JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'ownerName': ownerName,
    'ownerImage': ownerImage,
    'message': message,
    'createdDate': createdDate.toIso8601String(),
  };
}
