{
  description = "Node.js development environment using nixpkgs-unstable";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodejs_24
            pkgs.typescript
            pkgs.nodemon
          ];

          # Optional: shellHook runs once when you enter the shell.
          # Good for sanity-checking versions or printing project info.
          shellHook = ''
            echo "node $(node --version)  |  pnpm $(pnpm --version)"
          '';
        };
      });
}

