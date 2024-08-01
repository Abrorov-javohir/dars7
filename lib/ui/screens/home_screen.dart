import 'package:dars7/data/model/book.dart';
import 'package:dars7/ui/widgets/book_card10.dart';
import 'package:dars7/ui/widgets/book_card4.dart';
import 'package:dars7/ui/widgets/book_card5.dart';
import 'package:dars7/ui/widgets/book_card6.dart';
import 'package:dars7/ui/widgets/book_card7.dart';
import 'package:dars7/ui/widgets/book_card8.dart';
import 'package:dars7/ui/widgets/book_card9.dart';
import 'package:flutter/material.dart';
import 'package:dars7/ui/widgets/book_card1.dart';
import 'package:dars7/ui/widgets/book2_card.dart';
import 'package:dars7/ui/widgets/book_card3.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [
    Book(id: 1, title: '15 Yoshli Kapitan', url: 'assets/book1.png'),
    Book(id: 2, title: 'Sariq Devni Minib', url: 'assets/book2.png'),
    Book(id: 3, title: "O'tgan Kunlar", url: 'assets/book3.png'),
    Book(id: 4, title: "Besh Bolali Yigitcha", url: 'assets/book4.png'),
    Book(
        id: 5,
        title: "Urush Tugasa Ayting, Qaytib Kelaman",
        url: 'assets/book5.png'),
    Book(id: 6, title: "Urushning Birinchi Kuni", url: 'assets/book6.png'),
    Book(id: 7, title: "Yo'lchi", url: 'assets/book7.png'),
    Book(id: 8, title: "Tanlov", url: 'assets/book8.png'),
    Book(id: 9, title: "Oqibat", url: 'assets/book9.png'),
    Book(id: 10, title: "So'ngi Sahifa", url: 'assets/book10.png'),
    // Add more books here
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Book> filteredBooks = books
        .where((book) =>
            book.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Book",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_sharp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Message',
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Best Sellers",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  switch (book.id % 10) {
                    case 1:
                      return const BookCard1();
                    case 2:
                      return const Book2Card();
                    case 3:
                      return const BookCard3();
                    case 4:
                      return const BookCard4();
                    case 5:
                      return const BookCard5();
                    case 6:
                      return const BookCard6();
                    case 7:
                      return const BookCard7();
                    case 8:
                      return const BookCard8();
                    case 9:
                      return const BookCard9();
                    case 0:
                      return const BookCard10();
                    default:
                      return const SizedBox(); // Default case if no match
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
