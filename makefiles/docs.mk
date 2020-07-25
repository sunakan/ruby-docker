################################################################################
# タスク
################################################################################
.PHONY: docs
docs: ## documentの生成
	@mkdir -p ./docs
	@make --no-print-directory generate-dockerfiles-layout


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
