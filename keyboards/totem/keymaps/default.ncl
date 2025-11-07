
let { tap, hold, td, combo, encoder, CTL_T, LT, .. } = import "fak/keycode.ncl" in

let kc = tap.reg.kc in
let md = hold.reg.mod in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in
let MO = hold.reg.layer in
let me = tap.custom.media in

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
  TL = fun i t => TH (MO i) t,

} in

let qwerty = [
                 kc.Q,    kc.W,    kc.E,    kc.R,    kc.T,    kc.Y,   kc.U,  kc.I, kc.O, kc.P,
                 kc.A,    cu.TS kc.S,    cu.TC kc.D,  cu.TA kc.F,  kc.G,    kc.H,   cu.TA kc.J,  cu.TC kc.K, cu.TS kc.L, kc.SCLN,
        kc.ESC, kc.Z,    kc.X,    kc.C,    kc.V,    kc.B,    kc.N,   kc.M,  kc.COMM, kc.DOT, kc.DOT, kc.DOT,
                                kc.BSPC,   kc.SPC, cu.TH kc.BSPC (MO 1),    cu.TL 1 kc.TAB,  kc.ENT, kc.ENT,
    ] in
let nav = [
                kc.Q,    kc.HOME,    kc.UP,    kc.END,    kc.T,    kc.Y,   kc.U,  kc.I, kc.O, kc.P,
                kc.A,    kc.LEFT,    kc.DOWN,    kc.RIGHT,    XXXX,    XXXX,   kc.LEFT,  kc.DOWN, kc.UP, kc.RIGHT,
    cu.BOOT,    kc.Z,    kc.X,    kc.C,    kc.V,    kc.B,    kc.N,   kc.X,  kc.N, kc.M, kc.COMM, cu.BOOT,
                                  kc.BSPC, md.lsft, TTTT,    MO 1,  kc.N2, kc.SPC,
]in
{
  layers = [
    qwerty,
    nav,
  ]
}
