module Nav (Model, Action, Tab(..), initialModel, update, view) where

import Effects exposing (Never, Effects)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (href)


type Action
  = NoOp
  | ChooseTab Tab


type Tab
  = Posts
  | About


type alias Model =
  { currentTab : Tab
  }


initialModel : Model
initialModel =
  { currentTab = Posts }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    ChooseTab tab ->
      ( { model | currentTab = tab }, Effects.none )


view address model =
  nav
    []
    [ a [ href "#", onClick address (ChooseTab Posts) ] [ text "Posts" ]
    , a [ href "#", onClick address (ChooseTab About) ] [ text "About" ]
    ]
