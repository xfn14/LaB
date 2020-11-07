module Utils where

-- | Gets the element of a list in a certain index
getIndexList :: Int -- ^ Index of the element.
             -> [a] -- ^ List with elements
             -> a -- ^ Returned element.
getIndexList _ [] = error "The list is empty, error in indexList"; -- In case the list is empty.
getIndexList 0 (h:_) = h -- Return case (When index is 0)
getIndexList n (_:t) =
    if n > 0 then getIndexList (n-1) t -- Recursive until index is 0
    else error "List index can't be lesser than 0" -- When initial index is negative

-- | Set the element of a list in a certain index
setIndexList :: Int -- ^ Index of the element.
             -> [a] -- ^ List with the elements.
             -> a -- ^ Element to place.
             -> [a] -- ^ Returned list.
setIndexList x (h:t) elem =
    if (x <= length t) || (x < 0) then -- Index negative or bigger than list
        if x == 0 then elem:t -- Change the elem
        else h:(setIndexList (x-1) t elem) -- Recurisve until the index
    else error ("Invalid list index: " ++ show x ++ " " ++ (show $ length t))-- Invalid index value error message
