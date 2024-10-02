import 'package:hive_flutter/hive_flutter.dart';

part 'save_model.g.dart';

@HiveType(typeId: 0)
class SaveModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String date;
  @HiveField(3)
  String? image;
  @HiveField(4)
  String? author;

  SaveModel(
      {this.author,
      required this.title,
      required this.description,
      this.image,
      required this.date});
}
