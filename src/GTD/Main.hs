module Main (
  main
 ) where

import System.Directory
import System.Exit
import System.FilePath
import System.IO.Error

appName :: String
appName = "gtd"


configFileName :: FilePath -> FilePath
configFileName appDir = appDir ++ [pathSeparator] ++ ".gtdrc"


configDirErrorMessage :: String
configDirErrorMessage = "Error when locating GTD config directory"


configDirCreateErrorMessage :: String
configDirCreateErrorMessage = "Error when creating GTD config directory"


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
  putStrLn "GTD is not implemented yet"
