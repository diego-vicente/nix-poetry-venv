{
  description = "A simple Python + Poetry dev shell with mutable venv";

  inputs ={
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let 
          pkgs = import nixpkgs { 
            inherit system;
            config.allowUnfree = true;
          };
          python = pkgs.python39;
          poetry = pkgs.poetry.override { python = python; };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [ python poetry ];

            shellHook = ''
              export LD_LIBRARY_PATH=${pkgs.lapack}/lib:$LD_LIBRARY_PATH
              export LD_LIBRARY_PATH=${pkgs.blas}/lib:$LD_LIBRARY_PATH
              export LD_LIBRARY_PATH=${pkgs.zlib}/lib:$LD_LIBRARY_PATH
              export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib64:$LD_LIBRARY_PATH
              export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
              export EXTRA_CCFLAGS="-I/usr/include"
              unset SOURCE_DATE_EPOCH
              poetry config virtualenvs.in-project true --local
            '';
          };
        }
      );
}
