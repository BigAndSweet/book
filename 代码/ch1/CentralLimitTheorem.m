%ʤ��
p=0.9;
% �ظ��������
T=100000;
result=zeros(T,1);
for j=1:T
    x=rand(1);
    if x<=p
    result(j)=1;
    else
    result(j)=-1;    
    end
end
hist(result)

%�����ȡ10000�飬ÿ��1000������
dist=zeros(10000,1);
for i=1:10000
    randindx=randperm(T);
    dist(i)=sum(result(randindx(1:1000)));
end
hist(dist,1000)