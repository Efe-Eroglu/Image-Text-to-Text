import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String extractedText = "";
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        extractedText = "Sample Text";
      });
      Provider.of<HistoryProvider>(context, listen: false)
          .addHistoryItem(pickedFile.path, extractedText);
    }
  }

  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        extractedText = "Sample Text";
      });
      Provider.of<HistoryProvider>(context, listen: false)
          .addHistoryItem(pickedFile.path, extractedText);
    }
  }

  void _copyText() {
    if (extractedText.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: extractedText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Text copied")),
      );
    }
  }

  Widget _buildGradientButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
  }) {
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
        onPressed: onPressed ?? () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildGradientButton(
                  onPressed: _pickImage,
                  icon: Icons.photo,
                  label: "From Gallery",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildGradientButton(
                  onPressed: _captureImage,
                  icon: Icons.camera_alt,
                  label: "Take Photo",
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity, // Genişliği tam ekran yap
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView( // Uzun metinlerin kaydırılmasını sağla
                child: Text(
                  extractedText.isNotEmpty
                      ? extractedText
                      : "Select an image or take a photo to extract the text.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Opacity(
            opacity: extractedText.isNotEmpty ? 1.0 : 0.5,
            child: _buildGradientButton(
              onPressed: extractedText.isNotEmpty ? _copyText : null,
              icon: Icons.copy,
              label: "Copy Text",
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
