class PublicationsList {
  List<Publication> recipeList;

  PublicationsList({required this.recipeList});

  factory PublicationsList.fromJSON(Map<dynamic, dynamic> json) {
    return PublicationsList(recipeList: parserecipes(json));
  }

  static List<Publication> parserecipes(recipeJSON) {
    var rList = recipeJSON['publications'] as List;
    List<Publication> recipeList =
        rList.map((data) => Publication.fromJson(data)).toList();
    return recipeList;
  }
}

class Publication {
  String? title;
  String? description;
  String? authorName;
  String? url;
  String? uid;
  int? id;

  Publication({
    this.title,
    this.description,
    this.authorName,
    this.url,
    this.uid,
    this.id,
  });

  factory Publication.fromJson(Map<dynamic, dynamic> parsedJson) {
//    print(parsedJson);
    return Publication(
        title: parsedJson['title'],
        description: parsedJson['description'],
        authorName: parsedJson['author_name'],
        uid: parsedJson['uid'],
        id: parsedJson['id']);
  }
}
