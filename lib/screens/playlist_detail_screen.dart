import 'package:flutter/material.dart';
import 'video_player_screen.dart';
import '../models/video_model.dart';
import '../widgets/video_options_menu.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistTitle;
  final IconData playlistIcon;
  final int videoCount;
  final bool hasCustomThumbnail;

  const PlaylistDetailScreen({
    super.key,
    required this.playlistTitle,
    required this.playlistIcon,
    required this.videoCount,
    this.hasCustomThumbnail = false,
  });

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: Colors.grey[900],
            expandedHeight: 200,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey[800]!,
                      Colors.grey[900]!,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Icon(
                      widget.playlistIcon,
                      color: Colors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.playlistTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_getVideoCount()} videos',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Play all button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_getPlaylistVideos().isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                video: _getPlaylistVideos().first,
                              ),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Play All'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shuffle),
                      label: const Text('Shuffle'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Video list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final videos = _getPlaylistVideos();
                if (index >= videos.length) return null;
                final video = videos[index];
                return _buildVideoItem(video, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoItem(VideoModel video, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Index number
            Container(
              width: 24,
              alignment: Alignment.centerLeft,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Thumbnail
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 68,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      video.thumbnail,
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
                      video.duration,
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
            
            // Video info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
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
                    video.channelName,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${video.views} • ${video.uploadTime}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // More options
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey[400]),
              onPressed: () {
                showVideoOptionsMenu(context);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  int _getVideoCount() {
    if (widget.playlistTitle == 'Watch Later') {
      return 0;
    } else if (widget.playlistTitle == 'Liked Videos') {
      return 248;
    } else if (widget.playlistTitle == 'Cooking Recipes') {
      return 45;
    }
    return 0;
  }

  List<VideoModel> _getPlaylistVideos() {
    // Return empty list for Watch Later
    if (widget.playlistTitle == 'Watch Later') {
      return [];
    }
    
    // Generate sample videos based on playlist type
    if (widget.playlistTitle == 'Liked Videos') {
      return List.generate(
        248,
        (index) => VideoModel(
          id: 'liked_$index',
          title: _getLikedVideoTitles()[index % _getLikedVideoTitles().length],
          channelName: _getChannelNames()[index % _getChannelNames().length],
          channelAvatar: _getChannelNames()[index % _getChannelNames().length][0],
          thumbnail: 'assets/thumbnails/alps.jpg',
          views: _getViews()[index % _getViews().length],
          uploadTime: _getTimes()[index % _getTimes().length],
          duration: '${(index % 20) + 5}:${(index % 60).toString().padLeft(2, '0')}',
        ),
      );
    } else if (widget.playlistTitle == 'Cooking Recipes') {
      return List.generate(
        45,
        (index) => VideoModel(
          id: 'cooking_$index',
          title: _getCookingVideoTitles()[index % _getCookingVideoTitles().length],
          channelName: 'Chef\'s Kitchen',
          channelAvatar: 'C',
          thumbnail: 'assets/thumbnails/pasta.jpg',
          views: _getViews()[index % _getViews().length],
          uploadTime: _getTimes()[index % _getTimes().length],
          duration: '${(index % 15) + 8}:${((index % 60)).toString().padLeft(2, '0')}',
        ),
      );
    }
    
    return [];
  }

  List<String> _getLikedVideoTitles() {
    return [
      'Amazing Nature Documentary',
      'Top 10 Travel Destinations',
      'Learn Flutter in 30 Minutes',
      'Best Workout Routine for Beginners',
      'Delicious Pasta Recipe',
      'Photography Tips for Beginners',
      'How to Build a Mobile App',
      'Meditation and Mindfulness Guide',
    ];
  }

  List<String> _getCookingVideoTitles() {
    return [
      'Perfect Pasta Carbonara',
      'Homemade Pizza from Scratch',
      'Best Chocolate Cake Recipe',
      'Quick and Easy Stir Fry',
      'Authentic Pad Thai',
      'Classic French Croissants',
      'Spicy Chicken Curry',
      'Fresh Summer Salad',
    ];
  }

  List<String> _getChannelNames() {
    return [
      'TechFlow',
      'CodeMaster',
      'DesignPro',
      'DevSimplified',
      'AdventureVlogs',
      'FitnessHub',
      'MusicChannel',
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
    ];
  }

  List<String> _getTimes() {
    return [
      '2 days ago',
      '1 week ago',
      '3 weeks ago',
      '1 month ago',
      '2 months ago',
      '3 months ago',
    ];
  }
}
