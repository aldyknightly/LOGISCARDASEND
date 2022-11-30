{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE DeriveAnyClass      #-}
{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE NoImplicitPrelude   #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}

{-# OPTIONS_GHC -fno-warn-unused-imports #-}

import           Control.Monad        hiding (fmap)
import           Data.Aeson           (ToJSON, FromJSON)
import           Data.Map             as Map
import           Data.Text            (Text)
import           Data.Void            (Void)
import           GHC.Generics         (Generic)
import           Plutus.Contract
import           PlutusTx             (Data (..))
import qualified PlutusTx
import           PlutusTx.Prelude     hiding (Semigroup(..), unless)
import           Ledger               hiding (singleton)
import           Ledger.Constraints   (TxConstraints)
import qualified Ledger.Constraints   as Constraints
import qualified Ledger.Typed.Scripts as Scripts
import           Ledger.Ada           as Ada
import           Playground.Contract  (printJson, printSchemas, ensureKnownCurrencies, stage, ToSchema)
import           Playground.TH        (mkKnownCurrencies, mkSchemaDefinitions)
import           Playground.Types     (KnownCurrency (..))
import           Prelude              (IO, Semigroup (..), Show (..), String)
import           Text.Printf          (printf)
import           Data.Char
import           Ledger
-- nama project (LOGISCARDASEND) pengiriman cepat trust dan terpercaya Reward Point 

-- ONCHAIN SIMULATION KODE

data PengirimanDatum = PengirimanDatum -- ONCHAIN VALIDATION DATUM PARAMETER : payAddress, batasPengiriman, tandaterimaNomor
    { payAddress'   :: PaymentPubKeyHash
    , batasPengiriman' :: POSIXTime
    , tandaterimaNomor'    :: Integer
    , rewards'                :: Integer
    } deriving Show
PlutusTx.unstableMakeIsData ''PengirimanDatum

newtype MyRedeemer = MyRedeemer Integer
PlutusTx.unstableMakeIsData ''MyRedeemer

{-# INLINABLE execValidation #-}
execValidation :: PengirimanDatum -> MyRedeemer -> ScriptContext -> Bool
execValidation datum (MyRedeemer mrd) ctx = traceIfFalse "payAddress's signature missing" signedBypayAddress' &&
                         traceIfFalse "batasPengiriman not reached" batasPengiriman'Reached &&
                         (traceIfFalse "invalid tandaterimaNomor!" $ mrd == tandaterimaNomor' datum) 

  where
    info :: TxInfo
    info = scriptContextTxInfo ctx --info payaddress

    signedBypayAddress' :: Bool
    signedBypayAddress' = txSignedBy info $ unPaymentPubKeyHash $ payAddress' datum

    batasPengiriman'Reached :: Bool
    batasPengiriman'Reached = contains (from $ batasPengiriman' datum) $ txInfoValidRange info

data Delivery
instance Scripts.ValidatorTypes Delivery where
    type instance DatumType Delivery = PengirimanDatum
    type instance RedeemerType Delivery = MyRedeemer

typedValidator :: Scripts.TypedValidator Delivery
typedValidator = Scripts.mkTypedValidator @Delivery
    $$(PlutusTx.compile [|| execValidation ||])
    $$(PlutusTx.compile [|| wrap ||])
  where
    wrap = Scripts.wrapValidator @PengirimanDatum @MyRedeemer

validator :: Validator
validator = Scripts.validatorScript typedValidator

valHash :: Ledger.ValidatorHash
valHash = Scripts.validatorHash typedValidator

scrAddress :: Ledger.Address
scrAddress = scriptAddress validator


-- OFFCHAIN SIMULATION KODE


data PaymentParams = PaymentParams
    { payAddress            :: !PaymentPubKeyHash
    , batasPengiriman :: !POSIXTime
    , awalPengiriman             :: !String
    , tujuanPengiriman       :: !String
    , berat_Kg                 :: !Integer
    , tandaterimaNomor             :: !Integer 
    , rewards                       :: !Integer
    , namaBarang                :: !String
	, alamat						:: !String
    } deriving (Generic, ToJSON, FromJSON, ToSchema)

type SkemaPengiriman =
            Endpoint "Pembayaran" PaymentParams
        .\/ Endpoint "Konfirmasi" Integer

payment :: AsContractError e => PaymentParams -> Contract w s e ()
payment pp = do
    let price = 1000000
    let datum = PengirimanDatum
                { payAddress'   = payAddress pp
                , batasPengiriman' = batasPengiriman pp
                , tandaterimaNomor'    = tandaterimaNomor pp
                , rewards' = rewards pp
                }
    let start = awalPengiriman pp
    let tujuan = tujuanPengiriman pp
    let routex = rute (fmap toUpper start) (fmap toUpper tujuan)  -- Input awalPengiriman and tujuanPengiriman is not case sensitive because UpperCase function
    let tx  = Constraints.mustPayToTheScript datum $ Ada.lovelaceValueOf $ (price * berat_Kg pp) + routex  --PErhitungan pengiriman berdasarkan Harganya dipatok 1000000 * berat + Rute
    ledgerTx <- submitTxConstraints typedValidator tx
    void $ awaitTxConfirmed $ getCardanoTxId ledgerTx
    logInfo @String $ printf "made a payment of %d lovelace to %s with batasPengiriman' %s"
        (price)
        (show $ payAddress pp)
        (show $ batasPengiriman pp)

reward :: AsContractError e => PaymentParams -> Contract w s e ()
reward bb = do
    let datum = PengirimanDatum
                { payAddress'   = payAddress bb
                ,rewards' = rewards bb
                }
    let start = awalPengiriman bb
    let tujuan = tujuanPengiriman bb
    let tx  = Constraints.mustPayToTheScript datum $ Ada.lovelaceValueOf $ (rewards bb)
    ledgerTx <- submitTxConstraints typedValidator tx
    void $ awaitTxConfirmed $ getCardanoTxId ledgerTx
    logInfo @String $ printf "made a reward of %d lovelace to %s with rewards' %s"
        (show $ rewards bb)

-- harga rute pengiriman

rute :: String -> String -> Integer
rute "PADANG" "JAKARTA" = 1100000
rute "JAKARTA" "PADANG" = 1200000
rute "PADANG" "SURABAYA" = 3100000
rute "SURABAYA" "PADANG" = 3100000
rute "PADANG" "DENPASAR" = 7100000
rute "DENPASAR" "PADANG" = 7100000
rute "PADANG" "MEDAN" = 11000000
rute "MEDAN" "PADANG" = 1100000
rute "JAKARTA" "SURABAYA" = 4200000
rute "SURABAYA" "JAKARTA" = 4200000
rute "JAKARTA" "DENPASAR" = 8100000
rute "DENPASAR" "JAKARTA" = 8200000
rute "JAKARTA" "MEDAN" = 910000
rute "MEDAN" "JAKARTA" = 910000
rute "SURABAYA" "DENPASAR" = 4100000
rute "DENPASAR" "SURABAYA" = 420000
rute "SURABAYA" "MEDAN" = 13100000
rute "MEDAN" "SURABAYA" = 13200000
rute "DENPASAR" "MEDAN" = 15510000
rute "MEDAN" "DENPASAR" = 15520000


confirm :: forall w s e. AsContractError e => Integer -> Contract w s e ()
confirm masuk = do
    now   <- currentTime
    pkh   <- ownPaymentPubKeyHash
    utxos <- Map.filter (isSuitable pkh now) <$> utxosAt scrAddress
    if Map.null utxos
        then logInfo @String $ printf "pembayaran tidak tersedia => pkh = %s, tandaterimaNomor' = %s" (show $ pkh) (show $ masuk)
        else do
            let orefs   = fst <$> Map.toList utxos
                lookups = Constraints.unspentOutputs utxos  <>
                          Constraints.otherScript validator
                tx :: TxConstraints Void Void
                tx      = mconcat [Constraints.mustSpendScriptOutput oref $ Redeemer $ PlutusTx.toBuiltinData (MyRedeemer masuk) | oref <- orefs] <>
                          Constraints.mustValidateIn (from now)
            ledgerTx <- submitTxConstraintsWith @Void lookups tx
            void $ awaitTxConfirmed $ getCardanoTxId ledgerTx
            logInfo @String $ printf "payment Masuk => date %s pkh = %s" (show $ now) (show $ pkh)
  where
    isSuitable :: PaymentPubKeyHash -> POSIXTime -> ChainIndexTxOut -> Bool
    isSuitable pkh now o = case _ciTxOutDatum o of
        Left _          -> False
        Right (Datum e) -> case PlutusTx.fromBuiltinData e of
            Nothing -> False
            Just d  -> payAddress' d == pkh && batasPengiriman' d <= now && tandaterimaNomor' d == masuk


endpoints :: Contract () SkemaPengiriman Text ()
endpoints = awaitPromise (payment' `select` confirm' ) >> endpoints
  where
    payment' = endpoint @"Pembayaran" payment
    confirm' = endpoint @"Konfirmasi" confirm

mkSchemaDefinitions ''SkemaPengiriman

mkKnownCurrencies []