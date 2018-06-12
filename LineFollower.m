function [linearVelocityLeft,linearVelocityRight] = LineFollower(leftstate,middlestate,rightstate)
    linearVelocityLeft=1;
    linearVelocityRight=1;
      if (leftstate==0&&rightstate==0&&middlestate==0) 
       linearVelocityLeft=0.5;
    linearVelocityRight=-0.5;
                   
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