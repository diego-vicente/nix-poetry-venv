# `poetry-flake`: A prototyping flake to use Python and Poetry

This flake allows you to run a development shell that installs Python 3.9 and Poetry, with the minimal configuration needed for most wheels to properly build (BLAS, LAPACK). It will create a local `.venv` folder where all the dependencies will be installed.

The main motivation for this flake is to provide an easy prototyping workflow for simple data science projects, allowing you to jump in a fast-moving workflow using just Poetry. Be careful since it will bypass most advantages of Nix/NixOS, so it should be used sparsely and is not a good alternative to proper packaging in mission critical environments.

To run it, you can copy and adapt the `flake.nix` file or simply run:

```shell
nix develop github:diego-vicente/poetry-flake
```

Using `--impure` will let you access the rest of your tools, and using `--no-write-lock-file` is likely going to be needed if you are fetching it from some place else.

If you are using `nix-direnv` (and you absolutely should), it is as simple as writing this in your `.envrc` and allowing it:

```
use flake github:diego-vicente/poetry-flake --impure
```
