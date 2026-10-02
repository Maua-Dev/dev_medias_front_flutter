import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/service/course_service.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class CurrentCourseCard extends StatelessWidget {
  final int index;
  final String finalScore;
  final CourseModel course;

  // TO-DO adicionar tratamento de atributos null
  const CurrentCourseCard({
    super.key,
    required this.index,
    required this.finalScore,
    required this.course,
  });

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                height: course.isCustom ? 148 : 128,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Excluir matéria?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.red),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.isCustom
                          ? "Excluir ${course.name}? Ela será removida permanentemente (não aparecerá mais na lista de adicionar)."
                          : "Remover ${course.name} da sua lista?",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: Round.primary),
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 7)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Excluir"),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: Round.primary),
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 7)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancelar"),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _onDeletePressed(BuildContext context) async {
    final confirmed = await _confirmDelete(context);
    if (!confirmed || !context.mounted) return;

    try {
      await coursesController.removeCourseFromHome(course);
    } on CourseApiException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir matéria')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double score = double.tryParse(finalScore.replaceAll(',', '.')) ?? 0.0;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit', arguments: {'course': course});
        commonController.setPreviousPage("/home");
      },
      child: ClipRRect(
        borderRadius: Round.primary,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: Round.primary),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: Round.secondary,
                    color:
                        score <= 6.0 ? AppColors.red : const Color(0xFF00398C),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 28,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          finalScore == 'null' ? "N.A" : finalScore,
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 320,
                        child: Text(
                          course.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18, color: AppColors.black),
                        ),
                      ),
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              Text(
                                course.code,
                                style: const TextStyle(fontSize: 12),
                              ),
                              if (course.isCustom) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.purpleButton,
                                    borderRadius: Round.secondary,
                                  ),
                                  child: const Text(
                                    'Personalizada',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              // Lixo só em matéria custom — catálogo oficial não mostra ícone
              if (course.isCustom)
                IconButton(
                  tooltip: 'Excluir matéria personalizada',
                  onPressed: () => _onDeletePressed(context),
                  icon: const Icon(Icons.delete_outline, color: AppColors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
