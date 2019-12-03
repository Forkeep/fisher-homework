clc,clear all,close all
rain1 = [-1.9,-6.9,5.2,5,7.3,6.8,0.9,-12.5,1.5,3.8]';
rain2 = [3.2,10.4,2,2.5,0,12.7,-15.4,-2.5,1.3,6.8]';
unrain1 = [0.2,-0.1,0.4,2.7,2.1,-4.6,-1.7,-2.6,2.6,-2.8]';
unrain2 = [6.2,7.5,14.6,8.3,0.8,4.3,10.9,13.1,12.8,10]';
%%
% G1 = [rain1,rain2];
% G2 = [unrain1,unrain2];
% meanG1 = mean(G1);
% meanG2 = mean(G2);
% x1 = [0.6,3.0]';
% invc1 = inv(cov(G1));
% invc2 = inv(cov(G2));
% ma_dist1 = sqrt([x1 - meanG1']' * invc1 * [x1 - meanG1'])
% ma_dist2 = sqrt([x1 - meanG2']' * invc2 * [x1 - meanG2'])
%%
G1 = [rain1,rain2];
G2 = [unrain1,unrain2];
G = [G1;G2];
% meanG1 = mean(G1);
% meanG2 = mean(G2);
x1 = [0.6,3.0];
% invc1 = inv(cov(G1));
% invc2 = inv(cov(G2));
% ma_dist1 = sqrt([x1 - meanG1']' * invc1 * [x1 - meanG1'])
% ma_dist2 = sqrt([x1 - meanG2']' * invc2 * [x1 - meanG2'])

% species1 = [1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0]';
species2 = {'下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨','下雨',...
    '不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨','不下雨'}';
gscatter(G(:,1), G(:,2), species2,'rgb','osd');
xlabel('湿度差x1');
ylabel('气温差x2');
lda = fitcdiscr(G(:,1:2),species2);
r=predict(lda,x1)












