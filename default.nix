with import <nixpkgs> {}; {
  rEnv = stdenv.mkDerivation {
    name = "r";
    buildInputs = [
      rPackages.devtools
    ];
    R_LIBS = "${rPackages.devtools}/library";
  };  
}
