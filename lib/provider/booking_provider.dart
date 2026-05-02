import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/models/booking.dart';
import 'package:heal_link_manange/models/user.dart';

class BookingProvider extends StateNotifier<List<BookingModel>> {
  BookingProvider() : super([]);
  void setBookings(List<BookingModel> bookings) => state = bookings;
}

final bookingProvider =
    StateNotifierProvider<BookingProvider, List<BookingModel>>(
      (ref) => BookingProvider(),
    );
