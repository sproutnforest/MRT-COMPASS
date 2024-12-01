import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int _selectedIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final List<ChatBubble> _messages = [
    const ChatBubble(
      message: 'Halo selamat datang!, saya MRT COMPASS, yang akan menjawab pertanyaan anda',
      isSentByAssistant: true,
    ),
    const ChatBubble(
      message: 'Apa ada yang bisa saya bantu hari ini?', 
      isSentByAssistant: true,
    ),
  ];

  void _sendMessage() {
    final String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(ChatBubble(
        message: userMessage, 
        isSentByAssistant: false
      ));
      _controller.clear();
    });

    // Add assistant response
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatBubble(
          message: _generateResponse(userMessage),
          isSentByAssistant: true,
        ));
      });
    });
  }

  String _generateResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();
    
    Map<String, String> responses = {
      'help': 'Tentu! Apakah Anda membutuhkan bantuan dengan akun Anda? apakah berhubungan dengan transaksi ataupun pembayaran?',
      'phone': 'Anda dapat menghubungi Customer Service kami di 800.123.4567. Kami siap membantu Anda!',
      'apa kabar?': 'Saya baik, terima kasih sudah bertanya. Semoga Anda juga dalam keadaan sehat. Semoga hari Anda menyenankan!',
      'balance': '''
        Untuk mengecek point yang telah anda kumpulkan, ikuti langkah berikut:
        1. Buka aplikasi dan login ke akun Anda.
        2. Silahkan pergi ke bagian profil Anda.
        3. Klik bagian points Anda.
        4. Anda akan melihat jumlah point yang telah terkumpul.
      ''',
      'transaction': '''
        Untuk mengecek status transaksi:
        1. Buka aplikasi dan login ke akun Anda.
        2. Silahkan pergi ke bagian profil Anda.
        3. Pilih menu "History" di dashboard.
        4. Di halaman tersebut, Anda akan melihat status transaksi.
      ''',
      'payment method': '''
        Kami mendukung berbagai metode pembayaran:
        - Transfer bank
        - Dompet digital
        - Qr payment
      ''',
    };

    for (var entry in responses.entries) {
      if (userMessage.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'Maaf, saya tidak mengerti. Bisa jelaskan lebih lanjut?';
  }

  void _sendSuggestedMessage(String message) {
    setState(() {
      _messages.add(ChatBubble(
        message: message, 
        isSentByAssistant: false
      ));
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatBubble(
          message: _generateResponse(message),
          isSentByAssistant: true,
        ));
      });
    });
  }

  // void _onNavBarTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   switch (index) {
  //     case 1:
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const TicketScreen()),
  //       );
  //       break;
  //     case 2:
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const ProfileScreen()),
  //       );
  //       break;
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('FAQ'),
        backgroundColor: Colors.grey[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Agent Info Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'D', 
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MRT COMPASS Siap membantu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('FAQ Virtual untuk Anda'),
                  ],
                ),
              ],
            ),
          ),

          // Chat Messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[_messages.length - 1 - index];
              },
            ),
          ),

          // Message Input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),

          // Quick Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Help'),
                  child: const Text('Help'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Contact Phone'),
                  child: const Text('Contact Us'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Check Balance'),
                  child: const Text('Check Balance'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Transaction History'),
                  child: const Text('Transaction History'),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.confirmation_number),
      //         label: 'Ticket'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), label: 'Profile'),
      //   ],
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   currentIndex: _selectedIndex,
      //   // onTap: _onNavBarTap,
      // ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByAssistant;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByAssistant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Align(
        alignment: isSentByAssistant 
            ? Alignment.centerLeft 
            : Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSentByAssistant ? Colors.blue : Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
