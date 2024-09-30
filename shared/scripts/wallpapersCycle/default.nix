{ pkgs, ... }: 
let
  wallpaper2101 = ./wallpapers/1.png;
  wallpaper0109 = ./wallpapers/5.png;
  wallpaper0913 = ./wallpapers/2.png;
  wallpaper1318 = ./wallpapers/3.png;
  wallpaper1821 = ./wallpapers/4.png;
  swww = "${pkgs.swww}/bin/swww";

  transitionCfg = "--transition-type=fade --transition-duration=10 --transition-fps=60 --transition-step=1";
in pkgs.writers.writeHaskellBin "wallpapersCycle" {
  libraries = [pkgs.haskellPackages.intervals];
} 
/*haskell*/ ''
import System.Process (callCommand)
import Control.Concurrent
import Data.Time
import Data.Fixed (Pico)

data HourMinute = HourMinute Int Int
    deriving (Eq, Show)

instance Ord HourMinute where
    (HourMinute h1 m1) < (HourMinute h2 m2) = h1 < h2 || (h1 == h2 && m1 < m2)

    t1 <= t2 = t1 < t2 || t1 == t2 

totalMinutes :: HourMinute -> Int
totalMinutes (HourMinute h m) = 60 * h + m

instance Num HourMinute where
    (HourMinute h1 m1) + (HourMinute h2 m2) =
        let minutes = m1 + m2
            m = minutes `mod` 60
            h = h1 + h2 + if minutes >= 60 then 1 else 0
        in HourMinute h m 

    t1 - t2 =
        let totalM1 = totalMinutes t1
            totalM2 = totalMinutes t2
            diffM = totalM1 - totalM2 + if totalM1 > totalM2 then 0 else 24 * 60
            h = diffM `div` 60
            m = diffM `mod` 60
        in HourMinute h m

totalMicroseconds :: HourMinute -> Int
totalMicroseconds t = 3_600_000_000 * totalMinutes t 

fromTimeOfDay :: TimeOfDay -> HourMinute
fromTimeOfDay (TimeOfDay h m _) = HourMinute h m 

data Wallpaper = Wallpaper HourMinute String

localTime :: IO TimeOfDay
localTime = localTimeOfDay . zonedTimeToLocalTime <$> getZonedTime

setWallpaper :: String -> IO ()
setWallpaper path =
    callCommand $ "${swww} img "<>path<>" ${transitionCfg}" 

cycleWallpapersFrom :: [Wallpaper] -> HourMinute -> [Wallpaper] 
cycleWallpapersFrom config time = dropWhile (\(Wallpaper begin _) -> time < begin) config 
                                  ++ cycle config

sequentiallySetWallpapers :: [Wallpaper] -> HourMinute -> IO ()
sequentiallySetWallpapers ((Wallpaper begin path):wps) time = do
    threadDelay . totalMicroseconds $ begin - time
    setWallpaper path
    sequentiallySetWallpapers wps time

main :: IO ()
main = do
    let config :: [Wallpaper] = 
            [ Wallpaper (HourMinute 0 0)  "${wallpaper2101}"
            , Wallpaper (HourMinute 1 0)  "${wallpaper0109}"
            , Wallpaper (HourMinute 9 0)  "${wallpaper0913}"
            , Wallpaper (HourMinute 13 0) "${wallpaper1318}"
            , Wallpaper (HourMinute 18 0) "${wallpaper1821}"
            , Wallpaper (HourMinute 21 0) "${wallpaper2101}"
            ]
    
    now :: HourMinute <- fromTimeOfDay <$> localTime

    sequentiallySetWallpapers (cycleWallpapersFrom config now) now
''

