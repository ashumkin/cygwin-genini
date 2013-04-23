SDIR := $(shell cd $(dir $(firstword $(MAKEFILE_LIST))) && pwd)
GENINI := ${SDIR}/genini
release = release
SETUP_INI = setup.ini
SETUP_BZ2 = setup.bz2
setupini=

all : run bzip sign

run :
	perl "${GENINI}" ${setupini} --output=${SETUP_INI} --recursive ${release}

only :
	perl "${GENINI}" --output=${SETUP_INI}.only --recursive ${release}

bzip :
	bzip2 ${SETUP_INI} -c > ${SETUP_BZ2}

sign :
	rm --force ${SETUP_INI}.sig ${SETUP_BZ2}.sig 2>/dev/null
	gpg --detach-sign --default-key 29E42696 ${SETUP_INI}
	gpg --detach-sign --default-key 29E42696 ${SETUP_BZ2}
