OS  ?= $(shell uname -s)
GIT := git

gitMasterBranch := master
gitLocalBranch  := local

.PHONY: default copy install uninstall sync

default: copy

copy:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./copy.ps1
else
	@./copy.sh
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
