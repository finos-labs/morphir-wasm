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

.PHONY: fsharp-to-JS
fsharp-to-JS: restore
	@echo "Compiling F# to JS..."
	@dotnet dotnet fable src/App/App.fsproj -o src/generated/App-js

.PHONY: fsharp-to-TS
fsharp-to-TS: restore
	@echo "Compiling F# to TS..."
	@dotnet dotnet fable src/App/App.fsproj -o src/generated/App-ts --lang ts --fableLib fable-library --noReflection

.PHONY: compile
compile: fsharp-to-JS fsharp-to-TS
	@echo "Compiling..." 

build: restore compile
	@echo "Building..."	
	@npx webpack

clean: 
	@echo "Cleaning..."
	@dotnet clean
	@rm -rf src/generated/