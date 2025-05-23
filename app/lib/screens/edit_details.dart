import 'package:app/models/google_book.dart';
import 'package:app/models/personal_book.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/components/date_input.dart';

import 'theme/theme.dart';
import 'components/display_text.dart';
import 'components/entry.dart';
import 'components/primary_button.dart';

class EditDetails extends StatefulWidget {
  final PersonalBook personalBook;

  const EditDetails({super.key, required this.personalBook});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController initialDateController = TextEditingController();
  final TextEditingController finalDateController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  late GoogleBook googleBook;
  @override
  void initState() {
    super.initState();
    googleBook = widget.personalBook.googleBook;
    // Fill with book info
    if(widget.personalBook.comments != ""){
      commentsController.text = widget.personalBook.comments;
    }
    if(widget.personalBook.dayStarted != ""){
      initialDateController.text = widget.personalBook.dayStarted;
    }
    if(widget.personalBook.dayFinished != ""){
      finalDateController.text = widget.personalBook.dayFinished;
    }
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
                  child: DisplayText("Editando o Livro"),
                ),
                SizedBox(
                  width: 244,
                  child: Column(
                    children: <Widget>[
                      Entry(googleBook: googleBook),
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
                                text: "Salvar",
                                onTap: () {
                                  Navigator.pop(context, PersonalBook(
                                    googleBook: googleBook,
                                    dayStarted: initialDateController.text,
                                    dayFinished: finalDateController.text,
                                    comments: commentsController.text,
                                  ));
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
