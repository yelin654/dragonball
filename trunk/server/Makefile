########################################################
#编译器
CC:=g++
FLAG:=-g -Wall -std=c++0x
#需要的链接库名称如 -lm -lcdk -lncurses等
INCLUDE =
#当前目录
CURRENT_DIR += .
#头文件目录
HEADFILE_DIR += /usr/local/include
#生成的可执行文件名称
EXENAME = main
########################################################
ADDED_CFLAGS += -I$(CURRENT_DIR) -I$(HEADFILE_DIR)
SRC:=$(wildcard *.cpp)
HDF:=$(wildcard *.h)
OBJS:=$(patsubst %.cpp,%.o,$(SRC))
FILENAMES:=$(patsubst %.cpp,%,$(SRC))

main:$(OBJS)
	$(CC) $(FLAG) $(OBJS) -llua -ldl -o main

define addepend
$(1).o:$(shell g++ -MM $(1).cpp | sed "s/.*\.o: //" | tr -d '\\\n')
	@echo -n "building$(1).o: "
	$(CC) $(FLAG) -c $(1).cpp
endef

$(foreach file, $(FILENAMES), $(eval $(call addepend, $(file))))

.PHONY:clean
clean :
	-rm -rf *.o $(EXENAME)
#----EOF-------



