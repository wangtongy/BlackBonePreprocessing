function[fid]=calc_fid(a,b)

%for testing
%a=rand(10,2048);
%b=rand(10,2048);

m1=mean(a,1);
m2=mean(b,1);

ssdiff=sum((m1-m2).^2);

s1=cov(a');
s2=cov(b');

smean=real(sqrtm(s1*s2));

fid=ssdiff+trace(s1+s2-2*smean);