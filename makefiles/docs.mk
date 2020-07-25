################################################################################
# タスク
################################################################################
.PHONY: docs
docs: ## documentの生成
	@mkdir -p ./docs
	@make --no-print-directory generate-dockerfiles-layout
	@make --no-print-directory generate-help-docs


.PHONY: dockerfiles-layout
dockerfiles-layout:
	@echo '----'
	@echo '$$ make tree v*'
	@tree v*
	@echo '----'

.PHONY: generate-dockerfiles-layout
generate-dockerfiles-layout:
	@make --no-print-directory dockerfiles-layout > ./docs/dockerfiles-layout.adoc
	@echo Generated: ./docs/dockerfiles-layout.adoc


.PHONY: help-docs
help-docs:
	@echo '----'
	@echo '$$ make help'
	@make --no-print-directory help | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
	@echo '----'

.PHONY: generate-help-docs
generate-help-docs:
	@make --no-print-directory help-docs > ./docs/help.adoc
	@echo Generated: ./docs/help.adoc
