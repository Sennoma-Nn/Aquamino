local sqrt2=1.4142135623731

local bg={}
function bg.init(BPM,offset,offsetBeat,introBeat,pcAnimTMax)
    bg.BPM,bg.time,bg.introBeat=BPM or 120,offset or 0,introBeat or 128
    bg.offsetBeat=offsetBeat or 0
    bg.pc=0 bg.postpc=0 bg.pcAnimT=0 bg.pcAnimTMax=pcAnimTMax or .25
end
function bg.update(dt)
    bg.time=bg.time+dt
    bg.pcAnimT=max(bg.pcAnimT-dt,0)
end
function  bg.newProgress(pc)
    bg.postpc=bg.pc*(1-bg.pcAnimT/bg.pcAnimTMax)+bg.postpc*(bg.pcAnimT/bg.pcAnimTMax)
    bg.pc=pc bg.pcAnimT=bg.pcAnimTMax
end
local alpha,beat,m,bt,clap, k
local p=8
function bg.draw()
    beat=bg.time*bg.BPM/60-bg.offsetBeat
    m=1-beat%1
    bt=beat-bg.introBeat
    if bg.pc==1 then gc.clear(.15,.145,.09) else gc.clear(0,0,0) end
    if beat<bg.introBeat then
        if beat<bg.introBeat-4 then
        gc.setColor(1,1,1,m/8)
        --gc.rectangle('fill',-1000,-600,2000,1200)
        gc.setLineWidth(36)
        gc.circle('line',0,0,450)
        end
    else
        gc.setColor(1,1,1,m/4)
        gc.rectangle('fill',-1000,-600,2000,1200)
        if bg.pc==1 then gc.setColor(1,.96,.6) else gc.setColor(1,1,1) end
        k=math.log(beat%4+1,2)
        gc.setLineWidth(36+36*k)
        gc.rectangle('line',-960*k,-960*k,1920*k,1920*k)
        for i=0,3 do for j=1,p do
            gc.push()
            gc.rotate( ( (bt*.75+j)%p/p)*2*math.pi*(i%2*2-1) )
            gc.circle('fill',540+40*max(2*m-1,0)+180*i,0,25*(1+.4*i)*min(bt*4,1),4)
            gc.pop()
        end end
    end

    if bg.pc==1 then gc.setColor(1,.96,.6) else gc.setColor(1,1,1) end
    gc.setLineWidth(40+(beat>=bg.introBeat and (20*max(2*m-1,0)) or 0))
    local P=bg.pc*(1-bg.pcAnimT/bg.pcAnimTMax)+bg.postpc*(bg.pcAnimT/bg.pcAnimTMax)
    gc.arc('line','open',0,0,450,-math.pi/2,(P*2-.5)*math.pi,120)
end
return bg