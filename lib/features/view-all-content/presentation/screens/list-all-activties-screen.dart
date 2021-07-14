import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/plan-container.dart';
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
    return PaginationView(
      // preloadedItems: [],
      itemBuilder: (context, Activity activity, index) => PlanContainer(
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
        description: activity.subtitle,
        title: activity.title,
        image: activity.iconVO?.url,
      ),
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
    );
  }
}
