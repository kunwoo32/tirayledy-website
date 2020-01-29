{-# LANGUAGE CPP #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Import.NoFoundation
    ( module Import
    , displayProductPrice
    ) where

import ClassyPrelude.Yesod   as Import
import Model                 as Import
import Settings              as Import
import Settings.StaticFiles  as Import
import Yesod.Auth            as Import
import Yesod.Core.Types      as Import (loggerSet)
import Yesod.Default.Config2 as Import

displayProductPrice :: Product -> Text
displayProductPrice p =
    case fmap words (productPrice p) of
        Just (symbol:value:[]) -> convertSymbol symbol ++ periodToComma value
        Just t -> unwords t
        Nothing -> ""

convertSymbol s =
    case s of
        "EUR" -> "€"
        "USD" -> "$"
        _     -> s ++ " "

periodToComma :: Text -> Text
periodToComma = pack . fmap (\c -> if c=='.' then ',' else c) . unpack
