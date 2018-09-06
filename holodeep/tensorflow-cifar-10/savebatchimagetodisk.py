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

#import Image
from PIL import Image
import numpy as np

train_x, train_y, originalimage = get_data_set("test")

print(train_x.shape)

#originalimage = np.array(originalimage, dtype=float) / 255.0

imagedata = originalimage

imagedata = imagedata.reshape([-1, 3, 32,32])

imagedata = np.ascontiguousarray(imagedata.transpose(0,2,3,1)).astype('uint8')

print(len(originalimage))

#print(originalimage[2,:,:,:])

for i in range(len(imagedata)):
    im = Image.fromarray(imagedata[i,:], 'RGB')
    filename = 'data_set/rawtest/'+ str(i) + '.png'
    im.save(filename)
    


#plt.imshow(imagedata[0,:])

#originalimage = originalimage.transpose([0, 2, 3, 1])
#originalimage = originalimage.reshape(-1, 32*32*3)










