// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/grid-style-loader.dart';
import '../controller/focus-screen-controller.dart';
import '../widgets/focus-card.dart';

// ignore: must_be_immutable
class FocusScreen extends StatelessWidget {
  final FocusController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: blueDarkShade,
                    size: ScaleManager.spaceScale(
                      spaceing: 26,
                    ).value,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value,
                ),
                child: Text(
                  tr('focus title1'),
                  style: AppTextStyle.titleLM,
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: ScaleManager.spaceScale(spaceing: 1).value,
              ),
              sliver: SliverToBoxAdapter(
                child: Obx(
                  () => _controller.isLoading.value
                      ? const GridLoaderScreen()
                      : SizedBox(
                          // Here 120 is being considered as height of each grid bloc
                          height: ScaleManager.spaceScale(
                            spaceing: _controller.issues.length *
                                ScaleManager.spaceScale(spaceing: 120).value,
                          ).value,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.2,
                            ),
                            itemCount: _controller.issues.length,
                            itemBuilder: (context, index) {
                              //TODO image addresses need to be changes later
                              final issueImageAddr =
                                  '${ImagePath.issues}${'${_controller.issues[index].focusName.toLowerCase()}.png'}';
                              return FocusCard(
                                imageAddress: issueImageAddr,
                                title: _controller.issues[index].displayName,
                                onTap: () {
                                  _controller.getDescription(
                                    issueImageAddr,
                                    _controller.issues[index],
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    RouteName.issueDetail,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
