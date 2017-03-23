# libpq build.sh

This script builds libpq and the headers needed to install the pg Ruby gem without installing PostgreSQL.

Works on Mac, assuming OpenSSL is installed with Homebrew.

```console
$ ./build.sh 9.6.2
$ bundle config pg.build --with-pg-dir=$PWD/target
```
