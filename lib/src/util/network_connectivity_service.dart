import 'package:competition_tracker/src/util/inetwork_connectivity_service.dart';

class NetworkConnectivityService implements INetworkConnectivityService {
  @override
  bool isConnected() {
    return true;
  }
}
