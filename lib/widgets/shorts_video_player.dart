import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../widgets/video_options_menu.dart';
class ShortsVideoPlayer extends StatefulWidget {
  final ShortModel short;
  final bool isActive;

  const ShortsVideoPlayer({
    super.key,
    required this.short,
    required this.isActive,
  });

  @override
  State<ShortsVideoPlayer> createState() => _ShortsVideoPlayerState();
}

class _ShortsVideoPlayerState extends State<ShortsVideoPlayer> {
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Background (placeholder with gradient)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.teal.shade400,
                Colors.teal.shade800,
              ],
            ),
          ),
          child: Image.asset(
            widget.short.thumbnail,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.teal.shade300,
                      Colors.grey.shade900,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white54,
                  ),
                ),
              );
            },
          ),
        ),

        // Right side action buttons
        Positioned(
          right: 12,
          bottom: 150,
          child: Column(
            children: [
              _buildActionButton(
                icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                label: '1.2K',
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                    if (_isLiked) _isDisliked = false;
                  });
                },
                isActive: _isLiked,
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: _isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                label: 'Dislike',
                onTap: () {
                  setState(() {
                    _isDisliked = !_isDisliked;
                    if (_isDisliked) _isLiked = false;
                  });
                },
                isActive: _isDisliked,
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.comment_outlined,
                label: '234',
                onTap: () {
                  _showCommentsSheet();
                },
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                icon: Icons.more_vert,
                label: '',
                onTap: () => showVideoOptionsMenu(context),
              ),
            ],
          ),
        ),

        // Bottom description overlay
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black87,
                  Colors.transparent,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Channel info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red,
                      child: Text(
                        widget.short.title[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '@gamevideos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSubscribed = !_isSubscribed;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _isSubscribed ? Colors.grey[700] : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _isSubscribed ? 'Subscribed' : 'Subscribe',
                          style: TextStyle(
                            color: _isSubscribed ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Video description
                Text(
                  'Incredible skil move in the game! #gameclips #shorts',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                // Audio/Music info (optional)
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.music_note,
                      color: Colors.white70,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Original Audio',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.white,
              size: 28,
            ),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showCommentsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Comments',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Text('U${index + 1}'),
                        ),
                        title: Text(
                          'User ${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          'This is a sample comment for the short video!',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
