#  ------------------------------------------------------------------------------------------------------------i----------
#  *  Activate your Tensorflow virtualenv before running this script.
#  *  This script assumes gcc version >=5. If you have an older version, remove the -D_GLIBCXX_USE_CXX11_ABI=0 flag below.
#  *  On Mac OS X, the additional flag "-undefined dynamic_lookup" is required.
#  *  If this script fails, please refer to https://www.tensorflow.org/extend/adding_an_op#build_the_op_library for help.
#  -----------------------------------------------------------------------------------------------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
        ROOT=~/.tf_custom_ops/osx
        EXTRAS=-undefined dynamic_lookup
else
        ROOT=~/.tf_custom_ops/linux
fi
mkdir -p $ROOT
rm -f ~/.tf_custom_ops/high_dim_filter.so
g++ -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0 -shared high_dim_filter.cc modified_permutohedral.cc -o $ROOT/high_dim_filter.so -fPIC -I $TF_INC -O2 $EXTRAS
ln -s $ROOT/high_dim_filter.so ~/.tf_custom_ops/high_dim_filter.so
