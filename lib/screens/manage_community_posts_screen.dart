import 'package:flutter/material.dart';

class ManageCommunityPostsScreen extends StatefulWidget {
  const ManageCommunityPostsScreen({super.key});

  @override
  State<ManageCommunityPostsScreen> createState() => _ManageCommunityPostsScreenState();
}

class _ManageCommunityPostsScreenState extends State<ManageCommunityPostsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedAttachment;
  List<String>? _pollOptions;
  DateTime? _scheduledDateTime;
  final List<Map<String, dynamic>> _posts = [
    {
      'title': 'Weekly livestream tonight!',
      'content': 'Join us at 8PM for our AMA livestream. Drop your questions below!',
      'likes': 1250,
      'comments': 342,
      'status': 'Published',
      'scheduled': null,
      'image': 'assets/community/live_stream.png',
      'publishedAt': '2 hours ago',
    },
    {
      'title': 'Sneak peek: new project',
      'content': 'Working on something exciting. Can you guess what it is from this teaser image?',
      'likes': 980,
      'comments': 210,
      'status': 'Scheduled',
      'scheduled': 'Dec 20 • 10:00 AM',
      'image': 'assets/community/teaser.png',
      'publishedAt': null,
    },
    {
      'title': 'Community Poll',
      'content': 'What type of content should we prioritize in January? Vote below! ✅ Tutorials ✅ Reviews ✅ Livestream Q&A',
      'likes': 545,
      'comments': 198,
      'status': 'Draft',
      'scheduled': null,
      'image': null,
      'publishedAt': null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          'Manage Community Posts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[500],
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Published'),
            Tab(text: 'Scheduled'),
            Tab(text: 'Drafts'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePostSheet(),
        backgroundColor: Colors.red,
        label: const Text('Create post'),
        icon: const Icon(Icons.add),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostsList('Published'),
          _buildPostsList('Scheduled'),
          _buildPostsList('Draft'),
        ],
      ),
    );
  }

  Widget _buildPostsList(String filter) {
    final filtered = _posts.where((post) => post['status'] == filter).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              filter == 'Published'
                  ? Icons.campaign_outlined
                  : filter == 'Scheduled'
                      ? Icons.schedule_outlined
                      : Icons.article_outlined,
              color: Colors.grey[600],
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              filter == 'Published'
                  ? 'No published posts yet'
                  : filter == 'Scheduled'
                      ? 'No scheduled posts'
                      : 'No drafts',
              style: TextStyle(color: Colors.grey[400], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap "Create post" to get started.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final post = filtered[index];
        return _buildPostCard(post);
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[850]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              post['title'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  post['content'],
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (post['publishedAt'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Published ${post['publishedAt']}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
                if (post['scheduled'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Scheduled for ${post['scheduled']}',
                    style: const TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () => _showPostOptions(post),
            ),
          ),
          if (post['image'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Image.asset(
                post['image'],
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[850],
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined, color: Colors.white54, size: 32),
                    ),
                  );
                },
              ),
            )
          else
            const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildStatChip(Icons.thumb_up_alt_outlined, post['likes']),
                _buildStatChip(Icons.comment_outlined, post['comments']),
                TextButton.icon(
                  onPressed: () => _handleEditPost(post),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                ),
                TextButton.icon(
                  onPressed: () => _showPostInsights(post),
                  icon: const Icon(Icons.bar_chart_outlined, size: 18),
                  label: const Text('Insights'),
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            _formatNumber(value),
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.visibility, color: Colors.white),
                title: const Text('View post', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Colors.white),
                title: const Text('Edit post', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context),
              ),
              if (post['status'] == 'Published')
                ListTile(
                  leading: const Icon(Icons.unpublished_outlined, color: Colors.white),
                  title: const Text('Unpublish', style: TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context),
                ),
              if (post['status'] == 'Scheduled')
                ListTile(
                  leading: const Icon(Icons.schedule_outlined, color: Colors.white),
                  title: const Text('Reschedule', style: TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context),
                ),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.redAccent),
                title: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showCreatePostSheet() {
    _openPostComposer();
  }

  Future<void> _openPostComposer({Map<String, dynamic>? editingPost}) async {
    final isEditing = editingPost != null;
    final contentController = TextEditingController(text: editingPost?['content'] ?? '');

    final existingPolls = editingPost != null ? editingPost['pollOptions'] : null;
    final existingImage = editingPost != null ? editingPost['image'] : null;

    setState(() {
      _selectedAttachment = existingImage is String ? existingImage : null;
      _pollOptions = existingPolls is List ? List<String>.from(existingPolls.cast<String>()) : null;
      _scheduledDateTime = null;
    });

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DraggableScrollableSheet(
            initialChildSize: 0.85,
            maxChildSize: 0.95,
            minChildSize: 0.6,
            expand: false,
            builder: (context, controller) {
              return SingleChildScrollView(
                controller: controller,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 48,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Text(
                        isEditing ? 'Edit community post' : 'Create community post',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: contentController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Share something with your community...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.grey[850],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _buildCreateActionButton(
                            Icons.image_outlined,
                            'Image',
                            _handleAddImage,
                          ),
                          _buildCreateActionButton(
                            Icons.poll_outlined,
                            'Poll',
                            _handleCreatePoll,
                          ),
                          _buildCreateActionButton(
                            Icons.calendar_month_outlined,
                            'Schedule',
                            _handleSchedulePost,
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.save_outlined, color: Colors.white),
                          ),
                        ],
                      ),
                      if (_selectedAttachment != null || _pollOptions != null || _scheduledDateTime != null) ...[
                        const SizedBox(height: 16),
                        _buildAttachmentSummary(),
                      ],
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey[700]!),
                              ),
                              child: Text(isEditing ? 'Discard changes' : 'Save draft'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final updatedContent = contentController.text.trim();
                                if (updatedContent.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Post content cannot be empty'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }

                                if (editingPost != null) {
                                  final updatedPost = editingPost;
                                  setState(() {
                                    updatedPost['content'] = updatedContent;
                                    updatedPost['image'] = _selectedAttachment;
                                    if (_scheduledDateTime != null) {
                                      updatedPost['scheduled'] = _formatScheduleLabel(_scheduledDateTime!);
                                    } else {
                                      updatedPost['scheduled'] = null;
                                    }
                                    if (_pollOptions != null) {
                                      updatedPost['pollOptions'] = List<String>.from(_pollOptions!);
                                    } else {
                                      updatedPost.remove('pollOptions');
                                    }
                                  });
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Post updated'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Draft saved for review'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(isEditing ? 'Save changes' : 'Publish'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    contentController.dispose();

    if (!mounted) return;
    setState(() {
      _selectedAttachment = null;
      _pollOptions = null;
      _scheduledDateTime = null;
    });
  }

  Widget _buildCreateActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white70, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return value.toString();
    }
  }

  Future<void> _handleAddImage() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final options = ['Channel banner', 'Behind the scenes', 'Teaser artwork'];
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Attach image',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              ...options.map(
                (option) => ListTile(
                  leading: const Icon(Icons.image_outlined, color: Colors.white),
                  title: Text(option, style: const TextStyle(color: Colors.white)),
                  onTap: () => Navigator.pop(context, option),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.link_outlined, color: Colors.white),
                title: const Text('Use image link…', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context, 'Custom image link'),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );

    if (!mounted || selected == null) return;
    setState(() {
      _selectedAttachment = selected;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image attached: $selected'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _handleCreatePoll() async {
    String optionOne = '';
    String optionTwo = '';
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Create poll', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                onChanged: (value) => optionOne = value,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Option 1',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (value) => optionTwo = value,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Option 2',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Colors.grey[850],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Save', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      final options = [optionOne.trim(), optionTwo.trim()]
          .where((value) => value.isNotEmpty)
          .toList();
      if (options.length >= 2) {
        setState(() {
          _pollOptions = options;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Poll added to your post'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  Future<void> _handleSchedulePost() async {
    final now = DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(primary: Colors.red),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate == null) return;

    final selectedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(primary: Colors.red),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime == null) return;

    final scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    setState(() {
      _scheduledDateTime = scheduledDateTime;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Post scheduled for ${_formatScheduleLabel(scheduledDateTime)}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Widget _buildAttachmentSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!),
      ),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Post additions',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          if (_selectedAttachment != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.image_outlined, color: Colors.white70),
              title: Text(_selectedAttachment!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  setState(() {
                    _selectedAttachment = null;
                  });
                },
              ),
            ),
          if (_pollOptions != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.poll_outlined, color: Colors.white70),
              title: Text(
                'Poll: ${_pollOptions!.join(' vs ')}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  setState(() {
                    _pollOptions = null;
                  });
                },
              ),
            ),
          if (_scheduledDateTime != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.calendar_month_outlined, color: Colors.white70),
              title: Text(
                'Scheduled for ${_formatScheduleLabel(_scheduledDateTime!)}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () {
                  setState(() {
                    _scheduledDateTime = null;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }

  String _formatScheduleLabel(DateTime dateTime) {
    final timeOfDay = TimeOfDay.fromDateTime(dateTime);
    final hourLabel = timeOfDay.format(context);
    return '${dateTime.month}/${dateTime.day}/${dateTime.year} at $hourLabel';
  }

  Future<void> _handleEditPost(Map<String, dynamic> post) async {
    await _openPostComposer(editingPost: post);
  }

  Future<void> _showPostInsights(Map<String, dynamic> post) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Post insights', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInsightRow('Likes', post['likes'].toString()),
              _buildInsightRow('Comments', post['comments'].toString()),
              _buildInsightRow('Status', post['status']),
              if (post['publishedAt'] != null)
                _buildInsightRow('Published', post['publishedAt']),
              if (post['scheduled'] != null)
                _buildInsightRow('Scheduled', post['scheduled']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInsightRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
