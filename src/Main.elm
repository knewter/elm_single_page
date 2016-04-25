import StartApp
import Circles
import Squares
import Nav
import Task
import Effects exposing (Never, Effects)
import Html exposing (..)


type Action
  = Circles Circles.Action
  | Squares Squares.Action
  | Nav Nav.Action


type alias Model =
  { circles : Circles.Model
  , squares : Squares.Model
  , nav : Nav.Model
  }


initialModel : Model
initialModel =
  { circles = Circles.initialModel
  , squares = Squares.initialModel
  , nav = Nav.initialModel
  }


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Circles action ->
      let
        (circles, newEffect) = Circles.update action model.circles
        newModel = { model | circles = circles }
      in
        (newModel, Effects.map Circles newEffect)
    Squares action ->
      let
        (squares, newEffect) = Squares.update action model.squares
        newModel = { model | squares = squares }
      in
        (newModel, Effects.map Squares newEffect)
    Nav action ->
      let
        (nav, newEffect) = Nav.update action model.nav
        newModel = { model | nav = nav }
      in
        (newModel, Effects.map Nav newEffect)


subView : Signal.Address Action -> Model -> Html
subView address model =
  (case model.nav.currentTab of
    Nav.Squares ->
      Squares.view (Signal.forwardTo address Squares) model.squares
    Nav.Circles ->
      Circles.view (Signal.forwardTo address Circles) model.circles
  ) |> fromElement


view : Signal.Address Action -> Model -> Html
view address model =
  section []
    [ Nav.view (Signal.forwardTo address Nav) model
    , subView address model
    ]


init : (Model, Effects Action)
init =
  (initialModel, Effects.none)


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
