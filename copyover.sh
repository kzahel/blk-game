echo "Copy over generated files..."
cd build-gen
for f in `find . -type f`; do echo cp $f ../$f; done
for f in `find . -type f`; do cp $f ../$f; done
cd ..
