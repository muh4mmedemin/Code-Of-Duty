# 📘 Kodlama Standartları

> Projedeki tüm kod, sahne ve dosyalar bu kurallara göre yazılır.

---

## 📝 Script Kuralları

1. 🏷️ **Fonksiyonların ismi ne işe yaradığını anlatmalı.**
2. 💬 **Her fonksiyonun ne yaptığı hakkında bir yorum satırı olmalı.**
3. 🎯 **Bir fonksiyon en fazla 2-3 durumu ele almalı.**
4. 🧩 **Bir fonksiyon çok karışık olmamalı.**
5. 📂 **Birbiriyle ilgili fonksiyonlar `#region` / `#endregion` ile gruplanabilir.**

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
func take_damage(amount: int) -> void:
	health = max(health - amount, 0)
	if health == 0:
		die()
```

### 🧩 Karışık fonksiyonu parçalara böl

Bir fonksiyon çok iş yapıyorsa, her işi kendi fonksiyonuna ayır.

```gdscript
var current_ammo := 30
var is_reloading := false


# Ateş etmeyi dener; ateş edilemiyorsa hiçbir şey yapmaz.
func try_fire() -> void:
	if not can_fire():
		return
	consume_ammo()


# Silahın şu an ateş edip edemeyeceğini döndürür.
func can_fire() -> bool:
	return current_ammo > 0 and not is_reloading


# Şarjörden bir mermi düşer.
func consume_ammo() -> void:
	current_ammo -= 1
```

### 📂 Region ile gruplama

```gdscript
#region PLAYER_MOVEMENT_STATE
# Oyuncunun hareket durumunu günceller.
func handle_player_movement_state(delta):
	pass
#endregion
```

---

## 🎬 Sahne ve Script Düzeni

- 📄 **Her sahnenin kendine ait bir scripti olur.**

```
player.tscn         ->  player.gd
weapon_pickup.tscn  ->  weapon_pickup.gd
bullet_hole.tscn    ->  bullet_hole.gd
```

- 🔁 **Aynı türden sahneler ortak bir script kullanabilir.** Bu durumda sahneye özel değerler scriptte değil, bir `Resource` (`.tres`) dosyasında tutulur.

```
ak_47.tscn  ->  weapon.gd  +  data/weapons/ak47.tres
m4.tscn     ->  weapon.gd  +  data/weapons/m4.tres
```

---

## 📦 Veri (Resource) Dosyaları

- Veri modelleri `Resource`'tan türetilir ve `class_name` ile adlandırılır (ör. `WeaponData`).
- Veri dosyaları `data/` altında, türüne göre klasörlenir (ör. `data/weapons/ak47.tres`).
- Her silah türü için **bir** `.tres` dosyası olur; o türdeki bütün silahlar bu dosyayı paylaşır.
- `.tres` yalnızca **hiç değişmeyen** veriyi tutar. Oyun sırasında `.tres`'e yazılmaz; değişen durum (mevcut mermi vb.) sahnenin scriptinde tutulur.

```gdscript
class_name WeaponData
extends Resource

@export var weapon_name: String = ""
@export var damage: float = 25.0
@export var fire_rate: float = 0.2
@export var magazine_size: int = 30
```

---

## 🏷️ İsimlendirme

### 🔠 TAM BÜYÜK HARF (`WALK_SPEED`, `PLAYER_NORMAL_HEIGHT`, `BULLET_HOLE`)

- Oyun çalıştığı sürece sabit kalan değerlerde (`const`) kullanılır.
- `preload` ile yüklenen sahneler de sabit olarak bu biçimde yazılır (ör. `BULLET_HOLE`).
- Kodu okuyan kişi, bunun dokunulmaması gereken bir ayar değeri olduğunu hemen anlar.
- Birden fazla kelime `_` ile birbirinden ayrılır (bu yazım biçimi SCREAMING_SNAKE_CASE olarak bilinir).
- Hız, hasar, zıplama gücü gibi değerleri dengelerken hepsini tek bir yerden değiştirmeyi kolaylaştırır.

### 🔡 snake_case (`player_speed`, `aim_ray`, `current_ammo`)

- Değişkenler, fonksiyon parametreleri ve fonksiyon isimleri snake_case olur.

### 🅿️ PascalCase (`WeaponData`, `State`)

- `class_name` ile verilen sınıf isimleri ve `enum` isimleri PascalCase olur.
- `enum` değerleri TAM BÜYÜK HARF olur.

```gdscript
# Değişmeyen değerler: TAM BÜYÜK HARF
const WALK_SPEED = 5.0
const PLAYER_NORMAL_HEIGHT = 3.0
const BULLET_HOLE = preload("res://scenes/bullet_hole.tscn")

# Enum: isim PascalCase, değerler TAM BÜYÜK HARF
enum State {WALK, RUN, CROUCH, JUMP}

# Değişen değişkenler: snake_case
var player_speed = WALK_SPEED
var player_status = State.WALK
@export var aim_ray: RayCast3D


# Fonksiyon ve parametreler: snake_case
func handle_player_height(new_height, delta):
	pass
```

### 📁 snake_case (`player.tscn`, `weapon_pickup.tscn`)

- Sahne, script ve veri dosyası isimleri snake_case olur.
- Sahne isimleri açıklayıcı olmalı; isimden sahnenin ne olduğu anlaşılmalı.

| ✅ İyi | ❌ Kötü |
|--------|---------|
| `player.tscn` | `scene1.tscn` |
| `weapon_pickup.tscn` | `new_scene.tscn` |
| `bullet_hole.tscn` | `effect2.tscn` |

---

## 📋 Özet Tablo

| Ne | Kural | Örnek |
|----|-------|-------|
| 🔒 Sabitler (`const`, `preload`) | TAM BÜYÜK HARF (SCREAMING_SNAKE_CASE) | `WALK_SPEED`, `BULLET_HOLE` |
| 🔁 Değişkenler ve parametreler | snake_case | `player_speed`, `aim_ray`, `new_height` |
| ⚙️ Fonksiyonlar | snake_case, açıklayıcı | `handle_camera_look`, `apply_hit` |
| 🧱 Sınıf (`class_name`) ve `enum` isimleri | PascalCase | `WeaponData`, `State` |
| 🔢 `enum` değerleri | TAM BÜYÜK HARF | `WALK`, `CROUCH` |
| 📁 Sahne, script ve veri dosyaları | snake_case, açıklayıcı | `player.tscn`, `weapon.gd`, `ak47.tres` |