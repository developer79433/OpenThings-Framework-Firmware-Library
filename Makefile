CXX=g++
CXXFLAGS=-std=gnu++14 -Wall -Werror -I external/TinyWebsockets/tiny_websockets_lib/include -include cstdint
CXXFLAGS_STATIC=
CXXFLAGS_SHARED=-fPIC
LD=$(CXX)
AR=ar
ARFLAGS=rcs
LDFLAGS=-shared
LIBNAME=OpenThingsFramework
LIBRARY_STATIC=lib$(LIBNAME).a
LIBRARY_SHARED=lib$(LIBNAME).so
SOURCES=$(wildcard *.cpp)
HEADERS=$(wildcard *.h)
OBJECTS_STATIC=$(addsuffix .o.static,$(basename $(SOURCES)))
OBJECTS_SHARED=$(addsuffix .o.shared,$(basename $(SOURCES)))

.PHONY: all
all: static shared

%.o.static: %.cpp $(HEADERS)
	$(CXX) -c -o "$@" $(CXXFLAGS) $(CXXFLAGS_STATIC) "$<"

%.o.shared: %.cpp $(HEADERS)
	$(CXX) -c -o "$@" $(CXXFLAGS) $(CXXFLAGS_SHARED) "$<"

.PHONY: static
static: $(OBJECTS_STATIC)
	$(AR) $(ARFLAGS) "$(LIBRARY_STATIC)" $(OBJECTS_STATIC)

.PHONY: shared
shared: $(OBJECTS_SHARED)
	$(LD) $(LDFLAGS) -o "$(LIBRARY_SHARED)" $(OBJECTS_SHARED)

.PHONY: clean
clean:
	rm -f $(OBJECTS_STATIC) $(OBJECTS_SHARED) $(LIBRARY_STATIC) $(LIBRARY_SHARED)
