include makefiles/gitignore.mk
include makefiles/dockerhub.mk
include makefiles/ytt.mk
include makefiles/mo.mk
include makefiles/docs.mk
include makefiles/help.mk

################################################################################
# マクロ
################################################################################
define ci-yml
  cat docker-infos.yml | ./ytt -f- --output json
endef

################################################################################
# 変数
################################################################################
REPOSITORY      := sunakan/ruby
TAG             := 1.9.3-wheezy-slim
URL             := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["url"]')
SHA256          := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["sha256"]')
OS_DISTRIBUTION := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["os-distribution"]')
CONTEXT_PATH    := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["context-path"]')
RUBY_MAJOR      := $(shell dirname $(URL) | xargs -I {url} basename {url})
RUBY_VERSION    := $(shell basename $(URL) | sed -e s/ruby-//g | sed -e s/\.tar\.gz//g)

################################################################################
# タスク
################################################################################
.PHONY: build
build: ## DockerImageをビルド
	@docker build $(CONTEXT_PATH)/ --tag $(REPOSITORY):$(TAG)

.PHONY: push
push: ## ビルドしたDockerImageをpush
	@docker push $(REPOSITORY):$(TAG)

.PHONY: stdout-dockerfile
stdout-dockerfile: ## Dockerfileのテンプレートから標準出力
	@cat Dockerfile.base-$(OS_DISTRIBUTION)
	@echo ''
	@RUBY_MAJOR=$(RUBY_MAJOR) RUBY_VERSION=$(RUBY_VERSION) URL=$(URL) SHA256=$(SHA256) ./mo Dockerfile.template.mo

.PHONY: generate-dockerfile
generate-dockerfile: ## Dockerfileのテンプレートから作成
	@mkdir -p $(CONTEXT_PATH)
	@make --no-print-directory stdout-dockerfile > $(CONTEXT_PATH)/Dockerfile
	@echo Generated: $(CONTEXT_PATH)/Dockerfile

.PHONY: all
all: ## ci.ymlの全パターン用のDockerfileのテンプレートから作成
	@$(ci-yml) | jq --raw-output 'keys[]' | xargs -I {key} make --no-print-directory generate-dockerfile TAG={key}
	@make --no-print-directory docs
