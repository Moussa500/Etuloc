import 'package:flutter/material.dart';
import 'package:projet_federe/components/colors.dart';
import 'package:projet_federe/components/item_list_tile.dart';
import 'package:projet_federe/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: myPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Text(
                  "M E N U",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              //User Profile
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ItemListTile(label: "Profile", icon: Icons.person,ontap: (){},),
              )),
              const SizedBox(
                height: 25,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: ItemListTile(label: "HomePage", icon: Icons.home,ontap: ()=>Navigator.pop(context),),
              )),
            ],
          ),
          //Logout
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: ItemListTile(
              label: "HomePage",
              icon: Icons.logout,
              ontap: () {
                AuthService auth = AuthService();
                auth.signOut();
              },
            ),
          )),
        ],
      ),
    );
  }
}
