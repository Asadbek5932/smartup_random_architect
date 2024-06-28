import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'team.g.dart';

var uuid = const Uuid();

@HiveType(typeId: 0)
class Team {
  @HiveField(0)
  final String name;

  @HiveField(1)
  String level;

  @HiveField(2)
  final String id;

  @HiveField(3)
  int levelNumber;

  Team({required this.name, required this.level, required this.levelNumber}) : id = uuid.v4();
}
