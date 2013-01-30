module GTD.CLParser where

import GTD.Actions
import GTD.CLParser.Primitives
import GTD.Configuration
import GTD.Tasks

import Data.Time


parseCLActions :: Parser CLActions
parseCLActions = undefined


parseDescription :: Parser String
parseDescription = undefined


parseDueTime :: GTDConfig -> Parser UTCTime
parseDueTime = undefined


parseWaitTime :: GTDConfig -> Parser UTCTime
parseWaitTime = undefined


parseUTCTime :: GTDConfig -> Parser UTCTime
parseUTCTime = undefined


parseTags :: Parser [String]
parseTags = undefined


parseRecurFrequency :: Parser Int
parseRecurFrequency = undefined


parseRecurType :: Parser RecurType
parseRecurType = undefined


parseSelectors :: Parser Int
parseSelectors = undefined
