module Local.Theme (decorations,
                    focusedBorderColor, focusedText,
                    Local.Theme.urgentBorderColor, urgentText,
                    hasUrgentBorderColor,
                    secondaryColor, secondaryText,
                    normalBorderColor, normalText) where

import XMonad.Layout.Decoration

focusedBorderColor = "#ff0000"
focusedText = "white"

normalBorderColor = "#777777"
normalText = "white"

secondaryColor = "#4477bb"
secondaryText = "white"

urgentBorderColor = "#ffff00"
urgentText = "black"

hasUrgentBorderColor = "#ff8c00"

decorations = def
  { fontName = "xft:Sans:pixelsize=10:bold"
  , decoHeight = 14

  , activeBorderColor = focusedBorderColor
  , activeTextColor = focusedText
  , activeColor = focusedBorderColor

  , inactiveBorderColor = "#aaa"
  , inactiveTextColor = normalText
  , inactiveColor = normalBorderColor

  , XMonad.Layout.Decoration.urgentBorderColor = Local.Theme.urgentBorderColor
  , urgentTextColor = urgentText
  , urgentColor = Local.Theme.urgentBorderColor
  }
