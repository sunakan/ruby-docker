################################################################################
# タスク
################################################################################
.PHONY: docs
docs: ## documentの生成
	@mkdir -p ./docs
	@make --no-print-directory generate-dockerfiles-layout
	@make --no-print-directory generate-help-docs
	@make --no-print-directory generate-ytt-supplement
	@make --no-print-directory generate-mo-supplement



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


.PHONY: ytt-supplement
ytt-supplement:
	@echo '----'
	@echo '$$ cat ./docker-infos.yml | ./ytt -f-'
	@cat ./docker-infos.yml | ./ytt -f-
	@echo '----'

.PHONY: generate-ytt-supplement
generate-ytt-supplement:
	@make --no-print-directory ytt-supplement > ./docs/ytt-supplement.adoc
	@echo Generated: ./docs/ytt-supplement.adoc


.PHONY: mo-supplement
mo-supplement:
	@echo '----'
	@echo '$$ URL=DUMMY-URL SHA256=HELLO-WORLD ./mo Dockerfile.template.mo'
	@URL=DUMMY-URL SHA256=HELLO-WORLD ./mo Dockerfile.template.mo
	@echo '----'

.PHONY: generate-mo-supplement
generate-mo-supplement:
	@make --no-print-directory mo-supplement > ./docs/mo-supplement.adoc
	@echo Generated: ./docs/mo-supplement.adoc
