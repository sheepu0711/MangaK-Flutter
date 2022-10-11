import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mangak/screens/components/avatar.dart';
import 'package:mangak/theme/constain.dart';

class Tile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onReload;
  final String avatar;
  final String username;
  const Tile({
    Key? key,
    required this.onTap,
    required this.onReload,
    required this.avatar,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      // leading: Avatar(avatar: avatar, onTap: onTap),
      leading: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Avatar(
                avatar: snapshot.data!.photoURL.toString(),
                onTap: onTap,
              );
            }
            return Image.asset('assets/images/mangak.png');
          }),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stay trending',
            style: TextStyle(fontSize: 12, color: kSecondaryGrayColor),
          ),
          Text(
            username.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      trailing: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kSecondaryGrayColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: InkWell(
            onTap: onReload,
            child: const Icon(Icons.replay_outlined),
          )),
    );
  }
}
