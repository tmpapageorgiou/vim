# AUTHOR: https://github.com/pantuza
# Source: https://raw.githubusercontent.com/pantuza/panfiles/master/bash/Makefile

# Make file for install bash parts

# defines the shell to the make application
SHELL := /bin/bash

# bashrc file name
VIMRC := .vimrc

.PHONY := install uninstall

install: .vimrc
	@echo -e "\n${BROWN}# $(VIMRC) INSTALL${END_COLOR}"
	@echo -e "${BLUE}placing $(VIMRC) file at '$(HOME)/$(VIMRC)'${END_COLOR}"
	ln -s `pwd`/$(VIMRC) $(HOME)/$(VIMRC)
	@echo -e "$(BROWN)**\n$(END_COLOR)"

uninstall:
	@echo -e "\n${BROWN}# $(VIMRC) UNINSTALL${END_COLOR}"
	@echo -e "${BLUE}removing $(VIMRC) file from '$(HOME)/$(VIMRC)'${END_COLOR}"
	rm $(HOME)/$(VIMRC)
	@echo -e "$(BROWN)**\n$(END_COLOR)"

