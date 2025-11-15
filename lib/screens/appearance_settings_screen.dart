import 'package:flutter/material.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() =>
      _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
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
          'Appearance',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            _buildSectionHeader('Theme'),
            _buildSwitchTile(
              'Use device theme',
              'Follow system dark mode settings',
              false,
              (value) {},
            ),

            _buildRadioTile('Light', false, () {}),
            _buildRadioTile('Dark', false, () {}),

            _buildSwitchTile(
              'True dark mode',
              'Pure black background for OLED screens',
              false,
              (value) {},
            ),

            const Divider(height: 32, color: Colors.grey),

            // Video Playback
            _buildSectionHeader('Video Playback'),
            _buildDropdownTile('Video quality preferences', 'Auto', [
              'Auto',
              '144p',
              '240p',
              '360p',
              '480p',
              '720p',
              '1080p',
            ], (value) {}),
            _buildSwitchTile(
              'Save data mode',
              'Reduce video quality on mobile data',
              false,
              (value) {},
            ),
            _buildSwitchTile(
              'Auto-play videos',
              'Start playing videos automatically',
              false,
              (value) {},
            ),
            _buildSwitchTile(
              'Play in background',
              'Continue playing when app is minimized',
              false,
              (value) {},
            ),

            const Divider(height: 32, color: Colors.grey),

            // Navigation
            _buildSectionHeader('Navigation'),
            _buildDropdownTile('Default home tab', 'Home', [
              'Home',
              'Shorts',
              'Subscriptions',
              'Library',
            ], (value) {}),
            _buildNavigationTile(
              Icons.tune,
              'Customize tabs',
              'Choose which tabs to show',
              () {},
            ),

            const Divider(height: 32, color: Colors.grey),

            // Display
            _buildSectionHeader('Display'),
            _buildNavigationTile(
              Icons.text_fields,
              'Text size',
              'Adjust caption and subtitle size',
              () {},
            ),
            _buildNavigationTile(
              Icons.closed_caption,
              'Captions',
              'Customize caption appearance',
              () {},
            ),
            _buildNavigationTile(
              Icons.format_list_bulleted,
              'Feed preferences',
              'Customize your home feed',
              () {},
            ),

            const Divider(height: 32, color: Colors.grey),

            // Preview
            _buildSectionHeader('Preview'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[800]!),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.red,
                          child: const Text(
                            'P',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Preview Video Title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Channel Name • 1M views',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'This is a preview of how videos will appear with your current theme settings.',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[500], fontSize: 12),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.red,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildRadioTile(String title, bool selected, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
        color: selected ? Colors.red : Colors.grey[500],
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      trailing: DropdownButton<String>(
        value: value,
        dropdownColor: Colors.grey[900],
        style: const TextStyle(color: Colors.white),
        underline: Container(),
        items: items.map((String item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildNavigationTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[500], fontSize: 12),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      onTap: onTap,
    );
  }
}
