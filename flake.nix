{
  description = "Node.js development environment using nixpkgs-unstable";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      gcloud = pkgs.google-cloud-sdk.withExtraComponents [
        pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
      ];
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodejs_24
            pkgs.typescript
            pkgs.nodemon
            pkgs.temporal
            gcloud
            pkgs.terraform
          ];

          # Optional: shellHook runs once when you enter the shell.
          # Good for sanity-checking versions or printing project info.
          shellHook = ''
            export CLOUDSDK_CONFIG="$PWD/.gcloud"
            echo "node $(node --version)  |  gcloud $(gcloud version --format='value(\"Google Cloud SDK\")' 2>/dev/null)"
          '';
        };
      });
}

