with import <nixpkgs> {}; {
  rEnv = stdenv.mkDerivation {
    name = "r";
    buildInputs = [
      rPackages.devtools rPackages.survey
    ];
    R_LIBS = "${rPackages.devtools}/library:${rPackages.survey}/library";
  };  
}
