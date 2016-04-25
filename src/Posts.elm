module Posts (Model, Action, initialModel, update, view) where

import Effects exposing (Never, Effects)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


type Action
  = ViewList
  | ViewPost Post


type alias Post =
  { title : String
  , summary : String
  , body : String
  , id : Int
  }


type alias Model =
  { posts : List Post
  , currentPost : Maybe Post
  }


initialPosts : List Post
initialPosts =
  [ { title = "First Post"
    , summary = "Some things are afoot!"
    , body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean in blandit tellus, vitae porttitor ligula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In sagittis nulla ac maximus lobortis. Suspendisse eu condimentum tellus."
    , id = 0
    }
  , { title = "Second Post"
    , summary = "I lost my pants"
    , body = "Do you know where my pants went?"
    , id = 1
    }
  ]


initialModel : Model
initialModel =
  { posts = initialPosts
  , currentPost = Nothing
  }


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    ViewList ->
      ( { model | currentPost = Nothing }, Effects.none )

    ViewPost post ->
      ( { model | currentPost = Just post }, Effects.none )


viewPostSummary : Signal.Address Action -> Post -> Html
viewPostSummary address post =
  div
    []
    [ a [ href "#", onClick address (ViewPost post) ] [ h3 [] [ text post.title ] ]
    , p [] [ text post.summary ]
    ]


viewPost : Signal.Address Action -> Post -> Html
viewPost address post =
  div
    []
    [ h3 [] [ text post.title ]
    , p [] [ text post.body ]
    , a [ href "#", onClick address ViewList ] [ text "Back" ]
    ]


view : Signal.Address Action -> Model -> Html
view address model =
  case model.currentPost of
    Just post ->
      viewPost address post

    Nothing ->
      div
        []
        [ h2 [] [ text "Posts" ]
        , div [] (List.map (viewPostSummary address) model.posts)
        ]
