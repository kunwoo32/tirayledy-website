{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Import.DynamicHashing
    ( hashRename
    , hashRenameWholeDir
    ) where

import ClassyPrelude.Yesod
import Crypto.Hash.Conduit (hashFile)
import Crypto.Hash (MD5, Digest)
import qualified Data.ByteString.Char8 as S8
import qualified Data.ByteArray as ByteArray
import qualified Data.ByteString.Base64
import System.Directory (copyFile, listDirectory, doesFileExist)
import System.FilePath (takeExtension)

dynamicHashFile :: FilePath -> IO String
dynamicHashFile =
    fmap (base64Full . encode) . hashFile
  where
    encode d = ByteArray.convert (d :: Digest MD5)

hashRename :: FilePath -> FilePath -> IO ()
hashRename file directory = do
    name <- dynamicHashFile file
    copyFile file (directory </> name <.> takeExtension file)

hashRenameWholeDir :: FilePath -> FilePath -> IO ()
hashRenameWholeDir dirIn dirOut = do
    contents <- fmap (fmap (dirIn </>)) $ listDirectory dirIn
    forM_ contents (\c -> do
        isFile <- doesFileExist c
        if isFile
            then hashRename c dirOut
            else return ())

base64Full :: ByteString -> String
base64Full = map tr
           . S8.unpack
           . Data.ByteString.Base64.encode
  where
    tr '+' = '-'
    tr '/' = '_'
    tr c   = c
