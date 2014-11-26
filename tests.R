if(!require('RUnit')) { install.packages('RUnit') }

library(RUnit)

testsuite.runAnalysis = defineTestSuite("runAnalysis",
				dirs = file.path("examples"),
				testFileRegexp = "^runit.+\\.R",
				testFuncRegexp = "^test\\..+",
				rngKind = "Marsaglia-Multicarry",
				rngNormalKind = "Kinderman-Ramage")

testResult = runTestSuite(testsuite.runAnalysis)
printTextProtocol(testResult)
