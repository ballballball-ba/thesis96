class ApipayDemo {
  List<Pay> pay;

  ApipayDemo({this.pay});

  ApipayDemo.fromJson(Map<String, dynamic> json) {
    if (json['Pay'] != null) {
      pay = new List<Pay>();
      json['Pay'].forEach((v) {
        pay.add(new Pay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pay != null) {
      data['Pay'] = this.pay.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pay {
  int id;
  String status;
  String title;
  String message;

  Pay({this.id, this.status, this.title, this.message});

  Pay.fromJson(Map<String, dynamic> utf8) {
    id = utf8['id'];
    status = utf8['status'];
    title = utf8['title'];
    message = utf8['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}