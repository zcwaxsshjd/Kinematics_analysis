function [Name,Subn,Type,Time,Side,Task,Var,AVEP,STDP] = StatisticAnalysis(Dir,name,subn,type,time,side,task)
ExpList = GetExpList(Dir);
N = length(ExpList);
%% Load file and find the moving period
filename = cell(N,1);
Legend = cell(N,1);
Data = cell(N,1);
Period = cell(N,1);
for i = 1:N
    filename{i} = [Dir '//' ExpList{i}];
    Legend{i} = ExpList{i}(end-6:end-4);
    Data{i} = ImportLeftData(filename{i});
    Period{i} = FindInterPeriod(Data{i});
end
%% Find peak value
Name = cell(4,1);
Subn = cell(4,1);
Type = cell(4,1);
Time = cell(4,1);
Side = cell(4,1);
Task = cell(4,1);
Var= cell(4,1);
AVEP= zeros(4,1);
STDP= zeros(4,1);
Peak(1:4*N,1) = 0;
for j = 1:N
    L = length(Period{j}.Vel_filt_hand_x);
    for flag = 1:L
        Vel_filt_hand_xy = ((Period{j}.Vel_filt_hand_x).^2+(Period{j}.Vel_filt_hand_y).^2 ).^0.5;
    end
    Peak(j) = max(Vel_filt_hand_xy);
    Peak(j+1*N) = max(abs(Period{j}.Vel_filt_elbow));
    Peak(j+2*N) = max(Period{j}.Vel_filt_sh_flex);
    Peak(j+3*N) = max(Period{j}.Vel_filt_sh_abduct);
end
Var{1} = 'handxy';
Var{2} = 'elbow';
Var{3} = 'shflex';
Var{4} = 'shabduct';
AVEP(1) = mean(Peak(1:N));
STDP(1) = std(Peak(1:N));
AVEP(2) = mean(Peak(N+1:2*N));
STDP(2) = std(Peak(N+1:2*N));
AVEP(3) = mean(Peak(2*N+1:3*N));
STDP(3) = std(Peak(2*N+1:3*N));
AVEP(4) = mean(Peak(3*N+1:4*N));
STDP(4) = std(Peak(3*N+1:4*N));
for k = 1:4    
    Name{k} = name;
    Subn{k} = subn;
    Type{k} = type;
    Time{k} = time;
    Side{k} = side;
    Task{k} = task;
end