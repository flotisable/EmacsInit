OS  ?= $(shell uname -s)
GIT := git

gitMasterBranch := master
gitLocalBranch  := local

include settings

ifeq "${OS}" "Windows_NT"
	defaultScript := powershell -NoProfile ./default.ps1
else
	defaultScript := ./default.sh
endif

ifeq "${targetDir}" ""
targetDir := $(shell ${defaultScript} ${OS})
endif

all: $(targetDir)/$(initTargetName)
ifeq "${OS}" "Windows_NT"
	powershell -NoProfile -Command "Copy-Item $< ${initSourceName}"
else
	cp $< ${initSourceName}
endif

install:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./install.ps1
else
	@./install.sh
endif

uninstall:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./uninstall.ps1
else
	@./uninstall.sh
endif

sync:
	${GIT} checkout ${gitMasterBranch}
	${GIT} pull
	${GIT} checkout ${gitLocalBranch}
	${GIT} merge master
	${MAKE}
