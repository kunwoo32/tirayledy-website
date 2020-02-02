{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Contact where

import Import

getContactR :: Handler Html
getContactR =
    defaultLayout $ do
        setTitle "Contact Us"
        $(widgetFile "contact")
