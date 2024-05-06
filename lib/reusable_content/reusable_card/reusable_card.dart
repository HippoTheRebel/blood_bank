import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:flutter/material.dart';

class ReusableListCard extends StatefulWidget {
  const ReusableListCard(
      {Key? key, required this.cardText, required this.routePages})
      : super(key: key);

  final String cardText;
  final Widget routePages;

  @override
  State<ReusableListCard> createState() => _ReusableListCardState();
}

class _ReusableListCardState extends State<ReusableListCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => widget.routePages));
          });
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: SizedBox(
            width: 250,
            height: 60,
            child: Row(
              children: [
                Container(
                  color: Colors.blueAccent[100],
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.cardText,
                  style: kReusableListCardTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
