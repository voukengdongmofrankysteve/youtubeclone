import 'package:flutter/material.dart';
import '../models/video_model.dart';
import 'video_player_screen.dart';
import '../widgets/video_options_menu.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = 'how to build a mobile app';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          'Search Results',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          
          // Filter Chips
          _buildFilterChips(),
          
          const SizedBox(height: 8),
          
          // Search Results
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.grey[400]),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', true),
          const SizedBox(width: 8),
          _buildFilterChip('Videos', false),
          const SizedBox(width: 8),
          _buildFilterChip('Playlists', false),
          const SizedBox(width: 8),
          _buildFilterChip('Sort by', false, hasDropdown: true),
          const SizedBox(width: 8),
          _buildFilterChip('Duration', false, hasDropdown: true),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, {bool hasDropdown = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_drop_down,
                color: isSelected ? Colors.black : Colors.white,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    // Demo search results
    final searchResults = [
      {
        'title': 'Build a Fullstack App in 1 Hour wit...',
        'views': '1.2M views',
        'time': '3 months ago',
        'channel': 'CodeMaster',
        'thumbnail': 'assets/thumbnails/alps.jpg',
      },
      {
        'title': 'React Native for Beginners - ...',
        'views': '890K views',
        'time': '1 year ago',
        'channel': 'DevSimplified',
        'thumbnail': 'assets/thumbnails/pasta.jpg',
      },
      {
        'title': 'Mobile App UI Design in Figma ...',
        'views': '450K views',
        'time': '2 weeks ago',
        'channel': 'DesignPro',
        'thumbnail': 'assets/thumbnails/alps.jpg',
      },
      {
        'title': 'Deploying your Mobile App to th...',
        'views': '2.1M views',
        'time': '4 months ago',
        'channel': 'LaunchPadDev',
        'thumbnail': 'assets/thumbnails/pasta.jpg',
      },
      {
        'title': 'Advanced iOS Development',
        'views': '500K views',
        'time': '1 month ago',
        'channel': 'iOS Academy',
        'thumbnail': 'assets/thumbnails/alps.jpg',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final result = searchResults[index];
        return _buildSearchResultItem(
          title: result['title']!,
          views: result['views']!,
          time: result['time']!,
          channel: result['channel']!,
          thumbnail: result['thumbnail']!,
        );
      },
    );
  }

  Widget _buildSearchResultItem({
    required String title,
    required String views,
    required String time,
    required String channel,
    required String thumbnail,
  }) {
    // Create a VideoModel for navigation
    final video = VideoModel(
      id: 'search_${title.hashCode}',
      title: title,
      channelName: channel,
      channelAvatar: channel[0],
      views: views,
      uploadTime: time,
      duration: '10:25',
      thumbnail: thumbnail,
    );

    return GestureDetector(
      onTap: () {
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
                    '$views • $time',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    channel,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // More options button
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
}
