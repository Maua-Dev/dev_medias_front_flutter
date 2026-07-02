import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_form.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Menu',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(
                  LucideIcons.settings,
                  color: AppColors.white,
                ),
                title: const Text(
                  'Mudar ano/curso',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      elevation: 3,
                      backgroundColor: AppColors.background,
                      content: AddCourseForm(),
                    ),
                  );
                },
              ),
              if (userController.currentCourses.isNotEmpty)
                ListTile(
                  leading: const Icon(
                    LucideIcons.trash,
                    color: AppColors.white,
                  ),
                  title: const Text(
                    'Apagar todas as matérias',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Confirma antes de remover todas as matérias
                    _showDeleteAllCoursesDialog(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteAllCoursesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Remover todas as matérias?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.red,
            ),
          ),
          content: const Text(
            'Esta ação irá remover todas as suas matérias cadastradas e suas notas. Esta ação não pode ser desfeita.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textFaded,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                coursesController.deleteAllCurrentCourses();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todas as matérias foram removidas'),
                    backgroundColor: AppColors.red,
                  ),
                );
              },
              child: const Text(
                'Remover Todas',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
