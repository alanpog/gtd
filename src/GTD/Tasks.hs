module GTD.Tasks (
    Priority(..), 
    RecurType(..),
  ) where

import Data.Time
import Data.Function

-- | Task
data Task
  = Task {
      tDisplayId    :: Int
    , tUniqueId     :: String
    , tDescription  :: String
    , tPriority     :: Priority
    , tTags         :: [String]
    , tCreationDate :: UTCTime
    , tWaitDate     :: UTCTime
    , tDueDate      :: UTCTime
    } deriving (Show)

instance Eq Task where
  (==) = (==) `on` tUniqueId

-- | Task priority
data Priority
    = L -- ^ low priority
    | M -- ^ medium priority
    | H -- ^ high priority 
      deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- | Type of recurring task.
data RecurType = Relative 
               | Absolute 
                 deriving (Eq, Ord, Show, Read, Bounded, Enum)

