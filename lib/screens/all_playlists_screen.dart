import 'package:flutter/material.dart';
import 'create_playlist_screen.dart';

class AllPlaylistsScreen extends StatelessWidget {
  const AllPlaylistsScreen({super.key});

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
          'Playlists',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylistScreen(),
                ),
              );
              
              if (result != null && context.mounted) {
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playlist "${result['title']}" created'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPlaylistCard(
            context,
            icon: Icons.watch_later_outlined,
            title: 'Watch Later',
            videoCount: '0 videos',
            description: 'Save videos to watch later',
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.thumb_up_outlined,
            title: 'Liked Videos',
            videoCount: '248 videos',
            description: 'Videos you liked',
            hasCustomThumbnail: true,
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.playlist_play,
            title: 'Cooking Recipes',
            videoCount: '45 videos',
            description: 'Delicious recipes and cooking tips',
            hasCustomThumbnail: true,
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.fitness_center,
            title: 'Fitness & Workout',
            videoCount: '32 videos',
            description: 'Stay healthy and active',
            hasCustomThumbnail: true,
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.music_note,
            title: 'Music Collection',
            videoCount: '120 videos',
            description: 'Your favorite music videos',
            hasCustomThumbnail: true,
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.school,
            title: 'Educational Content',
            videoCount: '67 videos',
            description: 'Learn something new every day',
            hasCustomThumbnail: true,
          ),
          const SizedBox(height: 16),
          _buildPlaylistCard(
            context,
            icon: Icons.travel_explore,
            title: 'Travel & Adventure',
            videoCount: '89 videos',
            description: 'Explore the world',
            hasCustomThumbnail: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String videoCount,
    required String description,
    bool hasCustomThumbnail = false,
  }) {
    return GestureDetector(
      onTap: () {
        // Open playlist details
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 90,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(6),
              ),
              child: hasCustomThumbnail
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        'assets/thumbnails/alps.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(icon, color: Colors.white54, size: 28);
                        },
                      ),
                    )
                  : Icon(icon, color: Colors.white54, size: 28),
            ),
            const SizedBox(width: 12),
            // Info
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
                  ),
                  const SizedBox(height: 4),
                  Text(
                    videoCount,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
