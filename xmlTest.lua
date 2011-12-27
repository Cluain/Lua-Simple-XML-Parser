---
-- User: krystian
-- Company: Cluain Krystian Szczęsny
-- Date: 12/21/11
-- Time: 7:40 PM
--

local xml = require("xml").newParser()

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
testXml = testXml .. 'testTwoValue'
testXml = testXml .. '</testTwo>'
testXml = testXml .. '</testOne>'


local parsedXml = xml:ParseXmlText(testXml)


if parsedXml.testOne == nil then error("Node not created") end
if parsedXml.testOne:name() ~= "testOne" then error("Node name not set") end
if parsedXml.testOne.testTwo == nil then error("Child node not created") end
if parsedXml.testOne.testTwo:name() ~= "testTwo" then error("Child node name not set") end
if parsedXml.testOne.testTwo:value() ~= "testTwoValue" then error("Node value not set") end
if parsedXml.testOne.testTwo.test_Four:value() ~= "testFourValue" then error("Second child node value not set") end
if parsedXml.testOne["@param"] ~= "param1value" then error("Parameter not set") end
if parsedXml.testOne.testTwo["@paramTwo"] ~= "param2value" then error("Second child node parameter not set") end
if parsedXml.testOne.testTwo.test_Four["@something"] ~= "else" then error("Deepest node parameter not set") end

-- duplicate names tests
if parsedXml.testOne.testTwo.testThree[1]:value() ~= "testThreeValue" then error("First of duplicate nodes value not set") end
if parsedXml.testOne.testTwo.testThree[2]:value() ~= "testThreeValueTwo" then error("Second of duplicate nodes value not set") end
if parsedXml.testOne.testTwo.testThree[2]["@duplicate"][1] ~= "one" then error("First of duplicate parameters not set") end
if parsedXml.testOne.testTwo.testThree[2]["@duplicate"][2] ~= "two" then error("Second of duplicate parameters not set") end
   
-- node functions test
local node = require("xml").newNode("testName")

if node:name() ~= "testName" then error("Node creation failed") end

node:setName("nameTest")
if node:name() ~= "nameTest" then error("Name function test failed") end

node:setValue("valueTest")
if node:value() ~= "valueTest" then error("Value function test failed") end

local childNode = require("xml").newNode("parent")

node:addChild(childNode)

if type(node:children()) ~= "table" then error("children function test failed") end
if #node:children() ~= 1 then error("AddChild function test failed") end
if node:numChildren() ~= 1 then error("numChildren function test failed") end


node:addProperty("name", "value")

if type(node:properties()) ~= "table" then error("properties function test failed") end
if #node:properties() ~= 1 then error("Add property function test failed") end
if node:numProperties() ~= 1 then error("Num properties function test failed") end

print("Tests passed")