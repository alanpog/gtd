module GTD.Tasks (
    Priority(..), 
    RecurType(..),
  ) where

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

