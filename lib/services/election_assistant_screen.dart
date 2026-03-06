import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:provider/provider.dart';
import '../services/voice_service.dart';
import '../services/nlp_service.dart';

class ElectionAssistantScreen extends StatefulWidget {
  const ElectionAssistantScreen({super.key});

  @override
  State<ElectionAssistantScreen> createState() =>
      _ElectionAssistantScreenState();
}

class _ElectionAssistantScreenState extends State<ElectionAssistantScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _queryController = TextEditingController();
  final NLPService _nlpService = NLPService();
  NLPResponse? _response;
  bool _isLoading = false;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = '';

  late AnimationController _pulseController;

  final List<String> _quickQueries = [
    'BJP Slogan',
    'Congress Symbol',
    'DMK CM candidate',
    '2026 Prediction',
    '2021 Results',
    'TVK Info',
    'TVK Symbol',
    'Lotus Party',
  ];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _queryController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _processQuery([String? text]) {
    final query = text ?? _queryController.text;
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _response = null;
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _response = _nlpService.processQuery(query);
          _isLoading = false;
        });
        // Call Text-to-Speech
        context.read<VoiceService>().speak(_response!.text);
      }
    });
  }

  void _listen() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return;

    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => debugPrint('onStatus: $val'),
        onError: (val) => debugPrint('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _lastWords = val.recognizedWords;
              _queryController.text = _lastWords;
            });
            if (val.finalResult) {
              setState(() => _isListening = false);
              _processQuery();
            }
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      body: Stack(
        children: [
          // Background Gradient Orbs
          Positioned(
            top: -100,
            right: -100,
            child: _buildOrb(const Color(0xFF22D3EE).withOpacity(0.15), 300),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildOrb(const Color(0xFF10B981).withOpacity(0.1), 250),
          ),

          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                _buildQuickActions(),
                Expanded(child: _buildMainContent()),
                _buildInputSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrb(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: const Icon(
              Icons.analytics_rounded,
              color: Color(0xFF22D3EE),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Election Insights',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Local NLP Intelligence',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: _quickQueries.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _queryController.text = _quickQueries[index];
              _processQuery(_quickQueries[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              alignment: Alignment.center,
              child: Text(
                _quickQueries[index],
                style: GoogleFonts.outfit(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainContent() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Color(0xFF22D3EE),
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              'Analyzing Knowledge Base...',
              style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.4)),
            ),
          ],
        ),
      );
    }

    if (_response == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bubble_chart_outlined,
              size: 80,
              color: Colors.white.withOpacity(0.05),
            ),
            const SizedBox(height: 24),
            Text(
              'Awaiting your inquiry',
              style: GoogleFonts.outfit(
                color: Colors.white.withOpacity(0.2),
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: _buildGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome,
                  size: 18,
                  color: Color(0xFF22D3EE),
                ),
                const SizedBox(width: 8),
                Text(
                  'Analysis Result',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF22D3EE),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _response!.text,
              style: GoogleFonts.outfit(
                color: Colors.white.withOpacity(0.9),
                fontSize: 17,
                height: 1.6,
              ),
            ),
            if (_response!.imagePath != null) ...[
              const SizedBox(height: 24),
              _buildImageContainer(_response!.imagePath!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildImageContainer(String path) {
    return Center(
      child: Column(
        children: [
          Text(
            'Official Symbol Identifier',
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(path, height: 160, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: _buildGlassCard(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _queryController,
                style: GoogleFonts.outfit(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: GoogleFonts.outfit(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _processQuery(),
              ),
            ),
            _buildListeningIndicator(),
            const SizedBox(width: 8),
            _buildActionIcon(
              icon: Icons.send_rounded,
              color: const Color(0xFF22D3EE),
              onTap: _processQuery,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListeningIndicator() {
    return GestureDetector(
      onTap: _listen,
      child: ScaleTransition(
        scale: _isListening
            ? _pulseController
            : const AlwaysStoppedAnimation(1.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isListening
                ? const Color(0xFFF43F5E)
                : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
            color: _isListening ? Colors.white : Colors.white.withOpacity(0.4),
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
