module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Http
import Url.Builder as Url


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { text : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "Hello World", Cmd.none )



-- UPDATE


type Msg
    = NoOp
    | GetData
    | ReceiveData (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GetData ->
            ( model, getData )

        ReceiveData result ->
            case result of
                Ok data ->
                    ( { model | text = data }, Cmd.none )

                Err _ ->
                    ( { model | text = "Whoops! Something went wrong, please try again later." }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- HTTP


getData : Cmd Msg
getData =
    Http.send ReceiveData (Http.getString toDataUrl)


toDataUrl : String
toDataUrl =
    Url.relative [ "api", "data" ] []



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.text ]
        , div [] [ button [ onClick GetData ] [ text "Get Data" ] ]
        ]
