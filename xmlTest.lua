local xml = require("xmlSimple").newParser()
local testXml = io.open('/home/a/Desktop/Lua-Simple-XML-Parser-master/files/utf8.xml'):read('*all')
local parsedXml,err = xml:ParseXmlText(testXml)
function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end
function n(num)
	local str=""
	for i=0,num,1 do
		str=str.."-----"
	end
	return str
end
function p(var,num)
	if var==nil then		
		print(n(num),"nil")
	else
		if type(var)=="table" then
			for k,v in pairs(var) do
				print(n(num),k)
				num=num+1
				p(v,num)
				num=num-1
			end
		else
			print(n(num),k)
		end
	end
end
if parsedXml~=nil and err==nil then
print_r(parsedXml)
--p(parsedXml,0)
else
print(err)
end
