-- src/RedditAnalysis.hs

module RedditAnalysis where

import Data.Aeson
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as LBS
import Network.HTTP.Conduit

-- | Fetch Reddit data from the given URL and save it to a file
fetchAndSaveRedditData :: String -> FilePath -> IO ()
fetchAndSaveRedditData url outputFile = do
  response <- simpleHttp url
  LBS.writeFile outputFile response

-- | Example function to fetch Reddit data and save it to "reddit_data.json".
fetchRedditData :: IO ()
fetchRedditData = fetchAndSaveRedditData "https://www.reddit.com/r/haskell.json" "reddit_data.json"
