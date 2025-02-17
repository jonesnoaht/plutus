{-
FIXME: This module duplicates some necessary Haskell types from Marlowe.Client. These should
preferably be generated by purescript-bridge with a PSGenerator module created specifically for use
by the Marlowe Run frontend.
-}
module Marlowe.Client where

import Prologue
import Data.Generic.Rep (class Generic)
import Data.Lens (Lens')
import Data.Lens.Iso.Newtype (_Newtype)
import Data.Lens.Record (prop)
import Data.Newtype (class Newtype)
import Data.Symbol (SProxy(..))
import Foreign.Class (class Encode, class Decode)
import Foreign.Generic (genericDecode, genericEncode)
import Marlowe.Semantics (MarloweData, MarloweParams, TransactionInput, aesonCompatibleOptions)

-- This is the state of the follower contract. Its purpose is to provide us with an up-to-date
-- transaction history for a Marlowe contract running on the blockchain.
newtype ContractHistory
  = ContractHistory
  { chParams :: Maybe (Tuple MarloweParams MarloweData)
  , chHistory :: Array TransactionInput
  }

derive instance newtypeContractHistory :: Newtype ContractHistory _

derive instance eqContractHistory :: Eq ContractHistory

derive instance genericContractHistory :: Generic ContractHistory _

instance encodeContractHistory :: Encode ContractHistory where
  encode a = genericEncode aesonCompatibleOptions a

instance decodeContractHistory :: Decode ContractHistory where
  decode a = genericDecode aesonCompatibleOptions a

_chParams :: Lens' ContractHistory (Maybe (Tuple MarloweParams MarloweData))
_chParams = _Newtype <<< prop (SProxy :: SProxy "chParams")

_chHistory :: Lens' ContractHistory (Array TransactionInput)
_chHistory = _Newtype <<< prop (SProxy :: SProxy "chHistory")
