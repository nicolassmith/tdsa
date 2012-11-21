SHELL=/bin/sh

DATACMD=$(realpath bin/txt2npy)
SNRCMD=$(realpath bin/makeSNRdata)
NOISECURVETXTDIR='../../noisecurves/results/'
ORIGDIR=$(CURDIR)

BNSM1=1.4
BNSM2=1.4
NSBHM1=1.4
NSBHM2=10
BBHM1=10
BBHM2=10
FLOW=10
DATADIR=noisecurves

all: data bns nsbh bbh

data:
	mkdir noisecurves
	cd noisecurves && python $(DATACMD) $(NOISECURVETXTDIR)

bns:
	mkdir bnsdata
	cd bnsdata && python $(SNRCMD) --m1=$(BNSM1) --m2=$(BNSM2) --flow=$(FLOW) --datadir=$(ORIGDIR)/noisecurves --systype=bns

nsbh:
	mkdir nsbhdata
	cd nsbhdata && python $(SNRCMD) --m1=$(NSBHM1) --m2=$(NSBHM2) --flow=$(FLOW) --datadir=$(ORIGDIR)/noisecurves --systype=nsbh

bbh:
	mkdir bbhdata
	cd bbhdata && python $(SNRCMD) --m1=$(BBHM1) --m2=$(BBHM2) --flow=$(FLOW) --datadir=$(ORIGDIR)/noisecurves --systype=bbh

allclean: dataclean bnsclean nsbhclean bbhclean

dataclean:
	rm -fr noisecurves

bnsclean:
	rm -fr bnsdata

nsbhclean:
	rm -fr nsbhdata

bbhclean:
	rm -fr bbhdata
