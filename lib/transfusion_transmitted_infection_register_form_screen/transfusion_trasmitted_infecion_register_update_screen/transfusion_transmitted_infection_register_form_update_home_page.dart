import 'package:flutter/material.dart';

class TTRFormUpdateHomePage extends StatefulWidget {
  const TTRFormUpdateHomePage({Key? key}) : super(key: key);

  @override
  State<TTRFormUpdateHomePage> createState() => _TTRFormUpdateHomePageState();
}

class _TTRFormUpdateHomePageState extends State<TTRFormUpdateHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("Transfusion Transmitted Infection Register Form"),
      ),
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Are u sure want to save?'),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      //return false when click on "NO"
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const FormPage(),
                        //   ),
                        // );
                      },
                      //return true when click on "Yes"
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.add_box))
      ],
    );
  }
}
