module Local.Util where

import Data.Ratio ((%))
import Graphics.X11.Xlib.Extras
import Graphics.X11.Xlib.Misc (queryPointer)
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.XUtils
import qualified Data.Map.Strict as M

trim :: Int->String->String
trim n s
  | len > n = start ++ elip ++ end
  | otherwise = s
  where
    len = length s
    n' = fromIntegral $ ceiling (n % 2)
    start = take n' s
    end = drop (len - n') s
    elip = " .. "--" ⋯ "

wclass :: Window -> X String
wclass w = fmap ren (runQuery className w)
  where ren n
          | n == "chromium-browser" = "C"
          | n == "Emacs" = "E"
          | n == "URxvt" = "T"
          | otherwise = n

getPointer :: Window -> X (Position, Position)
getPointer window = do d <- asks display
                       (_,_,_,x,y,_,_,_) <- io $ queryPointer d window
                       return (fi x,fi y)

getWindowTopLeft :: Window -> X (Position, Position)
getWindowTopLeft w = do d <- asks display
                        atts <- io $ getWindowAttributes d w
                        return (fi $ wa_x atts, fi $ wa_y atts)

isFloating :: Window -> X Bool
isFloating w = gets ((M.member w) . W.floating . windowset)

onWorkspace :: (Eq i, Eq s) => i -> (W.Stack a -> W.Stack a) -> W.StackSet i l a s sd -> W.StackSet i l a s sd
onWorkspace w f ss = W.view (W.tag $ W.workspace $ W.current ss) $ W.modify' f $ W.view w ss
