class VideoModel {
  final String id;
  final String title;
  final String channelName;
  final String channelAvatar;
  final String thumbnail;
  final String views;
  final String uploadTime;
  final String duration;

  VideoModel({
    required this.id,
    required this.title,
    required this.channelName,
    required this.channelAvatar,
    required this.thumbnail,
    required this.views,
    required this.uploadTime,
    required this.duration,
  });
}

class ShortModel {
  final String id;
  final String title;
  final String thumbnail;

  ShortModel({
    required this.id,
    required this.title,
    required this.thumbnail,
  });
}

// Demo data
final List<VideoModel> demoVideos = [
  VideoModel(
    id: '1',
    title: 'Exploring the Alps: A Hiker\'s Journey',
    channelName: 'AdventureVlogs',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/alps.jpg',
    views: '2M views',
    uploadTime: '3 days ago',
    duration: '8:53',
  ),  VideoModel(
    id: '1',
    title: 'Exploring the Alps: A Hiker\'s Journey',
    channelName: 'AdventureVlogs',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/alps.jpg',
    views: '2M views',
    uploadTime: '3 days ago',
    duration: '8:53',
  ),  VideoModel(
    id: '1',
    title: 'Exploring the Alps: A Hiker\'s Journey',
    channelName: 'AdventureVlogs',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/alps.jpg',
    views: '2M views',
    uploadTime: '3 days ago',
    duration: '8:53',
  ),  VideoModel(
    id: '1',
    title: 'Exploring the Alps: A Hiker\'s Journey',
    channelName: 'AdventureVlogs',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/alps.jpg',
    views: '2M views',
    uploadTime: '3 days ago',
    duration: '8:53',
  ),  VideoModel(
    id: '1',
    title: 'Exploring the Alps: A Hiker\'s Journey',
    channelName: 'AdventureVlogs',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/alps.jpg',
    views: '2M views',
    uploadTime: '3 days ago',
    duration: '8:53',
  ),
  VideoModel(
    id: '2',
    title: 'The Perfect Pasta Carbonara Recipe',
    channelName: 'Chef\'s Kitchen',
    channelAvatar: 'C',
    thumbnail: 'assets/thumbnails/pasta.jpg',
    views: '500K views',
    uploadTime: '1 week ago',
    duration: '12:34',
  ),
  VideoModel(
    id: '3',
    title: 'Cyberpunk 2077 - Next-Gen Graphics Mod',
    channelName: 'GameReviews',
    channelAvatar: 'G',
    thumbnail: 'assets/thumbnails/cyberpunk.jpg',
    views: '1.2M views',
    uploadTime: '2 days ago',
    duration: '15:42',
  ),
  VideoModel(
    id: '4',
    title: 'Learn Digital Painting in 20 Minutes',
    channelName: 'ArtMastery',
    channelAvatar: 'A',
    thumbnail: 'assets/thumbnails/painting.jpg',
    views: '850K views',
    uploadTime: '5 days ago',
    duration: '20:15',
  ),
];

final List<ShortModel> demoShorts = [
  ShortModel(
    id: '1',
    title: 'Grumpy Cat in Sweater',
    thumbnail: 'assets/shorts/cat.jpg',
  ),
  ShortModel(
    id: '2',
    title: 'JavaScript Fire Fact',
    thumbnail: 'assets/shorts/js.jpg',
  ),
  ShortModel(
    id: '3',
    title: 'Mountain Views',
    thumbnail: 'assets/shorts/mountain.jpg',
  ),
];
