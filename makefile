OS  ?= $(shell uname -s)
GIT := git

gitMasterBranch := master
gitLocalBranch  := local

scriptDir := Scripts

.PHONY: default copy install uninstall sync

default: copy

copy:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/copy.ps1
else
	@./${scriptDir}/copy.sh
endif

install:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/install.ps1
else
	@./${scriptDir}/install.sh
endif

uninstall:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/uninstall.ps1
else
	@./${scriptDir}/uninstall.sh
endif

sync:
	${GIT} checkout ${gitMasterBranch}
	${GIT} pull
	${GIT} checkout ${gitLocalBranch}
	${GIT} merge master
	${MAKE}
