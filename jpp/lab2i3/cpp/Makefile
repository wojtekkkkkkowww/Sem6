CXX = g++
CXXFLAGS = -std=c++17 -Wall -Wextra -pedantic 

main: gf_test dh_test
	@echo "All done"

gf_test: test.o 
	$(CXX) $(CXXFLAGS) -o gf_test test.o 

gf_test.o: test.cpp 
	$(CXX) $(CXXFLAGS) -c test.cpp

dh_test: DHtest.o
	$(CXX) $(CXXFLAGS) -o dh_test DHtest.o

dh_test.o: DHtest.cpp
	$(CXX) $(CXXFLAGS) -c DHtest.cpp

clean:
	rm -f *.o gf_test dh_test
