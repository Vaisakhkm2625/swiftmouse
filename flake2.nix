{
  description = "A very basic flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable }: 
  let 
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    unstable= nixpkgs-unstable.legacyPackages.x86_64-linux; 
  in 
  {
    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
            unstable.rustc       
            unstable.cargo       
            unstable.clang
            #unstable.libpipewire 
            unstable.pipewire
            unstable.pkg-config
        ];

        PKG_CONFIG_PATH = "${unstable.pipewire.dev}/lib/pkgconfig";
        LIBCLANG_PATH = "${unstable.llvmPackages_11.libclang.lib}/lib";
    };

  };
}
