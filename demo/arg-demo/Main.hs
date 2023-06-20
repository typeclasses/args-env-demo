module Main (main) where

import Options.Applicative qualified as Arg
import Options.Applicative (option, str, long, help)

main :: IO ()
main = getSettings >>= print

getSettings :: IO (String, String)
getSettings = Arg.execParser $ Arg.info (parser Arg.<**> Arg.helper) info

info :: Arg.InfoMod a
info = Arg.header "Arg demonstration"

parser :: Arg.Parser (String, String)
parser = do
  host <- option str $ long "host" <> help "Host name"
  port <- option str $ long "port" <> help "Port number"
  pure (host, port)
