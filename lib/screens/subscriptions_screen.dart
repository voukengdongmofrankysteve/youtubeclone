import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'video_player_screen.dart';
import 'channel_screen.dart';
import '../models/video_model.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Channels horizontal list
            _buildChannelsList(),
            
            // Tabs: All, Today
            _buildTabs(),
            
            // Video feed
            Expanded(
              child: _buildVideoFeed(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            'Subscriptions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChannelsList() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildChannelAvatar('TechFlow', 'T', Colors.blue),
          _buildChannelAvatar('CodeMaster', 'C', Colors.red),
          _buildChannelAvatar('DesignPro', 'D', Colors.purple),
          _buildChannelAvatar('DevSimplified', 'D', Colors.orange),
          _buildChannelAvatar('UX Collective', 'U', Colors.teal),
          _buildChannelAvatar('LaunchPad', 'L', Colors.green),
          _buildChannelAvatar('iOS Academy', 'I', Colors.pink),
          _buildChannelAvatar('Web Dev', 'W', Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildChannelAvatar(String name, String initial, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChannelScreen(
              channelName: name,
              channelAvatar: initial,
              channelColor: color,
            ),
          ),
        );
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildTab('All', 0),
          const SizedBox(width: 12),
          _buildTab('Today', 1),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoFeed() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildVideoItem(
          title: _getTitles()[index % _getTitles().length],
          channelName: _getChannels()[index % _getChannels().length],
          channelAvatar: _getChannels()[index % _getChannels().length][0],
          views: _getViews()[index % _getViews().length],
          uploadTime: _getTimes()[index % _getTimes().length],
          duration: '${10 + index}:${20 + index}',
        );
      },
    );
  }

  List<String> _getTitles() {
    return [
      'Build a Full Stack App in 1 Hour',
      'React Native Complete Course',
      'UI Design Masterclass 2024',
      'Advanced Flutter Development',
      'JavaScript Tips & Tricks',
      'Modern Web Development',
      'Mobile App Architecture',
      'Design Systems Tutorial',
    ];
  }

  List<String> _getChannels() {
    return [
      'TechFlow',
      'CodeMaster',
      'DesignPro',
      'DevSimplified',
      'UX Collective',
      'LaunchPad',
      'iOS Academy',
      'Web Dev',
    ];
  }

  List<String> _getViews() {
    return [
      '1.2M views',
      '890K views',
      '2.5M views',
      '650K views',
      '1.8M views',
      '430K views',
      '3.1M views',
      '720K views',
    ];
  }

  List<String> _getTimes() {
    return [
      '2 hours ago',
      '5 hours ago',
      '1 day ago',
      '2 days ago',
      '3 days ago',
      '1 week ago',
      '2 weeks ago',
      '3 weeks ago',
    ];
  }

  Widget _buildVideoItem({
    required String title,
    required String channelName,
    required String channelAvatar,
    required String views,
    required String uploadTime,
    required String duration,
  }) {
    return GestureDetector(
      onTap: () {
        final video = VideoModel(
          id: 'sub_${title.hashCode}',
          title: title,
          channelName: channelName,
          channelAvatar: channelAvatar,
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/thumbnails/alps.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white54,
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Video info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Channel avatar
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.red,
                  child: Text(
                    channelAvatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                
                // Title and info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        channelName,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$views • $uploadTime',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // More options
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
