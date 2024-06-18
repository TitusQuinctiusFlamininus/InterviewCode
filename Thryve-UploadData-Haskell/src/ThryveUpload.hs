{-# LANGUAGE OverloadedStrings #-}

module ThryveUpload( retrieveThryveCloudData ) where

-- Our Libraries
import ThryveTypes
import ThryveUtils
import ThryveConstants

--External Helper Libraries 
import            Data.Aeson                     as A
import            Data.Char                      (chr)
import            Network.HTTP.Simple
import            Network.HTTP.Client.Conduit 
import            Control.Monad.IO.Class
import            Control.Monad.Trans.Class
import            Control.Monad.Trans.State.Lazy
import qualified  Data.ByteString                 as B




-- Entry function to the end-to-end test
retrieveThryveCloudData :: ThryveRest (Maybe ThryveHealthData) ThryveSession ThryveConstants
retrieveThryveCloudData = do
        generateThryveUser
        k <- lift get
        liftIO . putStrLn $ "\n Thryve User Created : Access Token for Session : -> "++fst k++"\n "
        uploadThryveUserData 
        k' <- lift get
        liftIO . putStrLn $ "Thryve User Health Data Uploaded at TimeStamp: -> "++snd k'++"\n "
        downloadThryveUserData 




-- Function that accesses the Thryve Server and requests for a Thryve User
-- to be generated. An AccessToken type is returned
generateThryveUser :: ThryveRest (Maybe ThryveHealthData) ThryveSession ThryveConstants
generateThryveUser = do
    request' <- parseRequest ("POST "++ checkFor "userCreationUrl")
    let request
            = setRequestMethod "POST"
            $ setRequestHeader "Content-Type"     ["application/x-www-form-urlencoded"]
            $ setRequestHeader "Authorization"    [authorizationHeader                ]
            $ setRequestHeader "AppAuthorization" [appAuthorizationHeader             ]
            $ setRequestSecure True
            $ setRequestPort 443
            $ request'
    resp <- liftIO $ httpBS request
    (lift $ put ((map (chr . fromEnum) . B.unpack . getResponseBody $ resp), [])) >> return Nothing
    


-- Function that Uploads the Thryve User's Health Data, represented as JSON
uploadThryveUserData :: ThryveRest (Maybe ThryveHealthData) ThryveSession ThryveConstants
uploadThryveUserData = do
    (accToken, _) <- lift get 
    liftIO findCurrentTime >>= (\t -> lift $ put (accToken, t)) 
    request'  <- parseRequest ("PUT "++checkFor "uploadDataUrl")
    let request
            = setRequestMethod "PUT"
            $ setRequestHeader "Content-Type"         ["application/json; charset=utf-8"  ]
            $ setRequestHeader "Authorization"        [authorizationHeader                ]
            $ setRequestHeader "AppAuthorization"     [appAuthorizationHeader             ]
            $ setRequestHeader "authenticationToken"  [createByteStream accToken          ]
            $ setRequestBody (RequestBodyBS . createByteStream $ hData)
            $ setRequestSecure True
            $ setRequestPort 443
            $ request'
    httpBS request >>= (\c -> liftIO $ putStrLn ("Response Code After Upload: -> "++(show . getResponseStatusCode $ c))) >> return Nothing
                            
    
-- Function that Uploads the Thryve User's Health Data, represented as JSON
downloadThryveUserData ::  ThryveRest (Maybe ThryveHealthData) ThryveSession ThryveConstants
downloadThryveUserData= do
    (accToken, tstamp) <- lift get 
    request' <- parseRequest ("POST "++checkFor "downloadDataUrl")
    let request
            = setRequestMethod "POST"
            $ setRequestHeader "Content-Type"         ["application/x-www-form-urlencoded"  ]
            $ setRequestHeader "Authorization"        [authorizationHeader                  ]
            $ setRequestHeader "AppAuthorization"     [appAuthorizationHeader               ]
            $ setRequestHeader "authenticationToken"  [createByteStream accToken            ]
            $ setRequestBody (RequestBodyBS $ createByteStream ("authenticationToken="++accToken++"&createdAfterUnix="++tstamp))
            $ setRequestSecure True
            $ setRequestPort 443
            $ request'
    httpBS request >>= (return . A.decode . flick . map (chr . fromEnum) . B.unpack . getResponseBody)
    