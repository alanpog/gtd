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


selector :: Parser [Int]
selector = selectorEntry <+> iter (literal ',' <?+> selectorEntry) 
             >>> concat . cons


selectorEntry :: Parser [Int]
selectorEntry = rangeSelector <|> (number >>> (:[]))


rangeSelector :: Parser [Int]
rangeSelector = number <+-> literal '-' <+> number >>> (\(a, b) -> [a..b])
