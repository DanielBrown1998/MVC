import 'package:app/dao/book_database.dart';
import 'package:app/models/personal_book.dart';

class BookController {
  PersonalBookDatabase database = PersonalBookDatabase();

  save(PersonalBook book) async {
    await database.save(book);
  }

  Future<List<PersonalBook>> getBooks() async {
    return await database.findAll();
  }

  Future<void> deleteBook(PersonalBook book) async {
    await database.delete(book);
  }

  Future<void> updateBook(PersonalBook book) async {
    await database.save(book);
  }
}
