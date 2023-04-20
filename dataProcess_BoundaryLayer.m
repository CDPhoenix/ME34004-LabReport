%ME34004 Lab, Boundary Layer measurement
%WANG Dapeng, 20074734D, Department of Mechanical Engineering
%Contact: 20074734d@connect.polyu.hk

dataset = readtable('BoundaryLayer.csv');

y = dataset.y;
y = y*10^-3;
u_50 = deleNan(dataset.u_50);

u_100 = deleNan(dataset.u_100);

u_200 = deleNan(dataset.u_200);

u_300 = deleNan(dataset.u_300);

x1 = y(1:length(u_50),:);

x2 = y(1:length(u_100),:);

x3 = y(1:length(u_200),:);

x4 = y(1:length(u_300),:);

U = [4.0;3.9;3.9;3.85];
L = [50*10^-3;100*10^-3;200*10^-3;300*10^-3];

ReS = ReynoldNumberCal(U,L);

diracts = LaminarBound(ReS,L);

x_1 = y(1:5);
x_2 = y(1:7);
x_3 = y(1:10);
x_4 = y(1:12);

diracts_tur = [0.0061;0.00675;0.00972;0.012115];

u_50_ther = LaminarVelocity(U(1),x_1,diracts(1));
u_100_ther = LaminarVelocity(U(2),x_2,diracts(2));
u_200_ther = LaminarVelocity(U(3),x_3,diracts(3));
u_300_ther = LaminarVelocity(U(4),x_4,diracts(4));

u_50_tur = TurbulentVelocity(U(1),x1,diracts_tur(1));
u_100_tur = TurbulentVelocity(U(2),x2,diracts_tur(2));
u_200_tur = TurbulentVelocity(U(3),x3,diracts_tur(3));
u_300_tur = TurbulentVelocity(U(4),x4,diracts_tur(4));

x0 = 10;
y0 = 10;
width=850;
height=600;

figure(1)

plot(u_50_ther,x_1);
hold on
plot(u_100_ther,x_2);
hold on
plot(u_200_ther,x_3);
hold on
plot(u_300_ther,x_4);
grid on
title('Theoretical Laminar Velocity profile')
xlabel('Fluid velocity (m/s)')
ylabel('Depth (m)')
legend('50 mm','100 mm','200 mm','300 mm')
set(gcf,'position',[x0,y0,width,height])


figure(2)
plot(u_50_tur,x1);
hold on
plot(u_100_tur,x2);
hold on
plot(u_200_tur,x3);
hold on
plot(u_300_tur,x4);
grid on
title('Theoretical Turbulent Velocity profile')
xlabel('Fluid velocity (m/s)')
ylabel('Depth (m)')
legend('50 mm','100 mm','200 mm','300 mm')
set(gcf,'position',[x0,y0,width,height])

figure(3)
plot(u_50,x1);
hold on
plot(u_100,x2);
hold on
plot(u_200,x3);
hold on
plot(u_300,x4);

grid on
title('Experimental Velocity profile')
xlabel('Fluid velocity (m/s)')
ylabel('Depth (m)')
legend('50 mm','100 mm','200 mm','300 mm')
set(gcf,'position',[x0,y0,width,height])

DisplacementThick = zeros(1,4);
MomentumThick = zeros(1,4);

[DisplacementThick(1),MomentumThick(1)] = thickCal(u_50,U(1),x1);
[DisplacementThick(2),MomentumThick(2)] = thickCal(u_100,U(2),x2);
[DisplacementThick(3),MomentumThick(3)] = thickCal(u_200,U(3),x3);
[DisplacementThick(4),MomentumThick(4)] = thickCal(u_300,U(4),x4);

x_axis_data = [50,100,200,300];
figure(4)
plot(x_axis_data,DisplacementThick);
hold on
plot(x_axis_data,MomentumThick);
title('Displament Thickness & Momentum Thickness at different distance')
xlabel('Distance (mm)')
ylabel('Values (m)')
legend('Displament Thickness','Momentum Thickness')
grid on
set(gcf,'position',[x0,y0,width,height])


function u = deleNan(u)
    idx = find(~isnan(u));
    u = u(idx);
end


function Re = ReynoldNumberCal(U,L)
    mu = 1.562*10^-5;
    Re = U.*L/mu;
end

function diracts = LaminarBound(Re,L)
    diracts = 5./sqrt(Re).*L;
end

function u = LaminarVelocity(U,y,diract)

    u = U.*(2*(y./diract)-(y./diract).^2);
    
end

function [D_thick,MomentumT] = thickCal(u,U,y)
    D_thick = 0.0;
    MomentumT = 0.0;
    for i = 2:length(y)
        D_thick = D_thick + (1-u(i)/U)*(y(i)-y(i-1));
        MomentumT = MomentumT + u(i)/U*(1-u(i)/U)*(y(i)-y(i-1));
    end
end


function u = TurbulentVelocity(U,y,diract)

    u = U.*(y./diract).^(1/7);
    
end
