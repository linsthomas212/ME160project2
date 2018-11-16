%% Documentation
% ME160 Project 2
% Date: 11/15/18
% Authors: Thomas Lins, Josh Lynde, Garret Taylor
% Problem summary: ME160 Project 2 involves simulating a submarine
%% Wipes old workspace to prevent contamination of data
%
clear
%
%% Setup variables
length=58; %meters
diameter=12; %meters
volume=length*pi*(diameter^2/4); %2088 pi meters^3
drymass=2812272.694; %kilograms, was 6200000 lbs
ballastmass=0;%kilograms
Cl=0.14; %dimensionless coefficient of lift, no unit
gravity=9.81; %meters/second^2
liftarea=length*diameter; %meters^2, the cross sectional area of the submarine
velocity=0; %meters/second. Between 0 and 17.8816 
depth=0; %meters 
depths=[0,30.48,45.72,91.44];
ballastchange=1000; %meters^3/second
ballastdensity=1025; %kilograms/meters^3
index=2; %should start at 2
velocityrecord=[1:100];
depthrecord=[1:100];
ballastrecord=[1:100];
vertvelocityrecord=[1:100];
positionrecord=[1:100];
vertvelocity=0;
vertacceleration=0;
vellist=[0,4.4704,8.9408,13.4112,17.881];
%% Important equations
%
% Force of lift: Fl=.5*Cl*density*liftarea*velocity^2;
% Force of ballast weight: Fba=ballastmass*gravity;
% Force of drymass weight: Fg=drymass*gravity;
% Force of Buoyancy: Fbo=density*gravity*volume;
% Density of the water; density=depth*(25/1143)+1025;
% Volume of ballast Vb=ballastmass/ballastdensity;
% 
%% Start of Program. Determines the timestep
clc
fprintf('Please enter a timestep in the dialog box.\nSmaller values are more accurate but take longer to run.\n');
timestepcell=(cell2mat(inputdlg('Enter a time step in seconds', 'Time step selection', [1,40], {'0.05'})));

if isempty(timestepcell)==1
    fprintf('\nYou did not enter anything! The program will now exit!\n')
    return
else   
timestep=str2double(timestepcell);
end

%% Main loop that runs everything
while 1
    if index==2
        velocity=vellist(menu('Choose the starting velocity', 'Stop (0 mph)', '10 mph', '20 mph', '30 mph', '40 mph'));
        depth=menu('Choose a new depth', 'Surface', '100 ft', '150 ft', '300 ft');        
    else
    mainmenu=menu('Choose one', 'Change Velocity', 'Change Depth', 'End Program');
    switch mainmenu
        case 1 %Velocity Menu
            velmenu=menu('Would you like to:', 'Choose a new velocity from a list', 'Enter a custom velocity');
            if velmenu==1
                velocitygoal=vellist(menu('Choose a new velocity', 'Stop (0 mph)', '10 mph', '20 mph', '30 mph', '40 mph'));
            elseif velmenu==2
                velocitygoal=(str2double(cell2mat(inputdlg('Enter a Velocity between 0 and 40 mph', 'Velocity input', [1,20], {''}))))/2.236936;
                if velocitygoal>17.8811||velocitygoal<0
                    fprintf('\nYou entered an invalid velocity! The program will now exit!\n')
                    return
                end
            end
        case 2 %Depth Menu
            depmenu=menu('Choose a new depth', 'Surface', '100 ft', '150 ft', '300 ft');
            depthgoal=depths(depmenu);
        case 3 %Break if the user wants to end the program. This still graphs the results
            break
    end
    end
    
%% This is where the actual calculations go and they run either until they reach their value or a long time has passed.
% while 1
%     %Processing stuff
%     %lots of stuff its annoying
%     ballastrecord(index)=ballastrecord
%     depthrecord(index)=depth;
%     velocityrecord(index)=velocity;
%     vertvelocity(index)=vertvelocity;
%     index=index+1
%     if value==goalvalue
%         break
%     end
% end

end
%% End of program. Plots all the recorded information

velocityrecordmph=velocityrecord.*2.236936;
depthrecordft=depthrecord.*3.281;
positionrecordft=positionrecord.*3.281;
vertvelocityrecordmph=vertvelocityrecord*2.236936;

time=0:timestep:(size(depthrecord,2)-1)*timestep;

figure('Name', 'Depth over Time','IntegerHandle' ,'off')
plot(time,depthrecordft)
title('\fontsize{16}Depth over Time')
xlabel('\fontsize{16}Time (Seconds)')
ylabel('\fontsize{16}Depth (mph)')

figure('Name', 'Horizotal Velocity over Time','IntegerHandle' ,'off')
plot(time,velocityrecordmph)
title('\fontsize{16}Horizotal Velocity over Time')
xlabel('\fontsize{16}Time (Seconds)')
ylabel('\fontsize{16}Horizontal Velocity (mph)')

figure('Name', 'Ballast over Time','IntegerHandle' ,'off')
plot(time,ballastrecord)
title('\fontsize{16}Ballast over Time')
xlabel('\fontsize{16}Time (Seconds)')
ylabel('\fontsize{16}Ballast (liters)')

figure('Name', 'Vertical Velocity over Time','IntegerHandle' ,'off')
plot(time,vertvelocityrecordmph)
title('\fontsize{16}Vertical Velocity over Time')
xlabel('\fontsize{16}Time (Seconds)')
ylabel('\fontsize{16}Vertical Velocity (mph)')

figure('Name', 'Depth over Horizontal Position','IntegerHandle' ,'off')
plot(positionrecordft, depthrecordft)
title('\fontsize{16}Depth over Horizontal Position')
xlabel('\fontsize{16}Horizontal Position (feet)')
ylabel('\fontsize{16}Depth (feet)')
