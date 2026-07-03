## Mode Details in ImCurlin

In this section, I will explain the detailed operational modes integrated within ImCurlin. Currently, the framework features 3 distinct modes: Default, Risk, and Defiance Mode. While ImCurlin strictly adheres to a minimalist and server friendly philosophy by default, Defiance Mode acts as a highly aggressive and unconventional engine.

Here are the detailed breakdown of each mode in ImCurlin:

### Default Mode
This is the most fundamental mode in ImCurlin, designed to execute baseline structural scans. It utilizes basic network camouflage by deploying randomized UserAgents and maintaining a dynamic request delay ranging between 2 to 5 seconds. Additionally, to ensure a lowprofile footprint, the tool automatically enforces a 5 seconds cooldown safety window after every 5 consecutive scans. 

You can view the execution interface and results in the screenshot gallery.


### Risk mode
Ini dia saat nya imcurlin menunjukkan "taring" nya, di mode ini imcurlin tidak lagi melakukan pemindaian biasa. Dan risk mode di bagi menjadi 3 bagian, yaitu default risk mode, timebased risk mode, gentle risk mode.
Berikut rincian bagian bagian risk mode:

* Default Risk mode: hanya mengscan biasa, tapi ingat di risk mode penyamarannya lebih bagus. Di risk mode anda WAJIB mengaktifkan tor di terminal anda, jika tidak maka tool akan reject permintaan anda. Di tambah random agent, dan jeda yang lebih lama juga. Di risk mode setiap scan di bungkus socks5.
* Time based risk mode: di sini, imcurlin akan melakukan time based sqli di web yang kamu kirim. Tapi mainnya di angka yang ga terlalu berbahaya (biasanya 2 sampai 3 detik). Dan di mode ini, payload nya akan menggunakan 4 lapis tamper. Jangan lupa dengan taktik penyamaran risk mode juga di tambah.
* Gentle risk mode: mode ini aneh, dia akan melakukan sacn secara lemah lembut, tapi server di paksa jawab dan memberikan alamat asli. Jika server nya mau jawab, orang satu ini bakal kasih hadiah berupa 10 detik delay tool, agar server bisa "bernafas". Jika tidak, ya ngapain peduli dan lanjut aja dengan delay default 6 detik. Jangan lupa penyamaran risk mode juga di tambah disini.

Semua ini akan di validasi false akan di scan di python (SQLI RISK MODE MASIH WIP VALIDASI NYA).
