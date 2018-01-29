module Random.Pipeline
    exposing
        ( always
        , finish
        , from
        , value
        )

{-|

@docs from, with, always, finish

-}

import Random exposing (Generator, Seed)


{-| -}
finish : ( Seed -> a, Seed ) -> a
finish ( ctor, seed ) =
    ctor seed


{-| Make a random value `from` a `Seed`
-}
from : Seed -> a -> ( a, Seed )
from seed a =
    ( a, seed )


{-| Continue down the pipeline, adding a random value `with` a generator
-}
with : Generator a -> ( a -> b, Seed ) -> ( b, Seed )
with generator ( ctor, seed ) =
    Random.step generator seed
        |> Tuple.mapFirst ctor


{-| `always` give the same value.
-}
always : a -> ( a -> b, Seed ) -> ( b, Seed )
always a ( ctor, seed ) =
    ( ctor a, seed )
