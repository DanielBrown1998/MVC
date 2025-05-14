import 'package:app/models/google_book.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/theme/theme.dart';

class Entry extends StatelessWidget {
  final GoogleBook googleBook;

  const Entry({super.key, required this.googleBook});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Container(
        constraints: BoxConstraints(maxHeight: 200, maxWidth: double.maxFinite),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.23,
                ),
                child: Image.network(
                  googleBook.thumbnailLink,
                  height: 189,
                  width: 129,
                  fit: BoxFit.cover,
                  // loadingBuilder:
                  //     (context, child, loadingProgress) =>
                  //         CircularProgressIndicator(),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/grimorio.png",
                      height: 189,
                      width: 129,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      googleBook.title,
                      style: EntryDecorationProperties.displayText,
                    ),
                  ),
                  Text(
                    googleBook.authors,
                    style: EntryDecorationProperties.authorText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
