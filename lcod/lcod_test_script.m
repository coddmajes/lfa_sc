append='_31';
load(strcat('trained_network/lcod_network',append,'.mat'));
datapath='USPS data/';
test_data=load([datapath 'USPS_Test_Data.mat']);
test_data=test_data.Test_Data;
train_data=load([datapath 'USPS_Train_Data.mat']);
train_data=train_data.Train_Data;
Wd=load('USPS Data/Dictionary2.mat');
Wd=Wd.Dict;
base_sp_code=load('USPS Data/Sparse_Coef2.mat');
base_sp_code=base_sp_code.Train_Set_sparse_vector;
sp_code=zeros(size(base_sp_code));
L=max(eig(Wd'*Wd))+1;
S=eye(size(Wd'*Wd))-(Wd'*Wd);
%%
for j=1:200
  %[base_sp_code(:,j),num_iter]=cod(train_data(:,j),Wd, S, 0.5, 0.001);
  %sp_code(:,j)=lcod_fprop(test_data(:,j),Wd',S,0.0001,100);
  base_sp_code(:,j)=cod(test_data(:,j),Wd,S,0.005,0.001,Inf);
  %sp_code(:,j)=cod(test_data(:,j),Wd,S,0.005,0.0001);
  sp_code(:,j)=lcod_fprop(test_data(:,j),network.We,network.S,network.theta,network.T);
  %%
  xp=Wd*sp_code(:,j);
  subplot(3,2,1);
  imshow(reshape(test_data(:,j),16,16));
  subplot(3,2,2);
  imshow(reshape(xp,16,16));
  %plot(train_data(:,j));
  %title('Input signal');
  subplot(3,2,3);
  plot(base_sp_code(:,j));
  title('Ground truth sparse code');
  subplot(3,2,4);
  plot(Wd*base_sp_code(:,j));
  title('Reconstructed signal');
  subplot(3,2,5);
  plot(sp_code(:,j));
  title('LCOD sparse code');
  subplot(3,2,6);
  plot(Wd*sp_code(:,j));
  title('Reconstructed signal');
  pause;
end
err=abs(base_sp_code-sp_code);