# VHDL_TB
this repo is created to user have better, and easier connection with Vivado testbench 

# How to install required python package
at first you need to install openTB python package using following command:

pip install openTB==0.0.3

or 

python -m pip install openTB==0.0.3

# How to use 

steps of using this repo came in the following list: 

  1. clone the repo
  2. customize the input file using python file (exist in PyFiles)
  3. generate a suitable testbench based on the testbench which exist in PRJ_NAME.srcs/sim_1/new/DUT_TB
  4. writing the generated data by vivado to a file 
  5. reading the inputs of the test bench and the output of the vivado using reader in python package. 
  6. compare the result. 


## 1. Customize input files
```
from openTB import openTB as tb2 # the 2 inspired of cv2 :)
import numpy as np 
handler = tb2.FileHandler(foldername = "<PROJECT_MAIN_FOLDER_NAME>", projectname = "PROJECT_NAME")
# for example if your project path be as follow : 
# <project path>/<foldername>/<project_name>.srcs
datatype_buffer = ["float32", "int16"]
file_reim = ["real", "imag"]
data_num = 4
data_size = int(1e3)
filenames = [handler.filenamegen(filetype = "python", inouttype = "output", filedescription = "pytflo"
, filenumber = i//2, filereim = file_reim[i%2], codec = ".txt", help = True) for i in range(data_num)]
# by study the help of file name generator you can see the properties of it 
data = handler.reader(filenames = filenames, verbose = True, datatype = datatype_buffer[0])
# depends on your data, datatype can be float32 or int16
```


