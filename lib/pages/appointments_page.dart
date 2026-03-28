import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../theme/app_colors.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  final List<Appointment> _appointments = [
    Appointment(
      id: 1,
      clientName: '张三',
      clientAvatar: '张',
      date: DateTime(2026, 3, 28, 10, 0),
      duration: 60,
      type: AppointmentType.initial,
      status: AppointmentStatus.upcoming,
      notes: '初诊咨询',
    ),
    Appointment(
      id: 2,
      clientName: '李四',
      clientAvatar: '李',
      date: DateTime(2026, 3, 28, 11, 30),
      duration: 60,
      type: AppointmentType.followUp,
      status: AppointmentStatus.upcoming,
      notes: '复诊咨询',
    ),
    Appointment(
      id: 3,
      clientName: '王五',
      clientAvatar: '王',
      date: DateTime(2026, 3, 28, 14, 0),
      duration: 60,
      type: AppointmentType.consultation,
      status: AppointmentStatus.upcoming,
      notes: '常规咨询',
    ),
    Appointment(
      id: 4,
      clientName: '赵六',
      clientAvatar: '赵',
      date: DateTime(2026, 3, 28, 15, 30),
      duration: 60,
      type: AppointmentType.followUp,
      status: AppointmentStatus.upcoming,
      notes: '复诊咨询',
    ),
    Appointment(
      id: 5,
      clientName: '孙七',
      clientAvatar: '孙',
      date: DateTime(2026, 3, 27, 9, 0),
      duration: 60,
      type: AppointmentType.initial,
      status: AppointmentStatus.completed,
      notes: '初诊咨询',
    ),
    Appointment(
      id: 6,
      clientName: '钱八',
      clientAvatar: '钱',
      date: DateTime(2026, 3, 27, 10, 30),
      duration: 60,
      type: AppointmentType.consultation,
      status: AppointmentStatus.cancelled,
      notes: '客户取消',
    ),
  ];

  List<Appointment> get _todayAppointments {
    return _appointments.where((appointment) {
      return appointment.date.year == _focusedDay.year &&
          appointment.date.month == _focusedDay.month &&
          appointment.date.day == _focusedDay.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildCalendar(),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: _buildAppointmentsList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '预约管理',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              '今日有 ${_todayAppointments.where((a) => a.status == AppointmentStatus.upcoming).length} 个预约',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('新建预约'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        calendarFormat: _calendarFormat,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        eventLoader: (day) {
          return _appointments.where((appointment) {
            return appointment.date.year == day.year &&
                appointment.date.month == day.month &&
                appointment.date.day == day.day;
          }).toList();
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          weekendTextStyle: const TextStyle(color: AppColors.textSecondary),
          defaultTextStyle: const TextStyle(color: AppColors.textPrimary),
          selectedTextStyle: const TextStyle(color: Colors.white),
          todayTextStyle: const TextStyle(color: AppColors.primary),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonShowsNext: false,
          formatButtonDecoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          formatButtonTextStyle: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
          leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.textSecondary),
          rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          titleTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    List<Appointment> dayAppointments = _todayAppointments;
    if (_selectedDay != null) {
      dayAppointments = _appointments.where((appointment) {
        return appointment.date.year == _selectedDay!.year &&
            appointment.date.month == _selectedDay!.month &&
            appointment.date.day == _selectedDay!.day;
      }).toList();
    }

    dayAppointments.sort((a, b) => a.date.compareTo(b.date));

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedDay != null
                ? '${_selectedDay!.year}年${_selectedDay!.month}月${_selectedDay!.day}日'
                : '今日预约',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: dayAppointments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: 64, color: AppColors.textTertiary),
                        const SizedBox(height: 16),
                        Text(
                          '暂无预约',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: dayAppointments.length,
                    itemBuilder: (context, index) {
                      return _buildAppointmentCard(dayAppointments[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    Color statusColor;
    String statusText;

    switch (appointment.status) {
      case AppointmentStatus.upcoming:
        statusColor = AppColors.primary;
        statusText = '即将开始';
        break;
      case AppointmentStatus.completed:
        statusColor = AppColors.successText;
        statusText = '已完成';
        break;
      case AppointmentStatus.cancelled:
        statusColor = AppColors.errorText;
        statusText = '已取消';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    appointment.clientAvatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.clientName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.notes,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text(
                '${appointment.date.hour.toString().padLeft(2, '0')}:${appointment.date.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.schedule, size: 16, color: AppColors.textTertiary),
              const SizedBox(width: 4),
              Text(
                '${appointment.duration} 分钟',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum AppointmentType {
  initial,
  followUp,
  consultation,
}

enum AppointmentStatus {
  upcoming,
  completed,
  cancelled,
}

class Appointment {
  final int id;
  final String clientName;
  final String clientAvatar;
  final DateTime date;
  final int duration;
  final AppointmentType type;
  final AppointmentStatus status;
  final String notes;

  Appointment({
    required this.id,
    required this.clientName,
    required this.clientAvatar,
    required this.date,
    required this.duration,
    required this.type,
    required this.status,
    required this.notes,
  });
}
