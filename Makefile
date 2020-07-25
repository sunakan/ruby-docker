include makefiles/gitignore.mk
include makefiles/dockerhub.mk
include makefiles/ytt.mk
include makefiles/help.mk

################################################################################
# マクロ
################################################################################
define ci-yml
  cat ci.yml | ./ytt -f- --output json
endef


################################################################################
# 変数
################################################################################
REPOSITORY    := sunakan/ruby
TAG           := 1.9.3-wheezy-slim
BUILD_CONTEXT := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["build-context-path"]')

################################################################################
# タスク
################################################################################
.PHONY: build
build: ## DockerImageをビルド
	@docker build $(BUILD_CONTEXT) --tag $(REPOSITORY):$(TAG)

.PHONY: push
push: ## ビルドしたDockerImageをpush
	@docker push $(REPOSITORY):$(TAG)
