# Initialisation des couleurs

END =		\033[0m
RED =		\033[31m
GRE =		\033[32m
YEL =		\033[33m
BLU =		\033[34m
PIN =		\033[35m
CYA =		\033[36m

#Initialisation des variables

NAME :=		$(shell if [ -z $(NAME) ]; then read -p "Library name : " REPLY; echo $$REPLY; fi)
DIR =		~/codage/perso/source_C/
PATH =		$(NAME)/

SRC =		$(shell cat $(PATH)source.txt | grep -v "\#" | tr -d '\n' | sed -e 's/\.c/.o /g')
OBJ =		$(PATH)$(shell echo $(SRC) | sed -e 's/ / $(NAME)\//g')
LIB =		$(PATH)$(NAME).a

INCS =		-I../headers_C
FLAGS =		-Wall -Wextra -Werror $(INCS)
COUNT =		0

# Règles de compilation

all: header conditions $(LIB)
	@echo "    ${YEL}[Updated ${PIN}$(COUNT)${YEL} file(s).]${STD}"
	@echo ""
	@echo "  ${GRE}---Compilation done !---${STD}"
	@echo ""

$(NAME): all
	
conditions:
	@if ! [ -d $(NAME) ]; then	\
	echo "  ${RED}/!\\ ${STD}Error ${RED}: Library directory not found [${STD}$(PATH)${RED}] /!\\"; echo "${STD}"; fi
	@if ! [ -e $(PATH)source.txt ] && [ -d $(PATH) ]; then \
	echo "  ${RED}/!\\ ${STD}Error ${RED}: No source file list existing [./$(PATH)${STD}source.txt${RED}] /!\\ ";	\
	echo "${STD}"; fi
	@echo "  ${CYA}---Compilation process---${STD}"
	@echo ""

$(LIB): $(OBJ)
	@echo "  ${RED}-->${STD} $(shell pwd) $(NAME).a ..."
	@ar rc $(LIB) $(OBJ)
	@ranlib $(LIB)
	@$(eval COUNT := $(shell expr $(COUNT) + 1))
	@echo ""
	

$(PATH)%.o: $(DIR)%.c
	@echo "  ${YEL}--> ${STD}$^ ..."
	@gcc $< $(FLAGS) -c
	@mv $(shell echo "$@" | sed -e 's/$(NAME)\///g') $(PATH)
	@$(eval COUNT := $(shell expr $(COUNT) + 1))

clean: header
	@echo "  ${CYA}---Cleaning process---"
	@echo ""
	@rm -f $(OBJ)
	@echo "  ${YEL}--> Files deleted !${STD}"
	@echo ""

fclean: clean
	@rm -f $(LIB)
	@echo "  ${YEL}--> Library deleted !${STD}"
	@echo ""

template: header
	@echo ""
	@echo "  ${GRE}---Creating directory---${STD}"
	@echo ""
	@mkdir $(NAME)
	@echo "#Put all source files below, separated by a newline\n#Comments and empty lines are ignored\n\nfichier1.c\nfichier2.c\n..." > $(PATH)source.txt
	@echo "  You will find a directory called ${PIN}\"$(NAME)\"${STD}"
	@echo "  and a blank ${PIN}source.txt${STD} file."
	@echo ""

header:
	@clear
	@echo "${BLU}"
	@echo "      ____________________"
	@echo "     |                    |"
	@echo "     | ${GRE}[Library Compiler] ${BLU}|"
	@echo "     |____________________|"
	@echo ""
	@echo "  ${PIN}Name :${STD} $(NAME).a"
	@echo "  ${PIN}Path :${STD} ./$(PATH)"
	@echo ""
