import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../error/exceptions.dart';

class ThrowExceptionIfResponseError {
  /// A Map of pre-conserved Exceptions
  static final Map<int, Exception> _exceptionMap = {
    401: AuthException(),
  };

  /// takes in Statuscode of the request you want to handle
  /// Check from the various Exceptions and throws the suitable one
  Exception call({@required int statusCode}) {
    /// If the response is valid
    if (statusCode == 200) {
      /// Don't do anything
      return null;
    } else {
      /// Checking if the proper exception is present or not
      log(statusCode.toString());
      if (_exceptionMap.containsKey(statusCode)) {
        /// If yes, Then throw the mapped exception
        throw _exceptionMap[statusCode];
      } else {
        /// else throw [ServerException]
        throw ServerException();
      }
    }
  }
}
