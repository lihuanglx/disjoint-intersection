module Main where

import qualified Data.Text                as T
import           System.Console.Haskeline

import           Source.Parser            (parseExpr)
import           Source.Syntax            (showExpr)


main :: IO ()
main = runInputT defaultSettings loop
  where loop :: InputT IO ()
        loop =
          do minput <- getInputLine "> "
             case minput of
               Nothing -> return ()
               Just "" -> loop
               Just ":q" -> return ()
               Just cmds -> dispatch cmds
        dispatch :: String -> InputT IO ()
        dispatch cmds =
          let e@(cmd:progm) = words cmds
          in case cmd of
               _ ->
                 processCMD e $
                 \xs ->
                   do emptyLine
                      outputStrLn "Abstract syntax"
                      outputStrLn $ show xs
                      emptyLine
                      outputStrLn "Pretty printing"
                      outputStrLn $ showExpr xs
          --      _ ->
          --        processCMD e $
          --        \xs ->
          --          do emptyLine
          --             case translate xs of
          --               Left err -> showText err
          --               Right (typ, targetExpr) -> do
          --                 outputStrLn "Source typing result"
          --                 showText $ showExpr typ
          --                 emptyLine
          --                 outputStrLn "After translation"
          --                 showText $ Target.Syntax.showExpr targetExpr
          --                 emptyLine
          --                 outputStrLn "Target typing result"
          --                 case Target.TypeCheck.typecheck targetExpr of
          --                   Left err -> showText err
          --                   Right t -> showText $ Target.Syntax.showExpr t
          --                 emptyLine
          --                 outputStrLn "Target evaluation result"
          --                 showText $ Target.Syntax.showExpr $ Target.TypeCheck.eval targetExpr
          where processCMD expr func =
                  do case parseExpr . unwords $ expr of
                       Left err -> outputStrLn . show $ err
                       Right xs -> func xs
                     emptyLine
                     loop
                emptyLine = outputStrLn ""
                -- showText = outputStrLn . T.unpack
