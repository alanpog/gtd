module GTD.Configuration (
    initializeConfig
  , loadConfiguration
 ) where

import GTD.Assets

import Data.ConfigFile

data GTDConfig = GTDConfig {
      gtdCDateFormat      :: String
    , gtdCShortDateFormat :: String
    , gtdCTasksDir        :: String
 }


defaultConfigString :: FilePath -> String
defaultConfigString tasksDir =
  "dateFormat      = %d-%m-%Y\n"   ++
  "shortDateFormat = %d-%m\n\n"    ++
  "tasksDir        = " ++ tasksDir ++
  "\n"


defaultConfigParser :: FilePath -> ConfigParser
defaultConfigParser tasksDir =
    case readstring emptyCP (defaultConfigString tasksDir) of
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
    userConfig <- readfile emptyCP configFile
    config <- case userConfig of
                Right cp -> return $ merge defaultConfig cp
                Left err -> do
                   putStrLn ("Error while loading configuration file "
                          ++ configFile ++ ": " ++ show err ++ "\nDefault "
                          ++ "configuration will be used.\n")
                   return defaultConfig
    validateConfiguration config
    return (configParser2GTDConfig config)


validateConfiguration :: ConfigParser -> IO ()
validateConfiguration = undefined


configParser2GTDConfig :: ConfigParser -> GTDConfig
configParser2GTDConfig = undefined
