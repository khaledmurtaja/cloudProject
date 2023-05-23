class UserModel {
  final String name;
  final String email;
  final List<String> selectedTrainingIds;

  UserModel({
    required this.name,
    required this.email,
    required this.selectedTrainingIds,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> selectedTrainingIds = map['selected_training_ids'];
    List<String> selectedTrainingIdsStrings =
        List<String>.from(selectedTrainingIds.map((x) => x.toString()));
    return UserModel(
      name: map['name'],
      email: map['email'],
      selectedTrainingIds: selectedTrainingIdsStrings,
    );
  }
}
