class SystemUser {
  late String fullName;
  late String role;
  late String email;
  late String urlForSupportDocument;
  late String field;
  late String id;
  late String uid;

  SystemUser({
    required this.fullName,
    required this.role,
    required this.email,
    required this.urlForSupportDocument,
    required this.field,
    required this.id,
    required this.uid
  });

  SystemUser.fromJson(Map<dynamic, dynamic> json) {
    fullName = json['name'];
    role = json['role'];
    email = json['email'];
    urlForSupportDocument = json['urlForSupportDocument'];
    field =json['field'];
    id=json['id'];
    uid=json['uid'];

  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = fullName;
    data['role'] = role;
    data['email'] = email;
    data['urlForSupportDocument'] = urlForSupportDocument;
    data['field'] = field;
    data['id']=id;
    data['uid']=uid;
    return data;
  }
}
