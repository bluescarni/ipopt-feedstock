#!/bin/bash

# if [ "$(uname)" == "Darwin" ]; then
# else
# fi

mkdir build
cd build

if [ "$(uname)" == "Darwin" ]; then
  export CXX=clang++
  export CC=clang
else
  export CXX=g++
  export CC=gcc
fi

../configure \
  CFLAGS="-I$PREFIX/include -I$PREFIX/include/asl" \
  CXXFLAGS=" -m64 -I$PREFIX/include -I$PREFIX/include/asl" \
  --with-blas-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -lopenblas" \
  --with-asl-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -lasl" \
  --with-mumps-lib="-Wl,-rpath,$PREFIX/lib -L$PREFIX/lib -ldmumps -lmumps_common -lpord -lmpiseq -lesmumps -lscotch -lscotcherr -lmetis -lgfortran" \
  --prefix=$PREFIX

make
make test
make install
