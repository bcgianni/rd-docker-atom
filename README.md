# rd-docker-atom

A dockerized Atom with linters ESLint, Rubocop and Reek already installed.

## How to install?
```
git clone git@github.com:ResultadosDigitais/rd-docker-atom.git
cd rd-docker-atom
./install.sh
```
Script `install.sh` builds Dockerfile and copies the executable `rd-atom` to `/usr/local/bin`. The first build can take some time, so be patient.

## Usage

After run `install.sh`, you are good to use it. To launch Atom, just type the following command in the desired directory:

```
rd-atom .
```
