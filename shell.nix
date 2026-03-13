{
  pkgs ? import <nixpkgs> { },
}:
pkgs.callPackage (
  {
    mkShell,
    nixfmt,
    nixd,
  }:
  mkShell {
    strictDeps = true;
    # buildInputs = [
    nativeBuildInputs = [
      nixfmt
      nixd
    ];
    # shellHook = ''
    #   nixfmt
    #   nixd
    # '';
  }
) { }

