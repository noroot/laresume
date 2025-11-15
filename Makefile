SHELL := /bin/bash
BUILD_DIR := _build

clean:
	rm -rvf $(BUILD_DIR)
	rm -vf *.aux
	rm -vf *.log
	rm -vf *.dvi
	rm -vf *.out

build:
	make build-template TEMPLATE=default-template

build-template:
	@if [ -z "$(TEMPLATE)" ]; then \
		echo "Error: TEMPLATE parameter is required"; \
		echo "Usage: make build-with-template TEMPLATE=template-name"; \
		echo "Example: make build-with-template TEMPLATE=default-template"; \
		exit 1; \
	fi
	make build-file file=$(TEMPLATE)

sign:
	make sign-file 

all:
	make build-template TEMPLATE=default-template
	make sign-file TEMPLATE=default-template

build-file: clean
	echo "Building version..."
	mkdir $(BUILD_DIR)
	pdflatex ${file}.tex
	mv ${file}.pdf _build/${file}.pdf

sign-file: clean
	@if [ -z "$(TEMPLATE)" ]; then \
		echo "Error: TEMPLATE parameter is required"; \
		echo "Usage: make sign-file TEMPLATE=template-name"; \
		echo "Example: make sign-fileTEMPLATE=default-template"; \
		exit 1; \
	fi
	echo "Signing ..."
	echo "Make sign hash from phrase:"
	@read PHRASE ; \
	mkdir $(BUILD_DIR) ; \
	cp ${TEMPLATE}.tex $(BUILD_DIR)/${TEMPLATE}.tex; \
	echo "$${PHRASE},`echo $${PHRASE} | sha256sum`, `date -R`" >> signatures.txt; \
	gsed -i "s/SIGN/`echo $${PHRASE} | sha256sum`/" $(BUILD_DIR)/${TEMPLATE}.tex; \
	pdflatex $(BUILD_DIR)/${TEMPLATE}.tex ; \
	mv ${TEMPLATE}.pdf "$(BUILD_DIR)/Resume`date +\"%Y%m%d%S\"`.pdf"
