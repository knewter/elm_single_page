module About (Model, Action, initialModel, update, view) where

import Effects exposing (Never, Effects)
import Html exposing (..)


type Action
  = NoOp


type alias Model =
  { text : String
  }


initialModel : Model
initialModel =
  { text = "Some about text" }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )


view : Signal.Address Action -> Model -> Html
view address model =
  p [] [ text model.text ]
