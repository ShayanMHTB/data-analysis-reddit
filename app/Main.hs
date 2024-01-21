-- app/Main.hs

module Main where

import RedditAnalysis

main :: IO ()
main = do
  putStrLn "Fetching Reddit Data..."
  fetchRedditData
  putStrLn "Reddit Data fetched and saved to reddit_data.json"
