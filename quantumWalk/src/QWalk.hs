{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DeriveAnyClass #-}

module QWalk where

import System.IO
import Vector
import Mtwo
import Data.Complex

--Duvidas:O M2 funciona para a condicao inicial? M2 tera sempre que ter um par por causa da moeda, mas o estado inicial nao sera um par. Matematicamente, o estado resultante de uma iteracao da quantum walk e Psi(t) = U * Psi(0) e nao estou a ver como isto traduz para M2. Talvez tenha que comecar com o estado inicial apenas em Vec, e de algum modo aplicar uma funcao dentro de M2 a um estado apenas em Vec.
sqrRoot = 1/sqrt(2) :: Complex Float
--Duvidas: O tipo de mTwoVec esta correto? Posso usar isto como condicao inicial? Penso que nao por causa da duvida anterior.
mTwoVec = return 0 :: M2 (Vec (Complex Float)) (Int)
--mTwoVec1 = M2 $ Pair ( Vec[(In1 0, 1.0)], Vec [])

--Duvidas: Penso que a moeda esta quase correta. Penso que o sinal negativo na amplitude tera que ser num estado diferente, porque o M2 esta a resultar no sinal negativo no estado errado.
hadamardCoin a = M2 $ Pair ( Vec[(In1( a-1), sqrRoot),(In2( a+1),sqrRoot)], Vec[(In1 (a-1), sqrRoot),(In2 (a+1),-sqrRoot)])

quantumWalkN :: (Num b) => Int -> M2( Vec( Complex Float)) b -> M2( Vec( Complex Float)) b
quantumWalkN (0) state = state
quantumWalkN n state = quantumWalkN (n-1) (state >>= hadamardCoin)
 
--concatWalk = fmap.fmap $ 
--initCond = M2(  
