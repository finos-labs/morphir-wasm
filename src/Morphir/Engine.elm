port module Morphir.Engine exposing (main)

import Platform


type alias Model =
    String


type Msg
    = MessageFromWorker String


port messageToWorker : String -> Cmd msg


port messageFromWorker : (String -> msg) -> Sub msg


init : flags -> ( Model, Cmd Msg )
init =
    \_ -> ( "", messageToWorker "Hello, Worker!" )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        MessageFromWorker message ->
            ( message, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    messageFromWorker MessageFromWorker


main : Platform.Program () Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }
