{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    {self,  nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      deps = 
          (with pkgs; [
            wayland-scanner
            wayland
          ]) ;
    in
    {

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = deps;

      };

      legacyPackages.${system}.raylibBuildInputs = deps;
    };
}
