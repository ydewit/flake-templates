{
  description = "Application packaged using poetry2nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.poetry2nix = {
    url = "github:nix-community/poetry2nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
        inherit (poetry2nix.legacyPackages.${system}) mkPoetryApplication;
        pkgs = nixpkgs.legacyPackages.${system};
        packageName = throw "put your package name here"; # can we get this from pyproject.toml?
        myapp = mkPoetryApplication { projectDir = self; };
      in
      {
        packages.default = myapp;
        packages.${packageName} = myapp;
        packages."${packageName}Image" = pkgs.dockerTools.buildLayeredImage {
          name = packageName;
          tag = "latest";
          contents = [
            myapp
          ];
          config = {
            Cmd = [ "${self.packages.${system}.default}/bin/app" ];
          };
        };

        devShells.default = pkgs.mkShell {
          packages = [ poetry2nix.packages.${system}.poetry ];
        };
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/app";
        };

      });
}
