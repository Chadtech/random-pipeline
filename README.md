# Random Pipeline

This is a package that makes getting random values a little bit easier in Elm.

Heres a side by side comparison between `Random` and `Random.Pipeline`

```elm
-- Random
modelGenerator : Generator Model
modelGenerator =
    Random.map4 Model
        positionGenerator
        enemiesGenerator
        uuidGenerator
        nameGenerator


init : Seed -> ( Model, Seed )
init =
    Random.step modelGenerator


-- Random.Pipeline
import Random.Pipeline exposing (from, with)

init : Seed -> ( Model, Seed )
init seed =
    Model
        |> from seed
        |> with positionGenerator
        |> with enemiesGenerator
        |> with uuidGenerator
        |> with nameGenerator
```

A little bit cleaner right? And what if we wanted to keep the seed in our `Model` too? Just use `Random.Pipeline.finish`

```elm
import Random.Pipeline exposing (from, with, finish)

init : Seed -> Model
init seed =
    Model
        |> from seed
        |> with positionGenerator
        |> with enemiesGenerator
        |> with uuidGenerator
        |> with nameGenerator
        |> finish


type alias Model =
    { pos : Position
    , enemies : List Enemy
    , uuid : Uuid
    , name : String
    , seed : Seed
    }
```

It also has `always` that can hardcode values into your random generation.

```elm
import Random.Pipeline exposing (from, with, finish, always)

update : Msg -> Model -> Model
update msg model =
    case msg of
        Restart ->
            Model
                |> Random.from model.seed
                |> Random.with positionGenerator
                |> Random.with enemiesGenerator
                |> Random.always model.uuid
                |> Random.always model.name
                |> Random.finish
```
