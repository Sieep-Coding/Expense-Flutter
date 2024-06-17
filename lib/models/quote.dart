class Quote {
  final String text;
  final String author;
  int likes;

  Quote({
    required this.text,
    required this.author,
    this.likes = 0,
  });
}