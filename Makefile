# VARIABLE DEFINITIONS  #######################################################
###############################################################################
# folders #####################################################################
DIR:= .#
CODE:= $(DIR)/code

DATA:= $(DIR)/data

FIG:= $(DIR)/figures

DT/P:= $(DATA)/processed
DT/R:= $(DATA)/raw
DT/I:= $(DATA)/interim

DOC:= $(DIR)/docs
JRN:= $(DOC)/journals
RPRT:= $(DOC)/reports

# FILES #######################################################################
# all interim data filee
DT/I/.rds :=  $(DT/I)/*.rds

# all processed files
DT/P/.rds := $(DT/P)/*.rds

# all figure files
FIGZ := $(FIG)/*.*

# COMMANDS ####################################################################
# recipe to make .dot file  of this makefile
define make2dot
	@echo creating the .dot file from the dependencies in this makefile ----------
	python $(DIR)/code/makefile2dot.py < $< > $@
	sed -i 's/rankdir="BT"/rankdir="TB"/' $(DT/P)/make.dot	
	@echo done -------------------------------------------------------------------
endef 

# recipe to make .png file  from the dot file
define dot2png
	@echo Creating the .png from the .dot ----------------------------------------
  dot -Tpng $< -o$(FIG)/make.png
	@echo done -------------------------------------------------------------------
endef

# recipe to knit pdf from first prerequisite
define rmd2pdf
	@echo creating the $(@F) file by knitting it in R. ---------------------------
  Rscript -e "suppressWarnings(suppressMessages(require(rmarkdown)));\
	render('$<', output_dir = '$(@D)', output_format = 'pdf_document',\
	quiet = TRUE )"
	-rm $(wildcard $(@D)/tex2pdf*) -fr
endef 

# recipe to knit html from first prerequisite
define rmd2html
	@echo creating the $(@F) file by knitting it in R.---------------------------
  Rscript -e "suppressWarnings(suppressMessages(require(rmarkdown))); \
	render('$<', output_dir = '$(@D)', output_format = 'html_document',\
	quiet = TRUE )"
endef 

# recipe for sourcing the prerequisite R file
define sourceR
	Rscript -e "source('$<')"
endef

# DEPENDENCIES   ##############################################################
###############################################################################

all: journal readme dot task	

.PHONY: all

# make chart from .dot #########################################################
dot: $(FIG)/make.png 

# make file .dot from the .makefile
$(FIG)/make.png: $(DT/P)/make.dot
	@$(dot2png)

# make file .dot from the .makefile
$(DT/P)/make.dot: $(DIR)/Makefile
	@$(make2dot)

# journals from Rmds ###########################################################
journal: $(JRN)/journal.pdf 

# journal (with graph) render to  pdf
$(JRN)/journal.pdf:  $(JRN)/journal.Rmd $(FIG)/make.png
	$(rmd2pdf)

# tast description from Rmds ###########################################################
task: $(JRN)/task.pdf 

# task render to  pdf
$(JRN)/task.pdf:  $(JRN)/task.Rmd 
	$(rmd2pdf)
	
# README from Rmds #############################################################
readme: README.html

README.html: README.md
	$(rmd2html)

