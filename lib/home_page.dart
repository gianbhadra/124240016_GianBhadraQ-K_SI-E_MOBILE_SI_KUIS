// Import Flutter Material Design
import 'package:flutter/material.dart';

import 'stationery_item.dart';

// Import halaman detail makanan
import 'detail_page.dart';

// Import halaman profile
import 'profile_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final List<StationeryItem> item = StationeryItem.sampleData;

  int selectedIndex = 0;


  // ========================================================
  // HALAMAN HOME
  // ========================================================
  Widget buildHome() {

    return Column(
      children: [

        // --------------------------------------------------
        // DAFTAR MAKANAN
        // --------------------------------------------------
        Expanded(
          child: ListView.builder(

            itemCount: item.length,

            // Membuat tampilan setiap makanan
            itemBuilder: (context, index) {

              // Mengambil data makanan berdasarkan index
              final stationery = item[index];


              // ------------------------------------------------
              // CARD MAKANAN
              // ------------------------------------------------
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                // InkWell digunakan agar card dapat diklik
                child: InkWell(

                  // ============================================
                  // KETIKA CARD MAKANAN DIKLIK
                  // ============================================
                  onTap: () {

                    // Membuka halaman DetailPage
                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) {

                          return DetailPage(
                            // Mengirim data makanan
                            // ke halaman DetailPage
                            stationery: stationery,
                          );
                        },
                      ),

                    // Setelah kembali dari DetailPage
                    ).then((_) {

                      // Memperbarui tampilan Home
                      // agar quantity dan total ikut berubah
                      setState(() {});
                    });
                  },


                  // Isi Card
                  child: Padding(
                    padding: const EdgeInsets.all(10),

                    child: Row(
                      children: [

                        // ======================================
                        // GAMBAR Item
                        // ======================================
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),

                          child: Image.network(
                            stationery.imageUrl,

                            // Lebar gambar
                            width: 90,

                            // Tinggi gambar
                            height: 90,

                            // Gambar memenuhi area
                            fit: BoxFit.cover,

                            // Jika gambar gagal dimuat
                            errorBuilder:
                                (context, error, stackTrace) {

                              return Container(
                                width: 90,
                                height: 90,
                                color: Colors.grey.shade300,


                              
                              );
                            },
                          ),
                        ),


                        const SizedBox(width: 12),


                        // ======================================
                        // INFORMASI MAKANAN
                        // ======================================
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              // Nama makanan
                              Text(
                                stationery.name,

                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),


                              const SizedBox(height: 4),


                              // Deskripsi makanan
                              Text(
                                stationery.description,

                                maxLines: 2,

                                overflow:
                                    TextOverflow.ellipsis,
                              ),


                              const SizedBox(height: 6),


                              // Harga makanan
                              Text(
                                'Rp ${stationery.formattedPrice}/Pcs',

                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              stationery.stock > 0
                                  ? Text(
                                      'Stok: ${stationery.stock}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : const Text(
                                      'Stok : 0',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  // ========================================================
  // BUILD UTAMA
  // ========================================================
  @override
  Widget build(BuildContext context) {

    // Daftar halaman yang tersedia
    final pages = [
      buildHome(),

      const ProfilePage(),
    ];


    return Scaffold(

      // ====================================================
      // APP BAR
      // ====================================================
      appBar: AppBar(
        title: const Text('Toko Alat Tulis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 0, 102, 255),

        centerTitle: true,
      ),


      // ====================================================
      // BODY
      // ====================================================
      // Menampilkan halaman berdasarkan selectedIndex
      body: pages[selectedIndex],


      // ====================================================
      // NAVIGASI BAWAH
      // ====================================================
      bottomNavigationBar:
          BottomNavigationBar(

        // Menentukan menu yang sedang aktif
        currentIndex: selectedIndex,

        // Ketika menu ditekan
        onTap: (index) {

          setState(() {
            selectedIndex = index;
          });
        },


        items: const [

          // Menu Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Barang',
          ),


          // Menu Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}