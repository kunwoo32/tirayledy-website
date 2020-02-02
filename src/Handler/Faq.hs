{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Faq where

import Import

getFaqR :: Handler Html
getFaqR =
    defaultLayout $ do
        setTitle "FAQ"
        $(widgetFile "faq")
