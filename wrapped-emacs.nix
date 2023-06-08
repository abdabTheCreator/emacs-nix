let
    nixpkgs = import <nixpkgs> {};
    inherit (nixpkgs) stdenv fetchFromGitHub which;
   
    emacs = stdenv.mkDerivation{
           name="emacs";
           src = nixpkgs.fetchFromGitHub {
           owner  = "emacs-mirror";
           repo   = "emacs";
          rev    = "7791907c3852e6ec197352e1c3d3dd8487cc04f5";
          sha256 = "sha256-O5Tp+6Uz+7FejRIfJx6bgXBEuxoeyyKdpDqRdMuzjZU=";
      };
  
  };
  
  wrappedEmacs = stdenv.mkDerivation {
          name = "emacs-wrapper";
          buildInputs = [emacs which nixpkgs.autoconf];
          unpackPhase = "true";
          installPhase = ''
           ./autogen.sh
           ./configure
      '';
      preConfigure = "./autogen.sh"
  };
 in wrappedEmacs
