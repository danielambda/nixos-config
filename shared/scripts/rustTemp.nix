{ pkgs, lib }: 
let
  wallpapersPath = /home/daniel/Downloads;
  setWpNumber = "${lib.getExe pkgs.swww} img ${wallpapersPath}/desert_sands_"; 
  ext = "png";
  transitionCfg = "--transition-type=fade --transition-duration=10 --transition-fps=60 --transition-step=1";
in pkgs.writers.writeHaskellBin "temp" {}
/*haskell*/ ''
  import System.Process (callCommand)
  import Control.Concurrent

  setWp :: Int -> IO ()
  setWp number =
      let n = show number;
      in callCommand $ "${setWpNumber}"<>n<>".${ext} ${transitionCfg}" 
>
  cycleWp :: Int -> IO ()
  cycleWp i = 
      if i < 1 || 5 < i then cycleWp 1
      else do
          setWp i
          threadDelay 10_000_000
          cycleWp $ i + 1

  main :: IO ()
  main = do
     cycleWp 1
''

