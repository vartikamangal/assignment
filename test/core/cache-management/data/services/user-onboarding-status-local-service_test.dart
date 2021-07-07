import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/user-onboarding-status-local-service.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'user-onboarding-status-local-service_test.mocks.dart';

@GenerateMocks([Box])

void main(){
  late MockBox localClient;
  late UserOnboardingStatusLocalServiceImpl remoteDataSourceImpl;

  setUp(() {
    localClient = MockBox();
    remoteDataSourceImpl = UserOnboardingStatusLocalServiceImpl(
      localClient: localClient,
    );
  });


  group('DATA services for user onBoarding fetch status', () {
    test(
        'If should return unit when retrieveActivity is called',
            () async {
          //act
          when(localClient.get(PersistenceConst.USER_ONBOARDING_STATUS)).thenAnswer((_) async{
            null;
            final result = await remoteDataSourceImpl.fetchStatus();
            //assert
            expect(result, null);
          });
        });
  });

  group('DATA services for user onBoarding save status', () {
    test(
        'If should return unit when saveStatus is called',
            () async {
          //act
          when(localClient.get(PersistenceConst.USER_ONBOARDING_STATUS)).thenAnswer((_) async{
            null;
            final result = await remoteDataSourceImpl.saveStatus(status: "status");
            //assert
            expect(result, null);
          });
        });
  });

  group('DATA services for user to check user is first time logged in', () {
    test(
        'If should return unit when checkIsFirstTimeUser is called',
            () async {
          //act
          when(localClient.get(PersistenceConst.IS_FIST_TIME_USER)).thenAnswer((_) async{
            null;
            final result = await remoteDataSourceImpl.checkIsFirstTimeUser();
            //assert
            expect(result, true);
          });
        });
  });


}