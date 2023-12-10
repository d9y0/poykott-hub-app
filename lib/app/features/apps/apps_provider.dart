import 'package:boycott_hub/app/features/apps/models/app_model.dart';
import 'package:boycott_hub/app/ui/screens/boycott_israeli_tech_lancher/boycott_israeli_tech_lancher.route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appsModelsProvider = Provider<List<AppModel>>((ref) {
  return [
    const AppModel(
      id: 1,
      description: "",
      displayName: "Boycott Israeli Tech",
      img: "assest/apps/boycottisraelitech/icon.png",
      website: "https://boycottisraelitech.com/",
      appPath: BoycottIsraeliTechLancherScreen.path,
    ),
  ];
});
