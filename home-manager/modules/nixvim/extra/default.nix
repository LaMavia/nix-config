{}:
let files = [
  ./cmp.lua
];
in 
builtins.concatStringsSep 
  "\n"
  ( builtins.concatMap 
      builtins.readFile 
      files 
  ) 
