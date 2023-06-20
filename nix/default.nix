{ pkgs }:

let
  inherit (pkgs.haskell.lib) dontCheck;

  haskellPackages = pkgs.haskell.packages."ghc96".override (_: {
    overrides = new: old: {
      optparse-applicative =
        dontCheck (new.callPackage ./haskell/optparse-applicative.nix { });
      prettyprinter =
        dontCheck (new.callPackage ./haskell/prettyprinter.nix { });
      prettyprinter-ansi-terminal =
        dontCheck (new.callPackage ./haskell/prettyprinter-ansi-terminal.nix { });
    };
  });

  demoHaskell = haskellPackages.developPackage {
    root = ../demo;
    name = "demo";
  };

  hls = pkgs.haskell-language-server.override {
    supportedGhcVersions = [ "96" ];
  };

in
{

  packages.default = pkgs.haskell.lib.justStaticExecutables demoHaskell;

  devShells.default = pkgs.mkShell {
    inputsFrom = [ demoHaskell.env ];
    buildInputs = [ hls pkgs.cabal-install ];
  };

}
