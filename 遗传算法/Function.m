function fitness = Function(x,funcId)
% 主函数参数说明
% x     : 表示问题的解向量, 要求x为行向量
% funcId: 表示测试函数的编号(共15个测试函数)


%% 0. 准备工作
% 判断x向量的形式
[~,D]= size(x);  % 获取x的行数

% 将列向量转换为行向量
if D==1 %
    x=x';
end

%% 1.选择测试函数: 获取函数调用句柄
%-----------------------------------------------------
% Unimodal function 单峰函数
if funcId==1
    fhd=str2func('sphere_func'); %等价价于语句 fhd =@spher_func
elseif funcId==2
    fhd=str2func('schwefel_102'); %
elseif funcId==3
    fhd=str2func('schwefel_102_noise_func');
elseif funcId==4
    fhd= str2func('schwefel_2_21');
elseif funcId==5
    fhd= str2func('schwefel_2_22');
elseif funcId==6
    fhd=str2func('high_cond_elliptic_func');
elseif funcId==7
    fhd=str2func('step_func');

% Multimodal function 多峰函数
elseif funcId==8
    fhd=str2func('Schwefel_func');
elseif funcId==9
    fhd=str2func('rosenbrock_func');
elseif funcId==10
    fhd=str2func('quartic');
elseif funcId==11
    fhd=str2func('griewank_func');
elseif funcId==12
    fhd=str2func('ackley_func');
elseif funcId==13
    fhd=str2func('rastrigin_func');
elseif funcId==14
    fhd=str2func('rastrigin_noncont');
elseif funcId==15
    fhd=str2func('weierstrass');
else
    disp('测试有误,测试函数范围1—15');
    pause; exit(1);
end

%% 计算测试函数的数值(作为个体的适应度数值)
fitnessvalue=feval(fhd,x);
fitness = fitnessvalue';
end


%% ------------------定义基准测试函数(子函数)------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%  1.Unimodal单峰函数   %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 	1.Sphere Function  完全可分
function f=sphere_func(x)
f=sum(x.^2,2);
end

%% 	2.Schwefel's Problem 1.2  完全不可分
function f=schwefel_102(x)
[~,D]=size(x);

f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
end

%% 3.Schwefel's Problem 1.2 with Noise 完全不可分
function f=schwefel_102_noise_func(x)
[ps,D]=size(x);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
f=f.*(1+0.4.*abs(normrnd(0,1,ps,1)));
end

%% 	4.Schwefel's Problem 2.21  取决于绝对值最大值
function f=schwefel_2_21(x)
f= max(abs(x),[],2);
end

%% 	5.Schwefel's Problem 2.22  完全可分函数
function f=schwefel_2_22(x)
% [ps,D]=size(x);

f= sum(abs(x),2) + prod(abs(x),2);
end

%% 	6.High Conditioned Elliptic Function  完全可分函数
function f=high_cond_elliptic_func(x)
[~,D]=size(x);

a=1e+6;
f=0;
for i=1:D
    f=f+a.^((i-1)/(D-1)).*x(:,i).^2;
end
end

%% 	7.Step Function完全可分函数
function f=step_func(x)

% [ps,D]=size(x);

f= sum(floor(x+0.5).^2,2);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% 2.Multimodal多峰函数  %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 8.Schwefel Function 完全可分函数
function f= Schwefel_func(x)
[~,D]=size(x);

f=418.982887272433799*D - sum(x.*sin(sqrt(abs(x))),2);
end

%% 9.Rosenbrock's Function 相邻向量直接相关 不相邻间接相关 完全不可分
function f=rosenbrock_func(x)
[~,D]=size(x);

f=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);

end
%% 10.Quartic函数（最小处位置很浅，很难高精确度找到）完全可分函数
function f= quartic(x)
[~,D]=size(x);

v=1:D;
xq =x.^4;

f = sum(v.*xq,2);
end

%% 11. Griewank's Function 完全不可分函数
function f=griewank_func(x)

[~,D]=size(x);

f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
f=sum(x.^2,2)./4000-f+1;
end

%% 12.Ackley's Function 完全可分函数
function f=ackley_func(x)

[~,D]=size(x);

f=sum(x.^2,2);
f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);

end
%% 13.Rastrign's Function 完全可分
function f=rastrigin_func(x)
% [ps,D]=size(x);

f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
end

%% 14.Rastrign's noncontinue Function 完全可分变量
function f=rastrigin_noncont(x)
% [ps,D]=size(x);

x=(abs(x)<0.5).*x+(abs(x)>=0.5).*(round(x.*2)./2);

f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
end

%% 	15.Weierstrass Function 完全可分
function f=weierstrass(x)
[~,D]=size(x);
x=x+0.5;
a = 0.5;
b = 3;
kmax = 20;
c1(1:kmax+1) = a.^(0:kmax);
c2(1:kmax+1) = 2*pi*b.^(0:kmax);
f=0;
c=-w(0.5,c1,c2);

for i=1:D
    f=f+w(x(:,i)',c1,c2);
end
f=f+c*D;
end

% 子函数
function y = w(x,c1,c2)
y = zeros(length(x),1);
for k = 1:length(x)
    y(k) = sum(c1 .* cos(c2.*x(:,k)));
end
end
