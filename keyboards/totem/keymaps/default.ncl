
let { tap, hold, td, combo, encoder, CTL_T, LT, TG, .. } = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let md = hold.reg.mod in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in
let MO = hold.reg.layer in
let me = tap.custom.media in
let mo = tap.custom.mouse in
let cu = {
  SFTZ = td.make 100 [
    md.lsft & kc.Z & hold.reg.behavior {},
    tap.reg.mod.lsft & kc.Z,
  ],
  TH_L = MO 1 & kc.SPC & hold.reg.behavior {},
  TH_R = MO 2 & kc.SPC & hold.reg.behavior {},
  FN_G = MO 3 & kc.GRV & hold.reg.behavior {},
  BOOT = tap.custom.fak.BOOT,
  TH = fun t h => t & h & hold.reg.behavior {},
  TC = fun t => TH t md.lctl,
  TS = fun t => TH t md.lsft,
  TA = fun t => TH t md.lalt,
  TR = fun t => TH t md.ralt,
  TG = fun t => TH t md.lgui,
  TL = fun i t => TH (MO i) t,
  shift = fun k => tap.reg.mod.lsft & k & hold.reg.behavior {},
  altgr = fun k => tap.reg.mod.ralt & k & hold.reg.behavior {},
} in
let se = {
  MINUS = kc.SLASH,
  PLUS = kc.MINUS,
  EQUAL = cu.shift kc.N0,
  MULT = cu.shift kc.BACKSLASH,
  SLASH = cu.shift kc.N7,
  PERC = cu.shift kc.N5,
  PIPE = cu.altgr kc.NUBS,
  ARING = kc.LBRC,
  AUML = kc.QUOTE,
  OUML = kc.SEMICOLON,
  LT = kc.NUBS,
  GT = cu.shift kc.NUBS,
  } in
let se_alphas = fun layout =>
  layout
  |> std.string.uppercase
  |> std.string.characters
  |> std.array.map
    (fun c =>
        c |> std.string.uppercase |>
        match {
            "Å" => se.ARING,
            "Ä" => se.AUML,
            "Ö" => se.OUML,
            "<" => se.LT,
            ">" => se.GT,
            "$" => cu.altgr kc.N4,
            "-" => kc.SLASH,
            "\"" => cu.shift kc.N2,
            "'" => kc.BACKSLASH,
            "?" => cu.shift kc.MINUS,
            "&" => cu.shift kc.N6,
            "@" => cu.altgr kc.N2,
            "[" => cu.altgr kc.N8,
            "]" => cu.altgr kc.N9,
            "(" => cu.shift kc.N8,
            ")" => cu.shift kc.N9,
            "|" => se.PIPE,
            "!" => cu.shift kc.N1,
            "~" => cu.altgr kc.RIGHT_BRACKET,
            ":" => cu.shift kc.DOT,
            "*" => cu.shift kc.BACKSLASH,
            "{" => cu.altgr kc.N7,
            "}" => cu.altgr kc.N0,
            "/" => cu.shift kc.N7,
            "%" => cu.shift kc.N5,
            "#" => cu.shift kc.N3,
            "·" => cu.altgr kc.DOT,
            "´" => kc.EQL,
            "`" => cu.shift kc.EQL,
            "^" => cu.shift kc.RIGHT_BRACKET,
            "\\" => cu.altgr kc.MINUS,
            "¨" => kc.RIGHT_BRACKET,
            " "=> TTTT,
            _ => kc."%{c}"
        }
    ) in
let home_row_mods = fun layout =>
  layout
  |> std.array.map_with_index
    (fun index value  =>
        index |> match {
            10 or 19 => cu.TG value,
            11 or 18 => cu.TA value,
            12 or 17 => cu.TC value,
            13 or 16 => cu.TS value,
            _ => value
        }
    ) in
let thumb_keys  = [
    cu.TL 3 kc.ESC, cu.TL 2 kc.SPC, cu.TL 1 kc.BSPC,      cu.TL 1 kc.TAB,  cu.TL 2 kc.ENT, cu.TL 3 kc.ESC,
] in
let se_dvorak =  "åäöpyfgcrl"  ++ "aoeuidhtns" ++ "-.qjkxbmwvz,"  in
let se_qwerty =  "qwertyuiop"  ++ "asdfghjklö" ++ "-zxcvbnm,.äå"  in
let se_symbols = "<>[]$"  ++ "\"?&^¨" ++
                 "@/()|"  ++  "'!#~ " ++
                ":* {}\\" ++  "`·%´  " in
let se_sym =  [
               kc.ESC, kc.HOME, kc.UP,    kc.END,    kc.PGUP,    se.SLASH,  kc.N7,  kc.N8,  kc.N9, se.MINUS,
               kc.ESC, kc.LEFT, kc.DOWN,  kc.RIGHT,  kc.PGDN,    se.MULT,   kc.N4,  kc.N5,  kc.N6, se.PLUS,
   cu.BOOT,    kc.DOT, XXXX,    XXXX,     kc.DEL,    XXXX,       kc.DOT,    kc.N1,  kc.N2,  kc.N3, se.EQUAL,  kc.COMMA,
                                   TTTT,  TTTT,      TTTT,       TTTT,      TTTT,   kc.N0,
] in
let nav = [
                kc.ESC, kc.HOME, kc.UP,    kc.END,    kc.PGUP,    se.SLASH,  kc.N7,  kc.N8,  kc.N9, se.MINUS,
                kc.ESC, kc.LEFT, kc.DOWN,  kc.RIGHT,  kc.PGDN,    se.MULT,   kc.N4,  kc.N5,  kc.N6, se.PLUS,
    cu.BOOT,    kc.DOT, XXXX,    XXXX,     kc.DEL,    XXXX,       kc.DOT,    kc.N1,  kc.N2,  kc.N3, se.EQUAL,  kc.COMMA,
                                    TTTT,  TTTT,      TTTT,       TTTT,      TTTT,   kc.N0,
] in
let mouse_layer = [
                kc.ESC,  mo.BTN1, mo.UP,   mo.BTN2, mo.WH_D,   XXXX,  XXXX,  XXXX,  XXXX, XXXX,
                kc.ESC,  mo.LEFT, mo.DOWN, mo.RGHT, mo.WH_U,   XXXX,  mo.BTN1,  mo.BTN3,  mo.BTN2, XXXX,
    cu.BOOT,    XXXX,    XXXX,    XXXX,       XXXX, XXXX,      XXXX,  XXXX,  XXXX,  XXXX, XXXX,  XXXX,
                                  TTTT,       TTTT, TTTT,      TTTT,  TTTT,   kc.N0,
] in
{
  layers = [
    (se_dvorak |> se_alphas |> home_row_mods) @ thumb_keys,
    nav,
    (se_symbols |> se_alphas) @ thumb_keys,
    mouse_layer,
    ],
    mouse.move_speed = 4,
}
