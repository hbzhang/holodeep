import pickle
import numpy as np
import os
from urllib.request import urlretrieve
import tarfile
import zipfile
import sys
import hickle

import deepdish

def loadbatchdata(name="train"):
    x = None
    y = None

    hdfdata = []

    #maybe_download_and_extract()

    folder_name = "cifar_10"

    f = open('./data_set/'+folder_name+'/batches.meta', 'rb')
    f.close()

    if name is "train":
        for i in range(5):
            f = open('./data_set/'+folder_name+'/data_batch_' + str(i + 1), 'rb')
            datadict = pickle.load(f, encoding='latin1')

            hdfdata.append(datadict)

            hickle.dump(datadict, 'train'+str(i)+'.hkl', mode='w')

            #datadict = hickle.load(f)

            f.close()

            _X = datadict["data"]
            _original_image = _X
            _Y = datadict['labels']

            _X = np.array(_X, dtype=float) / 255.0
            _X = _X.reshape([-1, 3, 32, 32])
            _X = _X.transpose([0, 2, 3, 1])
            _X = _X.reshape(-1, 32*32*3)

            if x is None:
                x = _X
                y = _Y
                original_image = _original_image
            else:
                x = np.concatenate((x, _X), axis=0)
                y = np.concatenate((y, _Y), axis=0)
                original_image = np.concatenate((original_image, _original_image), axis=0)

    elif name is "test":
        f = open('./data_set/'+folder_name+'/test_batch', 'rb')
        datadict = pickle.load(f, encoding='latin1')
        f.close()

        hickle.dump(datadict, 'test.hkl', mode='w')

        x = datadict["data"]
        y = np.array(datadict['labels'])
        original_image = x
        x = np.array(x, dtype=float) / 255.0
        x = x.reshape([-1, 3, 32, 32])
        x = x.transpose([0, 2, 3, 1])
        x = x.reshape(-1, 32*32*3)
        hickle.dump(datadict, 'test' + '.hkl', mode='w')


    print(len(hdfdata))
    if name is "train":
        hickle.dump(hdfdata, 'train.hkl', mode='w')
    elif name is "test":
        hickle.dump(hdfdata, 'test.hkl', mode='w')

    #print(datadict.size)


    return x, dense_to_one_hot(y), original_image


def dense_to_one_hot(labels_dense, num_classes=10):
    num_labels = labels_dense.shape[0]
    index_offset = np.arange(num_labels) * num_classes
    labels_one_hot = np.zeros((num_labels, num_classes))
    labels_one_hot.flat[index_offset + labels_dense.ravel()] = 1
    return labels_one_hot


if __name__ == "__main__":
    loadbatchdata("test")
