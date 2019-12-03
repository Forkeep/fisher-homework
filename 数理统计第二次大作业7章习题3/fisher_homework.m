clc,clear all,close all
rain1 = [-1.9,-6.9,5.2,5,7.3,6.8,0.9,-12.5,1.5,3.8]';%��1������x1
rain2 = [3.2,10.4,2,2.5,0,12.7,-15.4,-2.5,1.3,6.8]';%��1������x2
unrain1 = [0.2,-0.1,0.4,2.7,2.1,-4.6,-1.7,-2.6,2.6,-2.8]';%��2������x1
unrain2 = [6.2,7.5,14.6,8.3,0.8,4.3,10.9,13.1,12.8,10]';%��2������x1
G1 = [rain1,rain2];
G2 = [unrain1,unrain2];
G = [G1;G2];
%%
%%1.��Ҫ������ɢ�Ⱦ���B
mux1 = [mean(G1)]';
mux2 = [mean(G2)]';
mat_mux123 = [mux1,mux2];%������������ϳ�һ������
xmu = [mean([mux1';mux2'])]';
B = zeros(2);
for i = 1:2
B = B + (mat_mux123(:,i) - xmu) * (mat_mux123(:,i) - xmu)';
end
B = length(rain1) * B;
%%
%%2.��Ҫ�������ɢ�Ⱦ���E
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
%%3.ͨ���������ճ�����������ͶӰ�������൱������������
lagrange_mat = inv(E) * B;
[X,lambda] = eig(lagrange_mat);
eigvector = X(:,2);%�õ�һ����������ֵ��Ӧ����������
fenmu = eigvector' * (E / 18) * eigvector;%����Ҫ��׼���ķ�ĸ
w = eigvector * (1 / sqrt(fenmu))%����ͶӰ����w
%%
%%4.Ԥ�����֤���ݣ��о��ù�Ϊ��һ��
x_disc = [0.6,3.0]';
y = w' * x_disc;
d_G1 = abs(y - w' * mux1);
d_G2 = abs(y - w' * mux2);
if(d_G1 < d_G2)
    disp('�о�Ϊ��������');
else disp('�о�Ϊ���첻����');
end
%%
%%5.����ͼ��۲�����о����
xplot = [-15:1:10];
yplot = (w(2) / w(1)) * xplot;%����ͶӰ�������ڵ�ֱ��
plot(xplot,yplot);
% xlim([-15,10]),ylim([-20,15])
hold on
species2 = {'����','����','����','����','����','����','����','����','����','����',...
    '������','������','������','������','������','������','������','������','������','������'}';
gscatter(G(:,1), G(:,2), species2,'rgb','osd');
xlabel('ʪ�Ȳ�x1');
ylabel('���²�x2');
%%
%%6.����ر�������
n = 0;%���и���
for i = 1:length(rain1)%G1����ΪG2�ĸ���
d1_G1 = abs(w' * [G1(i,:)]' - w' * mux1);
d1_G2 = abs(w' * [G1(i,:)]' - w' * mux2);
    if(d1_G1 > d1_G2)
        n = n + 1;
    end
end

for i = 1:length(rain1)%����G2����ΪG1�ĸ���
d2_G1 = abs(w' * [G2(i,:)]' - w' * mux1);
d2_G2 = abs(w' * [G2(i,:)]' - w' * mux2);
    if(d2_G1 < d2_G2)
        n = n + 1;
    end
end
wrong_pct = n / (length(rain1) + length(unrain1));
fprintf('�ر�������Ϊ��%f\n',wrong_pct);







