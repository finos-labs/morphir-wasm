module InputReader
open Fable.Core
open Fable.Core.JsInterop

type IJavyIOBuiltins =
    abstract readSync: int * uint8 array -> int
    abstract writeSync: int * uint8 array -> int
    
type IJavyBuiltins =
    abstract member IO: IJavyIOBuiltins
    
let [<Global>] Javy:IJavyBuiltins = jsNative

