
class SwaadOrder {
  DateTime reqDelveryTime;
  DateTime orderTime;
  String orderType;
  String orderdBy;
  String status;
  int orderId;
  int totalPrice;
  Map items = <int, int>{};

  SwaadOrder.map(dynamic obj) {
    this.reqDelveryTime = obj['reqDelveryTime'];
    this.orderTime = obj['orderTime'];
    this.orderType = obj['orderType'];
    this.orderdBy = obj['orderdBy'];
    this.status = obj['status'];
    this.orderId = obj['orderId'];
    this.totalPrice = obj['totalPrice'];
    this.items = obj['items'];
  }

  Map<String,dynamic> toMap() {
    var map = new Map<String,dynamic>();
    map['reqDelveryTime'] = reqDelveryTime;
    map['orderTime'] = orderTime;
    map['orderType'] = orderType;
    map['orderdBy'] = orderdBy;
    map['status'] = status;
    map['orderId'] = orderId;
    map['totalPrice'] = totalPrice;
    map['items'] = items;
    return map;
  }

  SwaadOrder.fromMap(Map<String,dynamic> map) {
    this.reqDelveryTime = map['reqDelveryTime'];
    this.orderTime = map['orderTime'];
    this.orderType = map['orderType'];
    this.orderdBy = map['orderdBy'];
    this.status = map['status'];
    this.orderId = map['orderId'];
    this.totalPrice = map['totalPrice'];
    this.items = map['items'];
  }

  @override
  String toString() {
    return 'SwaadOrder{reqDelveryTime: $reqDelveryTime, orderTime: $orderTime, orderType: $orderType, orderdBy: $orderdBy, status: $status, OrderId: $orderId, totalPrice: $totalPrice, items: $items}';
  }
}