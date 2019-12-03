clc,clear all,close all
[G1,G2,G3] = readdata();%种类有三类，所以要求得两个投影向量
%%
%%1.想要求得类间散度矩阵B
mux1 = [mean(G1)]';
mux2 = [mean(G2)]';
mux3 = [mean(G3)]';
mat_mux123 = [mux1,mux2,mux3];%将上三个矩阵合成一个矩阵
xmu = [mean([mux1';mux2';mux3'])]';
B = zeros(4);
for i = 1:3
B = B + (mat_mux123(:,i) - xmu) * (mat_mux123(:,i) - xmu)';
end
B = 50 * B;
%%
%%2.想要求得类内散度矩阵E
G1_min = G1 - repmat(mux1',[50,1]);
E1 = zeros(4);
for i = 1:50
E1 = E1 + [G1_min(i,:)]' * G1_min(i,:);
end
G2_min = G2 - repmat(mux2',[50,1]);
E2 = zeros(4);
for i = 1:50
E2 = E2 + [G2_min(i,:)]' * G2_min(i,:);
end
G3_min = G3 - repmat(mux3',[50,1]);
E3 = zeros(4);
for i = 1:50
E3 = E3 + [G3_min(i,:)]' * G3_min(i,:);
end
E = E1 + E2 + E3;
%%
%%3.通过拉格朗日乘数法结论求投影向量，相当于求特征向量
lagrange_mat = inv(E) * B;
[X,lambda] = eig(lagrange_mat);
eigvector1 = X(:,1);%得到两个非零特征值对应的特征向量
eigvector2 = X(:,2);
fenmu1 = eigvector1' * (E / 147) * eigvector1;%求需要标准化的分母
fenmu2 = eigvector2' * (E / 147) * eigvector2;%求需要标准化的分母
w1 = eigvector1 * (1 / sqrt(fenmu1));%分类投影向量w1
w2 = eigvector2 * (1 / sqrt(fenmu2));%分类投影向量w2














