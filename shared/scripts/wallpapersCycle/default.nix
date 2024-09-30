{ pkgs, ... }: 
let
  wallpaper2101 = ./wallpapers/1.png;
  wallpaper0109 = ./wallpapers/5.png;
  wallpaper0913 = ./wallpapers/2.png;
  wallpaper1318 = ./wallpapers/3.png;
  wallpaper1821 = ./wallpapers/4.png;

  transitionCfg = "--transition-type=fade --transition-duration=10 --transition-fps=60 --transition-step=1";
in pkgs.writers.writeHaskellBin "wallpapersCycle" {
  libraries = [pkgs.haskellPackages.intervals];
} 
/*haskell*/ ''
import System.Process (callCommand)
import Control.Concurrent
import Data.Time

data Wallpaper = Wallpaper Int Int String

config :: [Wallpaper]
config = 
  [ Wallpaper 0  1  "${wallpaper2101}"
  , Wallpaper 1  9  "${wallpaper0109}"
  , Wallpaper 9  13 "${wallpaper0913}"
  , Wallpaper 13 18 "${wallpaper1318}"
  , Wallpaper 18 21 "${wallpaper1821}"
  , Wallpaper 21 24 "${wallpaper2101}"
  ]

currentHour :: IO Int
currentHour = do
  currentTime <- getZonedTime
  let hour = todHour . localTimeOfDay $ zonedTimeToLocalTime currentTime
  return hour

matchingWallpaper :: [Wallpaper] -> Int -> String
matchingWallpaper ((Wallpaper begin end path):wps) hour = 
  if begin <= hour && hour < end then path
  else matchingWallpaper wps hour
matchingWallpaper [] _ = "Something's wrong with the provided config"

setWallpaper :: String -> IO ()
setWallpaper path = 
  callCommand $ "${pkgs.swww}/bin/swww img "<>path<>" ${transitionCfg}"

main :: IO ()
main = do
  hour <- currentHour
  let wp = matchingWallpaper config hour
  setWallpaper wp 
''

