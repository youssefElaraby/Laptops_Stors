class CartModel {
  CartModel({
      this.products,});

  CartModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Products {
  Products({
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
      this.sales, 
      this.quantity, 
      this.totalPrice,});

  Products.fromJson(dynamic json) {
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
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
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
  num? quantity;
  num? totalPrice;

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
    map['quantity'] = quantity;
    map['totalPrice'] = totalPrice;
    return map;
  }

}