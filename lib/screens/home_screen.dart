import 'package:flutter/material.dart';
import '../widgets/shorts_section.dart';
import '../widgets/video_card.dart';
import '../widgets/community_post_card.dart';
import '../models/video_model.dart';
import '../services/auth_service.dart';
import 'search_screen.dart';
import 'user_profile_screen.dart';
import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int)? onTabChange;
  
  const HomeScreen({super.key, this.onTabChange});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _communityPosts = [
    {
      'channelName': 'TechFlow',
      'channelAvatar': 'T',
      'channelColor': Colors.blue,
      'postTime': '3 hours ago',
      'postContent': '🎉 Excited to announce our new series on Advanced Flutter Development! Starting next week, we\'ll dive deep into state management, animations, and performance optimization. What topics would you like us to cover?',
      'postImage': 'assets/thumbnails/alps.jpg',
      'likes': 2400,
      'comments': 156,
    },
    {
      'channelName': 'CodeMaster',
      'channelAvatar': 'C',
      'channelColor': Colors.red,
      'postTime': '1 day ago',
      'postContent': '💡 Quick tip: Always use const constructors in Flutter when widgets don\'t change. It significantly improves performance by reducing rebuilds. Small optimizations make a big difference!',
      'postImage': null,
      'likes': 1800,
      'comments': 89,
    },
    {
      'channelName': 'DesignPro',
      'channelAvatar': 'D',
      'channelColor': Colors.purple,
      'postTime': '2 days ago',
      'postContent': '🎨 New tutorial dropping tomorrow! We\'re creating a beautiful dark mode UI from scratch. Here\'s a sneak peek of what we\'re building...',
      'postImage': 'assets/thumbnails/pasta.jpg',
      'likes': 3200,
      'comments': 234,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset(
              'assets/youtube_logo.png',
              height: 20,
              errorBuilder: (context, error, stackTrace) {
                return const Row(
                  children: [
                    Icon(Icons.play_circle_outline, color: Colors.red, size: 28),
                    SizedBox(width: 4),
                    Text(
                      'YouTube',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Check if user is authenticated
              final authService = AuthService();
              if (authService.isAuthenticated) {
                // Navigate to profile if logged in
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProfileScreen(),
                  ),
                );
              } else {
                // Navigate to login if not authenticated
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.red,
                child: const Text(
                  'U',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Tabs: Home and Shorts
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildTab('Home', true, () {}),
                const SizedBox(width: 16),
                _buildTab('Shorts', false, () {
                  // Switch to Shorts tab (index 1)
                  widget.onTabChange?.call(1);
                }),
              ],
            ),
          ),
          
          // Shorts Section
          ShortsSection(onTabChange: widget.onTabChange),
          
          const SizedBox(height: 8),
          
          // Video List with Community Posts
          ..._buildFeedItems(),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFeedItems() {
    List<Widget> feedItems = [];
    int postIndex = 0;
    
    for (int i = 0; i < demoVideos.length; i++) {
      // Add video card
      feedItems.add(VideoCard(video: demoVideos[i]));
      
      // Insert community post after every 2-3 videos
      if ((i + 1) % 3 == 0 && postIndex < _communityPosts.length) {
        final post = _communityPosts[postIndex];
        feedItems.add(
          CommunityPostCard(
            channelName: post['channelName'],
            channelAvatar: post['channelAvatar'],
            postTime: post['postTime'],
            postContent: post['postContent'],
            postImage: post['postImage'],
            likes: post['likes'],
            comments: post['comments'],
            channelColor: post['channelColor'],
          ),
        );
        postIndex++;
      }
    }
    
    return feedItems;
  }
}
