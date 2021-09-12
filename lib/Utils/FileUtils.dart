import 'dart:io' as IO;

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUtils {
  static Future<String> getFilePath() async {
    IO.Directory directory = await PathProvider.getExternalStorageDirectory();
    return directory.path;
  }

  static Future<File> getOrCreateFile(String fileName) async {
    String filePath = await getFilePath();
    return IO.File('$filePath/$fileName.txt');
  }

  static Future saveDataInFile(String fileName, String data) async {
    File file = await getOrCreateFile(fileName);
    file.writeAsString(data);
  }

  static Future<String> readDataFromFile(String fileName) async {
    try {
      File file = await getOrCreateFile(fileName);
      String fileContents = await file.readAsString();
      return fileContents;
    } on IO.IOException catch (exception) {
      print(exception);
      print("No file Exists of this Name....");
      return null;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> updateCacheImage(String url) async {
    bool opStatus = false;
    try {
      File imgFileForUpdate = await DefaultCacheManager().getSingleFile(url);
      if (imgFileForUpdate != null) {
        String oldFilePath = imgFileForUpdate.path;
        await imgFileForUpdate.delete();
        FileInfo newImgFileInfo = await DefaultCacheManager().downloadFile(url);
        if (newImgFileInfo != null) {
          File newImgFile = newImgFileInfo.file;
          await newImgFile.rename(oldFilePath);
          opStatus = true;
        }
      }
    } catch (exp) {
      print("Update Cache Image Exception..");
    }

    return opStatus;
  }

  Future<IO.Directory> getInternalStorageDirectoryForAndroid() async {
    try {
      if (await Permission.storage.request().isGranted) {
        IO.Directory extStDir =
            await PathProvider.getExternalStorageDirectory();
        List<String> dirsName = extStDir.path.split("/");
        int andNameIn = -1;
        for (int i = dirsName.length - 1; i >= 0; i--) {
          if (dirsName[i] == "Android") {
            andNameIn = i;
          }
        }

        IO.Directory resDir = extStDir;
        if (andNameIn != -1) {
          andNameIn = (dirsName.length - andNameIn);
          for (int i = 0; i < andNameIn; i++) {
            resDir = resDir.parent;
          }

          return resDir;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}
