with import <nixpkgs> { };

let
  pythonPackages = python3Packages;
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [
    # A Python interpreter including the 'venv' module is required to bootstrap
    # the environment.
    python3.pkgs.python

    # This executes some shell code to initialize a venv in $venvDir before
    # dropping into the shell
    python3.pkgs.venvShellHook

    # Those are dependencies that we would like to use from nixpkgs, which will
    # add them to PYTHONPATH and thus make them accessible from within the venv.
    python3.pkgs.numpy
    python3.pkgs.requests
    python3.pkgs.jupyterlab
    python3.pkgs.openai
    python3.pkgs.openai
    python3.pkgs.matplotlib
    python3.pkgs.datasets
    python3.pkgs.fastprogress
    python3.pkgs.fastcore
    python3.pkgs.torch
    python3.pkgs.einops
  
    # # In this particular example, in order to compile any binary extensions they may
    # require, the Python modules listed in the hypothetical requirements.txt need
    # the following packages to be installed locally:
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib
  ];

  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -r requirements.txt
  '';

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}

