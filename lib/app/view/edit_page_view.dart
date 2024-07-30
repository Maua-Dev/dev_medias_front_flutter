import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    HomePageController controller = HomePageController();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo DevMédias
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: const Image(image: AssetImage('lib/app/assets/images/dev_medias_logo.png')),
                ),
                // Botão Adicionar Matérias
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: Round.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8, vertical: 4),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Nome da Disciplina", style: TextStyle(fontSize: 22, color: AppColors.black),),
                              const Text("Código da disciplina", style: TextStyle(fontSize: 12, color: AppColors.black),),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(onPressed: () {}, icon: Icon(Icons.delete, color: AppColors.red, size: 30,))
                        ],
                      ),
                    ),
                  ),
                ),
                // Lista de Matérias
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: Round.primary
                          ),
                          child: Column(
                            children: [
                              Text("Provas", style: TextStyle(color: AppColors.black, fontSize: 16)),
                              Text("Trabalhos", style: TextStyle(color: AppColors.black, fontSize: 16)),
                              Text("Média Final", style: TextStyle(color: AppColors.black, fontSize: 16)),
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: Container()),
                // Seção de Suporte
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: Round.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Precisa de Ajuda?", style: TextStyle(color: AppColors.white, fontSize: 15),),
                            Text("Entre em contato com a Dev", style: TextStyle(color: AppColors.white, fontSize: 10),),
                          ],
                        ),
                      Expanded(child: Container()),
                      ElevatedButton(style: TextButton.styleFrom(backgroundColor: AppColors.purpleButton, shape: RoundedRectangleBorder(borderRadius: Round.primary)) ,onPressed: () {}, child: Text("Suporte", style: TextStyle(color: AppColors.white),))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.incrementCounter(),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
