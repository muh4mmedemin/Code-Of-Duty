# 🧩 Script Sistemleri

> Bu döküman `code-of-duty/scripts/` altındaki script'lerde kullanılan sistemleri ve script'ler arası akışı özetler.
> Kodun `9c013d0` commit'indeki haline göre hazırlanmıştır. Kod değiştikçe güncellenmelidir.

---

## 📑 İçindekiler

- [Genel Bakış](#-genel-bakış)
- [player.gd: Oyuncu Kontrolcüsü](#-playergd-oyuncu-kontrolcüsü)
- [weapon.gd: Silah Davranışı](#-weapongd-silah-davranışı)
- [weapon_data.gd: Silah Veri Modeli](#-weapon_datagd-silah-veri-modeli)
- [weapon_pickup.gd: Yerdeki Silah](#-weapon_pickupgd-yerdeki-silah)
- [bullet_hole.gd: Mermi İzi](#-bullet_holegd-mermi-izi)
- [ak_47_pickup_model.gd](#-ak_47_pickup_modelgd)
- [Script'ler Arası Akış](#-scriptler-arası-akış)
- [Kullanılan Godot Desenleri](#-kullanılan-godot-desenleri)
- [Bilinen Notlar](#-bilinen-notlar)

---

## 🗂️ Genel Bakış

| Script | Bağlı olduğu sahne | Temel sınıf | Görevi |
|---|---|---|---|
| `player.gd` | `scenes/player.tscn` | `CharacterBody3D` | Hareket, kamera, eğilme, ateş ve silah alma |
| `weapon.gd` | `scenes/ak_47.tscn` | `Node` | Ateş ve isabet (hitscan) |
| `weapon_data.gd` | `data/weapons/*.tres` | `Resource` | Silah türünün değişmeyen verisi |
| `weapon_pickup.gd` | `scenes/weapon_pickup.tscn` | `Node3D` | Yerde duran, alınabilir silah |
| `bullet_hole.gd` | `scenes/bullet_hole.tscn` | `Node3D` | Süreli mermi izi |
| `ak_47_pickup_model.gd` | `scenes/ak_47_pickup_model.tscn` | `Node3D` | Boş (henüz işlevi yok) |

---

## 🏃 player.gd: Oyuncu Kontrolcüsü

Oyunun asıl mantığının çoğu bu script'tedir.

### Düğüm referansları

| Değişken | Düğüm |
|---|---|
| `camera` | `Head/Camera3D` |
| `player_head` | `Head` |
| `player_coll` | `CollisionShape3D` |
| `player_coll_mesh` | `CollisionShape3D/MeshInstance3D` |
| `aim_ray` | `Head/Camera3D/AimRay` (`RayCast3D`, 100 m) |
| `arms` | `Head/Camera3D/WeaponHolder/Arms` |
| `crouch_checker_shape` | Koddan oluşturulan `ShapeCast3D` |
| `player_current_weapon` | Eldeki silah örneği |

### 1. Hareket ve yer çekimi (`_physics_process`)

- Yerde değilken `get_gravity()` ile yer çekimi uygulanır.
- Zıplama `ui_accept` eylemiyle, yalnızca yerdeyken yapılır (`JUMP_VELOCITY = 4.5`).
- Yön `Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")` ile okunur ve `transform.basis` ile oyuncunun baktığı yöne çevrilir.
- Tuş bırakılınca hız `move_toward` ile sıfıra iner; ardından `move_and_slide()` çağrılır.

### 2. Kamera ve fare ile bakış (`_input` → `handle_camera_look`)

- `_ready` içinde fare ekrana kilitlenir (`MOUSE_MODE_CAPTURED`).
- Dikey bakış kamerayı döndürür ve **±80°** ile sınırlıdır.
- Yatay bakış oyuncunun gövdesini döndürür.
- Hassasiyet editörden ayarlanır: `@export var Sensivity`.

### 3. Hareket durum makinesi (`#region PLAYER_MOVEMENT_STATE`)

```gdscript
enum State {WALK, RUN, CROUCH, JUMP}
```

| Durum | Hız sabiti | Değer |
|---|---|---|
| `WALK` | `WALK_SPEED` | 5.0 |
| `RUN` | `RUN_SPEED` | 7.0 |
| `CROUCH` | `CROUCH_SPEED` | 2.5 |
| `JUMP` | — | Tanımlı, henüz kullanılmıyor |

- Durum değişince `handle_player_speed` hızı ayarlar.
- Koşarken eğilinemez, eğilirken koşulamaz.
- Durum değişimi, önceki durum (`was_player_status`) ile yeni durum karşılaştırılarak algılanır.

### 4. Eğilme ve tavan kontrolü

| Sabit | Değer |
|---|---|
| `PLAYER_NORMAL_HEIGHT` | 3.0 |
| `PLAYER_CROUCH_HEIGHT` | 2.0 |

- `handle_player_height` her karede `lerp` (`10.0 * delta`) ile şunları hedef boya yaklaştırır:
  - çarpışma kapsülünün yüksekliği
  - kapsülün görsel mesh'i
  - kapsülün konumu
  - kafanın (kameranın) yüksekliği
- Tavan kontrolü için `_ready` içinde bir `ShapeCast3D` oluşturulur:
  - 0.40 yarıçaplı küre (`SphereShape3D`), kafa hizasında
  - oyuncunun kendisi kontrolden hariç tutulur (`add_exception(self)`)
- Küre bir şeye değiyorsa durum fonksiyonu erken çıkar; tavan alçakken ayağa kalkılamaz.

### 5. Ateş etme

- `weapon_fire` tuşuna basıldığı anda (`is_action_just_pressed`) ve `Arms` altında en az bir çocuk varsa `player_current_weapon.fire()` çağrılır.

### 6. Yerden silah alma

`take_item` (F) basıldığında şu koşullar aranır:

1. Eller boş (`Arms` altında çocuk yok)
2. `AimRay` bir nesneye çarpıyor
3. Çarptığı nesnenin ebeveyni `pickup` grubunda

Koşullar sağlanırsa:

- Pickup'taki `weapon_model` sahnesinden yeni bir silah oluşturulur ve `Arms` altına eklenir.
- Oyuncunun `AimRay`'i silahın `aim_ray` alanına verilir.

---

## 🔫 weapon.gd: Silah Davranışı

### Bağımlılıklar

| Alan | Tip | Kaynağı |
|---|---|---|
| `data` | `WeaponData` | Editörden atanır (silah türünün verisi) |
| `aim_ray` | `RayCast3D` | Silah alınınca `player.gd` tarafından atanır |

### Fonksiyonlar

- **`fire()`**: Silah verisini konsola yazdırır (debug) ve `apply_hit()`'i çağırır.
- **`apply_hit()`**: Hitscan isabet sistemi.
  1. `aim_ray.is_colliding()` ile isabet kontrol edilir.
  2. Vurulan nesne (`get_collider()`) ve isabet noktası (`get_collision_point()`) alınır.
  3. `preload` edilmiş `BULLET_HOLE` sahnesinden bir mermi izi oluşturulur.
  4. İz, vurulan nesnenin çocuğu olarak eklenir ve isabet noktasına konur. Nesne hareket ederse iz de onunla hareket eder.

---

## 📦 weapon_data.gd: Silah Veri Modeli

```gdscript
class_name WeaponData
extends Resource
```

| Alan | Tip | Varsayılan |
|---|---|---|
| `weapon_name` | `String` | `""` |
| `damage` | `float` | 25.0 |
| `fire_rate` | `float` | 0.2 |
| `magazine_size` | `int` | 30 |

**Kullanım kuralı:**

- Her silah türü için bir `.tres` dosyası olur (ör. `data/weapons/ak47.tres`).
- O türdeki bütün silahlar aynı `.tres`'i paylaşır.
- `.tres` yalnızca **hiç değişmeyen** veriyi tutar. Oyun sırasında `.tres`'e yazılmaz; yazılırsa o türdeki bütün silahlar etkilenir.
- Değişen durum (mevcut mermi, reload durumu vb.) silah örneğinde (`weapon.gd`) tutulur.

---

## 🧲 weapon_pickup.gd: Yerdeki Silah

| Alan | Tip | Görevi |
|---|---|---|
| `weapon_model` | `PackedScene` | Alınınca ele geçen silah sahnesi |
| `weapon_pick_model` | `PackedScene` | Yerde görünen model |

- `_ready` içinde kendini `pickup` grubuna ekler; oyuncu pickup'ı bu grup sayesinde tanır.
- `weapon_pick_model` örneklenip `RigidBody3D/model_holder` altına eklenir. Yerdeki görünüm çalışma anında oluşturulur.

---

## 🕳️ bullet_hole.gd: Mermi İzi

- Süreli silinme:

  ```gdscript
  await get_tree().create_timer(lifetime).timeout
  queue_free()
  ```

- Süre editörden ayarlanır: `@export var lifetime`. Script'te varsayılan 15 sn, `bullet_hole.tscn`'de 2 sn.

---

## 📄 ak_47_pickup_model.gd

- Yalnızca `extends Node3D`. Şu an işlevi yok.

---

## 🔀 Script'ler Arası Akış

```
Ateş:   player.gd ──weapon_fire──► weapon.fire() ──► aim_ray (RayCast3D) ──► bullet_hole örneği

Alma:   player.gd ──take_item──► aim_ray'in çarptığı nesne ──► "pickup" grubunda mı?
                                   ──► weapon_model.instantiate() ──► Arms altına ekle, aim_ray'i ver

Veri:   ak47.tres (WeaponData, paylaşılan) ──► weapon.gd.data
```

---

## 🛠️ Kullanılan Godot Desenleri

| Desen | Nerede |
|---|---|
| `@export` ile editörden atanan değerler ve bağımlılıklar | `player.gd`, `weapon.gd`, `weapon_pickup.gd`, `bullet_hole.gd`, `weapon_data.gd` |
| `@onready` ile düğüm referansları | `player.gd` |
| Özel `Resource` sınıfı (`class_name`) | `weapon_data.gd` |
| `preload` / `instantiate` ile çalışma anında sahne oluşturma | `weapon.gd`, `player.gd`, `weapon_pickup.gd` |
| Grup tabanlı nesne tanıma (`add_to_group`, `is_in_group`) | `weapon_pickup.gd`, `player.gd` |
| `enum` tabanlı durum makinesi | `player.gd` |
| `lerp` ile yumuşak geçiş | `player.gd` |
| `RayCast3D` / `ShapeCast3D` ile çarpışma sorgusu | `player.gd`, `weapon.gd` |
| `await` + `create_timer` ile süreli olay | `bullet_hole.gd` |
| Bağımlılık enjeksiyonu (oyuncunun `AimRay`'ini silaha verme) | `player.gd` → `weapon.gd` |

---

## 📝 Bilinen Notlar

| Konu | Açıklama | İlgili issue |
|---|---|---|
| Etkisiz satır | `crouch_checker_shape.enabled` değer atamadığı için bir şey yapmaz (`ShapeCast3D` zaten açık). | — |
| Kullanılmayan veri | `fire_rate` ve `damage` henüz kodda kullanılmıyor; her tıklamada tek atış yapılıyor. | #10 |
| Gereksiz referans | `player = $"."` kendi düğümünü tutar; `self` ile aynıdır. | — |
| Pickup yerde kalıyor | Silah alındıktan sonra yerdeki pickup sahneden silinmiyor. | #20 |
| Paylaşılan mesh | Eğilmede `player_coll_mesh.mesh.height` mesh kaynağını değiştirir; aynı mesh'i kullanan başka nesneler de etkilenir. Şu an tek oyuncu olduğu için sorun yok. | — |
| Veri tek kaynakta değil | `ak_47.tscn` kendi içine gömülü bir `WeaponData` kullanıyor, `ak47.tres` kullanılmıyor. | #10 |
| Tanımsız alanlar | `ak47.tres`'teki `pickup_scene` ve `weapon_scene` alanları `WeaponData`'da tanımlı değil. | #10 |
