local T={}
function T.attend(list,atd)
    for i=1,#atd do list[l+i]=atd[i] end
end
function T.combine(a,b)--b中所有元素放入a
    if a then
        if b then for k,v in pairs(b) do a[k]=v end end
        return true
    else return false end
end
function T.copy(list,mode)
    if not mode then mode='all' end
    local clone={}
    for k,v in pairs(list) do
    if type(v)=='table' then
        if mode=='all' then clone[k]=T.copy(v,mode) end
    else clone[k]=v end
    end
    return clone
end
function T.include(a,b)--检测a中有无b元素
    if type(a)=='table' and b then
        for k,v in pairs(a) do
            if type(b)=='table' then if T.isEqual(b,v) then return k end
            elseif b==v then return k end
        end
    end
end
function T.isEqual(a,b)--两列表是否相等
    for k,va in pairs(a) do
        local vb=b[k]
        if not va==vb and type(va)=='table' and type(vb)=='table' and depth>0 then
            if not T.isEqual(va,vb) then return false end
        elseif va~=vb then return false end
    end
    return true
end
function T.shuffle(list)
    local mess=T.copy(list)
    for i=#list,1,-1 do
        table.insert(mess,table.remove(mess,math.random(i)))
    end
    return mess
end
function T.shuffleForNonIntTable(list)--WIP
    local key,mess={},{}
    for k,v in pairs(list) do key[#key+1]=k end
    for i=#key,1,-1 do
        table.insert(key,table.remove(key,math.random(i)))
    end
    for i=1,#key do mess[key[i]]=list[key[i]] end
    return mess
end

return T