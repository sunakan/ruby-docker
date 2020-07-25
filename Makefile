include makefiles/gitignore.mk
include makefiles/dockerhub.mk
include makefiles/ytt.mk
include makefiles/mo.mk
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
REPOSITORY      := sunakan/ruby
TAG             := 1.9.3-wheezy-slim
OS_DISTRIBUTION := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["os-distribution"]')
URL             := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["url"]')
SHA256          := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["sha256"]')
BUILD_CONTEXT   := $(shell $(ci-yml) | jq --raw-output '.["$(TAG)"]["build-context-path"]')

################################################################################
# タスク
################################################################################
.PHONY: build
build: ## DockerImageをビルド
	@docker build $(BUILD_CONTEXT) --tag $(REPOSITORY):$(TAG)

.PHONY: push
push: ## ビルドしたDockerImageをpush
	@docker push $(REPOSITORY):$(TAG)

.PHONY: stdout-dockerfile
stdout-dockerfile: ## Dockerfileのテンプレートから標準出力
	@OS_DISTRIBUTION=$(OS_DISTRIBUTION) \
	URL=$(URL) \
	SHA256=$(SHA256) \
	./mo Dockerfile.template.mo

.PHONY: generate-dockerfile
generate-dockerfile: ## Dockerfileのテンプレートから作成
	@mkdir -p $(BUILD_CONTEXT)
	@make --no-print-directory stdout-dockerfile > $(BUILD_CONTEXT)/Dockerfile
