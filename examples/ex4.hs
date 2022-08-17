import SimpleSMT

main :: IO ()
main =
  do l <- newLogger 0
     s <- newSolver "yices-smt2" [ "--smt2-model-format" ] (Just l)
     -- s <- newSolver "cvc5" [ ] (Just l)
     setLogic s "QF_LRA"
     x <- declare s "x" tReal
     assert s (mul (real 3) (add x (real 2)) `eq` real 2)
     print =<< check s
     print =<< getExprs s [x, real 0]



