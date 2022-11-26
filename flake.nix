{
  description = "Voronoi in C++";

  # inputs.nixpkgs.url = "nixpkgs/nixos-21.05-small";
  inputs.nixpkgs.url = "nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let

      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      packageName = "voronoi-in-cpp";
    in {

      packages.x86_64-linux.default = self.packages.x86_64-linux.voronoi;

      packages.x86_64-linux.voronoi =
        # Notice the reference to nixpkgs here.
        with import nixpkgs { system = "x86_64-linux"; };
        stdenv.mkDerivation {
          name = "voronoi";
          src = self;
          dontStrip = true;
          buildPhase = "gcc -fmodules-ts -std=c++2b -I./ -O0 -g -o voronoi ./voronoi.cpp -lstdc++";
          installPhase = "mkdir -p $out/bin; install -t $out/bin voronoi";
        };
    };
}
