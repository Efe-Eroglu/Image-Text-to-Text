import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image2Text',
      theme: ThemeData(
        primaryColor: const Color(0xFFb68cbf),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFb68cbf)),
      ),
      home: const Image2TextHomePage(),
    );
  }
}

class Image2TextHomePage extends StatefulWidget {
  const Image2TextHomePage({Key? key}) : super(key: key);

  @override
  _Image2TextHomePageState createState() => _Image2TextHomePageState();
}

class _Image2TextHomePageState extends State<Image2TextHomePage> {
  int _selectedIndex = 0; // Bottom Navigation'da seçili sayfa
  String recognizedText = ''; // Model çıktısını burada göstereceğiz
  bool isLoading = false; // Yükleme durumunu göstermek için

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Modern ve tam genişlikte header
          Container(
            width: double.infinity, // Header'ı tam genişlikte yapar
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            decoration: const BoxDecoration(
              color: Color(0xFFb68cbf),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Image2Text',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Resim seçin veya fotoğraf çekin',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Görüntü alma butonları
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galeriden Seç'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb68cbf), // 'primary' yerine 'backgroundColor' kullanılıyor
                          foregroundColor: Colors.white, // 'onPrimary' yerine 'foregroundColor' kullanılıyor
                        ),
                        onPressed: () {
                          // Galeriden resim seçme fonksiyonu burada olacak
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Fotoğraf Çek'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFb68cbf), // 'primary' yerine 'backgroundColor' kullanılıyor
                          foregroundColor: Colors.white, // 'onPrimary' yerine 'foregroundColor' kullanılıyor
                        ),
                        onPressed: () {
                          // Kamera açma fonksiyonu burada olacak
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Seçilen resim veya yükleme durumu
                  isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFb68cbf)) // Yükleme durumunu gösterir
                      : recognizedText.isNotEmpty
                          ? Column(
                              children: [
                                const Text(
                                  'Tanımlanan Metin:',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  recognizedText,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : const Text('Henüz bir resim işlenmedi.'),
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Geçmiş',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFb68cbf),
        onTap: _onItemTapped,
      ),
    );
  }
}
