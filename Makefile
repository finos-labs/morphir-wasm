.DEFAULT_GOAL := build

.PHONY: run
run: restore
	@echo "Running..."

.PHONY: restore-tools
restore-tools:
	@echo "Restoring tools..."
	@dotnet tool restore

.PHONY: npm-install
npm-install: package.json package-lock.json
	@echo "Installing npm packages..."
	@npm install

.PHONY: restore
restore: restore-tools npm-install
	@echo "Restoring packages and tools..."

.PHONY: compile
compile: 
	@echo "Compiling F# to JS..."
	@dotnet fable src/App/App.fsproj

build: restore compile
	@echo "Building..."	
	@npx webpack