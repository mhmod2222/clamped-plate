close all;clear all;clc;
choice = menu('Plate Deflection','Enter Values',' Select Default Values');
close all;clc;
if choice == 1
    l = input('enter length ');
    n = input('number of devisions in the length ');
    e = input('modulus of elasticity ');
    mu= input('poission ratio ');
    h = input('enter thickness ');
    p = input('enter load value ');
elseif choice ==2
    l = 1;
    n = 6;
    e = 10^5;
    mu= 0.3;
    h = 0.005;
    p = 50;
end
d = (h^3*e)/12*(1-mu^2);
lamda = l/n;
m = sym('m_%d_%d',[n n]);
fu = ones(n^2,1)*(-lamda^4*p/d); %load vector
q = zeros(n^2,n^2);
xx=1;
for j=1:n
    for i=1:n
            %%%%%%% fixed corner
            %%%%%%% 1
        if (i==1&&j==1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j+1)+m(i+1,j))+2*m(i+1,j+1)+m(i,j+2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 2
        elseif (i==1&&j==n)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1))+2*m(i+1,j-1)+m(i,j-2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 3
        elseif (i==n&&j==1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j+1)+m(i-1,j))+2*m(i-1,j+1)+m(i-2,j)+m(i,j+2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 4
        elseif (i==n&&j==n)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i,j-1))+2*m(i-1,j-1)+m(i,j-2)+m(i-2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%% fixed edge "2nd" and "nth-1" points
            %%%%%%% 1-A
        elseif (i==1&&j==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
        elseif (i==1&&j==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i,j-2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 2-A
        elseif (i==n&&j==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i,j+2)+m(i-2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
        elseif (i==n&&j==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i-2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 3-A
        elseif (j==1&&i==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i,j+1)+m(i+1,j))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
        elseif (j==1&&i==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i-2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 4-A
        elseif (j==n&&i==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i+2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
        elseif (j==n&&i==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%% fixed edge
            %%%%%%% 1-B
        elseif (i==1&&j>2&&j<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i+1,j))+2*(m(i+1,j-1)+m(i+1,j+1))+m(i+2,j)+m(i,j+2)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 2-B
        elseif (i==n&&j>2&&j<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i,j-1)+m(i,j+1)+m(i-1,j))+2*(m(i-1,j-1)+m(i-1,j+1))+m(i,j+2)+m(i-2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 3-B
        elseif (j==1&&i>2&&i<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1))+m(i,j+2)+m(i+2,j)+m(i-2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 4-B
        elseif (j==n&&i>2&&i<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i+1,j)+m(i-1,j)+m(i,j-1))+2*(m(i+1,j-1)+m(i-1,j-1))+m(i+2,j)+m(i,j-2)+m(i-2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%% adjacent to fixed corner
            %%%%%%% 1
        elseif (i==2&&j==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 2
        elseif (i==2&&j==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j-2)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 3
        elseif (i==n-1&&j==2)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j+2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 4
        elseif (i==n-1&&j==n-1)
            [Temp1,Temp2]=equationsToMatrix(22*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%% adjacent to fixed corner "2nd" and "nth-1" points
            %%%%%%% 1
        elseif (i==2&&j>2&&j<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i+2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 2
        elseif (i==n-1&&j>2&&j<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i-2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 3
        elseif (j==2&&i>2&&i<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j+2)+m(i-2,j)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%%
            %%%%%%% 4
        elseif (j==n-1&&i>2&&i<n-1)
            [Temp1,Temp2]=equationsToMatrix(21*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i,j-2)+m(i-2,j)+m(i+2,j),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
            %%%%%%% general point
            %%%%%%%
        else
            [Temp1,Temp2]=equationsToMatrix(20*m(i,j)-8*(m(i-1,j)+m(i+1,j)+m(i,j-1)+m(i,j+1))+2*(m(i-1,j+1)+m(i+1,j+1)+m(i+1,j-1)+m(i-1,j-1))+m(i-2,j)+m(i,j+2)+m(i+2,j)+m(i,j-2),m);
            q(xx,:) = Temp1(:);
            Temp1=0;
            xx=xx+1;
        end
    end
end
q=double(q);
m = linsolve(q,fu);
mytable(n,m);
m = reshape(m',n,n)';
m = [zeros(1,n+2);zeros(n,1),m, zeros(n,1);zeros(1,n+2)];
x = linspace(0,n,n+2);
x = x';
y = x;
figure,mesh(x,y,m)