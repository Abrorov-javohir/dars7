import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({Key? key}) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isDownloaded = false;
  double downloadProgress = 0.0;
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "15 Yoshli Kapitan",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Jyul Vern",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/book1.png",
                        width: 160,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow[700], size: 20),
                      const SizedBox(width: 4),
                      const Text(
                        "4.8",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      "Fantasy",
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    "432 Pages",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Konspekt",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                """
1873-yilning ikkinchi fevralida «Piligrim» nomli shxuna-brig\ndengizda Grinvichdan hisoblaganda 43°57' janubiy kenglikdagi\nva 165°19' g‘arbiy uzunlikdagi nuqtada edi. Bosim kuchi to‘rt\nyuz tonna keladigan bu kema janubiy dengizlarda kit ovlash\nuchun San-Fransisko shahrida safarga tayyorlangan edi.""",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () async {
              if (!isDownloaded) {
                await _downloadFile();
              } else if (filePath != null) {
                await OpenFilex.open(filePath!);
              }
            },
            child: Text(
              isDownloaded ? "Open" : "Download",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadFile() async {
    final url =
        'https://kitobsevar.uz/kxpv/xrpt_kpvz9sziuy0e08xt3deo2702s08n1cuasf1ryo1id1mdyaxoe356z5xg5tvtxfufkkx92mg5cu8.pdf'; // Replace with your file URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloaded_file.pdf');
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        filePath = file.path;
        isDownloaded = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Download Complete"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to download file"),
        ),
      );
    }
  }
}