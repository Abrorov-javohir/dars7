class Book {
  final int id;
  final String title;
  final String url;
  final bool isDownloaded;
  final String saveUrl;

  Book({
    required this.id,
    required this.title,
    required this.url,
    this.isDownloaded = false,
    this.saveUrl = "",
  });
}
