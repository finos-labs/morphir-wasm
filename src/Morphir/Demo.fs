module App.Demo

let elmModule = App.Engine.Elm
printfn "elmModule: %A" elmModule

let morphirModel = elmModule.Morphir
printfn "morphirModel: %A" morphirModel

let worker = App.Engine.initWorker()
printfn "worker: %A" worker