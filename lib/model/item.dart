class Item{
  final String category;
  final String model;
  final String storeCode;
  final String labName;

  Item({this.category,this.model,this.storeCode,this.labName});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    category: json["category"],
    model: json["model"],
    storeCode: json["storeCode"],
    labName: json["labName"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "model": model,
    "storeCode": storeCode,
    "labName": labName,
  };
}