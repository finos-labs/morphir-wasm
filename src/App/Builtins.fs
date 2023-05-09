[<AutoOpen>]
module Builtins
open Fable.Core
open Fable.Core.JS
open Fable.Core.JsInterop

type IJavyIOBuiltins =
    abstract readSync: int * Uint8Array -> int
    abstract writeSync: int * Uint8Array -> int
    
type IJavyBuiltins =
    abstract member IO: IJavyIOBuiltins
    
let [<Global>] Javy:IJavyBuiltins = jsNative

type [<Erase>]DecodeInput = U3<Uint8Array, ArrayBufferView, ArrayBuffer>

type TextDecoder =
    abstract decode: unit -> string
    abstract decode: Uint8Array -> string    
    abstract decodeInto: Uint8Array option * string option -> string
and IDecodeOptions =
    abstract stream: bool
and TextDecoderConstructor =
    [<Emit("new $0()")>]abstract Create: unit -> TextDecoder
    [<Emit("new $0($1)")>]abstract Create: string -> TextDecoder

type TextEncoder =
    abstract encode: string option -> Uint8Array
    abstract encodeInto: string option * Uint8Array -> IEncodeIntoResult
and IEncodeIntoResult =
    abstract read: int
    abstract written: int
    
 let [<Global>]TextDecoder:TextDecoderConstructor = jsNative