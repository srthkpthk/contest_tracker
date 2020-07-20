import 'package:competition_tracker/src/data/model/competitions/contest_entity.dart';
import 'package:competition_tracker/src/data/model/competitions/objects.dart';
import 'package:competition_tracker/src/data/model/competitions/resource.dart';
import 'package:competition_tracker/src/data/repositories/contest_api_repository.dart';
import 'package:competition_tracker/src/data/repositories/contest_repository.dart';
import 'package:competition_tracker/src/data/repositories/hive_repository.dart';
import 'package:competition_tracker/src/ui/screens/splash_screen.dart';
import 'package:competition_tracker/src/util/inetwork_connectivity_service.dart';
import 'package:competition_tracker/src/util/network_connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Objects>(ObjectsAdapter());
  Hive.registerAdapter<ContestEntity>(ContestEntityAdapter());
  Hive.registerAdapter<Resource>(ResourceAdapter());
  final contestsBox = await Hive.openBox<ContestEntity>('cp_tracker');
  final networkConnectivityService = NetworkConnectivityService();

  runApp(App(
    contestsBox: contestsBox,
    networkConnectivityService: networkConnectivityService,
  ));
}

class App extends StatelessWidget {
  final Box<ContestEntity> contestsBox;
  final INetworkConnectivityService networkConnectivityService;

  const App({
    @required this.contestsBox,
    @required this.networkConnectivityService,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ContestsRepository>(
      create: (_) => ContestsRepository(
        source: ContestsApiRepository(),
        cache: HiveRepository(this.contestsBox),
        hasConnection: this.networkConnectivityService.isConnected,
      ),
      child: MaterialApp(
        title: 'Competitive Tracker',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
