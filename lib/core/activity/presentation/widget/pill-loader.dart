import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';

class PillLoader extends StatelessWidget {
  bool? haveDescription;
  PillLoader({
    required this.haveDescription
});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return Padding(
            padding:  EdgeInsets.only(bottom:ScaleManager.spaceScale(
              spaceing: 40,
            ).value),
            child: Shimmer.fromColors(
              baseColor: const Color.fromRGBO(230, 230, 230, 1),
              highlightColor: const Color.fromRGBO(242, 245, 245, 1),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: ScaleManager.spaceScale(
                          spaceing: 85,
                        ).value,
                        width: ScaleManager.spaceScale(
                          spaceing: Get.width,
                        ).value,
                        margin: EdgeInsets.only(
                            top: ScaleManager.spaceScale(
                              spaceing: 4,
                            ).value,
                            left: ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: hintshade,
                            width: ScaleManager.spaceScale(
                              spaceing: 1,
                            ).value,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              ScaleManager.spaceScale(
                                spaceing: 42.5,
                              ).value,
                            ),
                          ),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: ScaleManager.spaceScale(spaceing: 78).value),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(right: ScaleManager.spaceScale(
                                  spaceing: haveDescription==false?130:70,
                                ).value,
                              ),
                                child: Container(
                                    height: ScaleManager.spaceScale(
                                      spaceing: 23,
                                    ).value,
                                  color: Colors.grey,
                                ),
                              ),
                              if (haveDescription==false)
                                EmptySpacePlaceHolder()
                              else
                                Padding(
                                  padding:  EdgeInsets.only(top: ScaleManager.spaceScale(spaceing: 14).value,right: ScaleManager.spaceScale(spaceing: 86).value),
                                  child: Container(height: 15,color: Colors.grey,),
                                )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Container(height: ScaleManager.spaceScale(spaceing: 91).value,
                        width: ScaleManager.spaceScale(spaceing: 91).value,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.grey,),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
