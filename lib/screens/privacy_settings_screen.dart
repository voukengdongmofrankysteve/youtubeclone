import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  bool _watchHistoryEnabled = true;
  bool _searchHistoryEnabled = true;
  bool _personalizedAdsEnabled = true;
  bool _activityTracking = true;
  bool _locationSharing = false;
  String _defaultVideoPrivacy = 'Public';

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
          'Privacy Settings',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Account Privacy'),
            _buildSwitchTile('Watch History', 'Save videos you watch', _watchHistoryEnabled, (v) => setState(() => _watchHistoryEnabled = v)),
            _buildSwitchTile('Search History', 'Save your searches', _searchHistoryEnabled, (v) => setState(() => _searchHistoryEnabled = v)),
            _buildNavigationTile(Icons.history, 'Clear Watch History', 'Remove all videos', () => _showClearDialog('watch history')),
            _buildNavigationTile(Icons.search_off, 'Clear Search History', 'Remove all searches', () => _showClearDialog('search history')),
            
            const Divider(height: 32, color: Colors.grey),
            _buildSectionHeader('Data & Personalization'),
            _buildSwitchTile('Personalized Ads', 'See ads based on activity', _personalizedAdsEnabled, (v) => setState(() => _personalizedAdsEnabled = v)),
            _buildSwitchTile('Activity Tracking', 'Better recommendations', _activityTracking, (v) => setState(() => _activityTracking = v)),
            _buildSwitchTile('Location Sharing', 'Local content', _locationSharing, (v) => setState(() => _locationSharing = v)),
            _buildNavigationTile(Icons.download, 'Download Your Data', 'Get a copy of your data', () {}),
            
            const Divider(height: 32, color: Colors.grey),
            _buildSectionHeader('Video Privacy'),
            _buildDropdownTile('Default Upload Privacy', _defaultVideoPrivacy, ['Public', 'Unlisted', 'Private'], (v) => setState(() => _defaultVideoPrivacy = v!)),
            _buildNavigationTile(Icons.visibility, 'Manage Video Visibility', 'Control who can see', () {}),
            _buildNavigationTile(Icons.comment, 'Comment Settings', 'Manage comments', () {}),
            
            const Divider(height: 32, color: Colors.grey),
            _buildSectionHeader('Account Security'),
            _buildNavigationTile(Icons.lock, 'Change Password', 'Update password', () {}),
            _buildNavigationTile(Icons.security, 'Two-Factor Authentication', 'Extra security', () {}),
            _buildNavigationTile(Icons.devices, 'Manage Devices', 'See where signed in', () {}),
            _buildNavigationTile(Icons.block, 'Blocked Accounts', 'Manage blocked users', () {}),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
  );

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) => SwitchListTile(
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
    subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
    value: value,
    onChanged: onChanged,
    activeColor: Colors.red,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  );

  Widget _buildNavigationTile(IconData icon, String title, String subtitle, VoidCallback onTap) => ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
    subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
    trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
    onTap: onTap,
  );

  Widget _buildDropdownTile(String title, String value, List<String> items, Function(String?) onChanged) => ListTile(
    title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15)),
    trailing: DropdownButton<String>(
      value: value,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      underline: Container(),
      items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    ),
  );

  void _showClearDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Clear $type?', style: const TextStyle(color: Colors.white)),
        content: Text('This will remove all items from your $type.', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: TextStyle(color: Colors.grey[400]))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${type.capitalize()} cleared'), backgroundColor: Colors.green));
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
