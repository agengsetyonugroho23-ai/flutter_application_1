import 'package:flutter/material.dart';

void main() {
  runApp(const TopUpGameApp());
}

class TopUpGameApp extends StatelessWidget {
  const TopUpGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameZone Top Up',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class GameItem {
  final String title;
  final String category;
  final IconData icon;

  GameItem({required this.title, required this.category, required this.icon});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<GameItem> games = [
    GameItem(title: 'Mobile Legends', category: 'MOBA', icon: Icons.sports_esports),
    GameItem(title: 'Free Fire', category: 'Battle Royale', icon: Icons.local_fire_department),
    GameItem(title: 'PUBG Mobile', category: 'Battle Royale', icon: Icons.crosshairs),
    GameItem(title: 'Genshin Impact', category: 'RPG', icon: Icons.auto_awesome),
    GameItem(title: 'Valorant', category: 'FPS', icon: Icons.bolt),
    GameItem(title: 'Honor of Kings', category: 'MOBA', icon: Icons.shield),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 GameZone Top Up', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
            tooltip: 'Riwayat Transaksi',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.blueAccent],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROMO MINGGU INI!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Top up game favoritmu dan dapatkan cashback hingga 30%.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Pilih Game',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Grid Daftar Game
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopUpDetailPage(game: game),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.deepPurple.shade300,
                          child: Icon(game.icon, size: 32, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          game.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          game.category,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Formulir Top Up
class TopUpDetailPage extends StatefulWidget {
  final GameItem game;

  const TopUpDetailPage({super.key, required this.game});

  @override
  State<TopUpDetailPage> createState() => _TopUpDetailPageState();
}

class _TopUpDetailPageState extends State<TopUpDetailPage> {
  final _userIdController = TextEditingController();
  String? selectedNominal;
  String? selectedPayment;

  final List<String> nominalList = [
    '50 Diamonds / Cash',
    '150 Diamonds / Cash',
    '300 Diamonds / Cash',
    '500 Diamonds / Cash',
    '1000 Diamonds / Cash',
  ];

  final List<String> paymentList = ['QRIS / BRImo', 'E-Wallet (Gopay/OVO)', 'Transfer Bank'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Up ${widget.game.title}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: User ID
            const Text('1. Masukkan User ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Contoh: 12345678 (1234)',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),

            // Step 2: Pilih Nominal
            const Text('2. Pilih Nominal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: nominalList.map((nominal) {
                final isSelected = selectedNominal == nominal;
                return ChoiceChip(
                  label: Text(nominal),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedNominal = selected ? nominal : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Step 3: Metode Pembayaran
            const Text('3. Pilih Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Column(
              children: paymentList.map((payment) {
                return RadioListTile<String>(
                  title: Text(payment),
                  value: payment,
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Tombol Beli
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (_userIdController.text.isEmpty || selectedNominal == null || selectedPayment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Harap lengkapi semua data transaksi!')),
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Konfirmasi Pembelian'),
                      content: Text(
                        'Game: ${widget.game.title}\n'
                        'ID: ${_userIdController.text}\n'
                        'Nominal: $selectedNominal\n'
                        'Metode: $selectedPayment',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pesanan Berhasil Dibuat!')),
                            );
                          },
                          child: const Text('Bayar Sekarang'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'BAYAR SEKARANG',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}