import 'package:hive_ce/hive.dart';

part 'HivItem.g.dart';

@HiveType(typeId: 0)
class Hivitem  extends HiveObject {
  
  @HiveField(0)
  String fileName;

  @HiveField(1)
  String  filePath;

  Hivitem(this.fileName,this.filePath);
  
}