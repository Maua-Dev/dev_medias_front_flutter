import 'package:dev_medias_front_flutter/app/service/graduation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseGraduationsPayload', () {
    test('lista com código/nome vira mapa por sigla', () {
      final parsed = parseGraduationsPayload([
        {'código': 'CIC', 'nome': 'Ciência da Computação'},
        {'código': 'EAL', 'nome': 'Engenharia de Alimentos'},
      ]);

      expect(parsed['CIC'], 'Ciência da Computação');
      expect(parsed['EAL'], 'Engenharia de Alimentos');
    });

    test('aceita codigo sem acento', () {
      final parsed = parseGraduationsPayload([
        {'codigo': 'ADM', 'name': 'Administração'},
      ]);

      expect(parsed['ADM'], 'Administração');
    });

    test('mapa antigo do CDN continua válido', () {
      final parsed = parseGraduationsPayload({
        'CIC': 'Ciência da Computação',
        'ADM': 'Administração',
      });

      expect(parsed['CIC'], 'Ciência da Computação');
      expect(parsed.length, 2);
    });
  });
}
