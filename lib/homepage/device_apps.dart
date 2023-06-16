import 'package:device_apps/device_apps.dart';

Future<List<Application>> getDeviceApps() async {
  List<Application> apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );
  return apps;
}
