#!/usr/bin/python

import sys, os, time
import h5py
import numpy as np

from scipy import ndimage
from scipy import misc

import scipy.io

# Library to manage raw  scan data from hdf5 files made from raf iris files


class HDF5scan:

    def __init__(self, ifile, isweep,ivar,dtime):

      if os.path.exists(ifile):

         print 'Openning %s file' % ifile

         fd = h5py.File(ifile,'r')

# parsing of necessary data

         dataset = fd['/Ingest_header/ingest_configuration_header/']

         self.rname = dataset.attrs['siteName']
	 #convert lat and lon information to degrees, formulas are from iris documentation
         self.lat = (float(dataset.attrs['radLatitude'])*45.0)/536870912.0
         self.lon = (float(dataset.attrs['radLongitude'])*45.0)/536870912.0
	 #these variables are not used
         self.alt = float(dataset.attrs['radAltitude'])/100
         self.scan = "test"#hdr['vol_name']

         self.var = ivar
         self.dtime = dtime
	
	 dataset = fd['/Ingest_header/task_configuration_header/task_Scan_Info_header']
         self.nsweep = dataset.attrs['numSweeps']
	 self.nsweep = self.nsweep[0]

	 sweep_file = 'sweep' + str(isweep)
	 sweepd = fd[sweep_file]
         self.obsval = np.asarray(sweepd[ivar])
	 self.obsval = self.obsval.astype(float)
	 #Z2 variable is used for masking data
         self.mask = np.asarray(sweepd["Z2"])
	 self.mask = self.obsval.astype(float)
	
         dataset = fd['/Ingest_header/task_configuration_header/task_Scan_Info_header']
	
	 ray_hdr = sweepd['Z2_RayHeaders']
	 #convert angles to degree
	 az = (((ray_hdr[:,0]*0.5)*360/2**16))*2
         el = (((ray_hdr[:,1]+ray_hdr[:,3])*0.5-1)/65534)*360

         self.posangle = np.asarray(el)
         self.az = np.asarray(az)

	 #range information
	 dataset = fd['/Ingest_header/task_configuration_header/task_Range_Info_header'];
	 firstRangeBin = dataset.attrs['firstBinRange']
	 firstRangeBin = firstRangeBin[0]/100 #in meters
	 self.firstRangeBin = firstRangeBin
	 lastRangeBin = dataset.attrs['lastBinRange'] #in meters
	 lastRangeBin = lastRangeBin[0]/100

	 self.bins = dataset.attrs['numOutRangeBins']
	 self.bins = self.bins[0]
	 self.rangestep = dataset.attrs['outputBinStep'] / 100

	 self.rangestep = self.rangestep[0];
	 self.dist = lastRangeBin-firstRangeBin
	 
	 

      else:
         print "File " + ifile + " non disponibile"

