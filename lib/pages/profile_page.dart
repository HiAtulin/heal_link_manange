import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../provider/counselor_provider.dart';
import '../models/counselor.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadCounselorData();
  }

  void _loadCounselorData() {
    final counselor = ref.read(counselorProvider);
    if (counselor != null) {
      setState(() {
        _nameController.text = counselor.fullName;
        _emailController.text = counselor.email;
        _phoneController.text = counselor.phone;
        _licenseController.text = counselor.qualification.isNotEmpty
            ? '心理咨询师证书编号：${counselor.qualification[0]}'
            : '';
        _specialtyController.text = counselor.major.join('、');
        _experienceController.text = '${counselor.experience}年心理咨询经验';
        _bioController.text = counselor.introduction;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _licenseController.dispose();
    _specialtyController.dispose();
    _experienceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(flex: 2, child: _buildProfileCard()),
              const SizedBox(width: 24),
              Expanded(child: _buildSettingsCard()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('个人资料', style: Theme.of(context).textTheme.displaySmall),
        if (!_isEditing)
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
            icon: const Icon(Icons.edit),
            label: const Text('编辑资料'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        else
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                  });
                },
                icon: const Icon(Icons.cancel),
                label: const Text('取消'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isEditing = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('保存成功'),
                        backgroundColor: AppColors.successText,
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('保存'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: Text(
                        _nameController.text[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (_isEditing)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField(
              controller: _nameController,
              label: '姓名',
              icon: Icons.person,
              enabled: _isEditing,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入姓名';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _emailController,
              label: '邮箱',
              icon: Icons.email,
              enabled: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入邮箱';
                }
                if (!value.contains('@')) {
                  return '请输入有效的邮箱地址';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _phoneController,
              label: '电话',
              icon: Icons.phone,
              enabled: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入电话';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _licenseController,
              label: '证书编号',
              icon: Icons.card_membership,
              enabled: _isEditing,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入证书编号';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _specialtyController,
              label: '专业领域',
              icon: Icons.psychology,
              enabled: _isEditing,
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _experienceController,
              label: '工作经验',
              icon: Icons.work,
              enabled: _isEditing,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _bioController,
              label: '个人简介',
              icon: Icons.description,
              enabled: _isEditing,
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            filled: !enabled,
            fillColor: enabled ? null : AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: enabled ? AppColors.border : Colors.transparent,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: enabled ? AppColors.border : Colors.transparent,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsCard() {
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
          Text('账户设置', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          _buildSettingItem(
            icon: Icons.lock,
            title: '修改密码',
            subtitle: '定期更换密码以保护账户安全',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.notifications,
            title: '通知设置',
            subtitle: '管理您的通知偏好',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: '语言设置',
            subtitle: '选择您的首选语言',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.dark_mode,
            title: '主题设置',
            subtitle: '切换深色或浅色主题',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip,
            title: '隐私设置',
            subtitle: '管理您的隐私和数据',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.border),
          const SizedBox(height: 24),
          _buildSettingItem(
            icon: Icons.help,
            title: '帮助与支持',
            subtitle: '获取帮助和常见问题解答',
            onTap: () {},
          ),
          _buildSettingItem(
            icon: Icons.info,
            title: '关于',
            subtitle: '应用版本和相关信息',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('确认退出'),
                    content: const Text('确定要退出登录吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('已退出登录'),
                              backgroundColor: AppColors.successText,
                            ),
                          );
                        },
                        child: const Text('确定'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout, color: AppColors.errorText),
              label: const Text(
                '退出登录',
                style: TextStyle(color: AppColors.errorText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
