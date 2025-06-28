class Language {
  Language({
    this.id,
    this.name,
    this.rating,
  });

  int? id;
  String? name;
  int? rating;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json['id'] != null ? json['id'] as int : null,
        name: json['name'] != null ? json['name'] as String : null,
        rating: json['rating'] != null ? json['rating'] as int : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id != null && id! > 0 ? id : null,
        'name': name,
        'rating': rating,
      };
}
