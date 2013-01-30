module GTD.Actions (
    CLActions(..)
  ) where

data CLActions = 
    Add {                             -- | Add a new task
      oDesc      :: String          , -- ^ Task description
      oDue       :: Maybe UTCTime   , -- ^ Task due time
      oWait      :: Maybe UTCTime   , -- ^ Task wait time
      oPri       :: Maybe Priority  , -- ^ Task priority
      oTags      :: [String]        , -- ^ Assocaiated tags
      oRecur     :: Maybe Int       , -- ^ Recurring frequency (in days)
      oRecurType :: Maybe RecurType   -- ^ When to generate new recuring task
    } 
  | Done {                            -- | Mark selected tasks as done 
      oSel       :: [Int]             -- ^ List of selected tasks
    } 
  | Modify {                          -- | Modify selected tasks 
      oSel       :: [Int]           , -- ^ List of selected tasks
      oDesc      :: String          , -- ^ Task description
      oDue       :: Maybe UTCTime   , -- ^ Task due time
      oWait      :: Maybe UTCTime   , -- ^ Task wait time
      oPri       :: Maybe Priority  , -- ^ Task priority
      oTags      :: [String]          -- ^ Associated tags
    } 
  deriving (Show)
