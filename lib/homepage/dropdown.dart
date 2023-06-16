import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:launch_any_app/homepage/device_apps.dart';
import 'package:launch_any_app/layout/container.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  final TextEditingController appController = TextEditingController();
  Application? selectedApp;

  @override
  // This method is rerun every time setState is called, for instance as done
  // by the _incrementCounter method above.
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownMenuEntry<Application>>>(
        future: buildDropdonEntries(),
        builder: (context, AsyncSnapshot<List<DropdownMenuEntry<Application>>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                padded(const Text("Select the Application to be used as Launcher")),
                DropdownMenu<Application>(
                  width: MediaQuery.of(context).size.width * 0.8,
                  menuHeight: MediaQuery.of(context).size.height * 0.5,
                  //initialSelection: ColorLabel.green,
                  controller: appController,
                  label: const Text('App'),
                  dropdownMenuEntries: snapshot.data!,
                  onSelected: (Application? app) {
                    setState(() => selectedApp = app);
                  },
                )
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Future<List<DropdownMenuEntry<Application>>> buildDropdonEntries() async {
  final apps = await getDeviceApps();
  final entries =
      apps.map((app) => DropdownMenuEntry(value: app, label: app.appName, leadingIcon: getAppIcon(app))).toList();
  return entries;
}

Widget? getAppIcon(Application app) {
  if (app is ApplicationWithIcon) {
    return Image.memory(app.icon, width: 32, height: 32);
  }
  return null;
}
