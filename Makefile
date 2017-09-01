#
# Copyright (c) 2016-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.
#

CXX = c++
CXXFLAGS = -pthread -std=c++0x
OBJS = args.o dictionary.o productquantizer.o matrix.o qmatrix.o vector.o model.o utils.o fasttext.o
INCLUDES = -I.

opt: CXXFLAGS += -O3 -funroll-loops
opt: fasttext

debug: CXXFLAGS += -g -O0 -fno-inline
debug: fasttext

args.o: src/args.cpp src/args.h
	$(CXX) $(CXXFLAGS) -c src/args.cpp

dictionary.o: src/dictionary.cpp src/dictionary.h src/args.h
	$(CXX) $(CXXFLAGS) -c src/dictionary.cpp

productquantizer.o: src/productquantizer.cpp src/productquantizer.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/productquantizer.cpp

matrix.o: src/matrix.cpp src/matrix.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/matrix.cpp

qmatrix.o: src/qmatrix.cpp src/qmatrix.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/qmatrix.cpp

vector.o: src/vector.cpp src/vector.h src/utils.h
	$(CXX) $(CXXFLAGS) -c src/vector.cpp

model.o: src/model.cpp src/model.h src/args.h
	$(CXX) $(CXXFLAGS) -c src/model.cpp

utils.o: src/utils.cpp src/utils.h
	$(CXX) $(CXXFLAGS) -c src/utils.cpp

fasttext.o: src/fasttext.cpp src/*.h
	$(CXX) $(CXXFLAGS) -c src/fasttext.cpp

fasttext: $(OBJS) src/fasttext.cpp
	$(CXX) $(CXXFLAGS) $(OBJS) src/main.cpp -o fasttext

clean:
	rm -rf *.o fasttext