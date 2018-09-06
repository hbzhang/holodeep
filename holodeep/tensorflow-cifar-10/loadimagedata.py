
import numpy as np
import tensorflow as tf
from time import time
import math

import os
import binascii
import pickle
import matplotlib.pyplot as plt


from include.data import get_data_set
from include.model import model, lr

from numpy import zeros, newaxis

#import Image
from PIL import Image
import numpy as np

def loaddata():
    base_dir = 'data_set/rawmatlaboutput/'
    data = None
    i = 0
    for filename in os.listdir(base_dir):
        #print(filename)
        i+=1
        #print(i)
        if filename.endswith(".png"):
        # print(os.path.join(directory, filename)
            infilename=os.path.join(base_dir, filename)
            img = Image.open(infilename)
            img.load()
            _data = np.asarray(img, dtype="int32")
            _data = _data.reshape(-1, 32 * 32 * 3)
            #_data = _data[:,:,:,newaxis]
            #print(_data.shape)
            if data is None:
                data = _data
            else:
                data = np.concatenate((data, _data))
                #print(data.shape)
            #break
        else:
            continue
        if i % 100 == 0:
            print(data.shape)
    return data

if __name__ == "__main__":
    loaddata()

