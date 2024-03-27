class BookModel {
  String? id;
  String? title;
  String? description;
  String? rating;
  int? pages;
  String? language;
  String? audioLen;
  String? author;
  String? aboutAuthor;
  String? bookurl;
  String? audioUrl;
  String? category;
  String? coverUrl;
  int? price;
  String? numberofRating;

  BookModel(
      {this.id,
      this.title,
      this.description,
      this.rating,
      this.pages,
      this.language,
      this.audioLen,
      this.author,
      this.aboutAuthor,
      this.bookurl,
      this.audioUrl,
      this.category,
      this.price,
      this.coverUrl,
      this.numberofRating});

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["rating"] is String) {
      rating = json["rating"];
    }
    if (json["pages"] is int) {
      pages = json["pages"];
    }
    if (json["language"] is String) {
      language = json["language"];
    }
    if (json["audioLen"] is String) {
      audioLen = json["audioLen"];
    }
    if (json["author"] is String) {
      author = json["author"];
    }
    if (json["aboutAuthor"] is String) {
      aboutAuthor = json["aboutAuthor"];
    }
    if (json["bookurl"] is String) {
      bookurl = json["bookurl"];
    }
    if (json["audioUrl"] is String) {
      audioUrl = json["audioUrl"];
    }
    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["coverUrl"] is String) {
      coverUrl = json["coverUrl"];
    }
    if (json["price"] is int) {
      price = json["price"];
    }
    if (json["numberofRating"] is int) {
      numberofRating = json["numberofRating"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["rating"] = rating;
    data["pages"] = pages;
    data["language"] = language;
    data["audioLen"] = audioLen;
    data["author"] = author;
    data["aboutAuthor"] = aboutAuthor;
    data["bookurl"] = bookurl;
    data["audioUrl"] = audioUrl;
    data["category"] = category;
    data["coverUrl"] = coverUrl;
    data["price"] = price;
    data["numberofRating"] = numberofRating;
    return data;
  }

  // @override
  // String toString() {
  //   return 'BookModel{id: $id, title: $title, description: $description, rating: $rating, pages: $pages, language: $language, audioLen: $audioLen, author: $author, aboutAuthor: $aboutAuthor, bookurl: $bookurl, audioUrl: $audioUrl, category: $category, coverUrl: $coverUrl, price: $price, numberofRating: $numberofRating}';
  // }
}
