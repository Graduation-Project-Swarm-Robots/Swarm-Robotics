function [linearVelocityLeft,linearVelocityRight] = LineFollower(leftstate,middlestate,rightstate,y)
    linearVelocityLeft=1;
    linearVelocityRight=1;
      if (leftstate==0&&rightstate==0&&middlestate==0)
          order = stack('pop')
       switch(order)
           case 0 %stop
               linearVelocityLeft=0
               linearVelocityRight=0
           case 1 %forward
               linearVelocityLeft=linearVelocityLeft
               linearVelocityRight=linearVelocityRight
           case 2 %right 90 degree
               linearVelocityLeft=0.5
               linearVelocityRight=0
           case 3 %left 90 degree
               linearVelocityLeft=0
               linearVelocityRight=0.5
           case 4 %right 180 degree
               linearVelocityLeft=0.5
               linearVelocityRight=-0.5
           case 5 %left 180 degree
               linearVelocityLeft=-0.5
               linearVelocityRight=0.5               
       end
      end 
      

        if (leftstate==0&&rightstate==0&&middlestate==1) 
            linearVelocityLeft=linearVelocityLeft
            linearVelocityRight=linearVelocityRight
        end
       if (leftstate==0&&rightstate==1&&middlestate==1) 
            linearVelocityLeft=linearVelocityLeft*0.3
            linearVelocityRight=linearVelocityRight
       end
        if (leftstate==1&&rightstate==0&&middlestate==0) 
            linearVelocityLeft=linearVelocityLeft*3
            linearVelocityRight=linearVelocityRight*0.3
        end
        if (leftstate==1&&rightstate==1&&middlestate==0) 
            linearVelocityLeft=linearVelocityLeft
            linearVelocityRight=linearVelocityRight
        end
        if (leftstate==1&&rightstate==0&&middlestate==1) 
            linearVelocityLeft=linearVelocityLeft
            linearVelocityRight=linearVelocityRight*0.3
        end
        if (leftstate==1&&rightstate==1&&middlestate==1) 
            linearVelocityLeft=-linearVelocityLeft*0.7
            linearVelocityRight=-linearVelocityRight*0.7
        end
        if (leftstate==0&&rightstate==1&&middlestate==0) 
            linearVelocityLeft=linearVelocityLeft*0.3
            linearVelocityRight=linearVelocityRight*3
        end
        
end