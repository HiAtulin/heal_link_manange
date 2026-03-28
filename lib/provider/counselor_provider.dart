import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/models/counselor.dart';

class CounselorProvider extends StateNotifier<Counselor?> {
  CounselorProvider()
    : super(
        Counselor(
          id: '',
          fullName: '',
          email: '',
          password: '',
          gender: '',
          age: 0,
          phone: '',
          title: '',
          major: const [],
          qualification: const [],
          experience: 0,
          introduction: '',
          status: '',
          avatar: '',
          createdAt: '',
          updatedAt: '',
        ),
      );
  Counselor? get counselor => state;
  void setounselor(String counselorJson) {
    state = Counselor.fromJson(counselorJson);
  }

  void signOut() {
    state = null;
  }
}

// 定义CounselorProvider的状态提供器，用于在应用中使用CounselorProvider的状态管理。
final counselorProvider = StateNotifierProvider<CounselorProvider, Counselor?>(
  (ref) => CounselorProvider(),
);
