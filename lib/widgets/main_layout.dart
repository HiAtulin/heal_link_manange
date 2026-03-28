import 'package:flutter/material.dart';
import 'package:heal_link_manange/controllers/counselor_auth_controller.dart';
import '../theme/app_colors.dart';
import '../pages/dashboard_page.dart';
import '../pages/clients_page.dart';
import '../pages/appointments_page.dart';
import '../pages/sessions_page.dart';
import '../pages/analytics_page.dart';
import '../pages/profile_page.dart';

class MainCounselorLayout extends StatefulWidget {
  const MainCounselorLayout({super.key});

  @override
  State<MainCounselorLayout> createState() => _MainCounselorLayoutState();
}

class _MainCounselorLayoutState extends State<MainCounselorLayout> {
  final _authController = CounselorAuthController();
  int _selectedIndex = 0;
  bool _isSidebarExpanded = true;

  final List<NavItem> _navItems = [
    NavItem(
      index: 0,
      label: '仪表盘',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    NavItem(
      index: 1,
      label: '客户管理',
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
    ),
    NavItem(
      index: 2,
      label: '预约管理',
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
    ),
    NavItem(
      index: 3,
      label: '咨询记录',
      icon: Icons.description_outlined,
      selectedIcon: Icons.description,
    ),
    NavItem(
      index: 4,
      label: '数据分析',
      icon: Icons.bar_chart_outlined,
      selectedIcon: Icons.bar_chart,
    ),
    NavItem(
      index: 5,
      label: '个人资料',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isSidebarExpanded ? 256 : 80,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _buildSidebarHeader(),
          Expanded(child: _buildNavigation()),
          _buildSidebarFooter(),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      padding: EdgeInsets.all(_isSidebarExpanded ? 24 : 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: _isSidebarExpanded
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (_isSidebarExpanded) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      '心',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '心理咨询',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textSecondary),
              onPressed: () {
                setState(() {
                  _isSidebarExpanded = false;
                });
              },
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textSecondary),
              onPressed: () {
                setState(() {
                  _isSidebarExpanded = true;
                });
              },
            ),
        ],
      ),
    );
  }

  Widget _buildNavigation() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _navItems.length,
      itemBuilder: (context, index) {
        final item = _navItems[index];
        final isSelected = _selectedIndex == item.index;
        return _buildNavItem(item, isSelected);
      },
    );
  }

  Widget _buildNavItem(NavItem item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _isSidebarExpanded ? 12 : 8,
        vertical: 4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = item.index;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: _isSidebarExpanded ? 16 : 16,
            ),
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.primaryGradient : null,
              color: isSelected ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: _isSidebarExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? item.selectedIcon : item.icon,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  size: 24,
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarFooter() {
    return Container(
      padding: EdgeInsets.all(_isSidebarExpanded ? 12 : 8),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Column(
        children: [
          _buildFooterItem(
            icon: Icons.settings_outlined,
            label: '设置',
            onTap: () {},
          ),
          _buildFooterItem(
            icon: Icons.logout,
            label: '退出登录',
            onTap: () async {
              await _authController.signOutUser(context: context);
            },
            isDanger: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _isSidebarExpanded ? 12 : 4,
        vertical: 2,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: _isSidebarExpanded ? 16 : 12,
            ),
            decoration: BoxDecoration(
              color: isDanger
                  ? AppColors.errorLight
                  : _isSidebarExpanded
                  ? null
                  : null,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: _isSidebarExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isDanger ? AppColors.error : AppColors.textSecondary,
                  size: 20,
                ),
                if (_isSidebarExpanded) ...[
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDanger
                          ? AppColors.error
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '搜索客户、预约或记录...',
                  hintStyle: TextStyle(color: AppColors.textTertiary),
                  prefixIcon: Icon(Icons.search, color: AppColors.textTertiary),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Container(height: 40, width: 1, color: AppColors.border),
          const SizedBox(width: 16),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '王医生',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    '心理咨询师',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.surfaceGradient),
      padding: const EdgeInsets.all(24),
      child: _getPageByIndex(_selectedIndex),
    );
  }

  Widget _getPageByIndex(int index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return const ClientsPage();
      case 2:
        return const AppointmentsPage();
      case 3:
        return const SessionsPage();
      case 4:
        return const AnalyticsPage();
      case 5:
        return const ProfilePage();
      default:
        return const DashboardPage();
    }
  }
}

class NavItem {
  final int index;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  NavItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}
