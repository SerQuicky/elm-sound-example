port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- PORTS


port playMusic : String -> Cmd msg


port stopMusic : String -> Cmd msg


port setSource : String -> Cmd msg



-- MODEL


type alias Model =
    { song : String
    }


init : ( Model, Cmd Msg )
init =
    ( { song = "" }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Play
    | Stop
    | Set String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play ->
            ( model
            , playMusic "play"
            )

        Stop ->
            ( model
            , stopMusic "stop"
            )

        Set message ->
            ( { model | song = message }
            , setSource message
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [ id "song-header" ] [ text ("Current song: " ++ model.song) ]
        , div [ Html.Attributes.class "song-holder" ]
            [ button [ onClick (Set "song1.mp3") ] [ Html.text "Song1" ]
            , button [ onClick (Set "song2.mp3") ] [ Html.text "Song2" ]
            , button [ onClick (Set "song3.wav") ] [ Html.text "Song3" ]
            ]
        , div [ Html.Attributes.class "audio-holder" ]
            [ button [ onClick Play ] [ Html.text "Play" ]
            , button [ onClick Stop ] [ Html.text "Stop" ]
            ]
        , audio [ src "./assets/sounds/song2.mp3", id "audio-player", controls True ] []
        ]
