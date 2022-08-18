import SimpleSMT
import Control.Concurrent.Async


main :: IO ()
main = do
  as <- mapM async 
    [ main_with "yices-smt2" [ "--smt2-model-format" ]
    , main_with "cvc5" []
    ]
  (a,r) <- waitAnyCancel as
  print r

main_with :: String ->  [String] -> IO [(SExpr,Value)]
main_with solver opts = do
     l <- newLogger 0
     s <- newSolver solver opts (Just l)
     setLogic s "QF_NIA"
     a <- declare s "a" tInt
     b <- declare s "b" tInt
     c <- declare s "c" tInt
     d <- declare s "d" tInt
     assert s $ leq (int 1) a
     assert s $ leq a b
     assert s $ leq c d
     assert s $ lt a c
     assert s $ lt d b
     assert s $ leq d (int 15)
     let cube x = iterate (mul x) (int 1) !! 3
     assert s $ eq (add (cube a) (cube b)) (add (cube c) (cube d))
     print =<< check s
     getExprs s [a,b,c,d]



