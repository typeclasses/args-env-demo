module Main (main) where

import Env qualified
import Env (var, str, help)

main :: IO ()
main = getSettings >>= print

getSettings :: IO (String, String)
getSettings = Env.parse info parser

info :: Env.Info e -> Env.Info e
info = Env.header "Environment demonstration"

parser :: Env.Parser Env.Error (String, String)
parser = do
  host <- var str "host" $ help "Host name"
  port <- var str "port" $ help "Post number"
  pure (host, port)
