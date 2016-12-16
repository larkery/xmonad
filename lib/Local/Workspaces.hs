module Local.Workspaces (fixedWorkspaces, workspaceKeys, warp) where

import Control.Monad (when)

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.Warp

fixedWorkspaces = ["one", "two"]

workspaceKeys = [ ("M-d M-d", ("screen swap", swapNextScreen >> warp))
                , ("M-d M-s", ("screen shift", shiftNextScreen >> nextScreen >> warp))
                , ("M-d M-f", ("screen focus", nextScreen >> warp))
                ]
warp :: X ()
warp = do mf <- gets (W.peek . windowset)
          case mf of
            (Just _) -> warpToWindow 0.1 0.1
            _ -> do sid <- gets (W.screen . W.current . windowset)
                    warpToScreen sid 0.1 0.1
