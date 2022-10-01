module Paths_ex01 (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\Personal\\College\\Functional Programming\\Exercise01\\.stack-work\\install\\8defbd7c\\bin"
libdir     = "D:\\Personal\\College\\Functional Programming\\Exercise01\\.stack-work\\install\\8defbd7c\\lib\\x86_64-windows-ghc-7.10.3\\ex01-0.1.0.0-DAmIZvqlGfO1en5WWmRvQz"
datadir    = "D:\\Personal\\College\\Functional Programming\\Exercise01\\.stack-work\\install\\8defbd7c\\share\\x86_64-windows-ghc-7.10.3\\ex01-0.1.0.0"
libexecdir = "D:\\Personal\\College\\Functional Programming\\Exercise01\\.stack-work\\install\\8defbd7c\\libexec"
sysconfdir = "D:\\Personal\\College\\Functional Programming\\Exercise01\\.stack-work\\install\\8defbd7c\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ex01_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ex01_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ex01_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ex01_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ex01_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
