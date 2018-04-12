function [xm]=PSO(fitnessf,N,c1,c2,wmax,wmin,M,D,infor,a,P,d,X)
format long;
A0=find(infor(:,1)~=0);
b0=size(A0,1);
for i=1:N/2
%     x(i,1)=d*rand+P(infor(A0(1,1),4),1);
%     x(i,2)=d*rand+P(infor(A0(1,1),4),2);
%     x(i,3)=rand*0.3;
    x(i,1)=d*rand-d/2+X(1,1);
    x(i,2)=d*rand-d/2+X(1,2);
    x(i,3)=rand*0.3-0.15+X(1,3);
    for j=1:D
        v(i,j)=randn;
    end
end
for i=N/2+1:N
    x(i,1)=d/2*rand+P(infor(A0(2,1),4),1);
    x(i,2)=d/2*rand+P(infor(A0(2,1),4),2);
    x(i,3)=rand*0.3;
    for j=1:D
        v(i,j)=randn;
    end
end
for k=1:N
    p(k)=fitnessf(x(k,:),infor,a,P,d);
    y(k,:)=x(k,:);
end
pg=x(N,:);
for i=1:N-1
    if fitnessf(x(i,:),infor,a,P,d)<fitnessf(pg,infor,a,P,d)
        pg=x(i,:);
    end
end

for t=1:M
    for j=1:N
        fv(j)=fitnessf(x(j,:),infor,a,P,d);
    end
    fvag=sum(fv)/N;
    fmin=min(fv);
    for i=1:N
        if fv(i)<=fvag
            w=wmin+(fv(i)-fmin)*(wmax-wmin)/(fvag-fmin);
        else
            w=wmax;
        end
        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));
        x(i,:)=x(i,:)+v(i,:);
        if fitnessf(x(i,:),infor,a,P,d)<p(i)
            p(i)=fitnessf(x(i,:),infor,a,P,d);
            y(i,:)=x(i,:);
        end
        if p(i)<fitnessf(pg,infor,a,P,d)
            pg=y(i,:);
        end
    end
    Pbest(t)=fitnessf(pg,infor,a,P,d);
end
disp('********************************************************');
disp('目标函数取最小值时的自变量：');
xm=pg
disp('目标函数的最小值：');
fv=fitnessf(pg,infor,a,P,d)
disp('********************************************************');