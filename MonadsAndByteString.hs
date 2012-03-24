import qualified Data.ByteString.Char8 as S

-- opening two different monads (IO and Maybe) with fmap :)

main = Prelude.fmap parseInt S.getLine
    where parseInt = Prelude.fmap fst . S.readInt
