include settings

all: $(targetDir)/$(initTargetName)
	cp $< .

install:
	./install.sh

uninstall:
	rm $(targetDir)/$(initTargetName)
