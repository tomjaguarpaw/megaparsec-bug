{-# LANGUAGE BangPatterns #-}

module Main where

import Text.Megaparsec
import qualified Data.ByteString as BS
import Data.Void

countTokens :: TraversableStream s => Int -> Parsec Void s Int
countTokens !n = do
  if n == Main.count `div` 2
  then do
    !_ <- getSourcePos
    pure ()
  else
    pure ()

  (anySingle *> countTokens (n + 1))
    <|>
    (do
      eof
      failure Nothing mempty)

count :: Int
count = 100 * 1000

bytestring :: BS.ByteString
bytestring = BS.replicate Main.count newline
  where newline = 10

main :: IO ()
main = do
  print $ either (Left . errorBundlePretty) Right (parse (countTokens 0) "filename" bytestring)
