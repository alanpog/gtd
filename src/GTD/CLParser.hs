module GTD.CLParser where

import GTD.Actions
import GTD.CLParser.Primitives
import GTD.Configuration
import GTD.Tasks

import Data.Char
import Data.List
import Data.Time


recurTypeKeywords :: [ (String    , RecurType) ]
recurTypeKeywords =  [ ("relative", Relative )
                     , ("absolute", Absolute ) ]


constructorFromKeyword :: [(String, a)] -> String -> Maybe a
constructorFromKeyword keywords keyword =
    let words = filter (((map toLower keyword) `isPrefixOf`) . fst) keywords
    in case length words of
         1 -> Just . snd . head $ words
         _ -> Nothing


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


recurType :: Parser RecurType
recurType = (word ?>>>) . constructorFromKeyword $ recurTypeKeywords


selector :: Parser [Int]
selector = selectorEntry <+> iter (literal ',' <?+> selectorEntry)
             >>> concat . cons


selectorEntry :: Parser [Int]
selectorEntry = rangeSelector <|> (number >>> (:[]))


rangeSelector :: Parser [Int]
rangeSelector = number <+-> literal '-' <+> number >>> (\(a, b) -> [a..b])
