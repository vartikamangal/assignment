import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';
import '../../domain/entities/set-feeling-success.dart';

abstract class SetSubjectFeelingLocalService {
  Future<SetFeelingSuccess> setFeeling({@required String feeling});
}

class SetSubjectFeelingLocalServiceImpl
    implements SetSubjectFeelingLocalService {
  final Box localClient;

  SetSubjectFeelingLocalServiceImpl({@required this.localClient});
  @override
  Future<SetFeelingSuccess> setFeeling({String feeling}) async {
    try {
      await localClient.put(PersistenceConst.RAPPORT_FEELING_BOX, feeling);
      return SetFeelingSuccess();
    } catch (e) {
      throw CacheException();
    }
  }
}
