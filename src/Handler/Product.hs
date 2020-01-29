{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Product where

import Import

data AmazonLink = AmazonLink
    { amazonLinkTld     :: Text
    , amazonLinkCountry :: Text
    , amazonLinkFlag    :: Route Static
    }

amazonLinks =
    [ AmazonLink
          { amazonLinkTld     = ".de"
          , amazonLinkCountry = "Germany"
          , amazonLinkFlag    = images_flagGermany_png
          }
    , AmazonLink
          { amazonLinkTld     = ".es"
          , amazonLinkCountry = "Spain"
          , amazonLinkFlag    = images_flagSpain_png
          }
    , AmazonLink
          { amazonLinkTld     = ".co.uk"
          , amazonLinkCountry = "UK"
          , amazonLinkFlag    = images_flagUK_png
          }
    , AmazonLink
          { amazonLinkTld     = ".fr"
          , amazonLinkCountry = "France"
          , amazonLinkFlag    = images_flagFrance_png
          }
    , AmazonLink
          { amazonLinkTld     = ".it"
          , amazonLinkCountry = "Italy"
          , amazonLinkFlag    = images_flagItaly_png
          }
    ]

makeLink :: AmazonLink -> Key Product -> Text
makeLink amzLink pid =
    "https://www.amazon" ++ amazonLinkTld amzLink ++ "/dp/" ++ unProductKey pid

getProductR :: ProductId -> Handler Html
getProductR pid = do
    item <- runDB $ get404 pid

    defaultLayout $ do
        setTitle $ toHtml $ productName item
        $(widgetFile "product")
