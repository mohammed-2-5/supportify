import 'package:flutter/material.dart';
import 'package:on_bording/model/donation_details_model.dart';

import 'OrganizationCard.dart';

class OrganizationListView extends StatelessWidget {
  const OrganizationListView({
    super.key,
    required this.organizations,
  });

  final List<DonationDetail> organizations;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: organizations.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrganizationCard(donationDetail: organizations[index]);
        },
      ),
    );
  }
}
