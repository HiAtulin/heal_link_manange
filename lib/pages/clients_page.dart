import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  final List<Client> _clients = [
    Client(
      id: 1,
      name: '张三',
      phone: '138****1234',
      email: 'zhangsan@example.com',
      status: ClientStatus.active,
      sessions: 12,
      lastSession: '2026-03-25',
      avatar: '张',
    ),
    Client(
      id: 2,
      name: '李四',
      phone: '139****5678',
      email: 'lisi@example.com',
      status: ClientStatus.active,
      sessions: 8,
      lastSession: '2026-03-24',
      avatar: '李',
    ),
    Client(
      id: 3,
      name: '王五',
      phone: '137****9012',
      email: 'wangwu@example.com',
      status: ClientStatus.paused,
      sessions: 5,
      lastSession: '2026-03-15',
      avatar: '王',
    ),
    Client(
      id: 4,
      name: '赵六',
      phone: '136****3456',
      email: 'zhaoliu@example.com',
      status: ClientStatus.completed,
      sessions: 15,
      lastSession: '2026-03-10',
      avatar: '赵',
    ),
    Client(
      id: 5,
      name: '孙七',
      phone: '135****7890',
      email: 'sunqi@example.com',
      status: ClientStatus.active,
      sessions: 3,
      lastSession: '2026-03-28',
      avatar: '孙',
    ),
    Client(
      id: 6,
      name: '钱八',
      phone: '134****2345',
      email: 'qianba@example.com',
      status: ClientStatus.paused,
      sessions: 7,
      lastSession: '2026-03-20',
      avatar: '钱',
    ),
  ];

  String _searchQuery = '';
  ClientStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 24),
        _buildFilters(),
        const SizedBox(height: 24),
        Expanded(
          child: _buildClientList(),
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
              '客户管理',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              '共 ${_clients.length} 位客户',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('新增客户'),
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
                hintText: '搜索客户姓名、电话或邮箱...',
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
            child: DropdownButton<ClientStatus?>(
              value: _selectedStatus,
              hint: const Text('全部状态'),
              items: const [
                DropdownMenuItem(value: null, child: Text('全部状态')),
                DropdownMenuItem(value: ClientStatus.active, child: Text('活跃')),
                DropdownMenuItem(value: ClientStatus.paused, child: Text('暂停')),
                DropdownMenuItem(value: ClientStatus.completed, child: Text('完成')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClientList() {
    List<Client> filteredClients = _clients.where((client) {
      final matchesSearch = client.name.contains(_searchQuery) ||
          client.phone.contains(_searchQuery) ||
          client.email.contains(_searchQuery);
      final matchesStatus = _selectedStatus == null || client.status == _selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    if (filteredClients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              '未找到匹配的客户',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemCount: filteredClients.length,
      itemBuilder: (context, index) {
        return _buildClientCard(filteredClients[index]);
      },
    );
  }

  Widget _buildClientCard(Client client) {
    Color statusColor;
    String statusText;

    switch (client.status) {
      case ClientStatus.active:
        statusColor = AppColors.primary;
        statusText = '活跃';
        break;
      case ClientStatus.paused:
        statusColor = AppColors.warning;
        statusText = '暂停';
        break;
      case ClientStatus.completed:
        statusColor = AppColors.accent;
        statusText = '完成';
        break;
    }

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
                    client.avatar,
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
                    Text(
                      client.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
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
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(Icons.phone, client.phone),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.email, client.email),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${client.sessions} 次咨询',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '最后咨询: ${client.lastSession}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textTertiary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

enum ClientStatus {
  active,
  paused,
  completed,
}

class Client {
  final int id;
  final String name;
  final String phone;
  final String email;
  final ClientStatus status;
  final int sessions;
  final String lastSession;
  final String avatar;

  Client({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.status,
    required this.sessions,
    required this.lastSession,
    required this.avatar,
  });
}
