import '../../domain/entities/emergency-number.dart';
import 'package:flutter/foundation.dart';

class EmergencyNumberModel extends EmergencyNumber {
  const EmergencyNumberModel({
    @required String number,
  }) : super(
          number: number,
        );

  factory EmergencyNumberModel.fromJson(Map<String, dynamic> jsonMap) {
    return EmergencyNumberModel(
      //TODO If getEmergencyNumber module gives any error make sure to also check this model once
      // because I guess if the current API response will be there in  form of List then .fromJson would not neded
      number: jsonMap["number"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // As per the current response, this would only be helpful in caching purposes
    return {
      "info": number,
    };
  }
}
