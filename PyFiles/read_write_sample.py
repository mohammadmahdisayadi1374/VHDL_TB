from openTB import openTB as tb2
import numpy as np 
import matplotlib.pyplot as plt 

handler = tb2.FileHandler(foldername = "VHDL_TB", projectname = "PRJ_NAME")
rd_wr_sel = "read"
datatype_buffer = ["float32", "int16"]
file_reim = ["real", "imag"]
data_num = 4
data_size = int(1e3)
filenames = [handler.filenamegen(filetype = "python", inouttype = "output", filedescription = "pytflo"
, filenumber = i//2, filereim = file_reim[i%2], codec = ".txt", help = True) for i in range(data_num)]
datatype = datatype_buffer[0]
if rd_wr_sel == "write":
    data_dict = {}
    # generate and write data to file 
    for i in range(data_num):
        if datatype == "float32":
            data_dict[filenames[i]] = tb2.fix2sfl(10*np.random.normal(0, 1, (data_size, ))) # float32
        elif datatype == "int16":
            data_dict[filenames[i]] = 10*np.random.normal(0, 1, (data_size, )) # int16
    # write data 
    handler.writer(datadict = data_dict, filenames = filenames, datatype = datatype)
    
elif rd_wr_sel == "read": 
    
    data = handler.reader(filenames = filenames, verbose = True, datatype = datatype_buffer[0])
    data_keys = list(data.keys())
    mdata = np.zeros((data_size, int(data_num/2)), dtype = np.complex64)
    for i in range(int(data_num/2)):
        mdata[:, i] = np.array(data[data_keys[2*i]], dtype = np.float32) + 1j*np.array(data[data_keys[2*i + 1]], dtype = np.float32)
    plot = True 
    if plot:
        plt.plot(np.abs(mdata), color = "blue")
        plt.show()



