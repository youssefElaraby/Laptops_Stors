class LapTopModel {
  LapTopModel({
    this.status,
    this.message,
    this.product,
  });

  LapTopModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = [];
      json['product'].forEach((v) {
        product?.add(Products.fromJson(v));
      });
    }
  }

  String? status;
  String? message;
  List<Products>? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (product != null) {
      map['product'] = product?.map((v) => v.toJson()).toList();
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
  });

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
