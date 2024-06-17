import 'package:openfred/models/quote.dart';

class QuoteService {
  static List<Quote> quotes = [
    Quote(
      text: "The unexamined life is not worth living.",
      author: "Socrates",
    ),
    Quote(
      text: "I think, therefore I am.",
      author: "René Descartes",
    ),
    // Add more quotes here
  ];

  static void likeQuote(Quote quote) {
    quote.likes++;
  }
}