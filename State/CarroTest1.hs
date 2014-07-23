import Carro

main =
    let
        carro = Carro 0
        semi  = anda carro
        usado = andaMais semi
    in
        putStrLn . show $ getKm usado
