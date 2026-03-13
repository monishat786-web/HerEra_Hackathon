import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share_plus/share_plus.dart';
import '../models/evidence_item.dart';
import '../services/evidence_storage_service.dart';
import 'package:intl/intl.dart';

class EvidenceLockerScreen extends StatefulWidget {
  const EvidenceLockerScreen({super.key});

  @override
  State<EvidenceLockerScreen> createState() => _EvidenceLockerScreenState();
}

class _EvidenceLockerScreenState extends State<EvidenceLockerScreen> {
  final EvidenceStorageService _storageService = EvidenceStorageService();
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<EvidenceItem> _evidenceItems = [];
  bool _isLoading = true;
  String? _playingPath;

  @override
  void initState() {
    super.initState();
    _loadEvidence();
  }

  Future<void> _loadEvidence() async {
    setState(() => _isLoading = true);
    final items = await _storageService.getEvidenceItems();
    setState(() {
      _evidenceItems = items.reversed.toList(); // Newest first
      _isLoading = false;
    });
  }

  Future<void> _togglePlayback(String path) async {
    if (_playingPath == path) {
      if (_audioPlayer.state == PlayerState.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.resume();
      }
      setState(() {});
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(DeviceFileSource(path));
      setState(() => _playingPath = path);
      _audioPlayer.onPlayerComplete.listen((event) {
        if (mounted) setState(() => _playingPath = null);
      });
    }
  }

  Future<void> _shareEvidence(EvidenceItem item) async {
    try {
      await Share.shareXFiles([XFile(item.path)], text: 'HerERA Safety Evidence - ${item.description ?? "Recorded Audio"}');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error sharing file: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Evidence Vault",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync_rounded, color: Colors.blueAccent),
            tooltip: "Sync with Cloud",
            onPressed: () async {
              await _storageService.syncAll();
              _loadEvidence();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.black87),
            onPressed: _loadEvidence,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  _buildVaultSummaryCard(),
                  const SizedBox(height: 20),
                  _buildFilterTabs(),
                  const SizedBox(height: 16),
                  if (_evidenceItems.isEmpty)
                    _buildEmptyState()
                  else
                    ..._evidenceItems.map((item) => _buildEvidenceCard(item)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "No evidence captured yet",
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey[500]),
          ),
          Text(
            "Captured SOS data will appear here.",
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceCard(EvidenceItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _buildMediaCard(
        title: item.type == EvidenceType.audio ? "Audio Evidence" : "SOS Log",
        color: item.description?.contains("Scream") == true ? const Color(0xFFDC2626) : const Color(0xFF8B5CF6),
        item: item,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.type == EvidenceType.audio)
              _buildAudioPlayer(item),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_rounded, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  item.location ?? "Unknown Location",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Icon(
                  item.isSynced ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
                  size: 14,
                  color: item.isSynced ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('HH:mm a').format(item.timestamp),
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (item.description != null) ...[
              const SizedBox(height: 8),
              Text(
                item.description!,
                style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500], fontStyle: FontStyle.italic),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPlayer(EvidenceItem item) {
    String path = item.path;
    bool isPlayingItem = _playingPath == path;
    bool isActuallyPlaying = isPlayingItem && _audioPlayer.state == PlayerState.playing;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Play/Pause - Purple
              GestureDetector(
                onTap: () => _togglePlayback(path),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF8B5CF6), // Purple
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isActuallyPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isActuallyPlaying ? "Playing Evidence..." : "Safety Recording",
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: isActuallyPlaying ? null : 0.0,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.withValues(alpha: 0.1)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Share Button - Pink
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                icon: const Icon(Icons.share_rounded, color: Color(0xFFDB2777), size: 20),
                onPressed: () => _shareEvidence(item),
              ),
              const SizedBox(width: 8),
              // Delete Button - Red
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFDC2626), size: 20),
                onPressed: () => _confirmDelete(context, item.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVaultSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text("${_evidenceItems.length}", style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(width: 6),
                  Text("Items Stored", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "0.4 GB", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                    TextSpan(text: " / 5 GB", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.4 / 5.0,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4B5563)),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF6EE7B7).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_user_rounded, color: Colors.black, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    "Blockchain Protected",
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildTab("All", true),
          _buildTab("Audio", false),
          _buildTab("Video", false),
          _buildTab("Photo", false),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[300] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? Colors.transparent : Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMediaCard({
    required String title,
    required Color color,
    required EvidenceItem item,
    required Widget content,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 8, color: color),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6EE7B7).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.lock_rounded, color: Colors.black, size: 10),
                                const SizedBox(width: 4),
                                Text(
                                  "SECURE",
                                  style: GoogleFonts.inter(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      content,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext screenContext, String id) async {
    return showDialog(
      context: screenContext,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          "Delete Evidence",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to permanently delete this evidence? This action cannot be undone.",
          style: GoogleFonts.inter(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("CANCEL", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await _storageService.deleteEvidence(id);
              if (dialogContext.mounted) Navigator.pop(dialogContext);
              
              if (success) {
                _loadEvidence();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Evidence deleted successfully"), backgroundColor: Colors.black87),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626), // Red
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("DELETE", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
