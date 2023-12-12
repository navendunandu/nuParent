import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';

class CustomTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackIcon;
  final bool showNotificationButton;
  const CustomTopBar(
      {Key? key, this.showBackIcon = true, this.showNotificationButton = true})
      : super(key: key);

  @override
  Size get preferredSize =>
      showBackIcon ? const Size.fromHeight(110) : const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 30, 18, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: [
                        Image.asset('assets/dummy-profile-pic.png',
                            height: 50, fit: BoxFit.cover),
                        const Padding(
                          padding: EdgeInsets.only(left: 35, top: 35),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.green,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello,'),
                      Text(
                        'Kamalapriya Ajay',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: showNotificationButton ? AppColors.whiteblue : null,
                    borderRadius: BorderRadius.circular(8.0)),
                child: showNotificationButton
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.notifications),
                      )
                    : GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Skip',
                        ),
                      ),
              ),
            ],
          ),
        ),
        if (showBackIcon)
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new), //Back Icon
              ),
            ],
          ),
      ],
    );
  }
}
