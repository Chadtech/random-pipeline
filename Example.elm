module Main exposing (..)

import Random exposing (Seed)
import Random.Pipeline as R


type alias Model =
    { position : Position
    , enemies : List Enemy
    , uuid : Uuid
    , name : String
    , seed : Seed
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        Restart ->
            Model
                |> R.from model.seed
                |> R.with positionGenerator
                |> R.with enemiesGenerator
                |> R.always model.uuid
                |> R.always model.name
                |> R.finish
