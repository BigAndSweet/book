clear all;
close all;
load data
start=500;
T=100;
risklessrate=3/100/365;
[n,m]=size(data);


%����1 ���µ��֣������λ
 weight=[];
jinzhi=ones(n,1);
for i=start:n
    %������չ�Ʊ����
    ret=data(i,:)./data(i-1,:);
    if isempty(weight)
        jinzhi(i)=jinzhi(i-1);
    else
       %������ջ���ֵ
        weight=weight.*ret(today>0)';
       jinzhi(i)=sum(weight); 
    end
    if ismember(i,posx)%�жϵ����Ƿ���ĩ
       %�������й�Ʊ,ѡ��200��������ǰ�Ѿ����еĹ�Ʊ
       today=data(i-200,:);
       temp=today(today>0);
       price=data(i,today>0);
       num=length(temp);
       aa=rand(num,1);
       %��������λ
       weight=aa./sum(aa)*jinzhi(i);

    end
    
end


figure(1)
plot(benchmark./benchmark(503),'blue')
hold on
plot(jinzhi,'red')




jinzhi1=ones(n,1);
%����2 ���µ��֣�ƽ����λ
weight=[];
for i=start:n
    %������չ�Ʊ����
    ret=data(i,:)./data(i-1,:);
    if isempty(weight)
        jinzhi1(i)=jinzhi1(i-1);
    else
        weight=weight.*ret(today>0)';
       jinzhi1(i)=sum(weight); 
    end
    if ismember(i,posx)%�жϵ����Ƿ���ĩ
       %�������й�Ʊ,ѡ��200��������ǰ�Ѿ����еĹ�Ʊ
       today=data(i-200,:);
       temp=today(today>0);
       num=length(temp);
       %ƽ������ֲ�
       weight=ones(num,1)/num*jinzhi1(i);
    end
    
end
figure(2)
plot(benchmark./benchmark(503),'blue')
hold on
plot(jinzhi1,'red')

%����3 ���µ��֣�ƽ����λ,��200�վ��߾����Ƿ�����ֽ�
jinzhi2=ones(n,1);
weight=[];
for i=start:n
    %������չ�Ʊ����
    ret=data(i,:)./data(i-1,:);
    if isempty(weight)
        jinzhi2(i)=jinzhi2(i-1);
    else
       ret2= ret(today>0);
       %���޷������渳ֵ����Ӧ�ʲ�
       ret2(compare)=risklessrate+1;
       weight=weight.*ret2';
       jinzhi2(i)=sum(weight); 
    end
    if ismember(i,posx)%�жϵ����Ƿ���ĩ
       %�������й�Ʊ,ѡ��200��������ǰ�Ѿ����еĹ�Ʊ
       today=data(i-200,:);
       ma200=sum(data(i-199:i,:))/200;
       temp=today(today>0);
       temp2=ma200(today>0);
       price=data(i,today>0);
       %�ҵ��������̼�С��200�վ��ߵ��ʲ���index
       compare=find(price<temp2);
       num=length(temp);
       weight=ones(num,1)/num*jinzhi2(i);
    end
    
end
figure(3)
plot(benchmark./benchmark(503),'blue')
hold on
plot(jinzhi1,'red')
hold on
plot(jinzhi2,'green')

%����4 ���µ��֣������λ,�ظ�100��

k=0;
result=zeros(n,T);
while k<T
 weight=[];
jinzhi3=ones(n,1);
k=k+1;
for i=start:n
    %������չ�Ʊ����
    ret=data(i,:)./data(i-1,:);
    if isempty(weight)
        jinzhi3(i)=jinzhi3(i-1);
    else
        
        weight=weight.*ret(today>0)';
       jinzhi3(i)=sum(weight); 
    end
    if ismember(i,posx)%�жϵ����Ƿ���ĩ
       %�������й�Ʊ,ѡ��200��������ǰ�Ѿ����еĹ�Ʊ
       today=data(i-200,:);
       temp=today(today>0);
       price=data(i,today>0);
       num=length(temp);
       aa=rand(num,1);

       weight=aa./sum(aa)*jinzhi3(i);

    end
    
end
result(:,k)=jinzhi3;
disp(k);
end
benchmark=benchmark./benchmark(503);
figure(4)
plot(benchmark(503:end),'blue')
hold on
plot(result(503:end,:),'red')
hold on
plot(jinzhi2(503:end),'green')