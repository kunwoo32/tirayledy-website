{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.DynamicImages where

import Import
import System.FilePath (takeExtension)

getDynamicImageR :: Text -> Handler Html
getDynamicImageR f =
    if takeExtension (unpack f) == ".jpg"
        then
            sendFile typeJpeg $ "dynamic" </> "images" </> unpack f
        else
            notFound
