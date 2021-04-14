

class GateModel {
  var apiVersion,merchantID,orderID,sessionID,status;

  GateModel({this.apiVersion, this.merchantID, this.orderID, this.sessionID,
      this.status});

  GateModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    merchantID = json['merchant_id'];
    orderID = json['order_id'];
    sessionID = json['session_id'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_version'] = this.apiVersion;
    data['merchant_id'] = this.merchantID;
    data['order_id'] = this.orderID;
    data['session_id'] = this.sessionID;
    data['status'] = this.status;
    return data;
  }
}