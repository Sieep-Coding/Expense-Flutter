import 'package:flutter/material.dart';
import 'package:openfred/models/quote.dart';
import 'package:openfred/services/quote_service.dart';
import 'package:openfred/widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quote> quotes = QuoteService.quotes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Philosophy Quotes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return QuoteCard(quote: quotes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}