# Code-Of-Duty

Godot 4 ile geliştirilen, hikaye odaklı, tek oyunculu bir birinci şahıs nişancı (FPS) oyunu. Oyun görev (mission) tabanlı bir kampanyadan oluşur; raunt, maç ya da çok oyunculu mod yoktur.

> **Durum:** Erken geliştirme aşaması (prototip). Oyun henüz oynanabilir bir sürümde değil.
>
> **Şu an çalışanlar:** Birinci şahıs hareket ve fare ile bakış, koşma, eğilme (tavan kontrolüyle), zıplama, yerdeki silahı alma ve raycast ile ateş etme (test haritasında, geçici modellerle).

## Oyun Hakkında

- **Tür:** Hikayeli, tek oyunculu FPS
- **Yapı:** Görevlerden oluşan kısa bir kampanya
- **Görünüm:** Low poly 3D
- **Temel oynanış:** Hızlı tempolu çatışmalar, siper kullanımı, görevler arasında ilerleyen hikaye

### Hikaye

[Buraya oyunun hikayesini 2-3 cümleyle yaz: oyuncu kim, ne yapmaya çalışıyor, karşısındaki tehdit ne?]

### Planlanan Özellikler

- Akıcı hareket ve tatmin edici silah hissi
- Yerden toplanabilen ve yere atılabilen silahlar
- Farklı silahlar ve düşman türleri
- Çatışma arenaları, sahnelenmiş büyük anlar ve telsiz diyaloğu ile anlatılan hikaye
- Checkpoint ve kaydetme sistemi
- Zorluk seviyeleri

### Silah Sistemi

| Özellik | Tasarım | Durum |
|---|---|---|
| Ateş sistemi | Ateşli silahlar anında isabet eden raycast (hitscan) kullanır, mermi düşüşü yoktur | ✅ Var (oyuncunun `AimRay`'i ile; hasar ve atış hızı henüz uygulanmıyor) |
| Silah verisi | Her silah türü için tek bir `WeaponData` (`.tres`); o türdeki tüm silahlar paylaşır | 🚧 Kısmen (`WeaponData` ve `data/weapons/ak47.tres` var; `ak_47.tscn` henüz kendi içine gömülü veriyi kullanıyor) |
| Yerden alma | Yerdeki silahlar toplanabilir | ✅ Var (`take_item`, yalnızca eller boşken) |
| Yere atma | Eldeki silah yere atılabilir; silah mermi durumunu korur | ⏳ Planlanıyor |
| Slotlar | Klasik 1-2-3 yapısı: 1 = tüfek, 2 = tabanca, 3 = henüz belirlenmedi | ⏳ Planlanıyor (şu an tek silah taşınıyor) |
| Mermi düşüşü | Yalnızca el bombası ve RPG gibi patlayıcı silahlarda (fizik tabanlı projectile) | ⏳ Planlanıyor |
| Kollar ve animasyon | Kollar silah sahnesinde değil oyuncu karakterindedir; tek kol rig'i üzerinde her silaha özel animasyonlar | 🚧 Kısmen (oyuncuda `Arms` düğümü var; kol modeli ve animasyon yok) |

## Teknik Bilgiler

- **Oyun motoru:** Godot 4.7
- **Renderer:** Forward+ (Vulkan / Direct3D 12 destekli ekran kartı gerektirir; Windows'ta Direct3D 12 sürücüsü seçili)
- **Fizik motoru:** Jolt Physics
- **Dil:** GDScript
- **Platform:** PC

## Projeyi Çalıştırma

1. [Godot 4.7](https://godotengine.org/download) veya daha yeni bir sürümü indir.
2. Bu depoyu klonla:
   ```
   git clone https://github.com/muh4mmedemin/Code-Of-Duty.git
   ```
3. Godot Project Manager'da **Import** seçeneğiyle `code-of-duty/project.godot` dosyasını seç.
4. Projeyi aç ve **F5** ile çalıştır.

## Klasör Yapısı

```
Code-Of-Duty/
├── code-of-duty/           # Godot projesi
│   ├── project.godot       # proje dosyası
│   ├── data/
│   │   └── weapons/        # silah verileri (WeaponData .tres)
│   ├── assets/
│   │   ├── audio/          # ses efektleri ve müzik
│   │   ├── models/         # 3D modeller
│   │   └── textures/       # dokular ve palet
│   ├── levels/             # görev haritaları
│   ├── scenes/             # oyuncu, silah, düşman ve diğer sahneler
│   ├── scripts/            # GDScript dosyaları
│   └── ui/                 # menüler ve HUD
├── docs/                   # proje dökümanları
│   ├── CODING_STANDART.md  # kodlama standartları
│   ├── INPUT_MAP.md        # tuş atamaları
│   └── SCRIPT_SYSTEMS.md   # script sistemleri
├── .github/ISSUE_TEMPLATE/ # issue şablonları
├── LICENSE.txt
├── THIRD PARTY LICENSE.txt
└── README.md
```

## Dökümanlar

- [Kodlama Standartları](docs/CODING_STANDART.md): isimlendirme, script ve sahne düzeni kuralları
- [Girdi Haritası](docs/INPUT_MAP.md): eylemler ve varsayılan tuşlar
- [Script Sistemleri](docs/SCRIPT_SYSTEMS.md): script'lerde kullanılan sistemler ve script'ler arası akış

## Üçüncü Taraf Lisansları

Bu oyun [Godot Engine](https://godotengine.org) ile yapılmıştır. Godot, MIT lisansı altındadır; lisans metni [THIRD PARTY LICENSE.txt](THIRD%20PARTY%20LICENSE.txt) dosyasındadır. Projede kullanılan diğer dış varlıklar (varsa) aynı dosyada, kendi lisanslarıyla listelenir.

## Lisans

Bu proje özel lisans altındadır. Tüm hakları saklıdır; izinsiz kullanılamaz, kopyalanamaz ve dağıtılamaz. Ayrıntılar için [LICENSE.txt](LICENSE.txt) dosyasına bak.

Copyright (c) 2026 muh4mmedemin. All rights reserved.