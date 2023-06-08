NP=100;%种群规模
Pm=0.5;%交叉概率
F=0.5;%缩放因子
G=50;%代数
D=10;%维度
ma=10;%最大值
mi=-10;%最小值
for x=1:15
f=rand([NP,D]);
for i=1:NP
    for j=1:D
          f(i,j)=mi+(ma-mi)*f(i,j);
    end
    %f1(i)=Function(f(i),x);
end
Bf=zeros(NP,D);
for l=1:G
   %变异
   for i=1:NP
      f1(i)=Function(f(i),x);
      n = randperm(NP,4);
      if n(1)==i
        n(1)=n(4);
      end
      if n(2)==i
        n(2)=n(4);
      end
      if n(3)==i
        n(3)=n(4);
      end
      Bf(i,:)=f(n(1),:)+F*(f(n(2),:)-f(n(3),:));
      for m = 1:D
        if Bf(i,m)<mi||Bf(i,m)>ma
            Bf(i,m)=rand*(ma-mi)+mi;
        end
      end
      %交叉
      for j=1:D
          r = randi([1,D]);
          rr=rand(1);
          if (rr<Pm || j==r)
             nf(i,j)=Bf(i,j);
          else
             nf(i,j)=f(i,j);
          end
      end
      f2(i)=Function(nf(i),x);
   end
   %选择
   for i=1:NP
       if f2(i)<=f1(i)
           f(i,:)=nf(i,:);
       end
       fit(i)=Function(f(i),x);
   end
   mafit(x,l)=max(fit);
   mifit(x,l)=min(fit);
   mefit(x,l)=mean(fit);
end
figure;
minfit(x)=min(mifit(x));
plot(mifit(x,:));
set (gca,'Yscale','log');
xx=strcat('fit', num2str(x),'.png');
saveas(gcf, xx);
end
boxplot(minfit);
set (gca,'Yscale','log');