module RedditAnalysisSpec where

import Test.Hspec
import RedditAnalysis

spec :: Spec
spec = do
  describe "Reddit Analysis" $ do
    it "fetches Reddit data correctly" $
      fetchRedditData `shouldReturn` ()
