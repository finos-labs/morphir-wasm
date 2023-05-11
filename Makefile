.DEFAULT_GOAL := build

.PHONY: run
run: restore build
	@echo "Running..."
	@echo "{'a':1}" | @wasmtime dist/morphir.wasm 

.PHONY: restore-tools
restore-tools:
	@echo "Restoring tools..."
	@dotnet tool restore

.PHONY: npm-install
npm-install: package.json package-lock.json
	@echo "Installing npm packages..."
	@npm install

.PHONY: paket-restore
paket-restore: 
	@echo "Restoring paket packages..."
	@dotnet paket restore

.PHONY: restore
restore: restore-tools paket-restore npm-install
	@echo "Restoring packages and tools..."

.PHONY: fsharp-to-JS
fsharp-to-JS: restore
	@echo "Compiling F# to JS..."
	@dotnet dotnet fable src/App/App.fsproj -o src/generated/App-js

.PHONY: fsharp-to-TS
fsharp-to-TS: restore
	@echo "Compiling F# to TS..."
	@dotnet dotnet fable src/App/App.fsproj -o src/generated/App-ts --lang ts --fableLib fable-library --noReflection

.PHONY: fable-compile
fable-compile: fsharp-to-JS fsharp-to-TS
	@echo "Running Fable Compile step..."

.PHONY: compile
compile: morphir-elm fable-compile

src/generated/App-js/App.js: fsharp-to-JS

.PHONY: esbuild
esbuild: src/generated/App-js/App.js src/App/Morphir.Elm.CLI.js
	@echo "Building with esbuild..."
	@npx esbuild src/generated/App-js/App.js --bundle --outfile=src/generated/App-js/App.bundle.js --minify --sourcemap
	@npx esbuild src/generated/App-js/App.js --bundle --outfile=src/generated/App-js/App.bundle.js --minify --sourcemap

.PHONY: build
build: restore esbuild
	@echo "Building..."	
	@javy compile -o dist/morphir.wasm src/generated/App-js/App.bundle.js 

.PHONY: rebuild
rebuild: clean compile build
	@echo "Rebuilding..."

clean: 
	@echo "Cleaning..."
	@dotnet clean
	@rm -rf src/generated/

.PHONY: morphir-elm
morphir-elm: 
	@echo "Building morphir-elm..."
	@cd paket-files/finos/morphir-elm && npm install && npx gulp build
	@cp paket-files/finos/morphir-elm/cli2/Morphir.Elm.CLI.js src/App/Morphir.Elm.CLI.js
	