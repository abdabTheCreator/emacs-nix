 {pkgs ? import <nixpkgs> {} }:
  
   pkgs.stdenv.mkDerivation rec {
      name = "emacs-doom"; 
      src = pkgs.fetchFromGitHub {
      owner  = "emacs-mirror";
      repo   = "emacs";
      rev    = "7791907c3852e6ec197352e1c3d3dd8487cc04f5";
      sha256 = "sha256-O5Tp+6Uz+7FejRIfJx6bgXBEuxoeyyKdpDqRdMuzjZU=";
    };
    nativeBuildInputs = [pkgs.gnutar pkgs.autoconf pkgs.texinfo];
    configureFlags = [
 	 "--prefix=/usr"
	 "--with-modules"
         "--without-x"
      ];
     installPhase = ''
	tar xf $src
	cd emacs-*
        ./configure --without-x --prefix=/usr --with-modules
	make 
        make install DESTDIR=$out
'';
  
  }
