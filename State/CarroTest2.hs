import StateCarro as SC
import State
import Carro as C

testa :: SCarro Int
testa = do
    SC.anda
    SC.andaMais
    SC.getKm

main =
    let
        resultado = runState testa $ C.Carro 0
    in
        putStrLn . show $ resultado
