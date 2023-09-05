class Burger {
  String ref;
  String title;
  String description;
  String imageUrl;
  int price;

  Burger({
    required this.ref,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Burger.fromJson(Map<String, dynamic> json) {
    return Burger(
      ref: json['ref'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['thumbnail'],
      price: json['price'],
    );
  }

  priceToEurStr(){
    return "${(price/100).toStringAsFixed(2)} €";
  }

  priceToEur(){
    return (price/100);
  }
}
