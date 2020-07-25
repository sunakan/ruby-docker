.PHONY: install-mo
install-mo: ## moのインストール
	( command -v ./mo ) \
	|| curl -sSL https://git.io/get-mo -o mo
	chmod +x ./mo

.PHONY: uninstall-mo
uninstall-mo: ## moのアンインストール
	command -v ./mo && rm ./mo
