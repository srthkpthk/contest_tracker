import 'package:competition_tracker/src/data/bloc/details_bloc.dart';
import 'package:competition_tracker/src/data/model/competitions/resource.dart';
import 'package:competition_tracker/src/data/repositories/contest_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  int id;
  String name;
  String icon;

  DetailsScreen(this.id, this.name, this.icon);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DetailsBloc _bloc;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) => _launchUrl(payload, context);

  _scheduleNotification(String start, String event, Resource resource, String href, int duration) async {
    var android = AndroidNotificationDetails('channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime = DateFormat('d-MM-yyyy hh:mm aa').parse(start).subtract(Duration(hours: 1));
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'The Competition $event is going to start in 1 Hour on ${resource.name}',
        'Be Prepared - Best of Luck - $duration Hours',
        scheduledNotificationDateTime,
        platform,
        payload: href);
  }

  @override
  void didChangeDependencies() {
    if (this._bloc == null) {
      final userRepository = RepositoryProvider.of<ContestsRepository>(context);
      this._bloc = DetailsBloc(userRepository)..add(GetDetails(widget.id));
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.black.withOpacity(.1),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                    title: Hero(
                      tag: widget.name,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(widget.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            )),
                      ),
                    ),
                    background: Hero(
                        tag: widget.id,
                        child: Stack(
                          children: [
                            SizedBox.expand(
                              child: Image.asset(
                                widget.icon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: Colors.black.withOpacity(.5),
                            )
                          ],
                        ))),
              ),
            ];
          },
          body: BlocBuilder(
            bloc: _bloc,
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is DetailsInitial) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 25,
                    ),
                    Text('Loading Contests...'),
                  ],
                );
              }
              if (state is DetailsError) {
                return Center(
                  child: Text('Error ', style: TextStyle()),
                );
              }
              if (state is DetailsEmpty) {
                return Center(
                  child: Text('No Contests in Upcoming time', style: TextStyle()),
                );
              }
              if (state is DetailsLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DetailsLoaded) {
                return RefreshIndicator(
                  onRefresh: () async => _bloc.add(PullRefresh(widget.id)),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            thickness: 2,
                          ),
                      itemCount: state.contests.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(state.contests[index].event),
                            leading: Text('${state.contests[index].duration} Hours'),
                            trailing: IconButton(
                                icon: Icon(Icons.notifications),
                                onPressed: () {
                                  if (DateTime.parse(DateFormat('d-MM-yyyy hh:mm aa')
                                              .parse(state.contests[index].start)
                                              .toIso8601String())
                                          .difference(DateTime.now()) <
                                      Duration(hours: 1)) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        'This Contest is Going On ? ',
                                      ),
                                    ));
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Do you want to get notified about this Competition?'),
                                      action: SnackBarAction(
                                          label: 'Yes',
                                          onPressed: () {
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                'Notification Scheduled for ${state.contests[index].start}',
                                              ),
                                            ));
                                            _scheduleNotification(
                                              state.contests[index].start,
                                              state.contests[index].event,
                                              state.contests[index].resource,
                                              state.contests[index].href,
                                              state.contests[index].duration,
                                            );
                                          }),
                                    ));
                                  }
                                }),
                            subtitle: Row(
                              //                        crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Start: ${state.contests[index].start}',
                                ),
                                Text(
                                  'End:${state.contests[index].end}',
                                ),
                              ],
                            ),
                            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    'Launch ${state.contests[index].event} in Browser ?',
                                  ),
                                  action: SnackBarAction(
                                      label: 'Yes', onPressed: () => _launchUrl(state.contests[index].href, context)),
                                )));
                      }),
                );
              }
            },
          )),
    );
  }

  _launchUrl(String href, BuildContext context) async {
    if (await canLaunch(href)) {
      await launch(href);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          onPressed: () {},
          label: 'Okay',
        ),
        content: Text('Cannot Redirect you to $href', style: TextStyle()),
      ));
    }
  }
}
