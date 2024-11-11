import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  double _textSize = 16;

  void _restoreDefaults() {
    setState(() {
      _darkMode = false;
      _notificationsEnabled = true;
      _textSize = 16;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        children: [
          const SizedBox(height: 60),
          const Text(
            "Preferences",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GradientSwitchTile(
            title: "Dark Mode",
            subtitle: "Enable or disable dark mode",
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          const Divider(),
          GradientSwitchTile(
            title: "Notifications",
            subtitle: "Enable or disable notifications",
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const SizedBox(height: 24),
          const Text(
            "Text Size",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GradientSliderTile(
            title: "Current: ${_textSize.toStringAsFixed(0)}",
            value: _textSize,
            onChanged: (double newValue) {
              setState(() {
                _textSize = newValue;
              });
            },
          ),
          const Divider(),
          const SizedBox(height: 24),
          GradientButton(
            onPressed: _restoreDefaults,
            text: "Restore Default Settings",
          ),
        ],
      ),
    );
  }
}

class GradientSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const GradientSwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFb68cbf), Color(0xFF8b5fbf)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,  
        inactiveThumbColor: const Color.fromARGB(255, 235, 232, 232),
        inactiveTrackColor: const Color.fromARGB(255, 194, 194, 194),
      ),
    );
  }
}

class GradientSliderTile extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  const GradientSliderTile({
    required this.title,
    required this.value,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFb68cbf), Color(0xFF8b5fbf)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Slider(
            value: value,
            min: 14,
            max: 20,
            divisions: 3,
            label: value.toStringAsFixed(0),
            activeColor: Colors.white,
            inactiveColor: Colors.white70,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFb68cbf), Color(0xFF8b5fbf)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          backgroundColor: const Color.fromARGB(0, 153, 94, 94),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
