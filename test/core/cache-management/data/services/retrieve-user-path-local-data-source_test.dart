import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/retrieve-user-path-local-data-source.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'retrieve-user-path-local-data-source_test.mocks.dart';

@GenerateMocks([Box])

void main(){
  late MockBox? localClient;
  late RetrieveUserPathLocalDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = RetrieveUserPathLocalDataSourceImpl(
      localClient: localClient!,
    );
  });


  group('DATA services for most recent activity', () {
    test(
        'If should return unit when retrieveActivity is called',
            () async {
          //act
          when(localClient!.get(PersistenceConst.USER_SELECTED_PATH)).thenAnswer((_) async{
            null;
            final result = await remoteDataSourceImpl.retrievePath();
            //assert
            expect(result, null);
          });
        });
  });
}