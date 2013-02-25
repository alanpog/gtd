module Main (
    main
  ) where

import Test.Framework
import Test.Framework.Providers.HUnit

import qualified GTD.CLParser.Tests

main :: IO ()
main = defaultMain tests

tests :: [Test]
tests =
  [
    testGroup "Parser" $ hUnitTestToTests GTD.CLParser.Tests.tests
  ]
