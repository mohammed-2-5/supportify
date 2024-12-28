import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:on_bording/model/donation_details_model.dart';

import '../../core/Widgets/FormDataRow.dart';

class OrganizationCard extends StatelessWidget {
  final DonationDetail donationDetail;

  const OrganizationCard({
    super.key,
    required this.donationDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: donationDetail.imageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      donationDetail.organizationName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    FormDataRow(
                      logo: 'assets/Menu-4.svg',
                      // Assuming this is a static asset
                      title: donationDetail.category,
                    ),
                    const SizedBox(height: 10),
                    FormDataRow(
                      logo: 'assets/flag.svg',
                      // Assuming this is a static asset
                      title: donationDetail.location,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              donationDetail.eventName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            Text(
              donationDetail.description,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: IntrinsicWidth(
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Donate',
                                style: TextStyle(
                                  color: Color(0xff388175),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.favorite_border,
                                  color: Color(0xff388175)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donationDetail.goal.toString(),
                                style: const TextStyle(
                                  color: Color(0xff388175),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.monetization_on_outlined,
                                  color: Color(0xff388175)),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
