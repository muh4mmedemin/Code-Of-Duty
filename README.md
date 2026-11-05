# Code-Of-Duty

**Code-Of-Duty**, Godot 4 ile geliştirilen, tek oyunculu, görev tabanlı bir birinci şahıs nişancı (FPS) oyunudur. Hızlı ve akıcı çatışmaları, senaryolu sinematik anları ve sade bir low-poly görsel stili bir araya getirir.

> 🚧 **Durum:** Proje planlama aşamasında. Geliştirme yol haritası [Issues](../../issues) ve [Milestones](../../milestones) sayfalarından takip ediliyor.

## Projenin Amacı

Klasik kampanya odaklı FPS oyunlarının hissini, **çoğu bilgisayarda akıcı çalışan** hafif bir oyunda sunmak. Hedefimiz:

- Lineer, görev bazlı bölümlerle sürükleyici bir tek oyunculu deneyim oluşturmak
- Hızlı ve tatmin edici bir silah ve hareket hissi yakalamak
- Düşük poligonlu (low-poly) sade bir görsel stil ile **eski ve düşük özellikli PC'lerde** bile yüksek performans sağlamak

## Öne Çıkan Özellikler (Planlanan)

- 🎯 **Görev bazlı lineer bölümler:** Açık dünya yerine hedef odaklı, tempolu bölüm akışı
- 🏃 **Akıcı hareket:** Sprint, zıplama, eğilme ve nişan alma (ADS)
- ❤️ **Yenilenen sağlık ve siper mantığı:** Siper alarak hayatta kalma odaklı çatışmalar
- 🤖 **Düşman yapay zekâsı:** Devriye, algılama (görüş ve ses), siper alma ve saldırı davranışları
- 💥 **Senaryolu anlar:** Patlamalar, kamera sarsıntıları ve telsiz konuşmaları
- 💾 **Checkpoint sistemi:** Bölüm içinde otomatik kayıt noktaları
- ⚙️ **Geniş grafik ayarları:** Düşük sistemlere uyum için ölçeklenebilir görüntü kalitesi

## Teknolojiler

| Konu | Seçim |
|---|---|
| Oyun motoru | Godot 4.x |
| Programlama dili | GDScript |
| Renderer | Compatibility (düşük donanım desteği için) |
| Görsel stil | Low-poly, flat shaded, ortak renk paleti dokusu |
| Platform | PC (Windows, ileride Linux) |

## Görsel Stil

- Sade formlu, keskin kenarlı, düz gölgeli (flat shaded) modeller
- Tüm modellerin paylaştığı 16-32 renkli tek bir palet dokusu
- Hafif sis, yumuşak ortam ışığı ve okunabilirlik için kontrast vurgu renkleri

## Yol Haritası

| Aşama | Hedef |
|---|---|
| **M0:** Proje Kurulumu | Repo, Godot projesi ve altyapı |
| **M1:** Prototip | Gri kutu haritada yürüyen ve ateş eden oyuncu |
| **M2:** Temel Oynanış | Düşmanlar, sağlık, silahlar ve HUD ile oynanabilir döngü |
| **M3:** Dikey Dilim | Menü, ses ve checkpoint ile cilalı tam bir bölüm |
| **M4:** Genişletme | Ek bölümler, düşmanlar, silahlar ve cilalama |
| **S:** Hikâye ve Evren | Hikâye, evren ve karakter kararları (henüz belirlenmedi) |

## Kapsam Dışı

- Çok oyunculu (multiplayer) mod
- Açık dünya

## Lisanslar ve Üçüncü Taraf Bildirimleri

Bu proje [Godot Engine](https://godotengine.org) ile geliştirilmektedir. Godot Engine MIT lisansı altında dağıtılır.

Kullanılan üçüncü taraf asset'ler (model, ses, yazı tipi vb.) eklendikçe bu bölümde kaynaklarıyla birlikte listelenecektir.

---

Copyright © 2026 muh4mmedemin. All rights reserved.
