import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/plan-container.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/view-all-content/presentation/controller/list-activities-controller.dart';

class ListAllActivitiesScreen extends StatefulWidget {
  const ListAllActivitiesScreen({Key? key}) : super(key: key);

  @override
  _ListAllActivitiesScreenState createState() =>
      _ListAllActivitiesScreenState();
}

class _ListAllActivitiesScreenState extends State<ListAllActivitiesScreen> {
  final ListActivitiesController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              Get.back();
            }),
        title: const Text("All Activities"),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          ScaleManager.spaceScale(spaceing: 12).value,
        ),
        child: PaginationView(
          // preloadedItems: [],
          itemBuilder: (context, Activity activity, index) =>
              _ActivityView(activity: activity, index: index),
          pageFetch: controller.fetchActivities,
          onError: (dynamic error) => const Center(
            child: Text('Some error occured'),
          ),
          onEmpty: const Center(
            child: Text('Sorry! This is empty'),
          ),
          bottomLoader: const Center(
            child: CircularProgressIndicator(),
          ),
          initialLoader: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class _ActivityView extends StatelessWidget {
  final int index;
  final Activity activity;
  const _ActivityView({
    Key? key,
    required this.activity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Acitivty number: : $index"),
            const SizedBox(height: 6),
            SelectableText("Activity id : ${activity.id}"),
          ],
        ),
        PlanContainer(
          requireBottomSpacing: true,
          isFaded: false,
          onPressed: () {
            Navigator.of(context).pushNamed(
              RouteName.activityScreen,
              arguments: {
                "activity": activity,
                "redirectRoute": RouteName.listAllActivities,

                /// If its value was [false] and the user didnt have a plan{Self or Guided},
                /// then there was a server error
                "isInstantActivity": true,
              },
            );
          },
          description: activity.subtitle ?? '',
          title: activity.title,
          image: activity.iconVO?.url,
        ),
      ],
    );
  }
}
