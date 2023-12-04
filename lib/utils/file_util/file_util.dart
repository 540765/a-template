import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  FileUtil._internal();
  static final FileUtil _instance = FileUtil._internal();
  factory FileUtil() => _instance;

  //获取的目录
  static late Directory appDirectory;
  //保存的文件夹
  static const String directoryPath = 'app_file';
  //保存的完整的文件夹
  static late Directory saveDirectory;

  static Future<void> init() async {
    appDirectory = await getApplicationDocumentsDirectory();
    saveDirectory = Directory(appDirectory.path + directoryPath);
  }

  ///保存文件
  static Future<String> saveFile({
    required File file,
  }) async {
    //判断目录是否存储，不存在就创建
    await existsDirectory(
      directory: appDirectory,
    );
    await existsDirectory(
      directory: saveDirectory,
    );
    //获取文件名
    String targetName = basename(file.path);
    //创建新文件
    String targerPath = saveDirectory.path + targetName;
    File targeFile = File(targerPath);
    if (!targeFile.existsSync()) {
      await file.copy(targerPath);
    }
    return targerPath;
  }

  //创建文件夹
  static Future<void> existsDirectory({
    required Directory directory,
  }) async {
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }

  //外部使用，判断文件是否存在
  static Future<bool> checkFileExists({required File file}) async {
    return await file.exists();
  }
}
