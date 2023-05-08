module App

open System
open Fable.Core

let readInput ():string =
    let chunkSize = 1024
    let inputChunks = ResizeArray<byte>()
    ""

let input = readInput ()
printfn "Hello World from Fable and F#"

printfn "> %s" input
