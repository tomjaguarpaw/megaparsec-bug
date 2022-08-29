set -e

cabal build --enable-profiling --with-ghc=ghc-9.0
$(cabal list-bin --with-ghc=ghc-9.0 megaparsec-bug) +RTS -hy -i0.00001
hp2ps megaparsec-bug.hp
