{-# LANGUAGE FlexibleContexts, OverloadedStrings #-}

module XMonad.Util.XMobar where

import XMonad
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import Data.Char
import DBus
import DBus.Client
import Codec.Binary.UTF8.String ( decodeString )
import Graphics.UI.Gtk hiding ( Signal )

runWithBar cfg =
  do session <- connectSession
     let sendBus s = emit session (signal"/org/xmonad/Log" "org.xmonad.Log" "Update")
            {signalBody = [toVariant $ decodeString s]}
         pp = (myPP (focusedBorderColor cfg)) { ppOutput = sendBus }
         log = dynamicLogWithPP pp
     xmonad $ cfg { logHook = (logHook cfg) >> log }

raw = escapeMarkup

taffyBold = wrap "<b>" "</b>"

taffyColor fg bg = wrap t "</span>"
  where
    t = concat ["<span fgcolor=\"", fg, if null bg then "" else "\" bgcolor=\"" ++ bg , "\">"]

myPP c = xmobarPP
  { ppCurrent = taffyColor c "" . taffyBold
  , ppVisible = taffyColor "white" "" . taffyBold
  , ppUrgent = taffyColor "red" ""
  , ppTitle = taffyColor "white" "" . raw . shorten 120
  , ppLayout = \s -> taffyColor "grey" "" $ case s of
      "Full" -> "+"
      x:" by H" -> x:""
      x:" by Full" -> x:"+"
      s -> s
  }
