# Installation

1.  Copy the xmlSimple.lua file to your project.
2.  Create a local variable `local xml = require("xmlSimple.lua").newParser()`
3.  Read xml using `xml:ParseXmlText(xmlString)` or `xml:loadFile(xmlFilename, base)`

# Parsing XML

``` xml
<test one="two">
    <three four="five" four="six"/>
    <three>eight</three>
    <nine ten="eleven">twelve</nine>
</test>
```
You can access values in two ways:

Using the simple method:

``` lua
xml.test["@one"] == "two"
xml.test.nine["@ten"] == "eleven"
xml.test.nine:value() == "twelve"
xml.test.three[1]["@four"][1] == "five"
xml.test.three[1]["@four"][2] == "six"
xml.test.three[2]:value() == "eight"
```

or if your XML is a little bit more complicated you can do it like this:

``` lua
xml:children()[1]:name() == "test"
xml:children()[1]:children()[2]:value() == "eight"
xml:properties()[1] == {name = "one", value = "two"}
```

# Limitations

There's no support for namespaces. When I see namespaces I immediately start to remember days when I worked at corporate. We had to use namespaces only because XML was so convoluted we would not be able to handle it without them. In the end XML parsing took longer for some APIs then actual logic of the API.
If you're in this situation it is better to step back and do something about it rather than asking for namespace support.
I am using this module to read fairly simple XML. Even if it is a large XML string, the structure is still simple, so I was not able to test it properly. Please create a new Issue if you spot a problem. 
Please take a loook at xmlTest.lua for an example of use.

# Final notes

This is a modified version of [Corona-XML-Module](https://github.com/jonbeebe/Corona-XML-Module) by Jonathan Beebe which in turn is based on Alexander Makeev's Lua-only XML parser found [here](http://lua-users.org/wiki/LuaXml)
