# rd-docker-atom

A dockerized Atom with ESLint, Rubocop and Reek linters already installed.

## How to install?
```
git clone 
cd rd-docker-atom
./install.sh
```
Script `install.sh` builds Dockerfile and copy `rd-atom` to `/usr/local/bin`. The first build can take a long time to finish, so please be patient.

## Usage

After run `install.sh`, you are good to use your dockerized Atom. To launch Atom, just type the following command in the desired directory:

```
rd-atom .
```
