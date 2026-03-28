import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  final List<Session> _sessions = [
    Session(
      id: 1,
      clientName: '张三',
      clientAvatar: '张',
      date: DateTime(2026, 3, 28, 10, 0),
      duration: 60,
      type: SessionType.initial,
      summary: '初诊咨询，了解客户基本情况，建立咨询关系',
      notes: '客户表现出焦虑症状，建议进行进一步评估',
      mood: '焦虑',
      progress: '良好',
    ),
    Session(
      id: 2,
      clientName: '李四',
      clientAvatar: '李',
      date: DateTime(2026, 3, 27, 14, 30),
      duration: 60,
      type: SessionType.followUp,
      summary: '复诊咨询，跟进上次咨询效果',
      notes: '客户反馈睡眠有所改善，情绪稳定',
      mood: '平静',
      progress: '改善',
    ),
    Session(
      id: 3,
      clientName: '王五',
      clientAvatar: '王',
      date: DateTime(2026, 3, 26, 9, 0),
      duration: 60,
      type: SessionType.consultation,
      summary: '常规咨询，讨论近期生活压力',
      notes: '客户工作压力较大，需要学习放松技巧',
      mood: '压力',
      progress: '稳定',
    ),
    Session(
      id: 4,
      clientName: '赵六',
      clientAvatar: '赵',
      date: DateTime(2026, 3, 25, 11, 0),
      duration: 60,
      type: SessionType.followUp,
      summary: '复诊咨询，评估治疗效果',
      notes: '客户症状明显改善，建议继续当前治疗方案',
      mood: '积极',
      progress: '显著改善',
    ),
    Session(
      id: 5,
      clientName: '孙七',
      clientAvatar: '孙',
      date: DateTime(2026, 3, 24, 15, 0),
      duration: 60,
      type: SessionType.initial,
      summary: '初诊咨询，收集客户病史信息',
      notes: '客户有抑郁倾向，建议进行专业评估',
      mood: '低落',
      progress: '待评估',
    ),
    Session(
      id: 6,
      clientName: '钱八',
      clientAvatar: '钱',
      date: DateTime(2026, 3, 23, 10, 30),
      duration: 60,
      type: SessionType.consultation,
      summary: '常规咨询，讨论人际关系问题',
      notes: '客户在家庭关系中遇到困难，需要学习沟通技巧',
      mood: '困惑',
      progress: '进行中',
    ),
  ];

  String _searchQuery = '';
  SessionType? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        _buildFilters(),
        const SizedBox(height: 24),
        Expanded(
          child: _buildSessionsList(),
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
              '咨询记录',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              '共 ${_sessions.length} 条记录',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('新增记录'),
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

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: '搜索客户姓名或记录内容...',
                hintStyle: TextStyle(color: AppColors.textTertiary),
                prefixIcon: Icon(Icons.search, color: AppColors.textTertiary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<SessionType?>(
              value: _selectedType,
              hint: const Text('全部类型'),
              items: const [
                DropdownMenuItem(value: null, child: Text('全部类型')),
                DropdownMenuItem(value: SessionType.initial, child: Text('初诊')),
                DropdownMenuItem(value: SessionType.followUp, child: Text('复诊')),
                DropdownMenuItem(value: SessionType.consultation, child: Text('咨询')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSessionsList() {
    List<Session> filteredSessions = _sessions.where((session) {
      final matchesSearch = session.clientName.contains(_searchQuery) ||
          session.summary.contains(_searchQuery) ||
          session.notes.contains(_searchQuery);
      final matchesType = _selectedType == null || session.type == _selectedType;
      return matchesSearch && matchesType;
    }).toList();

    if (filteredSessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              '未找到匹配的记录',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: filteredSessions.length,
      itemBuilder: (context, index) {
        return _buildSessionCard(filteredSessions[index]);
      },
    );
  }

  Widget _buildSessionCard(Session session) {
    Color typeColor;
    String typeText;

    switch (session.type) {
      case SessionType.initial:
        typeColor = AppColors.primary;
        typeText = '初诊';
        break;
      case SessionType.followUp:
        typeColor = AppColors.secondary;
        typeText = '复诊';
        break;
      case SessionType.consultation:
        typeColor = AppColors.accent;
        typeText = '咨询';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    session.clientAvatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
                    Row(
                      children: [
                        Text(
                          session.clientName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            typeText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: typeColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          '${session.date.year}年${session.date.month}月${session.date.day}日',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          '${session.date.hour.toString().padLeft(2, '0')}:${session.date.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.schedule, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 4),
                        Text(
                          '${session.duration} 分钟',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '咨询摘要',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  session.summary,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.sentiment_satisfied,
                  label: '情绪',
                  value: session.mood,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoChip(
                  icon: Icons.trending_up,
                  label: '进展',
                  value: session.progress,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.note, color: AppColors.infoText, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    session.notes,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.infoText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum SessionType {
  initial,
  followUp,
  consultation,
}

class Session {
  final int id;
  final String clientName;
  final String clientAvatar;
  final DateTime date;
  final int duration;
  final SessionType type;
  final String summary;
  final String notes;
  final String mood;
  final String progress;

  Session({
    required this.id,
    required this.clientName,
    required this.clientAvatar,
    required this.date,
    required this.duration,
    required this.type,
    required this.summary,
    required this.notes,
    required this.mood,
    required this.progress,
  });
}
