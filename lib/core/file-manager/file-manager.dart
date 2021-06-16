// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import '../error/failures.dart';

enum FileSaveStatus { SUCCESS, FAILED, UNKNOWN }
const String kVoiceNoteExtension = '.aac';

abstract class FileUtils {
  // Returns either the File path or failure on any exception
  Future<Either<Failure, String>> retriveFile();
  // Returns a generated-filename for voicenote name & Failure if any exception occurs
  Future<Either<Failure, String>> getNewFileNameName();
}

class FileUtilsImpl implements FileUtils {
  final Box box;

  FileUtilsImpl({
    @required this.box,
  });
  @override
  Future<Either<Failure, String>> getNewFileNameName() async {
    try {
      // gets the application specific directory
      final path = await getApplicationDocumentsDirectory();
      final DateTime dateTime = DateTime.now();
      //* HOPEFULLY THIS DOES GENERATES A RANDOM FILENAME EACH TIME
      final String newFileName =
          '/${dateTime.day}-${dateTime.month}-${dateTime.year}-${dateTime.day}-${dateTime.minute}-${dateTime.second}-${dateTime.millisecond}$kVoiceNoteExtension';
      final generatedFilePath = path.path + newFileName;
      log("GENERATED FILENAMEPATH: $generatedFilePath");
      return Right(
        generatedFilePath,
      );
    } catch (e) {
      log(e.toString());
      return Left(
        FileOperationFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, String>> retriveFile() {
    //TODO Implement retirveFile
    throw UnimplementedError();
  }
}
