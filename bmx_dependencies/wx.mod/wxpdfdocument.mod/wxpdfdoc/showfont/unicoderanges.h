#ifndef UNICODE_RANGES_H
#define UNICODE_RANGES_H

typedef struct _UnicodeRange
{
  wxUint32 first;
  wxUint32 last;
} UnicodeRange;

static const UnicodeRange gs_unicodeRanges[] =
{
  { 0x0000, 0x0377 },
  { 0x037a, 0x037e },
  { 0x0384, 0x038a },
  { 0x038c, 0x038c },
  { 0x038e, 0x03a1 },
  { 0x03a3, 0x0527 },
  { 0x0531, 0x0556 },
  { 0x0559, 0x055f },
  { 0x0561, 0x0587 },
  { 0x0589, 0x058a },
  { 0x0591, 0x05c7 },
  { 0x05d0, 0x05ea },
  { 0x05f0, 0x05f4 },
  { 0x0600, 0x0603 },
  { 0x0606, 0x061b },
  { 0x061e, 0x070d },
  { 0x070f, 0x074a },
  { 0x074d, 0x07b1 },
  { 0x07c0, 0x07fa },
  { 0x0800, 0x082d },
  { 0x0830, 0x083e },
  { 0x0840, 0x085b },
  { 0x085e, 0x085e },
  { 0x0900, 0x0977 },
  { 0x0979, 0x097f },
  { 0x0981, 0x0983 },
  { 0x0985, 0x098c },
  { 0x098f, 0x0990 },
  { 0x0993, 0x09a8 },
  { 0x09aa, 0x09b0 },
  { 0x09b2, 0x09b2 },
  { 0x09b6, 0x09b9 },
  { 0x09bc, 0x09c4 },
  { 0x09c7, 0x09c8 },
  { 0x09cb, 0x09ce },
  { 0x09d7, 0x09d7 },
  { 0x09dc, 0x09dd },
  { 0x09df, 0x09e3 },
  { 0x09e6, 0x09fb },
  { 0x0a01, 0x0a03 },
  { 0x0a05, 0x0a0a },
  { 0x0a0f, 0x0a10 },
  { 0x0a13, 0x0a28 },
  { 0x0a2a, 0x0a30 },
  { 0x0a32, 0x0a33 },
  { 0x0a35, 0x0a36 },
  { 0x0a38, 0x0a39 },
  { 0x0a3c, 0x0a3c },
  { 0x0a3e, 0x0a42 },
  { 0x0a47, 0x0a48 },
  { 0x0a4b, 0x0a4d },
  { 0x0a51, 0x0a51 },
  { 0x0a59, 0x0a5c },
  { 0x0a5e, 0x0a5e },
  { 0x0a66, 0x0a75 },
  { 0x0a81, 0x0a83 },
  { 0x0a85, 0x0a8d },
  { 0x0a8f, 0x0a91 },
  { 0x0a93, 0x0aa8 },
  { 0x0aaa, 0x0ab0 },
  { 0x0ab2, 0x0ab3 },
  { 0x0ab5, 0x0ab9 },
  { 0x0abc, 0x0ac5 },
  { 0x0ac7, 0x0ac9 },
  { 0x0acb, 0x0acd },
  { 0x0ad0, 0x0ad0 },
  { 0x0ae0, 0x0ae3 },
  { 0x0ae6, 0x0aef },
  { 0x0af1, 0x0af1 },
  { 0x0b01, 0x0b03 },
  { 0x0b05, 0x0b0c },
  { 0x0b0f, 0x0b10 },
  { 0x0b13, 0x0b28 },
  { 0x0b2a, 0x0b30 },
  { 0x0b32, 0x0b33 },
  { 0x0b35, 0x0b39 },
  { 0x0b3c, 0x0b44 },
  { 0x0b47, 0x0b48 },
  { 0x0b4b, 0x0b4d },
  { 0x0b56, 0x0b57 },
  { 0x0b5c, 0x0b5d },
  { 0x0b5f, 0x0b63 },
  { 0x0b66, 0x0b77 },
  { 0x0b82, 0x0b83 },
  { 0x0b85, 0x0b8a },
  { 0x0b8e, 0x0b90 },
  { 0x0b92, 0x0b95 },
  { 0x0b99, 0x0b9a },
  { 0x0b9c, 0x0b9c },
  { 0x0b9e, 0x0b9f },
  { 0x0ba3, 0x0ba4 },
  { 0x0ba8, 0x0baa },
  { 0x0bae, 0x0bb9 },
  { 0x0bbe, 0x0bc2 },
  { 0x0bc6, 0x0bc8 },
  { 0x0bca, 0x0bcd },
  { 0x0bd0, 0x0bd0 },
  { 0x0bd7, 0x0bd7 },
  { 0x0be6, 0x0bfa },
  { 0x0c01, 0x0c03 },
  { 0x0c05, 0x0c0c },
  { 0x0c0e, 0x0c10 },
  { 0x0c12, 0x0c28 },
  { 0x0c2a, 0x0c33 },
  { 0x0c35, 0x0c39 },
  { 0x0c3d, 0x0c44 },
  { 0x0c46, 0x0c48 },
  { 0x0c4a, 0x0c4d },
  { 0x0c55, 0x0c56 },
  { 0x0c58, 0x0c59 },
  { 0x0c60, 0x0c63 },
  { 0x0c66, 0x0c6f },
  { 0x0c78, 0x0c7f },
  { 0x0c82, 0x0c83 },
  { 0x0c85, 0x0c8c },
  { 0x0c8e, 0x0c90 },
  { 0x0c92, 0x0ca8 },
  { 0x0caa, 0x0cb3 },
  { 0x0cb5, 0x0cb9 },
  { 0x0cbc, 0x0cc4 },
  { 0x0cc6, 0x0cc8 },
  { 0x0cca, 0x0ccd },
  { 0x0cd5, 0x0cd6 },
  { 0x0cde, 0x0cde },
  { 0x0ce0, 0x0ce3 },
  { 0x0ce6, 0x0cef },
  { 0x0cf1, 0x0cf2 },
  { 0x0d02, 0x0d03 },
  { 0x0d05, 0x0d0c },
  { 0x0d0e, 0x0d10 },
  { 0x0d12, 0x0d3a },
  { 0x0d3d, 0x0d44 },
  { 0x0d46, 0x0d48 },
  { 0x0d4a, 0x0d4e },
  { 0x0d57, 0x0d57 },
  { 0x0d60, 0x0d63 },
  { 0x0d66, 0x0d75 },
  { 0x0d79, 0x0d7f },
  { 0x0d82, 0x0d83 },
  { 0x0d85, 0x0d96 },
  { 0x0d9a, 0x0db1 },
  { 0x0db3, 0x0dbb },
  { 0x0dbd, 0x0dbd },
  { 0x0dc0, 0x0dc6 },
  { 0x0dca, 0x0dca },
  { 0x0dcf, 0x0dd4 },
  { 0x0dd6, 0x0dd6 },
  { 0x0dd8, 0x0ddf },
  { 0x0df2, 0x0df4 },
  { 0x0e01, 0x0e3a },
  { 0x0e3f, 0x0e5b },
  { 0x0e81, 0x0e82 },
  { 0x0e84, 0x0e84 },
  { 0x0e87, 0x0e88 },
  { 0x0e8a, 0x0e8a },
  { 0x0e8d, 0x0e8d },
  { 0x0e94, 0x0e97 },
  { 0x0e99, 0x0e9f },
  { 0x0ea1, 0x0ea3 },
  { 0x0ea5, 0x0ea5 },
  { 0x0ea7, 0x0ea7 },
  { 0x0eaa, 0x0eab },
  { 0x0ead, 0x0eb9 },
  { 0x0ebb, 0x0ebd },
  { 0x0ec0, 0x0ec4 },
  { 0x0ec6, 0x0ec6 },
  { 0x0ec8, 0x0ecd },
  { 0x0ed0, 0x0ed9 },
  { 0x0edc, 0x0edd },
  { 0x0f00, 0x0f47 },
  { 0x0f49, 0x0f6c },
  { 0x0f71, 0x0f97 },
  { 0x0f99, 0x0fbc },
  { 0x0fbe, 0x0fcc },
  { 0x0fce, 0x0fda },
  { 0x1000, 0x10c5 },
  { 0x10d0, 0x10fc },
  { 0x1100, 0x1248 },
  { 0x124a, 0x124d },
  { 0x1250, 0x1256 },
  { 0x1258, 0x1258 },
  { 0x125a, 0x125d },
  { 0x1260, 0x1288 },
  { 0x128a, 0x128d },
  { 0x1290, 0x12b0 },
  { 0x12b2, 0x12b5 },
  { 0x12b8, 0x12be },
  { 0x12c0, 0x12c0 },
  { 0x12c2, 0x12c5 },
  { 0x12c8, 0x12d6 },
  { 0x12d8, 0x1310 },
  { 0x1312, 0x1315 },
  { 0x1318, 0x135a },
  { 0x135d, 0x137c },
  { 0x1380, 0x1399 },
  { 0x13a0, 0x13f4 },
  { 0x1400, 0x169c },
  { 0x16a0, 0x16f0 },
  { 0x1700, 0x170c },
  { 0x170e, 0x1714 },
  { 0x1720, 0x1736 },
  { 0x1740, 0x1753 },
  { 0x1760, 0x176c },
  { 0x176e, 0x1770 },
  { 0x1772, 0x1773 },
  { 0x1780, 0x17dd },
  { 0x17e0, 0x17e9 },
  { 0x17f0, 0x17f9 },
  { 0x1800, 0x180e },
  { 0x1810, 0x1819 },
  { 0x1820, 0x1877 },
  { 0x1880, 0x18aa },
  { 0x18b0, 0x18f5 },
  { 0x1900, 0x191c },
  { 0x1920, 0x192b },
  { 0x1930, 0x193b },
  { 0x1940, 0x1940 },
  { 0x1944, 0x196d },
  { 0x1970, 0x1974 },
  { 0x1980, 0x19ab },
  { 0x19b0, 0x19c9 },
  { 0x19d0, 0x19da },
  { 0x19de, 0x1a1b },
  { 0x1a1e, 0x1a5e },
  { 0x1a60, 0x1a7c },
  { 0x1a7f, 0x1a89 },
  { 0x1a90, 0x1a99 },
  { 0x1aa0, 0x1aad },
  { 0x1b00, 0x1b4b },
  { 0x1b50, 0x1b7c },
  { 0x1b80, 0x1baa },
  { 0x1bae, 0x1bb9 },
  { 0x1bc0, 0x1bf3 },
  { 0x1bfc, 0x1c37 },
  { 0x1c3b, 0x1c49 },
  { 0x1c4d, 0x1c7f },
  { 0x1cd0, 0x1cf2 },
  { 0x1d00, 0x1de6 },
  { 0x1dfc, 0x1f15 },
  { 0x1f18, 0x1f1d },
  { 0x1f20, 0x1f45 },
  { 0x1f48, 0x1f4d },
  { 0x1f50, 0x1f57 },
  { 0x1f59, 0x1f59 },
  { 0x1f5b, 0x1f5b },
  { 0x1f5d, 0x1f5d },
  { 0x1f5f, 0x1f7d },
  { 0x1f80, 0x1fb4 },
  { 0x1fb6, 0x1fc4 },
  { 0x1fc6, 0x1fd3 },
  { 0x1fd6, 0x1fdb },
  { 0x1fdd, 0x1fef },
  { 0x1ff2, 0x1ff4 },
  { 0x1ff6, 0x1ffe },
  { 0x2000, 0x2064 },
  { 0x206a, 0x2071 },
  { 0x2074, 0x208e },
  { 0x2090, 0x209c },
  { 0x20a0, 0x20b9 },
  { 0x20d0, 0x20f0 },
  { 0x2100, 0x2189 },
  { 0x2190, 0x23f3 },
  { 0x2400, 0x2426 },
  { 0x2440, 0x244a },
  { 0x2460, 0x26ff },
  { 0x2701, 0x27ca },
  { 0x27cc, 0x27cc },
  { 0x27ce, 0x2b4c },
  { 0x2b50, 0x2b59 },
  { 0x2c00, 0x2c2e },
  { 0x2c30, 0x2c5e },
  { 0x2c60, 0x2cf1 },
  { 0x2cf9, 0x2d25 },
  { 0x2d30, 0x2d65 },
  { 0x2d6f, 0x2d70 },
  { 0x2d7f, 0x2d96 },
  { 0x2da0, 0x2da6 },
  { 0x2da8, 0x2dae },
  { 0x2db0, 0x2db6 },
  { 0x2db8, 0x2dbe },
  { 0x2dc0, 0x2dc6 },
  { 0x2dc8, 0x2dce },
  { 0x2dd0, 0x2dd6 },
  { 0x2dd8, 0x2dde },
  { 0x2de0, 0x2e31 },
  { 0x2e80, 0x2e99 },
  { 0x2e9b, 0x2ef3 },
  { 0x2f00, 0x2fd5 },
  { 0x2ff0, 0x2ffb },
  { 0x3000, 0x303f },
  { 0x3041, 0x3096 },
  { 0x3099, 0x30ff },
  { 0x3105, 0x312d },
  { 0x3131, 0x318e },
  { 0x3190, 0x31ba },
  { 0x31c0, 0x31e3 },
  { 0x31f0, 0x321e },
  { 0x3220, 0x32fe },
  { 0x3300, 0x33ff },
  { 0x3400, 0x4db5 }, // CJK Ideograph Extension A
  { 0x4dc0, 0x4dff },
  { 0x4e00, 0x9fcb }, // CJK Ideograph
  { 0xa000, 0xa48c },
  { 0xa490, 0xa4c6 },
  { 0xa4d0, 0xa62b },
  { 0xa640, 0xa673 },
  { 0xa67c, 0xa697 },
  { 0xa6a0, 0xa6f7 },
  { 0xa700, 0xa78e },
  { 0xa790, 0xa791 },
  { 0xa7a0, 0xa7a9 },
  { 0xa7fa, 0xa82b },
  { 0xa830, 0xa839 },
  { 0xa840, 0xa877 },
  { 0xa880, 0xa8c4 },
  { 0xa8ce, 0xa8d9 },
  { 0xa8e0, 0xa8fb },
  { 0xa900, 0xa953 },
  { 0xa95f, 0xa97c },
  { 0xa980, 0xa9cd },
  { 0xa9cf, 0xa9d9 },
  { 0xa9de, 0xa9df },
  { 0xaa00, 0xaa36 },
  { 0xaa40, 0xaa4d },
  { 0xaa50, 0xaa59 },
  { 0xaa5c, 0xaa7b },
  { 0xaa80, 0xaac2 },
  { 0xaadb, 0xaadf },
  { 0xab01, 0xab06 },
  { 0xab09, 0xab0e },
  { 0xab11, 0xab16 },
  { 0xab20, 0xab26 },
  { 0xab28, 0xab2e },
  { 0xabc0, 0xabed },
  { 0xabf0, 0xabf9 },
  { 0xac00, 0xd7a3 }, // Hangul Syllable
  { 0xd7b0, 0xd7c6 },
  { 0xd7cb, 0xd7fb },
  { 0xd800, 0xf8ff }, // Private use, surrogate
  { 0xf900, 0xfa2d },
  { 0xfa30, 0xfa6d },
  { 0xfa70, 0xfad9 },
  { 0xfb00, 0xfb06 },
  { 0xfb13, 0xfb17 },
  { 0xfb1d, 0xfb36 },
  { 0xfb38, 0xfb3c },
  { 0xfb3e, 0xfb3e },
  { 0xfb40, 0xfb41 },
  { 0xfb43, 0xfb44 },
  { 0xfb46, 0xfbc1 },
  { 0xfbd3, 0xfd3f },
  { 0xfd50, 0xfd8f },
  { 0xfd92, 0xfdc7 },
  { 0xfdf0, 0xfdfd },
  { 0xfe00, 0xfe19 },
  { 0xfe20, 0xfe26 },
  { 0xfe30, 0xfe52 },
  { 0xfe54, 0xfe66 },
  { 0xfe68, 0xfe6b },
  { 0xfe70, 0xfe74 },
  { 0xfe76, 0xfefc },
  { 0xfeff, 0xfeff },
  { 0xff01, 0xffbe },
  { 0xffc2, 0xffc7 },
  { 0xffca, 0xffcf },
  { 0xffd2, 0xffd7 },
  { 0xffda, 0xffdc },
  { 0xffe0, 0xffe6 },
  { 0xffe8, 0xffee },
  { 0xfff9, 0xfffd },
  { 0x10000, 0x1000b },
  { 0x1000d, 0x10026 },
  { 0x10028, 0x1003a },
  { 0x1003c, 0x1003d },
  { 0x1003f, 0x1004d },
  { 0x10050, 0x1005d },
  { 0x10080, 0x100fa },
  { 0x10100, 0x10102 },
  { 0x10107, 0x10133 },
  { 0x10137, 0x1018a },
  { 0x10190, 0x1019b },
  { 0x101d0, 0x101fd },
  { 0x10280, 0x1029c },
  { 0x102a0, 0x102d0 },
  { 0x10300, 0x1031e },
  { 0x10320, 0x10323 },
  { 0x10330, 0x1034a },
  { 0x10380, 0x1039d },
  { 0x1039f, 0x103c3 },
  { 0x103c8, 0x103d5 },
  { 0x10400, 0x1049d },
  { 0x104a0, 0x104a9 },
  { 0x10800, 0x10805 },
  { 0x10808, 0x10808 },
  { 0x1080a, 0x10835 },
  { 0x10837, 0x10838 },
  { 0x1083c, 0x1083c },
  { 0x1083f, 0x10855 },
  { 0x10857, 0x1085f },
  { 0x10900, 0x1091b },
  { 0x1091f, 0x10939 },
  { 0x1093f, 0x1093f },
  { 0x10a00, 0x10a03 },
  { 0x10a05, 0x10a06 },
  { 0x10a0c, 0x10a13 },
  { 0x10a15, 0x10a17 },
  { 0x10a19, 0x10a33 },
  { 0x10a38, 0x10a3a },
  { 0x10a3f, 0x10a47 },
  { 0x10a50, 0x10a58 },
  { 0x10a60, 0x10a7f },
  { 0x10b00, 0x10b35 },
  { 0x10b39, 0x10b55 },
  { 0x10b58, 0x10b72 },
  { 0x10b78, 0x10b7f },
  { 0x10c00, 0x10c48 },
  { 0x10e60, 0x10e7e },
  { 0x11000, 0x1104d },
  { 0x11052, 0x1106f },
  { 0x11080, 0x110c1 },
  { 0x12000, 0x1236e },
  { 0x12400, 0x12462 },
  { 0x12470, 0x12473 },
  { 0x13000, 0x1342e },
  { 0x16800, 0x16a38 },
  { 0x1b000, 0x1b001 },
  { 0x1d000, 0x1d0f5 },
  { 0x1d100, 0x1d126 },
  { 0x1d129, 0x1d1dd },
  { 0x1d200, 0x1d245 },
  { 0x1d300, 0x1d356 },
  { 0x1d360, 0x1d371 },
  { 0x1d400, 0x1d454 },
  { 0x1d456, 0x1d49c },
  { 0x1d49e, 0x1d49f },
  { 0x1d4a2, 0x1d4a2 },
  { 0x1d4a5, 0x1d4a6 },
  { 0x1d4a9, 0x1d4ac },
  { 0x1d4ae, 0x1d4b9 },
  { 0x1d4bb, 0x1d4bb },
  { 0x1d4bd, 0x1d4c3 },
  { 0x1d4c5, 0x1d505 },
  { 0x1d507, 0x1d50a },
  { 0x1d50d, 0x1d514 },
  { 0x1d516, 0x1d51c },
  { 0x1d51e, 0x1d539 },
  { 0x1d53b, 0x1d53e },
  { 0x1d540, 0x1d544 },
  { 0x1d546, 0x1d546 },
  { 0x1d54a, 0x1d550 },
  { 0x1d552, 0x1d6a5 },
  { 0x1d6a8, 0x1d7cb },
  { 0x1d7ce, 0x1d7ff },
  { 0x1f000, 0x1f02b },
  { 0x1f030, 0x1f093 },
  { 0x1f0a0, 0x1f0ae },
  { 0x1f0b1, 0x1f0be },
  { 0x1f0c1, 0x1f0cf },
  { 0x1f0d1, 0x1f0df },
  { 0x1f100, 0x1f10a },
  { 0x1f110, 0x1f12e },
  { 0x1f130, 0x1f169 },
  { 0x1f170, 0x1f19a },
  { 0x1f1e6, 0x1f202 },
  { 0x1f210, 0x1f23a },
  { 0x1f240, 0x1f248 },
  { 0x1f250, 0x1f251 },
  { 0x1f300, 0x1f320 },
  { 0x1f330, 0x1f335 },
  { 0x1f337, 0x1f37c },
  { 0x1f380, 0x1f393 },
  { 0x1f3a0, 0x1f3c4 },
  { 0x1f3c6, 0x1f3ca },
  { 0x1f3e0, 0x1f3f0 },
  { 0x1f400, 0x1f43e },
  { 0x1f440, 0x1f440 },
  { 0x1f442, 0x1f4f7 },
  { 0x1f4f9, 0x1f4fc },
  { 0x1f500, 0x1f53d },
  { 0x1f550, 0x1f567 },
  { 0x1f5fb, 0x1f5ff },
  { 0x1f601, 0x1f610 },
  { 0x1f612, 0x1f614 },
  { 0x1f616, 0x1f616 },
  { 0x1f618, 0x1f618 },
  { 0x1f61a, 0x1f61a },
  { 0x1f61c, 0x1f61e },
  { 0x1f620, 0x1f625 },
  { 0x1f628, 0x1f62b },
  { 0x1f62d, 0x1f62d },
  { 0x1f630, 0x1f633 },
  { 0x1f635, 0x1f640 },
  { 0x1f645, 0x1f64f },
  { 0x1f680, 0x1f6c5 },
  { 0x1f700, 0x1f773 },
  { 0x20000, 0x2a6d6 }, // CJK Ideograph Extension B
  { 0x2a700, 0x2b734 }, // CJK Ideograph Extension C
  { 0x2b740, 0x2b81d }, // CJK Ideograph Extension D
  { 0x2f800, 0x2fa1d },
  { 0xe0001, 0xe0001 },
  { 0xe0020, 0xe007f },
  { 0xe0100, 0xe01ef },
  { 0xf0000, 0xffffd },
  { 0x100000, 0x10fffd },
  { 0xffffffff, 0xffffffff } // Sentinel
};

static int gs_unicodeRangeCount = sizeof(gs_unicodeRanges) / sizeof(UnicodeRange);

#endif
