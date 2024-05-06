class LoginResponseModel {
  Data? data;
  String? msg;
  int? status;

  LoginResponseModel({this.data, this.msg, this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}

class Data {
  String? token;
  String? email;
  String? sId;

  Data({this.token, this.email, this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['email'] = email;
    data['_id'] = sId;
    return data;
  }
}
