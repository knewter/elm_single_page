module Main (..) where

import StartApp
import Posts
import About
import Nav
import Task
import Effects exposing (Never, Effects)
import Html exposing (..)


type Action
  = Posts Posts.Action
  | About About.Action
  | Nav Nav.Action


type alias Model =
  { posts : Posts.Model
  , about : About.Model
  , nav : Nav.Model
  }


initialModel : Model
initialModel =
  { posts = Posts.initialModel
  , about = About.initialModel
  , nav = Nav.initialModel
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Posts action ->
      let
        ( posts, newEffect ) =
          Posts.update action model.posts

        newModel =
          { model | posts = posts }
      in
        ( newModel, Effects.map Posts newEffect )

    About action ->
      let
        ( about, newEffect ) =
          About.update action model.about

        newModel =
          { model | about = about }
      in
        ( newModel, Effects.map About newEffect )

    Nav action ->
      let
        ( nav, newEffect ) =
          Nav.update action model.nav

        newModel =
          { model | nav = nav }
      in
        ( newModel, Effects.map Nav newEffect )


subView : Signal.Address Action -> Model -> Html
subView address model =
  case model.nav.currentTab of
    Nav.Posts ->
      Posts.view (Signal.forwardTo address Posts) model.posts

    Nav.About ->
      About.view (Signal.forwardTo address About) model.about


view : Signal.Address Action -> Model -> Html
view address model =
  section
    []
    [ Nav.view (Signal.forwardTo address Nav) model
    , subView address model
    ]


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main : Signal Html
main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
