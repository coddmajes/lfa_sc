n_sample=100;
datapath='USPS Data/';
train_data=load([datapath 'USPS_Train_Data.mat']);
n_sample=min(n_sample,size(train_data.Train_Data,2));
train_data=train_data.Train_Data(:,1:n_sample);
% train_data=load([datapath 'train_data.mat']);
% n_sample=min(n_sample,size(train_data.train_data,2));
% train_data=train_data.train_data(:,1:n_sample);
sp_code=load('USPS Data/Sparse_Coef2.mat'); sp_code=sp_code.Train_Set_sparse_vector(:,1:n_sample);
% sp_code=load('USPS Data/coef_2000.mat'); sp_code=sp_code.sp(:,1:n_sample);
dict=load('USPS Data/Dictionary2.mat'); dict=dict.Dict;
learning_rate.alpha=10000;
learning_rate.t0=10;
learning_rate.max_change=0.1;
network=lista_train(train_data,dict,sp_code,0.5,3,1,learning_rate,1e-7,3);
disp('Saving.');
save('trained_network/lista_network.mat','network');