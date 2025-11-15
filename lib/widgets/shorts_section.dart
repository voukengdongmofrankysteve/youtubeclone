import 'package:flutter/material.dart';
import '../models/video_model.dart';

class ShortsSection extends StatelessWidget {
  final Function(int)? onTabChange;
  
  const ShortsSection({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shorts header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                Icons.play_arrow,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Shorts',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        
        // Horizontal scrollable shorts
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: demoShorts.length,
            itemBuilder: (context, index) {
              final short = demoShorts[index];
              return _ShortCard(
                short: short,
                onTap: () => onTabChange?.call(1),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ShortCard extends StatelessWidget {
  final ShortModel short;
  final VoidCallback? onTap;

  const _ShortCard({required this.short, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Short thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                color: Colors.grey[900],
                child: Image.asset(
                  short.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
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
                      child: const Center(
                        child: Icon(
                          Icons.play_arrow,
                          size: 48,
                          color: Colors.white54,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Short title
          Text(
            short.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        ),
      ),
    );
  }
}
