import GTD.Actions
import GTD.CLParser
import GTD.Tasks
import Test.HUnit

testCases =
  [
    (
      "Task description pri:H +work +idea"
    , Add {
          oDesc = "Task description"
        , oDue = Nothing
        , oWait = Nothing
        , oPri = Just H
        , oTags = ["work", "idea"]
        , oRecur = Nothing
        , oRecurType = Nothing
      }
    )
  ]


testTemplate input result = TestCase $ assertEqual
  "Should parse." (Just ("", result)) (parseCLActions input)

main = runTestTT $ TestList $ map toTestCase testCases
  where
    toTestCase = \(input, result) -> testTemplate input result
