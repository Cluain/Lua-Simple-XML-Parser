#!/usr/bin/env lua
local xml = require("xmlSimple").newParser()
local testXml = '<testOne param="param1value">'
testXml = testXml .. '<testTwo paramTwo="param2value">'
testXml = testXml .. '<testThree>'
testXml = testXml .. 'testThreeValue'
testXml = testXml .. '</testThree>'
testXml = testXml .. '<testThree duplicate="one" duplicate="two">'
testXml = testXml .. 'testThreeValueTwo'
testXml = testXml .. '</testThree>'
testXml = testXml .. '<test_Four something="else">'
testXml = testXml .. 'testFourValue'
testXml = testXml .. '</test_Four>'
testXml = testXml .. '<testFive>'
testXml = testXml .. '<testFiveDeep>'
testXml = testXml .. '<testFiveEvenDeeper>'
testXml = testXml .. '<testSix someParam="someValue"/>'
testXml = testXml .. '</testFiveEvenDeeper>'
testXml = testXml .. '</testFiveDeep>'
testXml = testXml .. '</testFive>'
testXml = testXml .. 'testTwoValue'
testXml = testXml .. '</testTwo>'
testXml = testXml .. '</testOne>'
local parsedXml = xml:ParseXmlText(testXml)
if parsedXml.testOne == nil then error("Node not created")
elseif parsedXml.testOne:name() ~= "testOne" then
	error("Node name not set")
elseif parsedXml.testOne.testTwo == nil then
	error("Child node not created")
elseif parsedXml.testOne.testTwo:name() ~= "testTwo" then
	error("Child node name not set")
elseif parsedXml.testOne.testTwo:value() ~= "testTwoValue" then
	error("Node value not set")
elseif parsedXml.testOne.testTwo.test_Four:value() ~= "testFourValue" then
	error("Second child node value not set")
elseif parsedXml.testOne["@param"] ~= "param1value" then
	error("Parameter not set")
elseif parsedXml.testOne.testTwo["@paramTwo"] ~= "param2value" then
	error("Second child node parameter not set")
elseif parsedXml.testOne.testTwo.test_Four["@something"] ~= "else" then
	error("Deepest node parameter not set")
end

-- duplicate names tests
if parsedXml.testOne.testTwo.testThree[1]:value() ~= "testThreeValue" then
	error("First of duplicate nodes value not set")
elseif parsedXml.testOne.testTwo.testThree[2]:value() ~= "testThreeValueTwo" then
	error("Second of duplicate nodes value not set")
elseif parsedXml.testOne.testTwo.testThree[2]["@duplicate"][1] ~= "one" then
	error("First of duplicate parameters not set")
elseif parsedXml.testOne.testTwo.testThree[2]["@duplicate"][2] ~= "two" then
	error("Second of duplicate parameters not set")
end

-- deep element test
if parsedXml.testOne.testTwo.testFive.testFiveDeep.testFiveEvenDeeper.testSix['@someParam'] ~= "someValue" then
	error("Deep test error")
end

-- node functions test
local node = require("xmlSimple"):newNode("testName")
if node:name() ~= "testName" then
	error("Node creation failed")
end
node:setName("nameTest")
if node:name() ~= "nameTest" then
	error("Name function test failed")
end
node:setValue("valueTest")
if node:value() ~= "valueTest" then
	error("Value function test failed")
end
local childNode = require("xmlSimple"):newNode("parent")
node:addChild(childNode)
if type(node:children()) ~= "table" then
	error("children function test failed")
elseif #node:children() ~= 1 then
	error("AddChild function test failed")
elseif node:numChildren() ~= 1 then
	error("numChildren function test failed")
end
node:addProperty("name", "value")
if type(node:properties()) ~= "table" then
	error("properties function test failed")
elseif #node:properties() ~= 1 then
	error("Add property function test failed")
elseif node:numProperties() ~= 1 then
	error("Num properties function test failed")
end
print("Tests passed")
