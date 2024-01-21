-- src/RedditAnalysis.hs

module RedditAnalysis where

-- Data packages
import Data.Aeson
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as LBS

-- Network packages
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Network.HTTP.Types.Status
import Network.HTTP.Types.Header

-- System pacakges
import System.Environment
import System.Directory

-- Configuration packages
import Configuration.Dotenv

clientId :: ByteString
clientId = "YOUR_CLIENT_ID"

clientSecret :: ByteString
clientSecret = "YOUR_CLIENT_SECRET"

-- | Fetch Reddit data from the given URL and save it to a file.
fetchAndSaveRedditData :: String -> FilePath -> IO ()
fetchAndSaveRedditData url outputFile = do
  -- Load environment variables from .env file
  loadFile defaultConfig

-- Read client ID and client secret from environment variables
  clientId <- getEnv "CLIENT_ID"
  clientSecret <- getEnv "CLIENT_SECRET"

-- Rest of the code remains the same...
  manager <- newManager tlsManagerSettings
  request <- parseRequest url
  let authHeaders = [("Authorization", "Basic " <> Base64.encode (encodeUtf8 clientId <> ":" <> encodeUtf8 clientSecret))]
  let requestWithAuth = request { requestHeaders = authHeaders }
  response <- httpLbs requestWithAuth manager
  case responseStatus response of
    s | s == status200 -> LBS.writeFile outputFile (responseBody response)
    _ -> putStrLn $ "Error: " ++ show (responseStatus response)

-- | Example function to fetch Reddit data and save it to "reddit_data.json".
fetchRedditData :: IO ()
fetchRedditData = fetchAndSaveRedditData "https://www.reddit.com/r/haskell.json" "reddit_data.json"
