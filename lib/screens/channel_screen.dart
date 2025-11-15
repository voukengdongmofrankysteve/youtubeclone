import 'package:flutter/material.dart';
import 'video_player_screen.dart';
import '../models/video_model.dart';

class ChannelScreen extends StatefulWidget {
  final String channelName;
  final String channelAvatar;
  final Color channelColor;

  const ChannelScreen({
    super.key,
    required this.channelName,
    required this.channelAvatar,
    required this.channelColor,
  });

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  int _selectedTab = 0;
  bool _isSubscribed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          // App bar with back and search
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          
          // Channel header
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Banner
                _buildBanner(),
                
                // Profile info
                _buildProfileSection(),
                
                // Subscribe button
                _buildSubscribeButton(),
                
                // Tabs
                _buildTabs(),
              ],
            ),
          ),
          
          // Content based on selected tab
          _buildTabContent(),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.channelColor.withOpacity(0.8),
            widget.channelColor.withOpacity(0.4),
            Colors.black.withOpacity(0.6),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative wave pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(color: widget.channelColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 45,
            backgroundColor: widget.channelColor,
            child: Text(
              widget.channelAvatar,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Channel name
          Text(
            widget.channelName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          
          // Handle and subscribers
          Text(
            '@${widget.channelName.toLowerCase().replaceAll(' ', '')} • 1.2M subscribers',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _isSubscribed = !_isSubscribed;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isSubscribed ? Colors.red : Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            _isSubscribed ? 'Subscribed' : 'Subscribe',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab('Videos', 0),
          _buildTab('Playlists', 1),
          _buildTab('Community', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildVideosGrid();
      case 1:
        return _buildPlaylistsGrid();
      case 2:
        return _buildCommunityTab();
      default:
        return _buildVideosGrid();
    }
  }

  Widget _buildVideosGrid() {
    final videos = _getChannelVideos();
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final video = videos[index];
            return _buildVideoCard(
              video['title']!,
              video['views']!,
              video['time']!,
              video['duration']!,
            );
          },
          childCount: videos.length,
        ),
      ),
    );
  }

  Widget _buildVideoCard(String title, String views, String uploadTime, String duration) {
    return GestureDetector(
      onTap: () {
        final video = VideoModel(
          id: 'channel_${widget.channelName}_${title.hashCode}',
          title: title,
          channelName: widget.channelName,
          channelAvatar: widget.channelAvatar,
          views: views,
          uploadTime: uploadTime,
          duration: duration,
          thumbnail: 'assets/thumbnails/alps.jpg',
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/thumbnails/alps.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white54,
                          size: 32,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          
          // Views and time
          Text(
            '$views • $uploadTime',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistsGrid() {
    final playlists = _getChannelPlaylists();
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final playlist = playlists[index];
            return _buildPlaylistItem(
              playlist['title']!,
              playlist['count']!,
            );
          },
          childCount: playlists.length,
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(String title, String videoCount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.playlist_play, color: Colors.white54, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  videoCount,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityTab() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Icon(
                Icons.people_outline,
                size: 64,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 16),
              Text(
                'No community posts yet',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getChannelVideos() {
    return [
      {
        'title': 'Exploring the Alps: A Scenic Hike',
        'views': '1.2M views',
        'time': '2 weeks ago',
        'duration': '15:42',
      },
      {
        'title': 'My Desk Setup for Productivity',
        'views': '890K views',
        'time': '3 weeks ago',
        'duration': '12:18',
      },
      {
        'title': 'How to Bake the Perfect Sourdough',
        'views': '2.3M views',
        'time': '1 month ago',
        'duration': '18:35',
      },
      {
        'title': 'Iceland\'s Northern Lights: A Travel Vlog',
        'views': '650K views',
        'time': '1 month ago',
        'duration': '20:47',
      },
      {
        'title': 'Ultimate Guide to Landscape Photography',
        'views': '1.5M views',
        'time': '2 months ago',
        'duration': '25:13',
      },
      {
        'title': 'A Day in the Life of a Software Engineer',
        'views': '430K views',
        'time': '2 months ago',
        'duration': '14:29',
      },
      {
        'title': 'Tasting the World\'s Spiciest Noodles',
        'views': '3.1M views',
        'time': '3 months ago',
        'duration': '11:54',
      },
      {
        'title': 'Building a PC from Scratch in 2024',
        'views': '720K views',
        'time': '3 months ago',
        'duration': '32:08',
      },
      {
        'title': 'Morning Routine for Maximum Productivity',
        'views': '980K views',
        'time': '4 months ago',
        'duration': '8:45',
      },
      {
        'title': 'Top 10 VS Code Extensions for Developers',
        'views': '1.8M views',
        'time': '4 months ago',
        'duration': '16:22',
      },
      {
        'title': 'Learning Flutter: Complete Beginner Guide',
        'views': '2.5M views',
        'time': '5 months ago',
        'duration': '45:30',
      },
      {
        'title': 'Weekend Vlog: Exploring Hidden Gems',
        'views': '560K views',
        'time': '5 months ago',
        'duration': '13:19',
      },
    ];
  }

  List<Map<String, String>> _getChannelPlaylists() {
    return [
      {
        'title': 'Travel Adventures',
        'count': '24 videos',
      },
      {
        'title': 'Tech Tutorials',
        'count': '35 videos',
      },
      {
        'title': 'Cooking Basics',
        'count': '18 videos',
      },
      {
        'title': 'Photography Tips',
        'count': '27 videos',
      },
      {
        'title': 'Productivity Hacks',
        'count': '15 videos',
      },
      {
        'title': 'Daily Vlogs',
        'count': '42 videos',
      },
    ];
  }
}

// Custom painter for wave pattern
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    
    // Draw multiple wave lines
    for (var i = 0; i < 5; i++) {
      final yOffset = size.height * (0.2 + i * 0.15);
      path.moveTo(0, yOffset);
      
      for (var x = 0.0; x <= size.width; x += 20) {
        final y = yOffset + 10 * (i % 2 == 0 ? 1 : -1);
        path.quadraticBezierTo(
          x + 10,
          y,
          x + 20,
          yOffset,
        );
      }
      
      canvas.drawPath(path, paint);
      path.reset();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
