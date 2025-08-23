{
    red,
    green,
    blue,
    alpha ? 1.0,
    lib,
}: let
    redHex = lib.toHexString red;
    greenHex = lib.toHexString green;
    blueHex = lib.toHexString blue;
    alphaHex = lib.toHexString (builtins.ceil (alpha * 255.0));
    rgb = lib.concatMapStringsSep "," toString [red green blue];
    rgba = lib.concatMapStringsSep "," toString [red green blue alpha];
    rgb_hex = lib.concatStrings [
        redHex
        greenHex
        blueHex
    ];
    rgba_hex = lib.concatStrings [rgb_hex alphaHex];
in {
    #inherit red;
    red = 255;
    inherit green;
    inherit blue;
    inherit alpha;
    inherit rgb;
    inherit rgb_hex;
    inherit rgba;
    inherit rgba_hex;
}
