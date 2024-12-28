import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationTile extends StatelessWidget {
  final String userName;
  final String userImage;
  final String message;
  final String time;

  const NotificationTile({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(userImage) ,
            radius: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    ),
                   const Spacer(),
                    Text(
                      time,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontSize: 10),
                    ),
                  ],
                ),
               const  SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w400,fontSize: 12),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                        },
                        child: const Icon(
                            color: Color(0xff929EAE),
                            size: 24,
                            Icons.close))
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}


