let 
  directionKeys = { h = "l"; j = "d"; k = "u"; l = "r"; };
  digits = builtins.genList (x: toString x) 10;
in rec {
  directionsBind = modifiedDirectionsBind ""; 
  modifiedDirectionsBind = modification: mods: dispatcher: builtins.attrValues (
    builtins.mapAttrs (key: dir:
      "${mods}, ${key}, ${dispatcher}, ${modification}${dir}"
    ) directionKeys
  );

  digitsBind = mods: dispatcher: map (digit: 
    "${mods}, ${digit}, ${dispatcher}, ${if digit != "0" then digit else "10"}"
  ) digits;
}
