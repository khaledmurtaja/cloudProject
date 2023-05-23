class SystemUser {
  late String name;
  late String role;
  late String email;
  late String field;
  late String id;
  late String uid;
  late String balance;
  late List<String> selectedTrainingIds;
  late String userImgUrl;

  SystemUser({
    required this.name,
    required this.role,
    required this.email,
    required this.field,
    required this.userImgUrl,
    required this.id,
    required this.uid,
    required this.balance,
    required this.selectedTrainingIds
  });

  SystemUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    userImgUrl=json['userImgUrl'];
    email = json['email'];
    field =json['field'];
    id=json['id'];
    uid=json['uid'];
    balance=json['balance'];
    selectedTrainingIds=['selected_training_ids'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['field'] = field;
    data['id']=id;
    data['uid']=uid;
    data['balance']=balance;
    data['userImgUrl']=userImgUrl;
    data['selected_training_ids']=selectedTrainingIds;
    return data;
  }
}