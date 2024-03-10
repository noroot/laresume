SHELL := /bin/bash
BUILD_DIR := _build

clean:
	rm -rf $(BUILD_DIR)

build:
	make build-file file=default

sign:
	make sign-i-file file=default

all:
	make build-file file=default
	make sign-file file=default sign=LaResume

build-file: clean
	echo "Building version..."
	mkdir $(BUILD_DIR)
	pdflatex ${file}.tex
	mv ${file}.pdf _build/${file}.pdf

sign-i-file: clean
	echo "Signing ..."
	echo "Make sign hash from phrase:"
	@read PHRASE ; \
	mkdir $(BUILD_DIR) ; \
	cp ${file}.tex $(BUILD_DIR)/${file}.tex; \
	echo "$${PHRASE},`echo $${PHRASE} | sha256sum`, `date -R`" >> signatures.txt; \
	gsed -i "s/SIGN/`echo $${PHRASE} | sha256sum`/" $(BUILD_DIR)/${file}.tex; \
	pdflatex $(BUILD_DIR)/${file}.tex ; \
	cp ${file}.pdf "$(BUILD_DIR)/Resume`date +\"%Y%m%d%S\"`.pdf"

sign-file: clean
	echo "Signing ..."
	mkdir $(BUILD_DIR) ; \
	cp ${file}.tex $(BUILD_DIR)/${file}.tex; \
	echo "$${sign},`echo $${sign} | sha256sum`, `date -R`" >> signatures.txt; \
	gsed -i "s/SIGN/`echo $${sign} | sha256sum`/" $(BUILD_DIR)/${file}.tex; \
	pdflatex $(BUILD_DIR)/${file}.tex ; \
	cp ${file}.pdf "$(BUILD_DIR)/Resume`date +\"%Y%m%d%S\"`.pdf"
