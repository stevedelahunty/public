#
# Makefile for creating yang data documentation and for generating RESTAPI's.
#
TOPDIR := $(PWD)
BASEDIR=release/models

DIRLIST := $(sort $(dir $(wildcard $(BASEDIR)/*/)))
colon:= :
empty:=
space:= $(empty) $(empty)
DIRS := $(subst $(space),$(colon),$(DIRLIST))
PYANG=pyang
base_models_dir := opx-base-model
rfc_models_dir := $(base_models_dir)/rfc
.PHONY: clean myprog

src := $(shell find $(BASEDIR) -name '*.yang')
obj = $(src:.yang=.html)



myprog: html $(base_models_dir) $(obj)
	@echo "All done"

html:
	mkdir html

$(base_models_dir):
	git clone https://github.com/open-switch/opx-base-model.git

%.html : %.yang
	$(PYANG) -f jstree --path=$(rfc_models_dir):$(DIRS) --lax-quote-checks $^ -o $@
	cp $@ $(TOPDIR)/html/$(notdir $@)

clean:
	rm -f $(obj) 
	rm -rf $(base_models_dir)
	rm -f *~
	rm -rf html
