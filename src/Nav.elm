module Nav (Model, Action, Tab(..), initialModel, update, view) where
import Effects exposing (Never, Effects)
import Html exposing (..)
import Html.Events exposing (..)


type Action
  = NoOp
  | ChooseTab Tab


type Tab
  = Squares
  | Circles


type alias Model =
  { currentTab : Tab
  }


initialModel : Model
initialModel =
  { currentTab = Squares }


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp -> ( model, Effects.none )
    ChooseTab tab ->
      ( { model | currentTab = tab }, Effects.none )


view address model =
  nav []
    [ a [onClick address (ChooseTab Circles)] [text "Circles"]
    , a [onClick address (ChooseTab Squares)] [text "Squares"]
    ]
