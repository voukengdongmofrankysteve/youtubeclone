import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'recent_videos_screen.dart';
import 'all_playlists_screen.dart';
import 'create_playlist_screen.dart';
import 'playlist_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
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
            
            // Tabs
            _buildTabs(),
            
            // Content
            Expanded(
              child: _buildTabContent(),
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
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.red,
            child: Icon(Icons.video_library, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          const Text(
            'Library',
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

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTab('History', 0, Icons.history),
          const SizedBox(width: 12),
          _buildTab('Your videos', 1, Icons.play_arrow),
          const SizedBox(width: 12),
          _buildTab('Downloads', 2, Icons.download_outlined),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildHistoryContent();
      case 1:
        return _buildYourVideosContent();
      case 2:
        return _buildDownloadsContent();
      default:
        return _buildHistoryContent();
    }
  }

  Widget _buildHistoryContent() {
    return ListView(
      padding: const EdgeInsets.only(top: 16),
      children: [
        // Recent section
        _buildRecentSection(),
        
        const SizedBox(height: 24),
        
        // Playlists section
        _buildPlaylistsSection(),
      ],
    );
  }

  Widget _buildYourVideosContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Your Videos header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Videos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Sort',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Video items
        _buildVideoItem(
          title: 'My First Vlog - Amazing Experience',
          views: '1.2K views',
          uploadTime: '2 days ago',
          duration: '8:45',
        ),
        const SizedBox(height: 16),
        _buildVideoItem(
          title: 'Tutorial: How to Build a Mobile App',
          views: '856 views',
          uploadTime: '1 week ago',
          duration: '15:30',
        ),
        const SizedBox(height: 16),
        _buildVideoItem(
          title: 'Travel Diary - Summer Adventure',
          views: '2.5K views',
          uploadTime: '3 weeks ago',
          duration: '12:20',
        ),
        const SizedBox(height: 16),
        _buildVideoItem(
          title: 'Cooking Delicious Pasta',
          views: '432 views',
          uploadTime: '1 month ago',
          duration: '6:15',
        ),
      ],
    );
  }

  Widget _buildDownloadsContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Downloads header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Downloads',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Manage',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Download items
        _buildVideoItem(
          title: 'Advanced Flutter Development',
          views: '3.2M views',
          uploadTime: 'Downloaded 1 day ago',
          duration: '45:20',
          showDownloadIcon: true,
        ),
        const SizedBox(height: 16),
        _buildVideoItem(
          title: 'UI Design Masterclass',
          views: '1.8M views',
          uploadTime: 'Downloaded 3 days ago',
          duration: '32:15',
          showDownloadIcon: true,
        ),
        const SizedBox(height: 16),
        _buildVideoItem(
          title: 'React Native Complete Course',
          views: '950K views',
          uploadTime: 'Downloaded 1 week ago',
          duration: '2:15:30',
          showDownloadIcon: true,
        ),
      ],
    );
  }

  Widget _buildVideoItem({
    required String title,
    required String views,
    required String uploadTime,
    required String duration,
    bool showDownloadIcon = false,
  }) {
    return Row(
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
                views,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                uploadTime,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        
        // More options or download icon
        IconButton(
          icon: Icon(
            showDownloadIcon ? Icons.download_done : Icons.more_vert,
            color: Colors.grey[400],
          ),
          onPressed: () {},
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  Widget _buildRecentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecentVideosScreen(),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 155,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildRecentVideoCard(
                'The amazing world of abstract art',
                '143K views',
                'assets/thumbnails/alps.jpg',
              ),
              const SizedBox(width: 12),
              _buildRecentVideoCard(
                'Exploring the City of the Future',
                '532K views',
                'assets/thumbnails/pasta.jpg',
              ),
              const SizedBox(width: 12),
              _buildRecentVideoCard(
                'Modern Architecture',
                '287K views',
                'assets/thumbnails/alps.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentVideoCard(String title, String views, String thumbnail) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: 160,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                thumbnail,
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
          const SizedBox(height: 8),
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
          const SizedBox(height: 2),
          Text(
            views,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Playlists',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllPlaylistsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildPlaylistItem(
          icon: Icons.watch_later_outlined,
          title: 'Watch Later',
          videoCount: '0 videos',
        ),
        _buildPlaylistItem(
          icon: Icons.thumb_up_outlined,
          title: 'Liked Videos',
          videoCount: '248 videos',
        ),
        _buildPlaylistItem(
          icon: Icons.playlist_play,
          title: 'Cooking Recipes',
          videoCount: '45 videos',
          hasCustomThumbnail: true,
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OutlinedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreatePlaylistScreen(),
                ),
              );
              
              if (result != null && mounted) {
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
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'New Playlist',
              style: TextStyle(color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[700]!),
              backgroundColor: Colors.transparent,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPlaylistItem({
    required IconData icon,
    required String title,
    required String videoCount,
    bool hasCustomThumbnail = false,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailScreen(
              playlistTitle: title,
              playlistIcon: icon,
              videoCount: int.parse(videoCount.split(' ')[0]),
              hasCustomThumbnail: hasCustomThumbnail,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
        children: [
          // Thumbnail
          Container(
            width: 70,
            height: 50,
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
                        return Icon(icon, color: Colors.white54, size: 24);
                      },
                    ),
                  )
                : Icon(icon, color: Colors.white54, size: 24),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
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
          Icon(Icons.chevron_right, color: Colors.grey[600]),
        ],
      ),
      ),
    );
  }
}
