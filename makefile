include settings

all: $(targetDir)/$(initTargetName)
	cp $< ${initSourceName}

install:
	./install.sh

uninstall:
	rm $(targetDir)/$(initTargetName)
