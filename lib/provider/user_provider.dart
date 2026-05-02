import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/models/user.dart';

class UserProvider extends StateNotifier<List<User>> {
  UserProvider()
    : super([
        User(
          id: "",
          fullName: "",
          email: "",
          state: "",
          city: "",
          locality: '',
          password: '',
          token: '',
          phone: '',
          avatar: '',
        ),
      ]);
  List<User> get users => state;
  void setUsers(List<User> users) => state = users;
  void signOut() => state = [];
}

final userProvider = StateNotifierProvider<UserProvider, List<User>>(
  (ref) => UserProvider(),
);
