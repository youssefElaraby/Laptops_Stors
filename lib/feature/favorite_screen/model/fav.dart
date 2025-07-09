class Fav {
  Fav({
      this.status, 
      this.favoriteProducts,});

  Fav.fromJson(dynamic json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        favoriteProducts?.add(FavoriteProducts.fromJson(v));
      });
    }
  }
  String? status;
  List<FavoriteProducts>? favoriteProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (favoriteProducts != null) {
      map['favoriteProducts'] = favoriteProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FavoriteProducts {
  FavoriteProducts({
      this.id, 
      this.status, 
      this.category, 
      this.name, 
      this.price, 
      this.description, 
      this.image, 
      this.images, 
      this.company, 
      this.countInStock, 
      this.v, 
      this.sales,});

  FavoriteProducts.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    company = json['company'];
    countInStock = json['countInStock'];
    v = json['__v'];
    sales = json['sales'];
  }
  String? id;
  String? status;
  String? category;
  String? name;
  num? price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  num? countInStock;
  num? v;
  num? sales;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['category'] = category;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['image'] = image;
    map['images'] = images;
    map['company'] = company;
    map['countInStock'] = countInStock;
    map['__v'] = v;
    map['sales'] = sales;
    return map;
  }

}