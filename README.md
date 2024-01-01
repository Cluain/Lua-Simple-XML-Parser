# xml.lua

simple xml parser for lua. based on one [abandoned
project](https://github.com/Cluain/Lua-Simple-XML-Parser), that was based on
some other abandoned project.

## installation
1.  Copy the xmlSimple.lua file to your project.
2.  Create a local variable `local xml = require("xmlSimple.lua").newParser()`
3.  Read xml using `xml:ParseXmlText(xmlString)` or `xml:loadFile(xmlFilename, base)`

## Parsing XML

``` xml
<test one="two">
    <three four="five" four="six"/>
    <three>eight</three>
    <nine ten="eleven">twelve</nine>
</test>
```

You can access values in two ways.

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
