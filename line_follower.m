vrep=remApi('remoteApi');
vrep.simxFinish(-1);

 clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
 
  if (clientID>-1)
        disp('Connected to remote API server');
        %code here
        [returnCode,left_Motor]=vrep.simxGetObjectHandle(clientID,'LeftMotor',vrep.simx_opmode_blocking);
        [returnCode,right_Motor]=vrep.simxGetObjectHandle(clientID,'RightMotor',vrep.simx_opmode_blocking);
        [returnCode,Right_Sensor]=vrep.simxGetObjectHandle(clientID,'RightSensor',vrep.simx_opmode_blocking);
        [returnCode,Left_Sensor]=vrep.simxGetObjectHandle(clientID,'LeftSensor',vrep.simx_opmode_blocking);
        [returnCode,Middle_Sensor]=vrep.simxGetObjectHandle(clientID,'MiddleSensor',vrep.simx_opmode_blocking);
        [returnCode,base]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx',vrep.simx_opmode_blocking);
        
        [~,rightstate,~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor,vrep.simx_opmode_streaming);
        [~,leftstate,~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor,vrep.simx_opmode_streaming);
        [~,middlestate,~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor,vrep.simx_opmode_streaming);
      disp(eulerAngles)
      rightstate=1;
        while (clientID>-1)
            [~,rightstate,~,~]=vrep.simxReadVisionSensor(clientID,Right_Sensor,vrep.simx_opmode_buffer);
            [~,leftstate,~,~]=vrep.simxReadVisionSensor(clientID,Left_Sensor,vrep.simx_opmode_buffer);
            [~,middlestate,~,~]=vrep.simxReadVisionSensor(clientID,Middle_Sensor,vrep.simx_opmode_buffer);
           
      [linearVelocityLeft,linearVelocityRight] = LineFollower(leftstate,middlestate,rightstate);
      [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor,linearVelocityLeft,vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor,linearVelocityRight,vrep.simx_opmode_blocking);
        if (leftstate==0&&rightstate==0&&middlestate==0)
            [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_Motor,linearVelocityLeft,vrep.simx_opmode_blocking);
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,right_Motor,linearVelocityRight,vrep.simx_opmode_blocking);
       pause(10);
        end
        end
        vrep.simxFinish(-1);
  end
    vrep.delete();
    