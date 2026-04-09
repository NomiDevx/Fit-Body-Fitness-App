class CommunityPost {
  final String username;
  final String profileImageUrl;
  final String content;
  final String timeAgo;
  final int likes;
  final int comments;
  final bool isLikedByMe;

  CommunityPost({
    required this.username,
    required this.profileImageUrl,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    this.isLikedByMe = false,
  });
}
