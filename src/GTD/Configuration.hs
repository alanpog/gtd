module GTD.Configuration where

data GTDConfig = GTDConfig {
      cDateFormat :: String
}

defualtConfig :: GTDConfig
defualtConfig = GTDConfig {
    cDateFormat = "%d-%m-%Y"
 }
