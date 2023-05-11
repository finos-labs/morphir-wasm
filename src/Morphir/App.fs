module App

open System
open Fable.Core.JS
open FSharp.Collections
open Thoth.Json
//const worker = require("./../Morphir.Elm.CLI").Elm.Morphir.Elm.CLI.init();

let readInput () =
    let chunkSize = 1024
    let inputChunks = ResizeArray<uint8> ()
    let mutable totalBytes = 0
    let mutable next = true
    
    while(next) do
        let buffer = Constructors.Uint8Array.Create(chunkSize)
        let fd = 0 // Stdin file descriptor
        let bytesRead = Javy.IO.readSync(fd, buffer)
        totalBytes <- totalBytes + bytesRead
        if (bytesRead = 0) then
             next <- false
        else
            for i = 0 to bytesRead - 1 do
                inputChunks.Add(buffer[i])
    
    printfn "inputChunks.size: %A" inputChunks.Count
    
    let finalBuffer = inputChunks.ToArray()
    
    printfn "Buffer: %A" finalBuffer
    let jsonString = System.Text.UTF8Encoding.UTF8.GetString(finalBuffer)
    printfn $"JSON> {jsonString}"
    JSON.parse(jsonString)
   // SimpleJson.parse(jsonString)
    //JSON.parse(TextDecoder().decode(finalBuffer)) |> unbox<string>

[<EntryPoint>]
let main (argv:string array) =
    printfn ""
    printfn "argv: %A" argv
    printfn "Here we are"
    let input = readInput ()
    printfn "Hello World from Fable and F#"
    printfn $"> {JSON.stringify(input)}"
    let worker = App.Engine.initWorker()
    printfn "worker: %A" worker
    0
