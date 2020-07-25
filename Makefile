include makefiles/gitignore.mk
include makefiles/dockerhub.mk
include makefiles/ytt.mk
include makefiles/help.mk

################################################################################
# 変数
################################################################################
REPOSITORY      := sunakan/ruby
RUBY_VERSION    := 1.9.3
OS_DISTRIBUTION := wheezy-slim
BUILD_CONTEXT   := $(PWD)/v$(RUBY_VERSION)/$(OS_DISTRIBUTION)/
TAG             := $(RUBY_VERSION)-$(OS_DISTRIBUTION)

################################################################################
# タスク
################################################################################
.PHONY: build
build: ## DockerImageをビルド
	@docker build $(BUILD_CONTEXT) --tag $(REPOSITORY):$(TAG)

.PHONY: push
push: ## ビルドしたDockerImageをpush
	@docker push $(REPOSITORY):$(TAG)
