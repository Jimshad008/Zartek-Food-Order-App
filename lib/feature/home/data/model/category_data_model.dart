class CategoryModel{
  String id;
  String name;
  List<DishesModel> dishes;

//<editor-fold desc="Data Methods">
  CategoryModel({
    required this.id,
    required this.name,
    required this.dishes,
  });



  CategoryModel copyWith({
    String? id,
    String? name,
    List<DishesModel>? dishes,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      dishes: dishes ?? this.dishes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'dishes': dishes.isEmpty
          ? []
          : List<dynamic>.from(dishes.map((x) => x.toMap())),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'].toString(),
      name: map['name']??"",
      dishes:map['dishes']== null
          ? []: map['dishes'].length==0?[]
          : List<DishesModel>.from( map['dishes']!.map((x) => DishesModel.fromMap(x))),

    );
  }

//</editor-fold>
}
class DishesModel{
  String id;
  String name;
  String price;
  String currency;
  String description;
  String image_url;
  double calories;
  int qty;
  List addons;

//<editor-fold desc="Data Methods">
  DishesModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.description,
    required this.image_url,
    required this.calories,
    required this.qty,
    required this.addons,
  });



  DishesModel copyWith({
    String? id,
    String? name,
    String? price,
    String? currency,
    String? description,
    String? image_url,
    double? calories,
    int? qty,
    List? addons,
  }) {
    return DishesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      image_url: image_url ?? this.image_url,
      calories: calories ?? this.calories,
      qty: qty ?? this.qty,
      addons: addons ?? this.addons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'currency': this.currency,
      'description': this.description,
      'image_url': this.image_url,
      'calories': this.calories,
      'qty': this.qty,
      'addons': this.addons,
    };
  }

  factory DishesModel.fromMap(Map<String, dynamic> map) {
    return DishesModel(
      id: map['id'].toString(),
      name: map['name']??"",
      price: map['price']??"0",
      currency: map['currency'] ??"INR",
      description: map['description']??"",
      image_url: map['image_url'] ??"",
      calories:double.parse( map['calories']==null?"0":map['calories'].toString()),
      qty: map['qty']??0,
      addons: map['addons']??[],
    );
  }

//</editor-fold>
}