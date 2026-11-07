# 📘 Kodlama Standartları

> Projedeki tüm kod, sahne ve dosyalar bu kurallara göre yazılır.

---

## 📝 Script Kuralları

1. 🏷️ **Fonksiyonların ismi ne işe yaradığını anlatmalı.**
2. 💬 **Her fonksiyonun ne yaptığı hakkında bir yorum satırı olmalı.**
3. 🎯 **Bir fonksiyon en fazla 2-3 durumu ele almalı.**
4. 🧩 **Bir fonksiyon çok karışık olmamalı.**

### ✅ İyi ve ❌ kötü isim

```gdscript
# ❌ Kötü: isim ne yaptığını anlatmıyor
func do_stuff():
	pass

# ✅ İyi: isim ne yaptığını anlatıyor
func reload_weapon():
	pass
```

### ✅ Yorum satırı ve az durum

Her fonksiyonun üstünde ne yaptığını anlatan bir yorum vardır. Fonksiyon küçüktür ve en fazla 2-3 durumu ele alır.

```gdscript
# Oyuncunun canını hasar kadar azaltır; can bittiyse ölümü başlatır.
func take_damage(Amount: int) -> void:
	Health = max(Health - Amount, 0)
	if Health == 0:
		die()
```

### 🧩 Karışık fonksiyonu parçalara böl

Bir fonksiyon çok iş yapıyorsa, her işi kendi fonksiyonuna ayır.

```gdscript
var CurrentAmmo := 30
var IsReloading := false


# Ateş etmeyi dener; ateş edilemiyorsa hiçbir şey yapmaz.
func try_fire() -> void:
	if not can_fire():
		return
	consume_ammo()


# Silahın şu an ateş edip edemeyeceğini döndürür.
func can_fire() -> bool:
	return CurrentAmmo > 0 and not IsReloading


# Şarjörden bir mermi düşer.
func consume_ammo() -> void:
	CurrentAmmo -= 1
```

---

## 🎬 Sahne ve Script Düzeni

- 📄 **Her sahnenin scripti ayrı olmalı.** Her sahne kendi scriptini kullanır.

```
player.tscn         ->  player.gd
enemy_soldier.tscn  ->  enemy_soldier.gd
main_menu.tscn      ->  main_menu.gd
```

---

## 🏷️ İsimlendirme

### 🔠 TAM BÜYÜK HARF (`MAX_HEALTH`, `GRAVITY`, `SCREEN_WIDTH`)

- Oyun çalıştığı sürece sabit kalan değerlerde kullanılır.
- Kodu okuyan kişi, bunun dokunulmaması gereken bir ayar değeri olduğunu hemen anlar.
- Birden fazla kelime `_` ile birbirinden ayrılır (bu yazım biçimi SNAKE_CASE olarak bilinir).
- Hız, hasar, zıplama gücü gibi değerleri dengelerken hepsini tek bir yerden değiştirmeyi kolaylaştırır.

### 🔡 PascalCase (`Health`, `MoveSpeed`, `CurrentAmmo`)

- Diğer tüm değişkenler PascalCase olur.

```gdscript
# Değişmeyen değerler: TAM BÜYÜK HARF
const MAX_HEALTH := 100
const GRAVITY := 9.8
const SCREEN_WIDTH := 1920

# Değişen değişkenler: PascalCase
var Health := MAX_HEALTH
var MoveSpeed := 6.0
var CurrentAmmo := 30
```

### 📁 snake_case (`player.tscn`, `main_menu.tscn`)

- Sahne ve dosya isimleri snake_case olur.
- Sahne isimleri açıklayıcı olmalı; isimden sahnenin ne olduğu anlaşılmalı.

| ✅ İyi | ❌ Kötü |
|--------|---------|
| `player.tscn` | `scene1.tscn` |
| `enemy_soldier.tscn` | `new_scene.tscn` |
| `main_menu.tscn` | `menu2.tscn` |

---

## 📋 Özet Tablo

| Ne | Kural | Örnek |
|----|-------|-------|
| 🔒 Hiç değişmeyen değerler | TAM BÜYÜK HARF (SNAKE_CASE) | `MAX_HEALTH`, `GRAVITY`, `SCREEN_WIDTH` |
| 🔁 Diğer tüm değişkenler | PascalCase | `Health`, `MoveSpeed`, `CurrentAmmo` |
| 📁 Sahne ve dosya isimleri | snake_case, açıklayıcı | `player.tscn`, `main_menu.tscn` |