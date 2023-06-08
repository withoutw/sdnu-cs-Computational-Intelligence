n=100;
NP=50;%种群规模
x=1;%函数序号
L=20;%二进制长度
Pc=0.8;%交叉概率
Pm=0.01;%变异概率
G=1000;%代数
D=10;%维度
ma=1;

for x=1:15
f=randi([0 1],[NP,D,L]);
for l=1:G
    for i=1:NP
        for k=1:D
            U=f(i,k,:);
            o(k) = 0;
            for j = 1:L
              o(k) = U(j)*2^(j-1)+o(k);
            end
        end
        fit(i)=Function(o,x);
    end
    mafit(x,l)=max(fit);
    mifit(x,l)=min(fit);
    meanfit(x,l)=mean(fit);
    sumfit(l) = mean(fit)*NP;
    for i=1:NP
        fiti(i)=sumfit(l)-fit(i);
    end
    c = unifrnd(0,1,NP,1);
    sum_fit = sum(fiti);
    for i=1:NP
        fitv(i)=fiti(i)/sum_fit;
    end
    for i=2:NP
        fitv(i)=fitv(i-1)+fitv(i);
    end
    ms = sort(c);
    fitii = 1;
    newi = 1;
    while newi <= NP
        if (ms(newi)) < fitv(fitii)
            nf(newi,1:D,1:L) = f(fitii,1:D,:);
            newi = newi+1;
        else
            fitii = fitii+1;
        end
    end
    for i = 1:2:NP
        p = rand;
        if p < Pc
            q = randi([0 1],[1,L]);
            qb=randi(D);
            for j = 1:L
                if q(j)==1
                    t = nf(i+1,qb,j);
                    nf(i+1,qb,j) =nf(i,qb,j);
                    nf(i,qb,j) = t;
                end
            end
        end
    end
    p = rand;
    if p<Pc
        d=randi([1 D]);
        h = randi([1,NP]);
        g = randi([1,L]);
        nf(h,D,g) =~ nf(h,D,g);
    end
    f=nf;
end
miii(x)=mifit(x,G);
figure;
plot(mifit(x,:));
set (gca,'Yscale','log');
xx=strcat('fit', num2str(x),'.png');
saveas(gcf, xx);
end
boxplot(miii);
set (gca,'Yscale','log');