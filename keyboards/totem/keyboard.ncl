
let { ColToRowKey, PeripheralSideKey, PhysicalEncoder, PeripheralSideEncoder, SoftSerialPin, .. } = import "fak/keyboard.ncl" in
let { CH552T, .. } = import "fak/mcus.ncl" in

let kbd_matrix = {
  cols = [35, 34, 15, 16, 17 ],
  rows = [32, 11, 12, 13],
} in

let side_central = {
  mcu = CH552T,
  matrix = kbd_matrix,
  split.channel = SoftSerialPin 31,
} in

let side_periph = {
  mcu = CH552T,
  matrix = kbd_matrix,
  split.channel = SoftSerialPin 31,
  keys =
    let M = ColToRowKey in
    [
             M 0 0, M 1 0, M 2 0, M 3 0, M 4 0,
             M 0 1, M 1 1, M 2 1, M 3 1, M 4 1,
      M 0 3, M 0 2, M 1 2, M 2 2, M 3 2, M 4 2,
                           M 2 3, M 3 3, M 4 3,
    ]
} in
let swapSides = fun row_lengths keys =>
    let split_by_lengths = fun acc len =>
        let split = std.array.split_at len acc.rem in
        { out = acc.out @ [split.left], rem = split.right } in
    let init = { out = [], rem = keys } in
    let rows = (std.array.fold_left split_by_lengths init row_lengths).out in
    std.array.flat_map std.array.reverse rows
in
let row_lengths = [10, 10, 12, 6] in
side_central & {
  usb_dev = {
    vendor_id = 14908, # 0x3A3C
    product_id = 1,
    product_ver = 130,
  },
  split.peripheral = side_periph,
  keys =
    let M = ColToRowKey in
    let S = PeripheralSideKey in


   [
             M 0 0, M 1 0, M 2 0, M 3 0, M 4 0,      S  4, S  3, S  2, S  1, S 0,
             M 0 1, M 1 1, M 2 1, M 3 1, M 4 1,      S  9, S  8, S  7, S  6, S 5,
      M 0 3, M 0 2, M 1 2, M 2 2, M 3 2, M 4 2,      S 15, S 14, S 13, S 12, S 11, S 10,
                           M 2 3, M 3 3, M 4 3,      S 18, S 17, S 16,

    ],
}
