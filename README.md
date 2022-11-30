# Cardalogis
Cardalogis Project Last 04
Project Last
---

need to use the plutus playground application
- Use This Code and Evaluate This Script
- Use Simulate and available tutorial in document

=========== Simulation =================
B.	SMART CONTRACT
Smart contract ini digunakan untuk pembayaran pada layanan pengiriman / logistik / kurir. Langkah-langkah untuk memakai smart contrat : 
1.	Masukan Pembayaran  agen jasa pengiriman 
walet add
	[wallet1 = a2c20c77887ace1cd986193e4e75babd8993cfd56995cd5cfce609c2]
	[wallet2 = 80a4f45b56b88d1139da23bc4c3c75ec6d32943c087f250b86193ca7]
	[wallet3 = 2e0ad60c3207248cecd47dbde3d752e0aad141d6b8f81ac2c6eca27c]
	[wallet4 = 557d23c0a533b4d295ac2dc14b783a7efc293bc23ede88a6fefd203d]
	[wallet5 = bf342ddd3b1a6191d4ce936c92d29834d6879edf2849eaea84c827f8]

2.	Masukan Batas Waktu Pengiriman  POSIX-time format. Waktu dalam simulasi ini Rabu, Juli 29, 2020 9:44:52.999 PM GMT (POSIX-time : 1596059092999). untuk contoh batas waktu yang telah ditetapkan Rabu, juli 29, 2020 9:45:01 PM (POSIX-time : 1596059101000) maka transaksi dari wallet-1 (Customer) ke wallet-2 (Pengiriman dan Pengantaran) akan berhasil jika slot waktu lebih besar dari atau sama dengan 10 detik dalam simulasi.

Plutus Playground - Value
---------------------------------------------------------------
	[1596059092999 = Wednesday, July 29, 2020 9:44:52.999 PM (NOW)]
	[1596059101000 = Wednesday, July 29, 2020 9:45:01 PM (+10 slot)]
	[1596059111000 = Wednesday, July 29, 2020 9:45:11 PM (+20 slot)]
	[1596059121000 = Wednesday, July 29, 2020 9:45:21 PM (+30 slot)]
	[1596059131000 = Wednesday, July 29, 2020 9:45:21 PM (+40 slot)]
	[1596059141000 = Wednesday, July 29, 2020 9:45:21 PM (+50 slot)]

3.	Masukkan lokasi/kota tujuan pengiriman barang yang akan dikirim lalu masukkan lokasi/kota tujuan pengiriman barang yang akan dikirim. Nama kota dimasukkan 

Harus Berdasarkan daftar rute berikut : 
Pengiriman Awal	Pengiriman Tujuan	Biaya Pengiriman (Lovelace)
[PADANG    To  JAKARTA 	    1100000 ]
[JAKARTA   To	PADANG	      1200000]
[PADANG	  To  SURABAYA	    3100000]
[SURABAYA  To	PADANG	      3100000]
[PADANG    To	DENPASAR	    7100000]
[DENPASAR  To	PADANG	      7100000]
[PADANG    To	MEDAN	        11000000]
[MEDAN     To	PADANG	      11000000]
[JAKARTA   To	SURABAYA	    4200000]
[SURABAYA  To	JAKARTA	      4200000]
[JAKARTA   To	DENPASAR	    8100000]
[DENPASAR  To	JAKARTA	      8200000]
[JAKARTA   To	MEDAN	        9100000]
[MEDAN     To	JAKARTA	      9100000]
[SURABAYA  To	DENPASAR	    4100000]
[DENPASAR  To	SURABAYA	    420000]
[SURABAYA  To	MEDAN	        131000000]
[MEDAN     To	SURABAYA	    132000000]]
[DENPASAR  To	MEDAN	        155200000]
[MEDAN     To	DENPASAR	    155000000]

4.	Masukkan berat_kg dengan nomor. Ini adalah berat barang yang akan dikirimkan. Perhitungan akhir pembayaran dapat dihitung dengan rumus berikut, Pembayaran = (1000000 Lovelace * weight_kg + Pengiriman)

5.	Masukan Reward yang ingin di berikan (harus berupa angka) 1 until 10

6.	Masukan Nama Barang yang akan dikirim (nama barang)

7.	Masukan Alamat yang akan di kirimkan

8.	Langkah terakhir adalah yang mengkonfirmasi Address Yang telah di kirim  - memasukan receipt Number berupa random number misal 123456. Receipt Number akan menjadi konfirmasi  beserta paymentAddress dan Deadline Pengiriman sebagai parameter datum yang akan divalidasi di onchain.

========================================
