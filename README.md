# Code-Of-Duty

Godot 4 ile geliştirilen, hikaye odaklı, tek oyunculu bir birinci şahıs nişancı (FPS) oyunu. Oyun görev (mission) tabanlı bir kampanyadan oluşur; raunt, maç ya da çok oyunculu mod yoktur.

> **Durum:** Erken geliştirme aşaması (prototip). Oyun henüz oynanabilir bir sürümde değil.

## Oyun Hakkında

- **Tür:** Hikayeli, tek oyunculu FPS
- **Yapı:** Görevlerden oluşan kısa bir kampanya
- **Görünüm:** Low poly 3D
- **Temel oynanış:** Hızlı tempolu çatışmalar, siper kullanımı, görevler arasında ilerleyen hikaye

### Hikaye

[Buraya oyunun hikayesini 2-3 cümleyle yaz: oyuncu kim, ne yapmaya çalışıyor, karşısındaki tehdit ne?]

### Planlanan Özellikler

- Akıcı hareket ve tatmin edici silah hissi
- Farklı silahlar ve düşman türleri
- Çatışma arenaları, sahnelenmiş büyük anlar ve telsiz diyaloğu ile anlatılan hikaye
- Checkpoint ve kaydetme sistemi
- Zorluk seviyeleri

## Teknik Bilgiler

- **Oyun motoru:** Godot 4.x
- **Renderer:** Forward+
- **Dil:** GDScript
- **Platform:** PC

## Projeyi Çalıştırma

1. [Godot 4](https://godotengine.org/download) sürümünü indir.
2. Bu depoyu klonla:
   ```
   git clone https://github.com/muh4mmedemin/Code-Of-Duty.git
   ```
3. Godot Project Manager'da **Import** seçeneğiyle klasördeki `project.godot` dosyasını seç.
4. Projeyi aç ve **F5** ile çalıştır.

## Klasör Yapısı

```
assets/     # model, ses, doku
levels/     # görev haritaları
scenes/     # oyuncu, silah, düşman ve diğer sahneler
scripts/    # GDScript dosyaları
ui/         # menüler ve HUD
```

## Üçüncü Taraf Lisansları

Bu oyun [Godot Engine](https://godotengine.org) ile yapılmıştır. Godot, MIT lisansı altındadır; lisans metni [THIRD_PARTY_LICENSES.txt](THIRD_PARTY_LICENSES.txt) dosyasındadır. Projede kullanılan diğer dış varlıklar (varsa) aynı dosyada, kendi lisanslarıyla listelenir.

## Lisans

Bu proje özel lisans altındadır. Tüm hakları saklıdır; izinsiz kullanılamaz, kopyalanamaz ve dağıtılamaz. Ayrıntılar için [LICENSE.txt](LICENSE.txt) dosyasına bak.

Copyright (c) 2026 muh4mmedemin. All rights reserved.