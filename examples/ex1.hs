import SimpleSMT

main :: IO ()
main =
  do l <- newLogger 0
     s <- newSolver "cvc5" [] (Just l)
     setLogic s "QF_LIA"
     x <- declare s "x" tInt
     assert s (add x (int 2) `eq` int 5)
     print =<< check s
     print =<< getExprs s [x]



