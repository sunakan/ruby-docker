include shared-makefiles/gitignore.mk
include shared-makefiles/dockerhub.mk
include shared-makefiles/help.mk

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
