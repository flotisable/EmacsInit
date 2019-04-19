include settings

ifeq "${targetDir}" ""
targetDir = $(shell ./default.sh ${os})
endif

all: $(targetDir)/$(initTargetName)
	cp $< ${initSourceName}

install:
	./install.sh

uninstall:
	rm $(targetDir)/$(initTargetName)
