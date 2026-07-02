import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

const String _kDefaultNoticeTitle = 'Aviso';

const String _kDefaultNoticeBody = '''

Lembre-se de conferir suas notas oficiais no sistema da instituição. Este aplicativo é uma ferramenta de apoio e pode conter erros ou interpretações diferentes do regulamento vigente.

Se encontrar inconsistências, utilize o canal de suporte para reportar o problema com o máximo de detalhes possível.

Obrigado por utilizar o DevMédias. Role até o final deste texto para habilitar o botão de confirmação.
''';

/// Aviso já fechado nesta execução do app; reinicia ao fechar e reabrir o app.
bool noticeDismissedThisAppSession = false;

/// Mostra o card de aviso em tela quase cheia; só fecha após rolar até o fim e tocar em ENTENDI.
Future<void> showBlockingNoticeDialog(
  BuildContext context, {
  String? title,
  String? description,
}) async {
  if (noticeDismissedThisAppSession) return;

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      final size = MediaQuery.sizeOf(dialogContext);
      final horizontalInset = 20.0;
      final verticalInset = 32.0;
      return Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: horizontalInset,
          vertical: verticalInset,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          width: size.width - horizontalInset * 2,
          height: size.height - verticalInset * 2,
          child: NoticeCard(
            title: title ?? _kDefaultNoticeTitle,
            description: description ?? _kDefaultNoticeBody,
          ),
        ),
      );
    },
  );
}

class NoticeCard extends StatefulWidget {
  const NoticeCard({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  State<NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<NoticeCard> {
  final ScrollController _scrollController = ScrollController();
  bool _reachedBottom = false;

  static const double _scrollEndTolerance = 12;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncScrollState());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() => _syncScrollState();

  void _syncScrollState() {
    if (!mounted) return;
    final c = _scrollController;
    if (!c.hasClients) return;
    final maxExtent = c.position.maxScrollExtent;
    final pixels = c.position.pixels;
    final atEnd = maxExtent <= _scrollEndTolerance ||
        pixels >= maxExtent - _scrollEndTolerance;
    if (atEnd != _reachedBottom) {
      setState(() => _reachedBottom = atEnd);
    }
  }

  void _onEntendi() {
    noticeDismissedThisAppSession = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.backgroundLight,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    widget.description.trim(),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (!_reachedBottom)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Role até o final para continuar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.55),
                    fontSize: 13,
                  ),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                disabledBackgroundColor: AppColors.textFaded,
                disabledForegroundColor: AppColors.white.withValues(alpha: 0.5),
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _reachedBottom ? _onEntendi : null,
              child: const Text(
                'ENTENDI',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
