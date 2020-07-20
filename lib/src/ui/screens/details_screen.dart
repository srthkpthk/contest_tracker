import 'package:competition_tracker/src/data/bloc/details_bloc.dart';
import 'package:competition_tracker/src/data/model/competitions/resource.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) => _launchUrl(payload, context);

  _scheduleNotification(String start, String event, Resource resource, String href, int duration) async {
    var android = AndroidNotificationDetails('channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime = DateTime.now();
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'The Competition $event is going to start in 1 Hour on ${resource.name}',
        'Be Prepared - Best of Luck - ${Duration(seconds: duration).inHours.toString()} Hours',
        scheduledNotificationDateTime,
        platform,
        payload: href);
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
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
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
            bloc: context.bloc<DetailsBloc>(),
            // ignore: missing_return
            builder: (BuildContext context, state) {
              if (state is DetailsInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DetailsError) {
                return Center(
                  child: Text('Error ', style: TextStyle()),
                );
              }
              if (state is DetailsLoaded) {
                return ListView.builder(
                    itemCount: state.contestEntity.objects.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(state.contestEntity.objects[index].event),
                          trailing: Text(
                              '${Duration(seconds: state.contestEntity.objects[index].duration).inHours.toString()} Hours'),
                          dense: true,
                          leading: IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () {
                                if (DateTime.parse(state.contestEntity.objects[index].start)
                                        .difference(DateTime.now()) <
                                    Duration(hours: 1)) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      'This Contest has either ended or is in the period of 1 hour',
                                    ),
                                  ));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Do you want to get notified about this Competition?'),
                                    action: SnackBarAction(
                                        label: 'Yes',
                                        onPressed: () => _scheduleNotification(
                                              state.contestEntity.objects[index].start,
                                              state.contestEntity.objects[index].event,
                                              state.contestEntity.objects[index].resource,
                                              state.contestEntity.objects[index].href,
                                              state.contestEntity.objects[index].duration,
                                            )),
                                  ));
                                }
                              }),
                          subtitle: Row(
                            //                        crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Start: ${DateFormat('d-MMM-yyyy hh:mm aa').format(DateTime.parse(state.contestEntity.objects[index].start))}',
                              ),
                              Text(
                                'End: ${DateFormat('d-MMM-yyyy hh:mm aa').format(DateTime.parse(state.contestEntity.objects[index].end))}',
                              ),
                            ],
                          ),
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  'Launch ${state.contestEntity.objects[index].event} in Browser ?',
                                ),
                                action: SnackBarAction(
                                    label: 'Yes',
                                    onPressed: () => _launchUrl(state.contestEntity.objects[index].href, context)),
                              )));
                    });
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
