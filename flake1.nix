{
  description = "shift mouse";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs,unstable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        defaultPackage = pkgs.hello;

        devShell = pkgs.mkShell {
          buildInputs = [
            # specify the default package
            unstable.rustc       
            unstable.cargo       
            unstable.clang
            unstable.libpipewire 
            unstable.pkg-config
            # specify the hello pacakge
            #hello-flake.packages.${system}.hello
          ];
        };
      }
    );
}
