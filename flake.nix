{
  description = "Emacs from head";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    gnutls.url = "github:gnutls/gnutls";
  };
  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      defaultPackage.aarch64-darwin  = pkgs.stdenv.mkDerivation rec {
        name = "emacs-head";
        src = pkgs.fetchFromGitHub {
          owner = "emacs-mirror";
          repo = "emacs";
          rev = "7791907c3852e6ec197352e1c3d3dd8487cc04f5";
          sha256 = "sha256-O5Tp+6Uz+7FejRIfJx6bgXBEuxoeyyKdpDqRdMuzjZU=";
        };
        buildInputs = [
          pkgs.autoconf
          pkgs.automake
	  pkgs.texinfo
          pkgs.libjpeg
          pkgs.libpng
          pkgs.libtiff
          pkgs.gnutls
          pkgs.harfbuzz
          pkgs.glib
          pkgs.dbus
          pkgs.libxslt
          pkgs.gtk3
          pkgs.gtk2
          pkgs.xorg.libXaw
          pkgs.xorg.libXpm
          pkgs.xorg.libSM
          pkgs.xorg.libXext
          pkgs.xorg.libXmu
          pkgs.xorg.libXt
        ];
        buildPhase = ''
          ./autogen.sh
          ./configure --prefix=$out
          make
        '';
        installPhase = ''
          make install
        '';
      };
    };
}
