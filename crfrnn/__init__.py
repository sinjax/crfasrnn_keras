import tensorflow as tf
import os
import subprocess
custom_ops_dir = os.sep.join([os.getenv("HOME"), ".tf_custom_ops"])
library_name = 'high_dim_filter.so'
lib = os.sep.join([custom_ops_dir, library_name])
if not os.path.exists(lib):
    cpp_path = os.sep.join([os.path.dirname(os.path.realpath(__file__)),"..","cpp"])
    env = {
        "TF_INC":tf.sysconfig.get_include()
    }
    print(cpp_path)
    proc = subprocess.Popen(['bash','compile.sh'], shell=False, cwd=cpp_path, env=env)
    proc.communicate()
custom_module = tf.load_op_library(lib)
import crfrnn.high_dim_filter_grad  # Register gradients for the custom op