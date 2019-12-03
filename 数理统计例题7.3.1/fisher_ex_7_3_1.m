clc,clear all,close all
[G1,G2,G3] = readdata();%���������࣬����Ҫ�������ͶӰ����
%%
%%1.��Ҫ������ɢ�Ⱦ���B
mux1 = [mean(G1)]';
mux2 = [mean(G2)]';
mux3 = [mean(G3)]';
mat_mux123 = [mux1,mux2,mux3];%������������ϳ�һ������
xmu = [mean([mux1';mux2';mux3'])]';
B = zeros(4);
for i = 1:3
B = B + (mat_mux123(:,i) - xmu) * (mat_mux123(:,i) - xmu)';
end
B = 50 * B;
%%
%%2.��Ҫ�������ɢ�Ⱦ���E
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
%%3.ͨ���������ճ�����������ͶӰ�������൱������������
lagrange_mat = inv(E) * B;
[X,lambda] = eig(lagrange_mat);
eigvector1 = X(:,1);%�õ�������������ֵ��Ӧ����������
eigvector2 = X(:,2);
fenmu1 = eigvector1' * (E / 147) * eigvector1;%����Ҫ��׼���ķ�ĸ
fenmu2 = eigvector2' * (E / 147) * eigvector2;%����Ҫ��׼���ķ�ĸ
w1 = eigvector1 * (1 / sqrt(fenmu1));%����ͶӰ����w1
w2 = eigvector2 * (1 / sqrt(fenmu2));%����ͶӰ����w2














