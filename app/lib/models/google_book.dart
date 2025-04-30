
class GoogleBook {
  late String id;
  late String title;
  late String authors;
  late String description;
  late String thumbnailLink;

  GoogleBook({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnailLink,
  });

  GoogleBook.fromApi(Map<String, dynamic> map) {
    id = map["id"];
    title = map["volumeInfo"]["title"] ?? "titulo desconhecido";
    authors =
        map["volumeInfo"]["authors"] == null
            ? "autor desconhecido"
            : (map["volumeInfo"]["authors"] as List<dynamic>)
                .map((e) => e)
                .toString();
    description = map["volumeInfo"]["description"] ?? "sem descricao";
    thumbnailLink = map["volumeInfo"]["imageLinks"]?["thumbnail"] ?? "https://placehold.co/200x290";
  }

  GoogleBook.fromJson(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    authors = map["authors"];
    description = map["description"];
    thumbnailLink = map["thumbnailLink"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "authors": authors,
      "description": description,
      "thumbnailLink": thumbnailLink,
    };
  }
}
