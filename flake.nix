{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/4206c4cb56751df534751b058295ea61357bbbaa";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.ncore-login = import ./package.nix { inherit pkgs; };
        devShells.default = pkgs.mkShellNoCC {
          packages = [ self.packages.${system}.ncore-login ];
        };
      });
}
