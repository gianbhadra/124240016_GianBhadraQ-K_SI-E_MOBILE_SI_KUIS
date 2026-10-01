// Import Flutter Material Design
import 'package:flutter/material.dart';

// Import model StationeryItem
import 'stationery_item.dart';


// ==========================================================
// DETAIL PAGE
// ==========================================================
// StatefulWidget digunakan karena quantity dapat berubah.
class DetailPage extends StatefulWidget {

  // Data makanan yang dikirim dari HomePage
  final StationeryItem stationery;



  // Constructor DetailPage
  const DetailPage({
    super.key,

    // stationery wajib dikirim dari HomePage
    required this.stationery,
  });


  @override
  State<DetailPage> createState() => _DetailPageState();
}




// ==========================================================
// STATE DETAIL PAGE
// ==========================================================
class _DetailPageState extends State<DetailPage> {
  TextEditingController get _descriptionController => TextEditingController(text: widget.stationery.description);
  TextEditingController get _stockController => TextEditingController(text: widget.stationery.stock.toString());
  TextEditingController get _priceController => TextEditingController(text: widget.stationery.price.toString());

  @override
  Widget build(BuildContext context) {

    // Mengambil data makanan yang dikirim
    // dari HomePage
    final stationery = widget.stationery;


    return Scaffold(

      // ====================================================
      // APP BAR
      // ====================================================
      appBar: AppBar(

        // Judul halaman
        title: const Text('Detail Makanan'),

        centerTitle: true,
      ),


      // ====================================================
      // BODY
      // ====================================================
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // =================================================
            // GAMBAR MAKANAN
            // =================================================
            Image.network(
              stationery.imageUrl,

              // Lebar mengikuti layar
              width: double.infinity,

              // Tinggi gambar
              height: 250,

              // Gambar memenuhi area
              fit: BoxFit.cover,

              // Jika gambar gagal dimuat
              errorBuilder:
                  (context, error, stackTrace) {

                return Container(
                  width: double.infinity,
                  height: 250,

                  color: Colors.grey.shade300,

                  child: const Icon(
                    Icons.fastfood,
                    size: 80,
                  ),
                );
              },
            ),


            // =================================================
            // INFORMASI MAKANAN
            // =================================================
            Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // Nama makanan
                  Text(
                    stationery.name,

                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),


                  const SizedBox(height: 8),



                  // Harga makanan
                  Text(
                    'Rp ${stationery.formattedPrice}/Pcs',

                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.green,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Deskripsi',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Stock',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tombol simpan
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        stationery.description = _descriptionController.text;
                        stationery.stock = int.tryParse(_stockController.text) ?? 0;
                        stationery.price = int.tryParse(_priceController.text) ?? 0;
                      });

                      // Kembali ke halaman sebelumnya
                      Navigator.pop(context);
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}