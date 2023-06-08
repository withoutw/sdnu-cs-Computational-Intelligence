NP=40;%种群大小
G=3000;%迭代次数
c1=0.5;
c2=1.5;%系数
D=30;%维度
x=1;%函数代号
ve=rand([NP,D]);
mi=-5;
ma=5;%搜索空间
vmax=1;%飞行速度限制
for i=1:NP %初始化种群
    for j=1:D
          ve(i,j)=mi+(ma-mi)*ve(i,j);
    end 
    pbest(i)=Function(ve(i),x);
end
v=zeros(NP,D);
gbestv=zeros(D);
gbest=inf;
pbestv=ve;
for l=1:G
    for i=1:NP%更新每个点的最小值
        f(i)=Function(ve(i),x);
        if f(i)<pbest(i)
            pbest(i)=f(i);
            pbestv(i)=ve(i);
        end
    end
    minf(l)=min(f);%更新全局最小值
    if minf(l)<gbest
        gbest=minf(l);
        r=find(f==minf(l));
        gbestv=ve(r);
    end
    %更新速度
    v=v+c1*rand*(pbestv-ve)+c2*rand*(gbestv-ve);
    v(v>vmax)=vmax;
    v(v<-vmax)=vmax*-1;
    ve=ve+v;
    ve(ve>ma)=ma;
    ve(ve<mi)=mi;
end
plot(minf);