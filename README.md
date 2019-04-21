# cli

## Installation

```sh
cd path/to/checkout
crystal build src/cli.cr -o issyl0
ln -s path/to/checkout/issyl0 /usr/local/bin/issyl0
```

## Usage

```sh
issyl0 config [email,repo_base_path]
issyl0 sync-fork [brew,core,cask]
```
