module App.Engine
open Fable.Core
open Fable.Core.JsInterop

type IElmApp =
    abstract Morphir : IMorphirModule
and IMorphirModule =
    abstract Elm : IMorphirElmModule
and IMorphirElmModule =
    abstract CLI : IMorphirElmCliModule
and IMorphirElmCliModule = 
    abstract init : unit -> CliWorker
and CliWorker = interface end

//const worker = require("./../Morphir.Elm.CLI").Elm.Morphir.Elm.CLI.init();
//[<Emit("""require("./Morphir.Elm.CLI").Elm.Morphir.Elm.CLI.init()""")>]
[<ImportDefault("${outDir}/Morphir.Elm.CLI")>]
let Elm:IElmApp = jsNative

let initWorker() = Elm.Morphir.Elm.CLI.init()