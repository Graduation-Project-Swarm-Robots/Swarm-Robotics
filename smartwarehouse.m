clc;
clear all;
vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
load('warehouseTracks');
robot(1)=40;
robot(2)=41;
robot(3)=42;
e1=[1,2];
[startNode,endNode,j]=chooseRobot(G,robot,e1(1));
direction='U';
 
  if (clientID>-1)
        disp('Connected to remote API server');
        %code here
        [returnCode,left_Motor(1)]=vrep.simxGetObjectHandle(clientID,'LeftMotor',vrep.simx_opmode_blocking);
        [returnCode,right_Motor(1)]=vrep.simxGetObjectHandle(clientID,'RightMotor',vrep.simx_opmode_blocking);
        [returnCode,Right_Sensor(1)]=vrep.simxGetObjectHandle(clientID,'RightSensor',vrep.simx_opmode_blocking);
        [returnCode,Left_Sensor(1)]=vrep.simxGetObjectHandle(clientID,'LeftSensor',vrep.simx_opmode_blocking);
        [returnCode,Middle_Sensor(1)]=vrep.simxGetObjectHandle(clientID,'MiddleSensor',vrep.simx_opmode_blocking);
        [returnCode,base(1)]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx',vrep.simx_opmode_blocking);
        
        [~,rightstate(1),~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor(1),vrep.simx_opmode_streaming);
        [~,leftstate(1),~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor(1),vrep.simx_opmode_streaming);
        [~,middlestate(1),~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor(1),vrep.simx_opmode_streaming);
        
        [returnCode,left_Motor(2)]=vrep.simxGetObjectHandle(clientID,'LeftMotor#0',vrep.simx_opmode_blocking);
        [returnCode,right_Motor(2)]=vrep.simxGetObjectHandle(clientID,'RightMotor#0',vrep.simx_opmode_blocking);
        [returnCode,Right_Sensor(2)]=vrep.simxGetObjectHandle(clientID,'RightSensor#0',vrep.simx_opmode_blocking);
        [returnCode,Left_Sensor(2)]=vrep.simxGetObjectHandle(clientID,'LeftSensor#0',vrep.simx_opmode_blocking);
        [returnCode,Middle_Sensor(2)]=vrep.simxGetObjectHandle(clientID,'MiddleSensor#0',vrep.simx_opmode_blocking);
        [returnCode,base(2)]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx#0',vrep.simx_opmode_blocking);
        
        [~,rightstate(2),~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor(2),vrep.simx_opmode_streaming);
        [~,leftstate(2),~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor(2),vrep.simx_opmode_streaming);
        [~,middlestate(2),~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor(2),vrep.simx_opmode_streaming);
        
        [returnCode,left_Motor(3)]=vrep.simxGetObjectHandle(clientID,'LeftMotor#1',vrep.simx_opmode_blocking);
        [returnCode,right_Motor(3)]=vrep.simxGetObjectHandle(clientID,'RightMotor#1',vrep.simx_opmode_blocking);
        [returnCode,Right_Sensor(3)]=vrep.simxGetObjectHandle(clientID,'RightSensor#1',vrep.simx_opmode_blocking);
        [returnCode,Left_Sensor(3)]=vrep.simxGetObjectHandle(clientID,'LeftSensor#1',vrep.simx_opmode_blocking);
        [returnCode,Middle_Sensor(3)]=vrep.simxGetObjectHandle(clientID,'MiddleSensor#1',vrep.simx_opmode_blocking);
        [returnCode,base(3)]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx#1',vrep.simx_opmode_blocking);
        
        [~,rightstate(3),~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor(3),vrep.simx_opmode_streaming);
        [~,leftstate(3),~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor(3),vrep.simx_opmode_streaming);
        [~,middlestate(3),~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor(3),vrep.simx_opmode_streaming);
   [path,L]=shortestpath(G,startNode,endNode);    
   
while (~isempty(e1))
    
     
     currentNode(j)=path(1)
while (currentNode(j)~=endNode)

 currentNode(j)=path(1)
 while(currentNode(j)~=endNode)
     [~,rightstate(j),~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor(j),vrep.simx_opmode_buffer);
            [~,leftstate(j),~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor(j),vrep.simx_opmode_buffer);
            [~,middlestate(j),~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor(j),vrep.simx_opmode_buffer);

        [linearVelocityLeft(j),linearVelocityRight(j)] = LineFollower(leftstate(j),middlestate(j),rightstate(j));
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor(j),linearVelocityLeft(j),vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor(j),linearVelocityRight(j),vrep.simx_opmode_blocking);
        if (leftstate(j)==0&&rightstate(j)==0&&middlestate(j)==0)
            currentNode(j)=path(1)
            if(currentNode(j)~=endNode)
    nextNode(j)=path(2)
    path=path(2:size(path,2))
            end
            [order,direction]=movements(currentNode(j),nextNode(j),direction);
            [linearVelocityLeft(j),linearVelocityRight(j)] = allBlack(order);
            [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor(j),linearVelocityLeft(j),vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor(j),linearVelocityRight(j),vrep.simx_opmode_blocking);
       pause(2.5);
        end
        
 end
startNode=currentNode(j);
endNode=robot(j);
[path,L]=shortestpath(G,startNode,endNode);
path=path(2:size(path,2));
end
[returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor(j),0,vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor(j),0,vrep.simx_opmode_blocking);
    e1=e1(2:size(e1,2));
    if(~isempty(e1))
   [startNode,endNode,j]=chooseRobot(G,robot,e1(1));
 [path,L]=shortestpath(G,robot(j),endNode);
path=path(2:size(path,2));
    end
end

        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor(j),0,vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor(j),0,vrep.simx_opmode_blocking);
        vrep.simxFinish(-1);
end
        
    vrep.delete();
