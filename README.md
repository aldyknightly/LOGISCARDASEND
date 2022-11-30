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
SImulation Success
![image](https://user-images.githubusercontent.com/38272712/204819945-53fa9d98-7fba-4508-a1cd-31dc40f01740.png)

![image](https://user-images.githubusercontent.com/38272712/204820003-cca16572-69c0-4293-a0a3-8bed501f1b12.png)

![image](https://user-images.githubusercontent.com/38272712/204820060-a20b901c-08d4-41cb-83a2-f209653886a7.png)

![image](https://user-images.githubusercontent.com/38272712/204820142-095f1c33-5cfb-4a36-9e2e-42da6eaf4d42.png)

Simulation Time Out more 7 Slot or 9
![image](https://user-images.githubusercontent.com/38272712/204820352-5a65e367-892e-47c9-97f3-58dc4c181816.png)

![image](https://user-images.githubusercontent.com/38272712/204820476-0022813d-ad77-4b83-a9dc-9459fc66840e.png)

![image](https://user-images.githubusercontent.com/38272712/204820537-867acc9a-1356-4074-80c1-6bc6385781a2.png)

![image](https://user-images.githubusercontent.com/38272712/204820609-6de6df2e-9dbf-4b0d-a197-d2e11cdff63f.png)

Simulation Wrong Pins
![image](https://user-images.githubusercontent.com/38272712/204820810-2fc499c7-0ba3-4c9a-bb39-74996fb5cfff.png)

![image](https://user-images.githubusercontent.com/38272712/204820966-0c2fa2fc-d3cd-45d3-821a-e6c84a626556.png)

![image](https://user-images.githubusercontent.com/38272712/204821060-e4fa5133-66d8-4262-918d-b47cc29b52f6.png)

![image](https://user-images.githubusercontent.com/38272712/204821124-b156cec4-7930-4d9d-9e2e-07eff5a2205d.png)


