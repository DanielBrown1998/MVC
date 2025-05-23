import 'package:app/models/google_book.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/components/display_text.dart';
import 'package:app/screens/components/entry.dart';
import 'package:app/screens/components/primary_button.dart';
import 'package:app/screens/new_entry.dart';
import 'package:app/services/google_book_service.dart';
import 'package:app/screens/theme/theme.dart';

class SearchBooks extends StatefulWidget {
  const SearchBooks({super.key});

  @override
  State<SearchBooks> createState() => _SearchBooksState();
}

class _SearchBooksState extends State<SearchBooks> {
  final GoogleBooksService googleBooksService = GoogleBooksService();
  TextEditingController search = TextEditingController();
  // Need to change list type
  Future<List<GoogleBook>>? booksList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: AppBackgroundProperties.boxDecoration,
        child: Scaffold(
          appBar: AppBar(backgroundColor: AppColors.black),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: <Widget>[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                    child: DisplayText("Adicionar Livro"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: TextFormField(
                      controller: search,
                      onChanged: (value) {
                        search.text = value;
                        //Populate list of books from API
                        setState(() {
                          booksList = googleBooksService.searchBooks(
                            search.text,
                          );
                        });
                      },
                      decoration: InputDecorationProperties.newInputDecoration(
                        "Procure por título/autor(a)",
                        "Busca",
                        const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                (booksList == null)
                    ? const SliverToBoxAdapter()
                    : _BooksList(future: booksList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BooksList extends StatelessWidget {
  const _BooksList({required this.future});

  // Need to change list type
  final Future<List<GoogleBook>>? future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;

          case ConnectionState.waiting:
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );

          case ConnectionState.active:
            break;

          case ConnectionState.done:
            if (snapshot.hasData || snapshot.data != []) {
              return SliverList.builder(
                itemBuilder:
                    (context, index) => Container(
                      constraints: BoxConstraints(maxWidth: double.maxFinite),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => Dialog(
                                  insetPadding: const EdgeInsets.all(16),
                                  clipBehavior: Clip.hardEdge,
                                  shape: ModalDecorationProperties.modalBorder,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                child: const Icon(Icons.close),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 24.0,
                                          ),
                                          child: DisplayText(
                                            "Detalhes do Livro",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: Image.network(
                                            snapshot.data![index].thumbnailLink,
                                            height: 220,
                                            width: 144,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) =>
                                                    CircularProgressIndicator(),
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return Image.asset(
                                                "assets/images/grimorio.png",
                                                height: 220,
                                                width: 144,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8.0,
                                          ),
                                          child: Text(
                                            snapshot.data![index].title,
                                            style:
                                                ModalDecorationProperties
                                                    .bookTitle,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: SizedBox(
                                            width: double.maxFinite,
                                            child: Text(
                                              snapshot.data![index].authors,
                                              style:
                                                  ModalDecorationProperties
                                                      .bookAuthor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 24.0,
                                          ),
                                          child: Text(
                                            snapshot.data![index].description,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        PrimaryButton(
                                          text: "Adicionar livro",
                                          onTap: () {
                                            GoogleBook book =
                                                snapshot.data![index];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => NewEntry(
                                                      googleBook: book,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: Entry(googleBook: snapshot.data![index]),
                      ),
                    ),
                itemCount: snapshot.data!.length,
              );
            }
            break;
        }
        return const SliverToBoxAdapter();
      },
    );
  }
}
