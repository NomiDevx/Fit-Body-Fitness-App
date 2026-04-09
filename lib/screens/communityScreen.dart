import 'package:flutter/material.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/models/postModel.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedIcon = -1;

  final List<CommunityPost> posts = [
    CommunityPost(
      username: 'Sarah Chen',
      profileImageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
      content: 'Just smashed my deadlift PR! 🏋️‍♀️ 220lbs acting light today. Consistency is key folks!',
      timeAgo: '2 hours ago',
      likes: 45,
      comments: 12,
      isLikedByMe: true,
    ),
    CommunityPost(
      username: 'Marcus Johnson',
      profileImageUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80',
      content: 'Morning 5K run done 🏃‍♂️ The weather is absolutely perfect for an outdoor cardio session.',
      timeAgo: '5 hours ago',
      likes: 128,
      comments: 8,
      isLikedByMe: false,
    ),
    CommunityPost(
      username: 'Emma Williams',
      profileImageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
      content: 'Does anyone have good recommendations for post-workout protein meals? Getting bored of chicken and rice 😭',
      timeAgo: '1 day ago',
      likes: 34,
      comments: 26,
      isLikedByMe: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(
        title: 'Community',
        selectedIndex: selectedIcon,
        onIconTap: (index) {
          setState(() {
            selectedIcon = index;
          });
        },
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(posts[index], index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildPostCard(CommunityPost post, int index) {
    return Card(
      color: AppColors.primary,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post.profileImageUrl),
                  backgroundColor: Colors.grey[800],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        post.timeAgo,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontFamily: 'Poppins',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz, color: Colors.white70),
                )
              ],
            ),
            const SizedBox(height: 12),
            Text(
              post.content,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInteractionButton(
                  icon: post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                  color: post.isLikedByMe ? Colors.redAccent : Colors.white70,
                  label: '${post.likes}',
                  onTap: () {
                    // Toggle like mock
                    setState(() {
                      int newLikes = post.isLikedByMe ? post.likes - 1 : post.likes + 1;
                      posts[index] = CommunityPost(
                        username: post.username,
                        profileImageUrl: post.profileImageUrl,
                        content: post.content,
                        timeAgo: post.timeAgo,
                        likes: newLikes,
                        comments: post.comments,
                        isLikedByMe: !post.isLikedByMe,
                      );
                    });
                  },
                ),
                _buildInteractionButton(
                  icon: Icons.chat_bubble_outline,
                  color: Colors.white70,
                  label: '${post.comments}',
                  onTap: () {},
                ),
                _buildInteractionButton(
                  icon: Icons.share_outlined,
                  color: Colors.white70,
                  label: 'Share',
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
