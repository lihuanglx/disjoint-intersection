{-# LANGUAGE DeriveGeneric #-}

module Common where

import           Data.Typeable                    (Typeable)
import           GHC.Generics                     (Generic)
import           Unbound.Generics.LocallyNameless


data Operation = Mul
               | Sub
               | Add
               deriving (Show, Generic, Typeable)


instance Alpha Operation