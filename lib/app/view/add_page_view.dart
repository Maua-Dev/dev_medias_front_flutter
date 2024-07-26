import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, required this.title});
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
                  child: TextField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Buscar Matéria",
                      fillColor: AppColors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.search),
                      suffixIconColor: AppColors.red,
                      border: OutlineInputBorder(
                        borderRadius: Round.primary,
                        borderSide: BorderSide.none,
                      )
                    ),
                    // height: 50,
                    // decoration: BoxDecoration(
                    //   color: AppColors.white,
                    //   borderRadius: Round.primary
                    // ),
                    // style: TextButton.styleFrom(backgroundColor: AppColors.white, shape: RoundedRectangleBorder(borderRadius: Round.primary), minimumSize: Size(0, 50), padding: EdgeInsets.symmetric(horizontal: 10)),
                    // onPressed: () {},
                    // child: Row(
                    //   children: [
                    //     Opacity(opacity: 0.7, child: const Text("Buscar Matéria", style: TextStyle(fontSize: 20.0, color: AppColors.black),)),
                    //     Expanded(child: Container()),
                    //     SvgPicture.asset('lib/app/assets/icons/add_button.svg', height: 30, width: 30,),
                    //   ],
                    // ),
                  ),
                ),
                // Lista de Matérias
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ClipRRect(
                          borderRadius: Round.primary,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: Round.primary
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 12),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(fit: BoxFit.contain, child: Text("Nome da Disciplina", style: TextStyle(fontSize: 18),)),
                                      FittedBox(fit: BoxFit.contain, child: Text("Código da disciplina - Tipo (Anual)", style: TextStyle(fontSize: 12),)),
                                    ],
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () {}, 
                                    icon: Icon(
                                      Icons.add_box, 
                                      color: AppColors.red, 
                                      size: 30,
                                    ),
                                    style: TextButton.styleFrom(shape: CircleBorder()),
                                  )
                                ],
                              ),
                            ),
                          ),
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
