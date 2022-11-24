import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      backgroundColor: Colors.grey[600],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outline_rounded,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
      leading: IconButton(
        onPressed: () {},
        icon: const ImageIcon(AssetImage("assets/icons/ic_menu.png")),
      ),
      title: const Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: Text("Hello"),
      ),
    );
  }
}
