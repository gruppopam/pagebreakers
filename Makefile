LAYOUT_BREAKER_SRC = layout-breaker.js
JIBBERISHIFIER_SRC = jibberishifier.js
README_TEMPLATE = README.md.template
README = README.md
LAYOUT_BREAKER_PLACEHOLDER = @@LAYOUT_BREAKER_HERE@@
JIBBERISHIFIER_PLACEHOLDER = @@JIBBERISHIFIER_HERE@@
URLENCODED_LAYOUT_BREAKER = $(shell cat $(LAYOUT_BREAKER_SRC) | sed -r 's/^\s+//g' | tr -d '\n' | sed -r 's/ /%20/g')
URLENCODED_LAYOUT_BREAKER_WITH_SED_ESCAPES = $(shell echo "$(URLENCODED_LAYOUT_BREAKER)" | sed 's/&/\\\&/g')
URLENCODED_JIBBERISHIFIER = $(shell cat $(JIBBERISHIFIER_SRC) | sed -r 's/^\s+//g' | tr -d '\n' | sed -r 's/ /%20/g' | sed -r 's/</%3C/g' | sed -r 's/>/%3E/g')
URLENCODED_JIBBERISHIFIER_WITH_SED_ESCAPES = $(shell echo "$(URLENCODED_JIBBERISHIFIER)" | sed 's/&/\\\&/g')

$(README): $(README_TEMPLATE) $(LAYOUT_BREAKER_SRC) $(JIBBERISHIFIER_SRC)
	cat $(README_TEMPLATE) | sed "s/$(LAYOUT_BREAKER_PLACEHOLDER)/$(URLENCODED_LAYOUT_BREAKER_WITH_SED_ESCAPES)/g" | sed "s/$(JIBBERISHIFIER_PLACEHOLDER)/$(URLENCODED_JIBBERISHIFIER_WITH_SED_ESCAPES)/g" > $(README)

.PHONY: clean
clean:
	rm $(README)
