{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_ex04 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\bin"
libdir     = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\lib\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0-1QJQDvZQOwjHLLAaOcEOsX"
dynlibdir  = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\lib\\x86_64-windows-ghc-8.6.4"
datadir    = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\share\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0"
libexecdir = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\libexec\\x86_64-windows-ghc-8.6.4\\ex04-0.1.0.0"
sysconfdir = "D:\\Personal\\College\\Functional Programming\\Exercise04\\.stack-work\\install\\932c8e22\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex04_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex04_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "ex04_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "ex04_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex04_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex04_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
