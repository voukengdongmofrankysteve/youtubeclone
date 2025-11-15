import 'package:flutter/material.dart';
import '../screens/community_post_detail_screen.dart';

class CommunityPostCard extends StatefulWidget {
  final String channelName;
  final String channelAvatar;
  final String postTime;
  final String postContent;
  final String? postImage;
  final int likes;
  final int comments;
  final Color channelColor;

  const CommunityPostCard({
    super.key,
    required this.channelName,
    required this.channelAvatar,
    required this.postTime,
    required this.postContent,
    this.postImage,
    required this.likes,
    required this.comments,
    required this.channelColor,
  });

  @override
  State<CommunityPostCard> createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends State<CommunityPostCard> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.likes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommunityPostDetailScreen(
              channelName: widget.channelName,
              channelAvatar: widget.channelAvatar,
              postTime: widget.postTime,
              postContent: widget.postContent,
              postImage: widget.postImage,
              initialLikes: _likeCount,
              initialComments: widget.comments,
              channelColor: widget.channelColor,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Channel info
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: widget.channelColor,
                child: Text(
                  widget.channelAvatar,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.channelName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.postTime,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, color: Colors.grey[400]),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Post content
          Text(
            widget.postContent,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          
          // Post image (if exists)
          if (widget.postImage != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.postImage!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: Colors.grey[600],
                      size: 48,
                    ),
                  );
                },
              ),
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Engagement row
          Row(
            children: [
              // Like button
              InkWell(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                    _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: _isLiked ? Colors.red : Colors.grey[400],
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatCount(_likeCount),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 24),
              
              // Dislike button
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.thumb_down_outlined,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
              
              const SizedBox(width: 24),
              
              // Comment button
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatCount(widget.comments),
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Share button
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.share_outlined,
                  color: Colors.grey[400],
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
