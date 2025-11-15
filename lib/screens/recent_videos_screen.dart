import 'package:flutter/material.dart';
import 'video_player_screen.dart';
import '../models/video_model.dart';

class RecentVideosScreen extends StatelessWidget {
  const RecentVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Recent',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15,
        itemBuilder: (context, index) {
          return _buildVideoItem(
            context,
            title: _getTitles()[index % _getTitles().length],
            views: _getViews()[index % _getViews().length],
            uploadTime: _getTimes()[index % _getTimes().length],
            duration: '10:${20 + index}',
          );
        },
      ),
    );
  }

  List<String> _getTitles() {
    return [
      'The amazing world of abstract art',
      'Exploring the City of the Future',
      'Modern Architecture Design',
      'Understanding Color Theory',
      'Photography Basics for Beginners',
      'Digital Marketing Strategies',
      'Web Development Tutorial',
      'Mobile App Design Principles',
    ];
  }

  List<String> _getViews() {
    return [
      '143K views',
      '532K views',
      '287K views',
      '1.2M views',
      '890K views',
      '456K views',
      '2.1M views',
      '675K views',
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
      '1 month ago',
    ];
  }

  Widget _buildVideoItem(
    BuildContext context, {
    required String title,
    required String views,
    required String uploadTime,
    required String duration,
  }) {
    return GestureDetector(
      onTap: () {
        final video = VideoModel(
          id: 'recent_${title.hashCode}',
          title: title,
          channelName: 'Tech Channel',
          channelAvatar: 'T',
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
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            Stack(
              children: [
                Container(
                  width: 140,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/thumbnails/alps.jpg',
                      fit: BoxFit.cover,
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
                  ),
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
            const SizedBox(width: 12),
            
            // Video Info
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
                    '$views • $uploadTime',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
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
      ),
    );
  }
}
