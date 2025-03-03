import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/controller/auth_provider.dart';
import 'package:receipe_app/core/constants/spacing_constants.dart';
import 'package:receipe_app/model/profile_list_model.dart';
import 'package:receipe_app/view/widgets/user_detail.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final List<ProfileList> items = [
    ProfileList(
        title: 'About App',
        leadingIcon: const Icon(Icons.settings),
        trailingIcon: const Icon(Icons.chevron_right)),
    ProfileList(
        title: 'Logout',
        leadingIcon: const Icon(Icons.logout),
        trailingIcon: const Icon(Icons.chevron_right)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 80,
                          child: Icon(
                            Icons.person_3,
                            size: 50,
                          ),
                        ),
                      ),
                      kWidth10,
                       UserDetails(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title!),
                  leading: Icon(items[index].leadingIcon!.icon),
                  trailing: GestureDetector(
                      onTap: () {
                        _handleOnTap(
                          context,
                          items[index].title!,
                        );
                      },
                      child: Icon(items[index].trailingIcon!.icon)),
                );
              })),
    );
  }

  void _handleOnTap(BuildContext context, String title) {
    

    if (title == 'Logout') {
    signoutAlert(context);
    } 
  }

  signoutAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              'Alert',
              style: TextStyle(fontSize: 14),
            ),
            content: const Text(
              'Do you want to  logout?',
              style: TextStyle(fontSize: 17),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    signout(context);
                  },
                  child: const Text('YES')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NO')),
            ],
          );
        }));
  }

  signout(BuildContext context) async {
    Provider.of<AuthProvider>(context, listen: false).logoutEvent();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
