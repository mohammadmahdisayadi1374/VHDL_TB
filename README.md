# VHDL_TB
this repo is created to user have better, and easier connection with Vivado testbench 

# How to install required python package
at first you need to install openTB python package using following command:

pip install openTB==0.0.3

or 

python -m pip install openTB==0.0.3

# How to use 

steps of using this repo came in the following list: 

  1. customize the input file using python file (exist in PyFiles)
  2. generate a suitable testbench based on the testbench which exist in PRJ_NAME.srcs/sim_1/new/DUT_TB
  3. writing the generated data by vivado to a file 
  4. reading the inputs of the test bench and the output of the vivado using reader in python package. 
  5. compare the result. 


## 1. Customize input files
in this section you have to generate your data in the python and write theme to some text files in the Testfile directory. 
following codes show you how you can write your data into a file in testfile directory.
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
filenames = [handler.filenamegen(filetype = "python", inouttype = "output", filedescription = "xxxxxx"
, filenumber = i//2, filereim = file_reim[i%2], codec = ".txt", help = True) for i in range(data_num)]
# by study the help of file name generator you can see the properties of it 
data = handler.writer(datadict = data_dict, filenames = filenames, datatype = datatype_buffer[0])
# depends on your data, datatype can be float32 or int16
```

## 2. Generate testbench 

copy the testbench exited in the /sim_1/new/VHDL_TB to your testbench path if it defferent, and then change it in a way that solve your problem. 

### 2.1. Adding File Reader and File writer ip cores

inside of the source_1/ip there are two main ips named FileReader and FileWriter.
first add them to the project using vivado
in the second stet you have to add text file which are generated by python to the vivado. 
for addint them 

in the addsource --> add simulation source (third and last case) --> go to the TestFile path and add the 
favorit files to the vivado for using them in the simulation. 

port mapt file reader and create its appropreat signals. 
for port maping it you have to pay attention to following hints: 

  1. G_interval width: shows the interval of arraving data, for example if the G_interval is set on 16, it means that your data came in every 16 clock pulses.
  2. real and imag file names are the variables with string type. the lenght of the string belong to how many file you have for testing your core, but the length of        vaiable name must have be equal to the name of the added text file to the vivado and it is a fixed number which is equal to 26 chars.
  3. depends on your data type the input can be array or std_logiC_vector and its bit widths can be 16, 32, or 64 bits. 

## 3. Adding file writer 
the same with the adding file reader to your project, your can port map the filewriter ip to the project, but notice that in the filename portmaping your string variable must contain all the path directory as you can see the VHDL_TB which is in the sim_1/new dir.



## 4. Reading Generated file using python 
in this section you are able to read the file which python is generated or the file which vivado is generated, or even both of them.
for reading files using python follow the following codes: 

````
atatype_buffer = ["float32", "int16"]
file_reim = ["real", "imag"]
data_num = 4
data_size = int(1e3)
filenames = [handler.filenamegen(filetype = "python", inouttype = "output", filedescription = "xxxxxx"
, filenumber = i//2, filereim = file_reim[i%2], codec = ".txt", help = True) for i in range(data_num)]
data = handler.reader(filenames = filenames, verbose = True, datatype = datatype_buffer[0])
````

# FROM NOW ON YOU HAVE FOLLOWING ABILITIES

  1. ability to connect your python project to you vivado test bench project
  2. ability to compare generated data with input data, and generate python data in the python ides which is more accurate.
  3. you can extend the code, and the write belive that the propagating this file can be start of a big usefull software for hardware programmers like me.







