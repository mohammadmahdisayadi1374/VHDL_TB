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


##1. Customize input files
```
from openTB import openTB as tb2 # the 2 inspired of cv2 :)
import numpy as np 
handler = tb2.FileHandler(foldername = "<PROJECT_MAIN_FOLDER_NAME>", projectname = "PROJECT_NAME")
# for example if your project path be as follow : 
# <project path>/<foldername>/<project_name>.srcs

```


