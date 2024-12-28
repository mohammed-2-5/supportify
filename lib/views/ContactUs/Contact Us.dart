import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Contactus_message.dart';



class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Contact Us',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 24), // Global padding for left and right
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 24), // Spacing after the avatar
                // A method to build each ListTile with Divider
                _buildListItem(
                  onTap: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const  ContactUsMessage(),
                          ));

                  },
                  icon: 'assets/images/Message.svg',
                  title: 'Message ',
                  context: context,
                ),
                const SizedBox(height: 20,),
                _buildListItem(
                  onTap: () {},
                  icon: 'assets/images/call.svg',
                  title: 'Call',
                  context: context,
                ),
                const SizedBox(height: 20,),
                _buildListItem(
                  onTap: () {

                  },
                  icon: 'assets/images/whatsapp.svg',
                  title: 'whatsapp',
                  context: context,
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
      {required VoidCallback onTap,
        required String icon,
        required String title,
        required BuildContext context}) {
    return Container(
      width: 327,
      height: 60,
        decoration:BoxDecoration(
            border: Border.all(
                color: const Color(0xffCED5E1),
                width:1
              ,
                ),
            borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
      child: ListTile(
        leading: SvgPicture.asset(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}