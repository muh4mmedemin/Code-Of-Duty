# INPUT_MAP

## Projede Tanımlı Eylemler

> `code-of-duty/project.godot` içindeki Input Map ile birebir aynıdır.

| Eylem | Varsayılan Tuş | Kullanıldığı yer |
|-------|----------------|------------------|
| `ui_up` | W (gamepad: D-pad yukarı, sol çubuk) | Hareket: ileri |
| `ui_down` | S (gamepad: D-pad aşağı, sol çubuk) | Hareket: geri |
| `ui_left` | A (gamepad: D-pad sol, sol çubuk) | Hareket: sol |
| `ui_right` | D (gamepad: D-pad sağ, sol çubuk) | Hareket: sağ |
| `ui_accept` | Boşluk / Enter (Godot varsayılanı) | Zıplama |
| `player_sprint` | Shift | Koşma |
| `player_crouch` | Ctrl | Eğilme |
| `weapon_fire` | Sol tık | Ateş etme |
| `take_item` | F | Yerdeki silahı alma |

> Hareket için Godot'un hazır `ui_*` eylemleri kullanılır; bu eylemler projede WASD tuşlarıyla yeniden tanımlanmıştır. `ui_accept` değiştirilmemiştir, Godot'un varsayılan tuşlarını kullanır.

## Planlanan Eylemler (henüz projede yok)

| Eylem | Varsayılan Tuş |
|-------|----------------|
| `prone` | Z |
| `lean_left` | Q |
| `lean_right` | E |
| `aim` | Sağ tık |
| `reload` | R |
| `quick_reload` | R (çift basış) |
| `throw_grenade` | G |
| `drop_weapon` | Belirlenecek |
| `inspect_weapon` | H |
| `slot_1` | 1 (tüfek) |
| `slot_2` | 2 (tabanca) |
| `slot_3` | 3 (belirlenecek) |

> Silah slotları klasik 1-2-3 yapısındadır: 1 = tüfek, 2 = tabanca, 3 = henüz belirlenmedi. Silah değiştirme fare tekerleğiyle de yapılabilir.
>
> Planlanan eylemler projeye eklendiğinde bu tablodan üstteki tabloya taşınır ve isimleri projedeki isimlerle eşlenir.