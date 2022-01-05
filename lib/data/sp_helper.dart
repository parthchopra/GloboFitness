import 'package:globo_fitness/data/session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SPHelper {
  static late SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Session session) async {
    prefs.setString(session.id.toString(), jsonEncode(session.toJson()));
  }

  List<Session> getSessions() {
    List<Session> sessions = [];
    Set<String> keys = prefs.getKeys();
    for (var key in keys) {
      if (key != 'counter') {
        Session session =
            Session.fromJson(jsonDecode(prefs.getString(key) ?? ''));
        sessions.add(session);
      }
    }
    return sessions;
  }

  Future setCounter() async {
    int counter = getCounter();
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}
