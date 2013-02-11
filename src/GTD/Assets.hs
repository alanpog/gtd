module GTD.Assets (
    appName
  , configFileName

  , configDirErrorMessage
  , configDirCreateErrorMessage
 ) where


appName, configFileName :: String
appName        = "gtd"
configFileName = ".gtdrc"


configDirErrorMessage, configDirCreateErrorMessage :: String
configDirErrorMessage       = "Error when locating GTD config directory"
configDirCreateErrorMessage = "Error when creating GTD config directory"
