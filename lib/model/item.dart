class Item{
  final String category;
  final String model;
  final String storeCode;
  final String labName;
  final String imageURL;

  Item({this.category,this.model,this.storeCode,this.labName,this.imageURL});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    category: json["category"],
    model: json["model"],
    storeCode: json["storeCode"],
    labName: json["labName"],
    imageURL: json["imageURL"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "model": model,
    "storeCode": storeCode,
    "labName": labName,
    "imageURL": imageURL,
  };
}