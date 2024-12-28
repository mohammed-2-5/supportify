import 'package:flutter/material.dart';

import '../../controller/HomeController.dart';
import '../../controller/OrganizationController.dart';
import 'HeaderRow.dart';
import 'organization_card_listview.dart';

class HomeOrganizationSection extends StatelessWidget {
  final String headerTitle;
  final double size;
  final OrganizationController organizationController;
  final HomeController homeController;

  const HomeOrganizationSection({
    Key? key,
    required this.headerTitle,
    required this.size,
    required this.organizationController,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderRow(title: headerTitle),
        OrganizationCardListView(
          homeController: homeController,
          organizationController: organizationController,
        ),
      ],
    );
  }
}
