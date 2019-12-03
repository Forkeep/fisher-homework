clc,clear all,close all
rain1 = [-1.9,-6.9,5.2,5,7.3,6.8,0.9,-12.5,1.5,3.8]';%第1类因素x1
rain2 = [3.2,10.4,2,2.5,0,12.7,-15.4,-2.5,1.3,6.8]';%第1类因素x2
unrain1 = [0.2,-0.1,0.4,2.7,2.1,-4.6,-1.7,-2.6,2.6,-2.8]';%第2类因素x1
unrain2 = [6.2,7.5,14.6,8.3,0.8,4.3,10.9,13.1,12.8,10]';%第2类因素x1
G1 = [rain1,rain2];
G2 = [unrain1,unrain2];
G = [G1;G2];
%%
%%1.想要求得类间散度矩阵B
mux1 = [mean(G1)]';
mux2 = [mean(G2)]';
mat_mux123 = [mux1,mux2];%将上两个矩阵合成一个矩阵
xmu = [mean([mux1';mux2'])]';
B = zeros(2);
for i = 1:2
B = B + (mat_mux123(:,i) - xmu) * (mat_mux123(:,i) - xmu)';
end
B = length(rain1) * B;
%%
%%2.想要求得类内散度矩阵E
G1_min = G1 - repmat(mux1',[length(rain1),1]);
E1 = zeros(2);
for i = 1:length(rain1)
E1 = E1 + [G1_min(i,:)]' * G1_min(i,:);
end

G2_min = G2 - repmat(mux2',[length(rain1),1]);
E2 = zeros(2);
for i = 1:length(rain1)
E2 = E2 + [G2_min(i,:)]' * G2_min(i,:);
end

E = E1 + E2;
%%
%%3.通过拉格朗日乘数法结论求投影向量，相当于求特征向量
lagrange_mat = inv(E) * B;
[X,lambda] = eig(lagrange_mat);
eigvector = X(:,2);%得到一个非零特征值对应的特征向量
fenmu = eigvector' * (E / 18) * eigvector;%求需要标准化的分母
w = eigvector * (1 / sqrt(fenmu))%分类投影向量w
%%
%%4.预测待验证数据，判决该归为哪一类
x_disc = [0.6,3.0]';
y = w' * x_disc;
d_G1 = abs(y - w' * mux1);
d_G2 = abs(y - w' * mux2);
if(d_G1 < d_G2)
    disp('判决为明天下雨');
else disp('判决为明天不下雨');
end
%%
%%5.绘制图像观察分类判决情况
xplot = [-15:1:10];
yplot = (w(2) / w(1)) * xplot;%作出投影向量所在的直线
plot(xplot,yplot);
% xlim([-15,10]),ylim([-20,15])
hold on
species2 = {'下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨',...
    '不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨'}';
gscatter(G(:,1), G(:,2), species2,'rgb','osd');
xlabel('湿度差x1');
ylabel('气温差x2');
%%
%%6.计算回报误判率
n = 0;%误判个数
for i = 1:length(rain1)%G1误判为G2的个数
d1_G1 = abs(w' * [G1(i,:)]' - w' * mux1);
d1_G2 = abs(w' * [G1(i,:)]' - w' * mux2);
    if(d1_G1 > d1_G2)
        n = n + 1;
    end
end

for i = 1:length(rain1)%加上G2误判为G1的个数
d2_G1 = abs(w' * [G2(i,:)]' - w' * mux1);
d2_G2 = abs(w' * [G2(i,:)]' - w' * mux2);
    if(d2_G1 < d2_G2)
        n = n + 1;
    end
end
wrong_pct = n / (length(rain1) + length(unrain1));
fprintf('回报误判率为：%f\n',wrong_pct);







