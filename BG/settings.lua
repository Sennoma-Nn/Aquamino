local pic=gc.newCanvas(120,1440)
gc.setScissor(0,0,120,1440)
gc.setCanvas(pic)
gc.setColor(1,1,1)
gc.rectangle('fill',10,0,100,600) gc.rectangle('fill',10,840,100,600)
gc.setCanvas()
gc.setScissor()
local bg={}
function bg.init()
    bg.time=0
end
function bg.update(dt)
    bg.time=bg.time+dt
end
function bg.draw()
    gc.clear(.05,.05,.05)
    gc.setColor(1,1,1,.16)
    for i=0,15 do
        local p=sin((bg.time%8/4+i/16)*math.pi)
        gc.draw(pic,-960+120*i,-720+120*p)
    end
end
return bg