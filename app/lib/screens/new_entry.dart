import 'package:app/controller/book_controller.dart';
import 'package:app/models/google_book.dart';
import 'package:app/models/personal_book.dart';
import 'package:flutter/material.dart';
import 'components/date_input.dart';
import 'components/display_text.dart';
import 'components/entry.dart';
import 'components/primary_button.dart';
import 'theme/theme.dart';

import 'home.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key, required this.googleBook});
  final GoogleBook googleBook;

  @override
  State<NewEntry> createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final _formKey = GlobalKey<FormState>();
  final BookController bookController = BookController();
  final TextEditingController initialDateController = TextEditingController();
  final TextEditingController finalDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  late GoogleBook googleBook;
  @override
  void initState() {
    super.initState();
    googleBook = widget.googleBook;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: AppBackgroundProperties.boxDecoration,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(backgroundColor: AppColors.black),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: DisplayText("Adicionando um Livro"),
                ),
                SizedBox(
                  width: 244,
                  child: Column(
                    children: <Widget>[
                      Entry(googleBook: googleBook),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Text(googleBook.description),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: DateInput(
                                textController: initialDateController,
                                label: "Início da Leitura",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: DateInput(
                                textController: finalDateController,
                                label: "Final da Leitura",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: TextFormField(
                                controller: commentsController,
                                decoration:
                                    InputDecorationProperties.newInputDecoration(
                                      "",
                                      "Comentários",
                                    ),
                                maxLines: 5,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: PrimaryButton(
                                text: "Adicionar",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Adicionando livro..."),
                                      ),
                                    );
                                  }
                                  PersonalBook personalBook = PersonalBook(
                                    googleBook: googleBook,
                                    comments: commentsController.text,
                                    dayStarted: initialDateController.text,
                                    dayFinished: finalDateController.text,
                                  );
                                  bookController.save(personalBook);

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                    (_) => false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
