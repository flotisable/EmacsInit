OS ?= $(shell uname -s)

include settings

ifeq "${targetDir}" ""
targetDir = $(shell ./default.sh ${OS})
endif

all: $(targetDir)/$(initTargetName)
	cp $< ${initSourceName}

install:
	@./install.sh

uninstall:
	rm $(targetDir)/$(initTargetName)
