import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/success/success-interface.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/contact-info.dart';
import '../repositories/request-instant-contact-service.dart';

class RequestInstantContact
    implements Usecase<Success, RequestInstantContactParams> {
  final RequestInstantContactService service;

  RequestInstantContact({@required this.service});
  @override
  Future<Either<Failure, Success>> call(
      RequestInstantContactParams params) async {
    return service.requestInstantContactService(
      contactInfo: params.contactInfo,
    );
  }
}

class RequestInstantContactParams extends Equatable {
  final ContactInfo contactInfo;

  const RequestInstantContactParams({
    @required this.contactInfo,
  });
  @override
  List<Object> get props => [contactInfo];
}
