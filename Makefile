# AUTHOR: https://github.com/pantuza
# Source: https://raw.githubusercontent.com/pantuza/panfiles/master/bash/Makefile

# Make file for install bash parts

# defines the shell to the make application
SHELL := /bin/bash

# bashrc file name
VIMRC := .vimrc

.PHONY := install

install: .vimrc
	@echo -e "\n${BROWN}# $(VIMRC) INSTALL${END_COLOR}"
	@echo -e "${BLUE}placing $(VIMRC) file at '$(HOME)/$(VIMRC)'${END_COLOR}"
	ln -sf `pwd`/$(VIMRC) $(HOME)/$(VIMRC)
	@echo -e "$(BROWN)**\n$(END_COLOR)"
