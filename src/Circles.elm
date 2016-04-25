module Circles (Model, Action, initialModel, update, view) where
import Color exposing (..)
import Effects exposing (Never, Effects)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

type Action
  = NoOp

type alias Circle =
  { position : (Int, Int)
  , radius : Int
  , color : Color
  }

type alias Model =
  { circles : List Circle
  }


initialModel : Model
initialModel =
  { circles = [] }


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp -> ( model, Effects.none )


view : Signal.Address Action -> Model -> Element
view address model =
  collage 400 400
    []
