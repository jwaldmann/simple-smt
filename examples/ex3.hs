import SimpleSMT

main :: IO ()
main =
  do l <- newLogger 0
     -- s <- newSolver "z3" [ "-in", "-smt2" ] (Just l)
     s <- newSolver "cvc5" [ ] (Just l)
     setLogic s "QF_LRA"
     x <- declare s "x" tReal
     assert s (mul (real 3) (add x (real 2)) `eq` real (negate 5))
     print =<< check s
     print =<< getExprs s [x]



