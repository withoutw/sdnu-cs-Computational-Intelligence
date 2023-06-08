% 从文件中读取数据
load('Results_A.mat');
dataA=Gbest_History;
load('Results_B.mat');
dataB=Gbest_History;
load('Results_C.mat');
dataC=Gbest_History;
load('Results_D.mat');
dataD=Gbest_History;
% 计算每个算法的全局最佳适应度数值
bestA = min(dataA, [], 2);
bestB = min(dataB, [], 2);
bestC = min(dataC, [], 2);
bestD = min(dataD, [], 2);
% 计算收敛精度的均值和方差
fprintf('mean:\n');
MeanA = mean(bestA);
fprintf('meanA = %d\n',MeanA);
MeanB=mean(bestB);
fprintf('meanB = %d\n',MeanB);
MeanC = mean(bestC);
fprintf('meanC = %d\n',MeanC);
MeanD = mean(bestD);
fprintf('meanD = %d\n',MeanD);
fprintf('std:\n');
stdA = std(bestA);
stdB = std(bestB);
stdC = std(bestC);
stdD = std(bestD);
fprintf('STDA = %d\n',stdA);
fprintf('STDB = %d\n',stdB);
fprintf('STDC = %d\n',stdC);
fprintf('STDD = %d\n',stdD);
% 输出极值
maxA=max(bestA);
maxB=max(bestB);
maxC=max(bestC);
maxD=max(bestD);
fprintf('max:\n');
fprintf('maxA = %d\n',maxA);
fprintf('maxB = %d\n',maxB);
fprintf('maxC = %d\n',maxC);
fprintf('maxD = %d\n',maxD);
maxA=min(bestA);
maxB=min(bestB);
maxC=min(bestC);
maxD=min(bestD);
fprintf('min:\n');
fprintf('maxA = %d\n',maxA);
fprintf('maxB = %d\n',maxB);
fprintf('maxC = %d\n',maxC);
fprintf('maxD = %d\n',maxD);
% 将每个算法的最佳收敛精度结果放在一个矩阵中
data=randn(10,4);
data(:,1)=bestA;
data(:,2)=bestB;
data(:,3)=bestC;
data(:,4)=bestD;
% 绘制箱线图
figure;
boxplot(data);
hold on;
xlabel('算法');
ylabel('适应度');
xticklabels({'A','B','C','D'});
saveas(gcf, 'convergence accuracy.png');
% 绘制收敛曲线
figure;
ConvergenceA = mean(dataA,1,"double");
ConvergenceB = mean(dataB,1,"double");
ConvergenceC = mean(dataC,1,"double");
ConvergenceD = mean(dataD,1,"double");
x = linspace(1,300000,300000);
p=plot(x,ConvergenceA,x,ConvergenceB,x,ConvergenceC,x,ConvergenceD);
for i=1:4
   p(i).LineWidth=1.5;
   p(i).Marker='.';
   p(i).MarkerIndices=1:50000:300000;
   p(i).MarkerSize=10;
end
set (gca,'Yscale','log');
legend('A','B','C','D');
hold on;
title('Convergence');
xlabel('Fitness Evalution (FEs)');
ylabel('Mean Best Fitness');
saveas(gcf, 'convergence.png');
% 进行Mann-Whitney U检验
[p_AB,h_AB] = ranksum(bestA, bestB);
[p_AC,h_AC] = ranksum(bestA, bestC);
[p_AD,h_AD] = ranksum(bestA, bestD);
[p_BC,h_BC] = ranksum(bestB, bestC);
[p_BD,h_BD] = ranksum(bestB, bestD);
[p_CD,h_CD] = ranksum(bestC, bestD);
fprintf('Mann-Whitney U Test :\n');
fprintf('A vs B: p_AB = %d,H=%d\n', p_AB,h_AB);
fprintf('A vs C: p_AC = %d,H=%d\n', p_AC,h_AC);
fprintf('A vs D: p_AD = %d,H=%d\n', p_AD,h_AD);
fprintf('B vs C: p_BC = %d,H=%d\n', p_BC,h_BC);
fprintf('B vs D: p_BD = %d,H=%d\n', p_BD,h_BD);
fprintf('C vs D: p_CD = %d,H=%d\n', p_CD,h_CD);
