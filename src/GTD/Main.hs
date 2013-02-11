module Main (
  main
 ) where

import GTD.Assets
import GTD.Configuration

import Control.Monad (unless)
import System.Directory
import System.Exit
import System.FilePath
import System.IO.Error


configFileFromPath :: FilePath -> FilePath
configFileFromPath appDir = appDir ++ [pathSeparator] ++ configFileName


handleIOErrors :: String -> IOError -> IO a
handleIOErrors message e = do
  print $ message ++ ": " ++ show e
  exitFailure


main :: IO ()
main = do
  appDirectory <- catchIOError (getAppUserDataDirectory appName)
                               (handleIOErrors configDirErrorMessage)
  catchIOError (createDirectoryIfMissing True appDirectory)
               (handleIOErrors configDirCreateErrorMessage)

  let configFile = configFileFromPath appDirectory
  configExists <- doesFileExist configFile
  unless configExists (initializeConfig configFile appDirectory)
  config <- loadConfiguration configFile appDirectory

  putStrLn "GTD is not implemented yet"
