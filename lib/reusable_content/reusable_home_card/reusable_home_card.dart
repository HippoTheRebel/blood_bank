import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:flutter/material.dart';

class ReusableHomeCard extends StatefulWidget {
  const ReusableHomeCard({Key? key, required this.homeCardText, required this.routePages}) : super(key: key);
  final String homeCardText;
  final Widget routePages;

  @override
  State<ReusableHomeCard> createState() => _ReusableHomeCardState();
}

class _ReusableHomeCardState extends State<ReusableHomeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.routePages,
                ),
              );
            });
          },
          child: Card(
              elevation: 10,
              shadowColor: Colors.blueAccent[500],
              color: Colors.blueAccent[100],
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
                width: 300,
                height: 500,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Text(
                      widget.homeCardText,
                      style: kReusableHomeCardTextStyle,
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      softWrap: true,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
