import 'package:flutter/material.dart';
import 'package:getx_architecture/App/modules/trainingDetails/widgets/customFixedRow.dart';

class FixedSideMenu extends StatelessWidget {
  const FixedSideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomFixedRow(
          imageUrl: 'assets/icons/calendar.png',
          title: 'Flexible deadlines',
          supTitle: 'Reset deadlines in accordance to \nyour schedule',
        ),
        SizedBox(
          height: 25,
        ),
        CustomFixedRow(
          imageUrl: 'assets/icons/certificate.png',
          title: 'Shareable Certificate',
          supTitle: 'Earn a Certificate upon completion',
        ),
        SizedBox(
          height: 25,
        ),
        CustomFixedRow(
          imageUrl: 'assets/icons/online.png',
          title: '100% online',
          supTitle: 'Start instantly and learn at your \nown schedule',
        ),
        SizedBox(
          height: 25,
        ),
        CustomFixedRow(
          imageUrl: 'assets/icons/level.png',
          title: 'Beginner Level',
          supTitle:
              'You will need mathematical and \nstatistical knowledge and skills at \nleast at  high-school level',
        ),
        SizedBox(
          height: 25,
        ),
        CustomFixedRow(
          imageUrl: 'assets/icons/time.png',
          title: '10 Weeks',
          supTitle: '',
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
