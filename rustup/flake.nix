{
  description = "Your project description here";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.myShell;
    
    packages.x86_64-linux.myShell = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        clang
        llvmPackages.bintools
        rustup
      ];

      RUSTC_VERSION = nixpkgs.lib.readFile ./rust-toolchain;
      LIBCLANG_PATH = nixpkgs.lib.makeLibraryPath [ nixpkgs.legacyPackages.x86_64-linux.llvmPackages_latest.libclang.lib ];

      shellHook = ''
        export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
        export PATH=$PATH:''${RUSTUP_HOME:-~/.rustup}/toolchains/$RUSTC_VERSION-x86_64-unknown-linux-gnu/bin/
        '';

      RUSTFLAGS = (builtins.map (a: ''-L ${a}/lib'') [
        # add libraries here (e.g. nixpkgs.legacyPackages.x86_64-linux.libvmi)
      ]);

      BINDGEN_EXTRA_CLANG_ARGS =
        (builtins.map (a: ''-I"${a}/include"'') [
          nixpkgs.legacyPackages.x86_64-linux.glibc.dev
        ])
        ++ [
          ''-I"${nixpkgs.legacyPackages.x86_64-linux.llvmPackages_latest.libclang.lib}/lib/clang/${nixpkgs.legacyPackages.x86_64-linux.llvmPackages_latest.libclang.version}/include"''
          ''-I"${nixpkgs.legacyPackages.x86_64-linux.glib.dev}/include/glib-2.0"''
          ''-I${nixpkgs.legacyPackages.x86_64-linux.glib.out}/lib/glib-2.0/include/''
        ];
    };
  };
}

