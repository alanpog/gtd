module GTD.Configuration (
    initializeConfig
  , loadConfiguration
 ) where

import GTD.Assets

import Control.Monad.Error
import Data.ConfigFile
import System.Exit

data GTDConfig = GTDConfig {
      gtdCDateFormat      :: String
    , gtdCTasksDir        :: String
 } deriving Show


gtdCP :: ConfigParser
gtdCP = emptyCP {optionxform = id}


defaultConfigString :: FilePath -> String
defaultConfigString tasksDir =
  "dateFormat      = %d-%m-%Y\n"   ++
  "tasksDir        = " ++ tasksDir ++
  "\n"


defaultConfigParser :: FilePath -> ConfigParser
defaultConfigParser tasksDir =
    case readstring gtdCP (defaultConfigString tasksDir) of
      Left _   -> error ("Error parsing built-in default configuration! " ++
                         "This should never happen. Please report this "  ++
                         "as a bug.")
      Right cp -> cp


initializeConfig :: FilePath -> FilePath -> IO ()
initializeConfig configFile tasksDir =
    writeFile configFile (defaultConfigString tasksDir)


loadConfiguration :: FilePath -> FilePath -> IO GTDConfig
loadConfiguration configFile tasksDir = do
    let defaultConfig = defaultConfigParser tasksDir
    userConfig <- readfile gtdCP configFile
    config <- case userConfig of
                Right cp -> return $ merge defaultConfig cp
                Left err -> do
                   putStrLn ("Error while loading configuration file "
                          ++ configFile ++ ": " ++ show err ++ "\nDefault "
                          ++ "configuration will be used.\n")
                   return defaultConfig
    configParser2GTDConfig config


configParser2GTDConfig :: ConfigParser -> IO GTDConfig
configParser2GTDConfig config = do
  eitherEntries <- runErrorT $ items config "DEFAULT"
  case eitherEntries of
    Left _ -> do putStrLn ("Error while reading the DEFAULT section of "
                     ++ "configuration file. This should never happen."
                     ++ "Please report this as a bug.")
                 exitFailure
    Right entries -> return $ foldl setOption (GTDConfig "" "") entries
    where setOption config (entry, value)
              | entry == "dateFormat" = config {gtdCDateFormat = value}
              | entry == "tasksDir"   = config {gtdCTasksDir   = value}
