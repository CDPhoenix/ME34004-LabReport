%ME34004 Lab, Laminar & Turbulent in pipe flow
%WANG Dapeng, 20074734D, Department of Mechanical Engineering
%Contact: 20074734d@connect.polyu.hk

dataset = readtable('LaminarTurbulent.csv');

h = dataset.h;
Re = dataset.Re;

u = dataset.u;

u1 = dataset.u_1;
u2 = dataset.u_2;

f_exp = dataset.exp;

Re_16 = dataset.Re_16;

Bla = dataset.Blasius;

k = zeros(1,4);


figure(1)

plot(h,u,'o');
hold on
plot(h,u1);
hold on
plot(h,u2);
grid on
xlabel('Head Loss (m)')
ylabel('Velocity (m/s)')
legend('Experiment Velocity','Theorical Laminar Velocity','Theorical Turbulent velocity')
x0 = 10;
y0 = 10;
width=850;
height=600;
set(gcf,'position',[x0,y0,width,height])


figure(2)

plot(Re,f_exp);
hold on
plot(Re,Re_16);
hold on
plot(Re,Bla);
grid on
xlabel('Reynold number')
ylabel('Friction Factor')
legend('Experiment friction factor','16/Re','Blasius for Turbulent')
set(gcf,'position',[x0,y0,width,height])